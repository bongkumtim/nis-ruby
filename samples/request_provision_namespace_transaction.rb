require 'nis'
hr = '-' * 64

# Account A (Source)
A_ADDRESS = 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT'.freeze
A_PRIVATE_KEY = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'.freeze
A_PUBLIC_KEY  = '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519'.freeze

# build Transaction Object
tx = Nis::Struct::ProvisionNamespaceTransaction.new(
  timeStamp: Nis::Util.timestamp,
  # signature: '',
  fee:  20_000_000,
  type: Nis::Struct::ProvisionNamespaceTransaction::TYPE,
  deadline: Nis::Util.timestamp + 43_200,
  version:  Nis::Util::TESTNET_VERSION_1,
  signer:   A_PUBLIC_KEY,
  rentalFeeSink: Nis::Util::NAMESPACE_SINK[:testnet],
  rentalFee: 5_000_000_000,
  newPart: 'alice',
  parent:  nil
)

# build RequestPrepareAnnounce Object
rpa = Nis::Struct::RequestPrepareAnnounce.new(
  transaction: tx,
  privateKey: A_PRIVATE_KEY
)

# Create NIS instance
nis = Nis.new

# Send XEM request.
res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
puts res.message
puts hr
