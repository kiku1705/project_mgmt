class User < ActiveRecord::Base
	extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enumerize :role, in: [:developer, :project_manager], default: :developer
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  has_many :projects, through: :tasks

  scope :project_managers , -> { where(role:'project_manager') } 
end
