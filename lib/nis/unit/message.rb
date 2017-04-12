module Nis::Unit
  # @attr [String] payload
  # @attr [Integer] type
  class Message
    attr_accessor :payload, :type

    TYPE_PLAIN     = 1
    TYPE_ENCRYPTED = 2

    def initialize(payload, type)
      @payload = payload
      @type = type
    end

    # @return [Boolean]
    def encrypted?
      @type == TYPE_ENCRYPTED
    end

    # @return [Integer]
    def bytesize
      @payload.bytesize
    end

    # @return [String]
    def to_s
      @payload
    end

    # @return [Hash]
    def to_hash
      { payload: @payload, type: @type }
    end

    # @return [Boolean]
    def ==(other)
      @payload == other.payload
    end

    # @return [Boolean]
    def valid?
      bytesize <= 512
    end

    # @return [Boolean]
    def encrypt!
      @payload = encryption(@payload) # encrypted payload
      @type = TYPE_ENCRYPTED
    end

    # @return [Boolean]
    def decrypt!
      @payload = decryption(@payload) # decrypted payload
      @type = TYPE_PLAIN
    end

    private

    # https://ja.wikipedia.org/wiki/%E6%9A%97%E5%8F%B7%E5%88%A9%E7%94%A8%E3%83%A2%E3%83%BC%E3%83%89#CBC
    # http://nemmanual.net/NEM_Technical_reference_JA/Cryptography/3.3.html#fn_4

    def encryption(string)
      string
    end

    def decryption(string)
      string
    end

    def cipher
      @cipher ||= OpenSSL::Cipher.new('AES-128-CBC')
    end

    # require 'openssl'
    # data = "Very, very confidential data"
    #
    # cipher = OpenSSL::Cipher.new('AES-128-CBC')
    # cipher.encrypt
    # key = cipher.random_key
    # iv  = cipher.random_iv
    #
    # encrypted = cipher.update(data) + cipher.final
    #
    #
    # decipher = OpenSSL::Cipher.new('AES-128-CBC')
    # decipher.decrypt
    # decipher.key = key
    # decipher.iv  = iv
    #
    # plain = decipher.update(encrypted) + decipher.final
    #
    # puts data == plain #=> true
  end
end
