class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
  

  has_many :sakes, dependent: :destroy

  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  has_many :likes, dependent: :destroy
  has_many :liked_sakes, through: :likes, source: :sake
  def already_liked?(sake)
    self.likes.exists?(sake_id: sake.id)
  end
  

end

