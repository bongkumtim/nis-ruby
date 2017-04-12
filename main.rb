require 'nis'
require 'pry'
require 'pp'
_hr = '-' * 64

# nis = Nis.new(host: '50.3.87.123')
nis = Nis.new

# Account A
A_ADDRESS     = 'TAH4MBR6MNLZKJAVW5ZJCMFAL7RS5U2YODUQKLCT'.freeze
A_PRIVATE_KEY = '00b4a68d16dc505302e9631b860664ba43a8183f0903bc5782a2403b2f9eb3c8a1'.freeze
A_PUBLIC_KEY  = '5aff2e991f85d44eed8f449ede365a920abbefc22f1a2f731d4a002258673519'.freeze

# Account B
B_ADDRESS     = 'TAFPFQOTRYEKMKWWKLLLMYA3I5SCFDGYFACCOFWS'.freeze
B_PRIVATE_KEY = '2f6bececfaa81e0ce878be6263df29d11412559132743eebde99f695fbc4e288'.freeze
B_PUBLIC_KEY  = '9fd1e5e886c4006efc715a0e183f2a87f198b8d19c44e7c67925b01aa45a7114'.freeze

# nis = Nis.new(host: '50.3.87.123')
# nis = Nis.new

# puts nis.heartbeat

# a = Nis::Unit::Balance.new(100)
# b = Nis::Unit::Balance.new(200)
#
# puts a < b

# address = Nis::Unit::Address.new('TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS')
# puts address.valid?
# puts nis.request! :get, 'account/generate'

puts 'Account A => balance: %d' %
  (nis.account_get address: A_ADDRESS)[:account][:balance]
puts 'Account B => balance: %d' %
  (nis.account_get address: B_ADDRESS)[:account][:balance]
puts _hr

# t = Nis::Struct::Transaction.new(
#   amount:    100_000,
#   fee:     1_000_000,
#   recipient: B_ADDRESS,
#   signer: A_PUBLIC_KEY,
#   message: {
#     payload: '',
#     type: 1
#   },
#   type: Nis::Struct::Transaction::TRANSFER,
#   timestamp: Nis::Util.timestamp,
#   deadline: Nis::Util.timestamp + 43_200,
#   version: Nis::Struct::Transaction::TESTNET_VERSION_1
# )

# rpa = Nis::Struct::RequestPrepareAnnounce.new(
#   transaction: t,
#   privateKey: A_PRIVATE_KEY
# )
#
# puts nis.transaction_prepare_announce(rpa).inspect
