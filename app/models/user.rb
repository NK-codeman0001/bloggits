class User < ApplicationRecord
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable,  :validatable, :omniauthable, omniauth_providers: %i[twitter google_oauth2 facebook linkedin]
  

  validates :username, presence: true, uniqueness: true

  def is_admin?
    is_admin==true
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   user.provider = auth.provider
  #   user.uid = auth.uid
  #   user.username = auth.info.nickname
  #   # user.email = auth.info.email
  #   # user.password = Devise.friendly_token[0, 20]
  #   # user.name = auth.info.name # assuming the user model has a name
  #   # user.username = auth.info.nickname # assuming the user model has a username
  #   #user.image = auth.info.image # assuming the user model has an image
  #   # If you are using confirmable and the provider(s) you use validate emails,
  #   # uncomment the line below to skip the confirmation emails.
  #   # user.skip_confirmation!
  #   end
  # end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts user
      user.provider = auth.provider
      user.uid = auth.uid
      if user.provider == "google_oauth2" || user.provider == "facebook"
        user.username = auth.info.email.split('@').first
      else
        user.username = auth.info.nickname
      end
      user.email = auth.info.email

    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
end
