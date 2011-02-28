#require 'typus_devise'

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

  include Typus::Orm::ActiveRecord::User::InstanceMethods

  alias :orole :role
  def role
    orole.name
  end

end
