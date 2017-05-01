require 'pry'
require 'pp'
# https://github.com/QuantumMechanics/NEM-sdk/blob/master/src/crypto/keyPair.js
# https://github.com/QuantumMechanics/NEM-sdk/blob/master/src/external/nacl-fast.js
module Nis::Util
  module Encrypter

  end

  class KeyPair
    def initialize(private_key)
      # public_key = new BinaryKey([].fill(0,0,32))
      # secret_key = hex2ua_reversed(private_key)
      #   nacl.lowlevel.crypto_sign_keypair_hash(public_key.data, this.secretKey, hashfunc);
    end

    def sign(data)

    end
  end
  # let hashfunc = function(dest, data, dataLength) {
  #     let convertedData = convert.ua2words(data, dataLength);
  #     let hash = CryptoJS.SHA3(convertedData, {
  #         outputLength: 512
  #     });
  #     convert.words2ua(dest, hash);
  # }
  # var gf = function(init) {
  #   var i, r = new Float64Array(16);
  #   if (init) for (i = 0; i < init.length; i++) r[i] = init[i];
  #   return r;
  # };
  # function crypto_sign_keypair_hash(pk, sk, hashfunc) {
  #   var d = new Uint8Array(64);
  #   var p = [gf(), gf(), gf(), gf()];
  #   var i;
  #
  #   hashfunc(d, sk, 32);
  #   d[0] &= 248;
  #   d[31] &= 127;
  #   d[31] |= 64;
  #
  #   scalarbase(p, d);
  #   pack(pk, p);
  #
  #   for (i = 0; i < 32; i++) sk[i+32] = pk[i];
  #   return 0;
  # }
  # KeyPair = function(privkey) {
  #   this.publicKey = new BinaryKey(new Uint8Array(nacl.lowlevel.crypto_sign_PUBLICKEYBYTES));
  #   this.secretKey = convert.hex2ua_reversed(privkey);
  #   nacl.lowlevel.crypto_sign_keypair_hash(this.publicKey.data, this.secretKey, hashfunc);
  #   // Signature
  #   this.sign = (data) => {
  #     var sig = new Uint8Array(64);
  #     var hasher = new hashobj();
  #     var r = nacl.lowlevel.crypto_sign_hash(sig, this, data, hasher);
  #     if (!r) {
  #         alert("Couldn't sign the tx, generated invalid signature");
  #         throw new Error("Couldn't sign the tx, generated invalid signature");
  #     }
  #     return new BinaryKey(sig);
  #   }
  # }

  class BinaryKey
    attr_reader :data

    # @param [Uint8Array] data
    def initialize(data)
       @data = data
    end

    def to_s
      ua2hex(@data)
    end
  end
end
