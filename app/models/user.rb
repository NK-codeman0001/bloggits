class User < ApplicationRecord
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable,  :validatable

  def is_admin?
    is_admin==true
  end
  
end
