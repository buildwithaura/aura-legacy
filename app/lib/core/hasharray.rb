# A stopgap solution to Ruby 1.8's lack of ordered hashes.
class HashArray < Array
  alias _each each
  def each(&blk)
    _each { |hash| yield hash.to_a.flatten }
  end

  alias _map map
  def map(&blk)
    _map { |hash| yield hash.to_a.flatten }
  end

  def to_hash
    inject({}) { |hash, (k, v)| hash[k] = v; hash }
  end
end

class Array
  def to_hash_array
    HashArray.new self
  end
end
