class ProjectPolicy
	attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
    user.role.project_manager?
  end

  def update?
    user.role.project_manager? 
  end

  def index?
    user.role.project_manager?
  end

  def project_summary?
  	user.role.project_manager?
  end

end