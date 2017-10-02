class UsersController < ApplicationController
	before_filter :authenticate_user!

	def developer_dashboard
		@data = Hash.new { |hash, key| hash[key] = {} }
		@projects = current_user.projects.pluck(:name).uniq
		current_user.tasks.includes(:project).find_each do |task|
			(@data[task.status][task.project.name] ||= [] ) << task.name
		end
	end
end