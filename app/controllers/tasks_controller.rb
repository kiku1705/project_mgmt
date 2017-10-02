class TasksController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_task, only: [:update, :edit]

	def create
		@task = Task.new(task_params)
		authorize @task, :create?
		if @task.valid?
			@task.save
			flash[:notice] = 'Task created successfully'
			redirect_to projects_path
		else
			flash[:error] = @task.errors.full_messages.uniq.join('<br/>')
			render 'new'
		end
	end

	def new
		@task = Task.new
	end

	def edit
		authorize @task, :update?
	end

	def update
		authorize @task, :update?
		if @task.update_attributes(task_params)
			flash[:notice] = 'Task created successfully'
			redirect_to tasks_path
		else
			flash[:error] = @task.errors.full_messages.uniq.join('<br/>')
			render 'new'
		end
	end

	private

	def set_task
		@task = Task.find(params[:id])
	end

	def task_params
		if current_user.role.project_manager?
			params.require(:task).permit(:name, :project_id, :user_id, :status)
		else
			params.require(:task).permit(:status)
		end
	end
end