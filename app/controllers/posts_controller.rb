class PostsController < ApplicationController
  before_filter :current_app
  
  def show
    @source_id = params[:id] #this is actually the source identifier
  end
  
  def current_app
    @app ||= App.find(params[:app_id])
  end
end
