class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_app #, :only => [:new, :create, :show, :edit, :update, :destroy]
  # protect_from_forgery :except => [:show]
  
  # GET
  def show
    @post_id = params[:id] #this is actually the source key
  end
  
  # POST
  def create
    #[Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key
    response = RestClient.post(([Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source => params[:source], :dimension_ids => @app.id
    })
    
    render :text => response.body
  end

  # POST
  def voteup
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id] ,'up.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  # POST
  def votedown
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id],'down.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  protected
  def find_app
    @app ||= App.find(params[:app_id])
  end
end
