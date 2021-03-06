class Nis::Struct
  # @attr [Nis::Struct::UnconfirmedTransactionMetaData] meta
  # @attr [Nis::Struct::Transaction] transaction
  # @see http://bob.nem.ninja/docs/#unconfirmedTransactionMetaDataPair
  class UnconfirmedTransactionMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :transaction

    def self.build(meta:, transaction:)
      new(
        meta: UnconfirmedTransactionMetaData.build(meta),
        transaction: Transaction.build(transaction)
      )
    end
  end
end
