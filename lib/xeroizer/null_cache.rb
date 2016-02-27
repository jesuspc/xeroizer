module Xeroizer
  class NullCache
    def fetch(_key, &block)
      block.call
    end
  end
end
