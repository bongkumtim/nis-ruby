module Nis::Util
  module Serializer
    # Serialize a transaction object
    # @param [Hash] entity
    # @return [Array]
    def self.serialize_transaction(entity)
      a = []
      a += serialize_int(entity[:type])
      a += serialize_int(entity[:version])
      a += serialize_int(entity[:timeStamp])

      temp = hex2ua(entity[:signer])
      a += serialize_int(temp.size)
      a += temp

      a += serialize_long(entity[:fee])
      a += serialize_int(entity[:deadline])

      temp = serialize_safe_string(entity[:recipient])
      a += temp

      a += serialize_long(entity[:amount])

      temp = hex2ua(entity[:message][:payload])
      if temp.size == 0
        a += [0,0,0,0]
      else
        a += serialize_int(temp.size + 8)
        a += serialize_int(entity[:message][:type])
        a += serialize_int(temp.size)
        a += temp
      end
      a
    end

    private

    # Safe String - Each char is 8 bit
    # @param [String] str
    # @return [Array]
    def self.serialize_safe_string(str)
      return [].fill(255, 0, 4) if str.nil?
      return [].fill(0, 0, 4) if str.empty?
      [str.size, 0, 0, 0] + str.bytes
    end

    # @param [String] str
    # @return [Array]
    def self.serialize_ua_string(str)
      return [].fill(255, 0, 4) if str.nil?
      return [].fill(0, 0, 4) if str.empty?
      chars = str.is_a?(String) ? str.chars : str
      [chars.size, 0, 0, 0] + chars.map(&:to_i)
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_int(value)
      a = [].fill(0, 0, 4)
      bin = sprintf('%032b', [value].pack('L').unpack('L')[0])
      0.upto(bin.size / 8 - 1) do |i|
        a[i] = 0xFF & (value >> 8 * i)
      end
      a
    end

    # @param [Integer] value
    # @return [Array]
    def self.serialize_long(value)
      a = [].fill(0, 0, 8)
      bin = sprintf('%040b', [value].pack('L').unpack('L')[0])
      0.upto(bin.size / 8 - 1) do |i|
        a[i] = 0xFF & (value >> 8 * i)
      end
      a
    end

    # @param [Nis::Struct::MosaicId] mosaic_id
    # @return [Array]
    def self.serialize_mosaic_id(mosaic_id)
      serialized_namespace_id = serialize_safe_string(mosaic_id.namespace_id)
      serialized_name = serialize_safe_string(mosaic_id.name)
      [serialized_namespace_id.size + serialized_name.size, 0, 0, 0] +
        serialized_namespace_id +
        serialized_name
    end

    # @param [Nis::Struct::Mosaic] mosaic
    # @return [Array]
    def self.serialize_mosaic_and_quantity(mosaic)
      a = [].fill(0, 0, 4)
      serialized_mosaic_id = serialize_mosaic_id(mosaic.mosaic_id)
      serialized_quantity = serialize_long(mosaic.quantity)
      a[0] = serialized_mosaic_id.size + serialized_quantity.size
      a += serialized_mosaic_id + serialized_quantity
    end

    # @param [Array <Nis::Struct::Mosaic>] entities
    # @return [Array]
    def self.serialize_mosaics(entities)
      a = [].fill(0, 0, 4)
      a[0] = entities.size
      a + entities.map do |ent|
        { entity: ent,
          value: [
            ent.mosaic_id.namespace_id,
            ent.mosaic_id.name,
            ent.quantity,
          ].join(':') }
      end.sort_by do |ent|
        ent[:value]
      end.map do |ent|
        serialize_mosaic_and_quantity(ent[:entity])
      end.flatten
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_property(entity)
      a = [].fill(0, 0, 4)
      serialized_name  = serialize_safe_string(entity[:name]);
      serialized_value = serialize_safe_string(entity[:value]);
      a[0] = serialized_name.size + serialized_value.size
      a + serialized_name + serialized_value
    end

    # @param [Array] entities
    # @return [Array]
    def self.serialize_properties(entities)
      a = [].fill(0, 0, 4)
      a[0] = entities.size

      helper = {
        'divisibility'  => 1,
        'initialSupply' => 2,
        'supplyMutable' => 3,
        'transferable'  => 4
      }
      a + entities.sort_by { |ent| helper[ent[:name]] }
        .map { |ent| serialize_property(ent) }.flatten
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_levy(entity)
      return [].fill(0, 0, 4) if entity.nil?
      a = [].fill(0, 0, 8)
      a[0] = entity[:type]
      temp = serialize_safe_string(entity[:recipient])
      serialized_mosaic_id = serialize_mosaic_id(entity[:mosaic_id])
      serialized_fee = serialize_long(entity[:fee])
      a += temp + serialized_mosaic_id + serialized_fee
      a[0] = 4 + temp.size + serialized_mosaic_id.size + 8;
      a
    end

    # @param [Hash] entity
    # @return [Array]
    def self.serialize_mosaic_definition(entity)
      a = [].fill(0, 0, 4)
      temp = hex2ua(entity[:creator])
      a[0] = temp.size
      a += temp
      a += serialize_mosaic_id(entity[:id])
      utf8_to_ua = hex2ua(utf8_to_hex(entity[:description]));
      a += serialize_ua_string(utf8_to_ua);
      a += serialize_properties(entity[:properties]);
      a += serialize_levy(entity[:levy]);
      a
    end

    # @param [String] hex
    # @return [Array]
    def self.hex2ua(hex)
      hex.scan(/../).map(&:hex)
    end


    def self.ua2words(ua, ua_size)
        # temp = [];
        # for (let i = 0; i < ua_size; i += 4) {
        #     let x = ua[i] * 0x1000000 + (ua[i + 1] || 0) * 0x10000 + (ua[i + 2] || 0) * 0x100 + (ua[i + 3] || 0);
        #     temp.push((x > 0x7fffffff) ? x - 0x100000000 : x);
        # }
        # CryptoJS.lib.WordArray.create(temp, ua_size);
    end

    def self.fix_private_key(private_key)
      (('0' * 64) + private_key.sub(/^00/, ''))[-64..-1]
    end

    # @param [String] hex
    # @return [Array]
    def self.hex2ua_reversed(hex)
      hex.scan(/../).map(&:hex).reverse
    end

    # @param [Array] ua
    # @return [String]
    def self.ua2hex(ua)
      ua.map { |v| '%02x' % v }.join
    end

    # @param [String] str
    # @return [String]
    def self.utf8_to_hex(str)
      rstr2utf8(str).each_byte.map { |b| b.to_s(16) }.join
    end

    # @param [String] str
    # @return [String]
    def self.rstr2utf8(str)
      str.unpack('U*').map do |c|
        case
        when c < 128
          c
        when 128 < c && c < 2048
          [((c >> 6) | 192), ((c & 63) | 128)]
        else
          [((c >> 12) | 224), (((c >> 6) & 63) | 128), ((c & 63) | 128)]
        end
      end.flatten.map(&:chr).join
    end

    def encode(sender_privkey, recipient_pubkey, message)
      sk = hex2ua(sender_privkey)
      pk = hex2ua(recipient_pubkey)
      # let shared = new Uint8Array(32);
      # let r = key_derive(shared, salt, sk, pk);
      # let encKey = r;
      # let encIv = {
      #     iv: convert.ua2words(iv, 16)
      # };
      # let encrypted = CryptoJS.AES.encrypt(CryptoJS.enc.Hex.parse(convert.utf8ToHex(msg)), encKey, encIv);
      #
      salt = RbNaCl::Random.random_bytes(32)
      iv   = RbNaCl::Random.random_bytes(16)
      ua2hex(salt) + ua2hex(iv) # + CryptoJS.enc.Hex.stringify(encrypted.ciphertext)
    end
  end
end
