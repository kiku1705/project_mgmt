class ProjectsController < ApplicationController
	before_filter :authenticate_user!
	def index
	end

	def create
		@project = Project.new(project_params)
		authorize @project, :create?
		if @project.valid?
			@project.save
			flash[:notice] = 'Project created successfully'
			redirect_to projects_path
		else
			flash[:error] = @project.errors.full_messages.uniq.join('<br/>')
			render 'new'
		end
	end

	def project_summary
		@project = Project.find(params[:id])
		authorize @project, :create?
		@data = Hash.new { |hash, key| hash[key] = {} }
		@developers = @project.developers.pluck('users.email').uniq
		@project.tasks.includes(:developer).find_each do |task|
			(@data[task.status][task.developer.email] ||= [] ) << task.name
		end
	end

	def chart_summary
		project = Project.find(params[:id])
		summery = project.tasks.select("SUM(case tasks.status when 'todo' then 1 else 0 end) as todo, SUM(case tasks.status when 'in_progress' then 1 else 0 end) as in_progress, SUM(case tasks.status when 'done' then 1 else 0 end) as done")
		status_arr = [['Status', 'count']]
		Task::STATUS.each do |status|
			status_arr << [status.titleize, summery[0].try(:send, status)]
		end
		render json: { task_data: status_arr }
	end

	private

	def project_params
		params.require(:project).permit(:name, :description, :user_id)
	end
end