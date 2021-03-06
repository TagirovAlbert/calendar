class User < ActiveRecord::Base


  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  TEMP_LOGIN_PREFIX = 'example_login'
  TEMP_AGE_PREFIX = 20
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
 validates :first_name,:last_name, presence: true,length: {in: 3..18}
  validates_numericality_of :age, :only_integer => true, :less_than_or_equal_to=> 100,:greater_than_or_equal_to => 12
  validates :login, presence: true, uniqueness:true
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events

  def self.find_for_facebook_oauth access_token
    if user = User.where(:uid => access_token.uid).first
      user
    else
      email_is_verified = access_token['info']['email'] && access_token['info']['verified']
      email = access_token['info']['email'] if email_is_verified
      user_new=User.new(:provider => access_token.provider,
                   :uid => access_token.uid,
                   :first_name => access_token['extra']['raw_info']['name'].split.second,
                   :last_name => access_token['extra']['raw_info']['name'].split.first,
                   :email => email ? email: "#{TEMP_EMAIL_PREFIX}-#{access_token.uid}-#{access_token.provider}.com",
                   :login => "#{TEMP_LOGIN_PREFIX}",
                   :age => "#{TEMP_AGE_PREFIX}",
                   :password => Devise.friendly_token[0,20])
      user_new.skip_confirmation!
      user_new.save!
    end
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end




  attr_accessible :first_name, :last_name,:login, :uid, :provider, :email, :age,   :password, :password_confirmation, :remember_me
end
