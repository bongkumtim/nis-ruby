class Nis::Builder
  class Transaction
    NETWORKS = [
      :testnet,
      :mainnet
    ]

    TYPES = [
      :transfer,
      :importance_transfer,
      :multisig_aggregate_modification_transfer,
      :multisig_signature,
      :multisig,
      :provision_namespace,
      :mosaic_definition_creation,
      :mosaic_supply_change
    ]

    VERSIONS = [
      1,
      2
    ]

    # @option [Symbol] network
    # @option [Symbol] type
    # @option [Symbol] version
    def initialize(network:, type:, version:)
      unless NETWORKS.include?(network)
        raise ArgumentError, "Supported networks => #{NETWORKS.join(' / ')}"
      end
      unless TYPES.include?(type)
        raise ArgumentError, "Supported types => #{TYPES.join(' / ')}"
      end
      unless VERSIONS.include?(version)
        raise ArgumentError, "Supported versions => #{VERSIONS.join(' / ')}"
      end

      @transaction = Nis::Struct::Transaction.new(
        type: Nis::Struct::Transaction.const_get(type.upcase),
        version: Nis::Struct::Transaction.const_get("#{network.upcase}_VERSION_#{version}"),
        deadline: 43_200 # default 12 hours
      )

      yield self if block_given?
    end

    def amount=(amount)
      @transaction.amount = Nis::Unit::Balance.new(amount)
    end

    def fee=(fee)
      @transaction.fee = Nis::Unit::Balance.new(fee)
    end

    def recipient=(address)
      @transaction.recipient = Nis::Unit::Address.new(address)
    end

    def signer=(public_key)
      @transaction.recipient = public_key
    end

    def message=(payload, type: 1)
      @transaction.message = { payload: payload, type: type }
    end

    def timestamp=(timestamp)
      @transaction.timestamp = timestamp
    end

    def deadline=(seconds)
      @transaction.deadline = Nis::Util.now + seconds
    end

    def add_mosaic(mosaic)
      @transaction.mosaics << mosaic
      @transaction
    end

    # @return [Nis::Struct::Transaction]
    def transaction
      @transaction.timestamp = Nis::Util.now
      @transaction
    end

    # friendly access
    alias to=   recipient=
    alias from= signer=
  end
end
