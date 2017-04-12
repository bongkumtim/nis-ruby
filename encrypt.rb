require 'nis'
require 'pry'
require 'pp'
_hr = '-' * 64

# Account A (Source)
A_ADDRESS = 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT'.freeze
A_PRIVATE_KEY = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'.freeze
A_PUBLIC_KEY  = '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519'.freeze

# Account B (Dist)
B_ADDRESS = 'TAFPFQOTRYEKMKWWKLLLMYA3I5SCFDGYFACCOFWS'.freeze
B_PRIVATE_KEY = '2f6bececfaa81e0ce878be6263df29d11412559132743eebde99f695fbc4e288'.freeze
B_PUBLIC_KEY  = '9fd1e5e886c4006efc715a0e183f2a87f198b8d19c44e7c67925b01aa45a7114'.freeze

# Account C (Dist)
C_ADDRESS = 'TDJNDAQ7F7AQRXKP2YVTH67QYCWWKE6QLSJFWN64'.freeze
C_PRIVATE_KEY = '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3'.freeze
C_PUBLIC_KEY  = '6d72b57d2bc199d328e7ea3e24775f7f614760bc18f3f8501cd3daa9870cc40c'.freeze

# Account D (Dist)
D_ADDRESS = 'TDWWYDGQNBKSAJBSHZX7QWVX7WNVAWWB7HGPWRB2'.freeze
D_PRIVATE_KEY = '00b8bd961ed1f33200fff2a389a4cd23a79a2913dd9b6d29e32e44febdf9fca394'.freeze
D_PUBLIC_KEY  = '0efc3228277de0f8c6107bac5d183bcb3497d58edd632273f1d03cae7d8f852d'.freeze

# Create NIS instance
nis = Nis.new(host: '104.128.226.60')

# puts nis.account_transfers_incoming(
#   address: A_ADDRESS,
#   # hash: 'f6ce36ca96d2f95996a4bfb99858df84d1547462a2bf8f19eedf8f2083df70b6',
#   # id: 109322
# ).first.to_json
# puts nis.request(:get, '/account/transfers/incoming',
#   address: A_ADDRESS,
#   hash: 'f6ce36ca96d2f95996a4bfb99858df84d1547462a2bf8f19eedf8f2083df70b6',
#   # id: 109322
# ).to_json

# check banalces before sending XEM.
# puts 'Account A => balance: %d' %
#   (nis.account_get address: A_ADDRESS)[:account][:balance]
# puts 'Account B => balance: %d' %
#   (nis.account_get address: B_ADDRESS)[:account][:balance]
# puts 'Account C => balance: %d' %
#   (nis.account_get address: C_ADDRESS)[:account][:balance]
# puts 'Account D => balance: %d' %
#   (nis.account_get address: D_ADDRESS)[:account][:balance]
# puts _hr
#
tx = {
  type: Nis::Struct::Transaction::TRANSFER,
  version:   Nis::Struct::Transaction::TESTNET_VERSION_1,
  timeStamp: Nis::Util.timestamp,
  signer: B_PUBLIC_KEY,
  fee:    1_000_000,
  deadline:  Nis::Util.timestamp + 43_200,

  recipient: A_ADDRESS,
  amount: 5_000_000,
  message: {
    payload: '',
    type: 1
  },
}

# puts '' % [tx[:type]]
puts [tx[:type]].pack('i')
puts [tx[:version]].pack('i')

exit

params = {
  data: '',
  signature: ''
}

pp nis.request(:post, '/transaction/announce/', params)

exit

# build Transaction Object
# t = Nis::Struct::Transaction.new(
#   amount: 487000006,
#   fee:      1000000,
#   recipient: A_ADDRESS,
#   signer: B_PUBLIC_KEY,
#   message: {
#     payload: '',
#     type: 1
#   },
#   type: Nis::Struct::Transaction::TRANSFER,
#   timeStamp: Nis::Util.timestamp,
#   deadline:  Nis::Util.timestamp + 43_200,
#   version:   Nis::Struct::Transaction::TESTNET_VERSION_1
# )
#
# # build RequestPrepareAnnounce Object
# rpa = Nis::Struct::RequestPrepareAnnounce.new(
#   transaction: t,
#   privateKey: B_PRIVATE_KEY
# )
#
# # Send XEM request.
# res = nis.transaction_prepare_announce(request_prepare_announce: rpa)
# puts res.inspect
#
# After several minutes, check to see Account B received XEM.
