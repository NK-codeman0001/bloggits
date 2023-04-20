class User < ApplicationRecord
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable,  :validatable
  

  validates :username, presence: true, uniqueness: true

  def is_admin?
    is_admin==true
  end
  
end
