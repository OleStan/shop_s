class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:github] #, :twitter

  has_many :orders
  has_many :carts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable



  def self.from_omniauth(auth)
    puts auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts user
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      !auth.info.email.nil? ? user.email = auth.info.email : user.email = auth.info.nickname
    end
  end
end
