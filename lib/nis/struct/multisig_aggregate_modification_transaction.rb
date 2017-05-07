class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [String]  signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Array <Nis::Struct::MultisigCosignatoryModification>] modifications
  # @attr [Hash] minCosignatories
  # @see http://bob.nem.ninja/docs/#multisigAggregateModificationTransaction
  class MultisigAggregateModificationTransaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :fee, :type, :deadline, :version, :signer,
                  :modifications, :minCosignatories

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias min_cosignatories minCosignatories
    alias min_cosignatories= minCosignatories=

    TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def _version
      (0xFFFFFFF0 & @version)
    end

    # @return [Boolean]
    def testnet?
      (0x0000000F & @version) == Nis::Util::TESTNET
    end

    # @return [Boolean]
    def mainnet?
      (0x0000000F & @version) == Nis::Util::MAINNET
    end
  end
end
