# nis-ruby

[![Gem Version](https://badge.fury.io/rb/nis-ruby.svg)](https://badge.fury.io/rb/nis-ruby)
[![Build Status](https://travis-ci.org/44uk/nis-ruby.svg?branch=master)](https://travis-ci.org/44uk/nis-ruby)
[![Code Climate](https://codeclimate.com/github/44uk/nis-ruby/badges/gpa.svg)](https://codeclimate.com/github/44uk/nis-ruby)
[![Join the chat at https://gitter.im/44uk/nis-ruby](https://badges.gitter.im/44uk/nis-ruby.svg)](https://gitter.im/44uk/nis-ruby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

<img src="https://cloud.githubusercontent.com/assets/370508/24320282/a332d238-1175-11e7-96dc-75bc30e562d2.png" width="320" height="320" alt="NEM" align="right" />

Ruby client library for the NEM Infrastructure Server API

- [NEM \- Distributed Ledger Technology \(Blockchain\)](https://www.nem.io/)
- [NEM NIS API Documentation](http://bob.nem.ninja/docs/)


## Installation

```bash
$ gem install nis-ruby
```

Or add this line to your application's Gemfile:

```ruby
gem 'nis-ruby'
```


## Usage

```ruby
nis = Nis.new

nis.heartbeat
# => {code: 1, type: 2, message: "ok"}
# See http://bob.nem.ninja/docs/#heart-beat-request

nis.status
# => {code: 6, type: 4, message: "status"}
# See http://bob.nem.ninja/docs/#status-request

nis.request(:get, '/account/get',
  address: 'TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS'
)
# => [AccountMetaDataPair structure]
# See http://bob.nem.ninja/docs/#accountMetaDataPair

nis.request(:post, '/account/unlock',
  privateKey: '00983bb01d05edecfaef55df9486c111abb6299c754a002069b1d0ef4537441bda'
)
# => Nothing
# See http://bob.nem.ninja/docs/#locking-and-unlocking-accounts
```


## Documentation

Available at [rubydoc.info](http://www.rubydoc.info/gems/nis-ruby).


## Commandline

```bash
$ nis status # => {"code":6,"type":4,"message":"status"}
$ nis heartbeat # => {"code":1,"type":2,"message":"ok"}
$ nis request get account/get --params=address:TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS
# => [AccountMetaDataPair structure]
$ nis request get account/harvests --params=address:TALICELCD3XPH4FFI5STGGNSNSWPOTG5E4DS2TOS hash:81d52a7df4abba8bb1613bcc42b6b93cf3114524939035d88ae8e864cd2c34c8
# => [Array <HervestInfo structure>]
```


## Connection

### Environment Variable

```bash
$ export NIS_URL=http://bigalice3.nem.ninja:7890
$ nis heartbeat # => {"code":1,"type":2,"message":"ok"}
```

### Hash

```ruby
# Passing hostname
Nis.new(host: 'bigalice3.nem.ninja')

# Passing url
Nis.new(url: 'http://bigalice3.nem.ninja:7890')
```


## TODO

- Do more improvements.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nis-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
