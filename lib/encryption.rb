module Encryption
  module Crypter
    def self.encrypt(payload)
      result = {}

      cipher = OpenSSL::Cipher.new('aes-256-gcm')
      cipher.encrypt

      result[:key] = cipher.random_key
      result[:iv] = cipher.random_iv
      result[:salt] = SecureRandom.random_bytes(16)

      result[:data] = Encryptor.encrypt(
        algorithm: 'aes-256-gcm',
        value: payload,
        key: result[:key],
        iv: result[:iv],
        salt: result[:salt]
      )

      result
    end

    def self.decrypt(result)
      Encryptor.decrypt(
        algorithm: 'aes-256-gcm',
        value: result[:data],
        key: result[:key],
        iv: result[:iv],
        salt: result[:salt]
      )
    end
  end
end
