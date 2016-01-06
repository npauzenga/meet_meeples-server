class Encryptor
  include BCrypt

  TOKEN_KEY = Rails.application.secrets.secret_key_base
  TOKEN_HASH = "SHA512"

  def self.digest_token(token)
    OpenSSL::HMAC.hexdigest(TOKEN_HASH, TOKEN_KEY, token).to_s
  end

  def self.generate_token
    raw = SecureRandom.urlsafe_base64.to_s
    [digest_token(raw), raw]
  end

  def self.tokens_match?(raw_token, enc_token)
    Encryptor.digest_token(raw_token) == enc_token
  end
end
