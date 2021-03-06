class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
      user: user
    }
  end

  private
  def user
    user_obj = User.find(decoded_auth_token[:user_id])

    @user ||= user_obj if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => error
    raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token} #{error.message}"))
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end