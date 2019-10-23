class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base || 'development_temporary_secret_key_string'
  SIGNING_ALGORITHM = 'HS256'.freeze
  EXPIRATION_TIME = 24 * 60 * 60 # 24 Hour

  def JsonWebToken.encode(payload)
    payload[:exp] = Time.now.to_i + EXPIRATION_TIME.to_i
    JWT.encode payload, SECRET_KEY, SIGNING_ALGORITHM
  end

  def JsonWebToken.decode(jwt_string)
    JWT.decode jwt_string, SECRET_KEY, true, algorithm: SIGNING_ALGORITHM
  end
end
