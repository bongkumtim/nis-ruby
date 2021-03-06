class Nis::Struct
  # @attr [Integer] height
  # @see http://bob.nem.ninja/docs/#blockHeight
  class BlockHeight
    include Nis::Util::Assignable
    attr_accessor :height

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def to_i
      @height
    end

    # @return [String]
    def to_s
      @height.to_s
    end
  end
end
