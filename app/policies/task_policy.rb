class TaskPolicy
	attr_reader :user, :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def create?
    @user.role.project_manager?
  end

  def update?
    @user.role.project_manager? || (@task.user_id == @user.id && @user.role.developer?)
  end

end