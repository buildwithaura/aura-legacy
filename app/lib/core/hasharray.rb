# A stopgap solution to Ruby 1.8's lack of ordered hashes.
class HashArray < Array
  def each(&blk)
    super { |hash| yield hash.to_a.flatten }
  end

  def map(&blk)
    super { |hash| yield hash.to_a.flatten }
  end

  def values
    inject([]) { |a, (k, v)| a << v; a }
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
