class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { guest: 0, host: 1, admin: 2 }

  # Associations
  has_many :properties, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_properties, through: :favorites, source: :property

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def jwt_payload
    {
      'user_id' => id,
      'email' => email,
      'role' => role
    }
  end
end
