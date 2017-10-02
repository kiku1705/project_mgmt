class Task < ActiveRecord::Base
	STATUS = ['done', 'in_progress', 'todo'].freeze
	validates :name, :project_id, :user_id, presence: true
	validates :status, inclusion: { in: STATUS }

	belongs_to :project
	belongs_to :developer, foreign_key: "user_id", class_name: "User"
end
