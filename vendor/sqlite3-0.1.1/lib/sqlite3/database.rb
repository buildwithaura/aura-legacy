# Copyright (c) 2004, Jamis Buck (jamis@jamisbuck.org)
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:

# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.

# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in
#   the documentation and/or other materials provided with the
#   distribution.

# * The names of its contributors may not be used to endorse or
#   promote products derived from this software without specific prior
#   written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

module SQLite3

  # The Database class encapsulates a single connection to a SQLite3 database.
  # Its usage is very straightforward:
  #
  #   require "sqlite3"
  #
  #   db = SQLite3::Database.new("data.db")
  #
  #   db.execute("select * from table") do |row|
  #     p row
  #   end
  #
  #   db.close
  #
  # It wraps the lower-level methods provides by the selected driver, and
  # includes the Pragmas module for access to various pragma convenience
  # methods.
  #
  # The Database class provides type translation services as well, by which
  # the SQLite3 data types (which are all represented as strings) may be
  # converted into their corresponding types (as defined in the schemas
  # for their tables). This translation only occurs when querying data from
  # the database--insertions and updates are all still typeless.
  #
  # Furthermore, the Database class has been designed to work well with the
  # ArrayFields module from Ara Howard. If you require the ArrayFields
  # module before performing a query, and if you have not enabled results as
  # hashes, then the results will all be indexible by field name.
  class Database
    include Pragmas
    include Extensions

    class << self

      alias :open :new

      # Quotes the given string, making it safe to use in an SQL statement.
      # It replaces all instances of the single-quote character with two
      # single-quote characters. The modified string is returned.
      def quote(string)
        string.gsub(/'/, "''")
      end

    end

    # The low-level opaque database handle that this object wraps.
    attr_reader :handle

    # A reference to the underlying SQLite3 driver used by this database.
    attr_reader :driver

    # A boolean that indicates whether rows in result sets should be returned
    # as hashes or not. By default, rows are returned as arrays.
    attr_accessor :results_as_hash

    # Encoding used to comunicate with database.
    attr_reader :encoding

    # Create a new Database object that opens the given file. If utf16
    # is +true+, the filename is interpreted as a UTF-16 encoded string.
    #
    # By default, the new database will return result rows as arrays
    # (#results_as_hash) and has type translation disabled (#type_translation=).
    def initialize(file_name, options = {})
      @encoding = Encoding.find(options.fetch(:encoding, "utf-8"))

      @driver = Driver.new

      @statement_factory = options[:statement_factory] || Statement

      result, @handle = @driver.open(file_name, Encoding.utf_16?(@encoding))
      Error.check(result, self, "could not open database")

      @closed = false
      @results_as_hash = options.fetch(:results_as_hash, false)
    end

    # Return +true+ if the string is a valid (ie, parsable) SQL statement, and
    # +false+ otherwise
    def complete?(string)
      @driver.complete?(string)
    end

    # Return a string describing the last error to have occurred with this
    # database.
    def errmsg
      @driver.errmsg(@handle)
    end

    # Return an integer representing the last error to have occurred with this
    # database.
    def errcode
      @driver.errcode(@handle)
    end

    # Closes this database.
    def close
      unless @closed
        result = @driver.close(@handle)
        Error.check(result, self)
      end
      @closed = true
    end

    # Returns +true+ if this database instance has been closed (see #close).
    def closed?
      @closed
    end

    # Returns a Statement object representing the given SQL. This does not
    # execute the statement; it merely prepares the statement for execution.
    #
    # The Statement can then be executed using Statement#execute.
    #
    def prepare(sql)
      stmt = @statement_factory.new(self, sql, Encoding.utf_16?(@encoding))
      if block_given?
        begin
          yield stmt
        ensure
          stmt.close
        end
      else
        return stmt
      end
    end

    # Executes the given SQL statement. If additional parameters are given,
    # they are treated as bind variables, and are bound to the placeholders in
    # the query.
    #
    # Note that if any of the values passed to this are hashes, then the
    # key/value pairs are each bound separately, with the key being used as
    # the name of the placeholder to bind the value to.
    #
    # The block is optional. If given, it will be invoked for each row returned
    # by the query. Otherwise, any results are accumulated into an array and
    # returned wholesale.
    #
    # See also #execute2, #query, and #execute_batch for additional ways of
    # executing statements.
    def execute(sql, *bind_vars)
      prepare(sql) do |stmt|
        result = stmt.execute(*bind_vars)
        if block_given?
          result.each { |row| yield row }
        else
          return result.inject([]) { |arr, row| arr << row; arr }
        end
      end
    end

    # Executes the given SQL statement, exactly as with #execute. However, the
    # first row returned (either via the block, or in the returned array) is
    # always the names of the columns. Subsequent rows correspond to the data
    # from the result set.
    #
    # Thus, even if the query itself returns no rows, this method will always
    # return at least one row--the names of the columns.
    #
    # See also #execute, #query, and #execute_batch for additional ways of
    # executing statements.
    def execute2(sql, *bind_vars)
      prepare(sql) do |stmt|
        result = stmt.execute(*bind_vars)
        if block_given?
          yield result.columns
          result.each { |row| yield row }
        else
          return result.inject([result.columns]) { |arr,row| arr << row; arr }
        end
      end
    end

    # A convenience method for obtaining the first row of a result set, and
    # discarding all others. It is otherwise identical to #execute.
    #
    # See also #get_first_value.
    def get_first_row(sql, *bind_vars)
      execute(sql, *bind_vars) { |row| return row }
      nil
    end

    # A convenience method for obtaining the first value of the first row of a
    # result set, and discarding all other values and rows. It is otherwise
    # identical to #execute.
    #
    # See also #get_first_row.
    def get_first_value(sql, *bind_vars)
      execute(sql, *bind_vars) { |row| return row[0] }
      nil
    end

    # Obtains the unique row ID of the last row to be inserted by this Database
    # instance.
    def last_insert_row_id
      @driver.last_insert_rowid(@handle)
    end

    # Returns the number of changes made to this database instance by the last
    # operation performed. Note that a "delete from table" without a where
    # clause will not affect this value.
    def changes
      @driver.changes(@handle)
    end

    # Indicates that if a request for a resource terminates because that
    # resource is busy, SQLite should sleep and retry for up to the indicated
    # number of milliseconds. By default, SQLite does not retry
    # busy resources. To restore the default behavior, send 0 as the
    # +ms+ parameter.
    #
    # See also the mutually exclusive #busy_handler.
    def busy_timeout(ms)
      result = @driver.busy_timeout(@handle, ms)
      Error.check(result, self)
    end

    # Begins a new transaction. Note that nested transactions are not allowed
    # by SQLite, so attempting to nest a transaction will result in a runtime
    # exception.
    #
    # The +mode+ parameter may be either <tt>:deferred</tt> (the default),
    # <tt>:immediate</tt>, or <tt>:exclusive</tt>.
    #
    # If a block is given, the database instance is yielded to it, and the
    # transaction is committed when the block terminates. If the block
    # raises an exception, a rollback will be performed instead. Note that if
    # a block is given, #commit and #rollback should never be called
    # explicitly or you'll get an error when the block terminates.
    #
    # If a block is not given, it is the caller's responsibility to end the
    # transaction explicitly, either by calling #commit, or by calling
    # #rollback.
    def transaction(mode = :deferred)
      execute "begin #{mode.to_s} transaction"
      @transaction_active = true

      if block_given?
        abort = false
        begin
          yield self
        rescue ::Object
          abort = true
          raise
        ensure
          abort and rollback or commit
        end
      end

      true
    end

    # Commits the current transaction. If there is no current transaction,
    # this will cause an error to be raised. This returns +true+, in order
    # to allow it to be used in idioms like
    # <tt>abort? and rollback or commit</tt>.
    def commit
      execute "commit transaction"
      @transaction_active = false
      true
    end

    # Rolls the current transaction back. If there is no current transaction,
    # this will cause an error to be raised. This returns +true+, in order
    # to allow it to be used in idioms like
    # <tt>abort? and rollback or commit</tt>.
    def rollback
      execute "rollback transaction"
      @transaction_active = false
      true
    end

    # Returns +true+ if there is a transaction active, and +false+ otherwise.
    def transaction_active?
      @transaction_active
    end
  end
end
