module Nis::Util
  NEM_EPOCH = Time.utc(2015, 3, 29, 0, 6, 25, 0)

  def self.timestamp
    (Time.now - NEM_EPOCH).to_i
  end

  def self.error_handling(hash)
    error_klass = case hash[:error]
                  when 'Not Found' then Nis::NotFoundError
                  when 'Bad Request' then Nis::BadRequestError
                  when 'Internal Server Error' then Nis::InternalServerError
                  else Nis::Error
    end
    error_klass.new(hash[:message])
  end
end

Dir[File.expand_path('../util/*.rb', __FILE__)].each { |f| require f }
