class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :presentations, :class_name => 'Course', :foreign_key => :user_id

  has_many :course_registrations
  has_many :courses, :through => :course_registrations

  belongs_to :role

  public

  #
  # Typus adaptation
  #

  enable_as_typus_user

  ROLE = Typus::Configuration.roles.keys.sort
  LANGUAGE = Typus.locales

  def self.authenticate(email, password)
    resource = find_for_database_authentication({ :email=>email })
    resource && resource.valid_password?( password ) ? resource : nil
  end

  # Typus redefines it
  def password_required?
    true
  end
  
  def first_name
    email
  end

  def last_name
  end

  def preferences
    ''
  end


end
