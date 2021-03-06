class RecipesController < ApplicationController
  layout 'project'

  before_action :load_owner
  before_action :load_project
  before_action :load_recipe
  after_action :update_project, only: [:update]

  authorize_resource parent: Project.name

  def show
  end

  def update
    if @recipe.update recipe_params
      render :update
    else
      render 'errors/failed', status: 400
    end
  end

  private

  def recipe_params
    if params[:recipe]
      params.require(:recipe).permit states_attributes: [:id, :position]
    end
  end

  def load_owner
    owner_id = params[:owner_name] || params[:user_id] || params[:group_id]
    @owner = ProjectOwner.friendly_first(owner_id)
  end

  def load_project
    @project = @owner.projects.friendly.find params[:project_id]
  end

  def load_recipe
    @recipe = @project.recipe
  end

  def update_project
    if @_response.response_code == 200
      @project.updated_at = DateTime.now.in_time_zone
      @project.save!
    end
  end
end
