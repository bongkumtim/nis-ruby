class Nis::Struct
  # @attr [Nis::Struct::MosaicMetaData] meta
  # @attr [Nis::Struct::Mosaic] mosaic
  # @see http://bob.nem.ninja/docs/#mosaicDefinitionMetaDataPair
  class MosaicDefinitionMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :mosaic

    def self.build(attrs)
      new(
        meta:   MosaicDefinitionMetaData.build(attrs[:meta]),
        mosaic: MosaicDefinition.build(attrs[:mosaic])
      )
    end
  end
end
