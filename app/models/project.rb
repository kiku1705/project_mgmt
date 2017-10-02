class Project < ActiveRecord::Base
	validates :name, :description, presence: true
	has_many :tasks
	has_many :developers, through: :tasks, class_name: "User"

	belongs_to :project_manager, foreign_key: "user_id", class_name: "User"

	scope :manager_projects, lambda { |manager_id|  where(user_id: manager_id) }
end
