class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :presentations, :class_name => 'Course', :foreign_key => :user_id

  has_and_belongs_to_many :courses

  has_and_belongs_to_many :roles

  def role_symbols
    roles.map do |role|
      role.name.to_sym
    end
  end

  def name
    email
  end

end
