class User < ApplicationRecord
  has_many :pets, through: :appointments

  has_secure_password

  validates_presence_of :name, :email, :password_digest, :role
end
