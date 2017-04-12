require 'spec_helper'

describe Nis::Struct::AccountMetaData do
  let(:attrs) do
    {
      status: 'UNKNOWN',
      remote_status: 'ACTIVE',
      cosignatory_of: [],
      cosignatories: []
    }
  end
  let(:struct) { described_class.new(attrs) }

  subject { struct }

  describe '#unknown?' do
    it { expect(subject.unknown?).to be true }
  end

  describe '#locked?' do
    let(:attrs) { { status: 'LOCKED', remote_status: 'ACTIVE', cosignatory_of: [], cosignatories: [] } }
    it { expect(subject.locked?).to be true }
  end

  describe '#unlocked?' do
    let(:attrs) { { status: 'UNLOCKED', remote_status: 'ACTIVE', cosignatory_of: [], cosignatories: [] } }
    it { expect(subject.unlocked?).to be true }
  end
end
