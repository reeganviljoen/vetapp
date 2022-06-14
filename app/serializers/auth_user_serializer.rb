class AuthUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :auth_token

  def auth_token
    token = AuthenticateUser.new(object.email, object.password).call
  end
  has_many :appointments
  has_many :registrations
end
