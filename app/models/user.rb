class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  devise :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]

  has_many :sakes, dependent: :destroy

  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  has_many :likes, dependent: :destroy
  has_many :liked_sakes, through: :likes, source: :sake
  def already_liked?(sake)
    self.likes.exists?(sake_id: sake.id)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end

