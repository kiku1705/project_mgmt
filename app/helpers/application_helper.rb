module ApplicationHelper
	def project_list
		Project.pluck(:name,:id)
	end

	def developer_list
		User.pluck(:email, :id)
	end

	def project_managers_list
		User.project_managers.pluck(:email, :id)
	end
end
