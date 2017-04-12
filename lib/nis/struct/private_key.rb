class Nis::Struct
  # @attr [String] value
  # @see http://bob.nem.ninja/docs/#privateKey
  class PrivateKey
    include Nis::Util::Assignable
    attr_accessor :value

    def self.build(attrs)
      new(attrs)
    end
  end
end
