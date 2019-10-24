class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  rescue_from JWT::VerificationError, with: :api_unauthorized_exception_response
  rescue_from JWT::ExpiredSignature, with: :api_unauthorized_exception_response
  rescue_from JWT::DecodeError, with: :api_unauthorized_exception_response

  protected

  def save_cookie_in_browser(key, value)
    # SSL is not enforced on the Rails app level,
    # thus :secure option cannot be set, regardless of environment.
    cookies.signed[key.to_sym] = {
      value: value,
      httponly: true,
      domain: Rails.env.production? ? 'hamkuu.com' : nil,
    }
  end

  def remove_cookie_from_browser(key)
    cookies.delete key.to_sym, domain: Rails.env.production? ? 'hamkuu.com' : nil
  end

  def get_response_with_params(endpoint, params)
    uri = URI(endpoint)

    headers = { Accept: 'application/json' }

    Net::HTTP.post(uri, params.to_query, headers)
  end

  def get_response_with_token_auth(endpoint, token)
    uri = URI.parse(endpoint)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Get.new(uri.request_uri)
    req['Authorization'] = 'Token ' + token

    http.request(req)
  end

  private

  def api_unauthorized_exception_response(message)
    render status: :unauthorized, json: { status: false, message: message }
  end
end
