class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :set_requested_url, :only => [:show]
  before_filter :find_app, :except => [:index] #, :only => [:new, :create, :show, :edit, :update, :destroy]
  # protect_from_forgery :except => [:show]

  # GET
  # def index
  # end
  
  # GET
  def show
    @post_id = params[:id] #this is actually the source key
  end
  
  # POST
  def create
    #[Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key
    response = RestClient.post(([Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source => params[:source], :dimension_ids => @app.id, :user_id => current_user.id
    })
    
    render :text => response.body
  end
  
  # PUT / POST
  def update
    response = RestClient.post(([Share.config.endpoint,  'sources', params[:id] + '.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source => params[:source], :dimension_ids => @app.id, :user_id => current_user.id, :_method => :put
    })
    
    render :text => response.body
  end

  # POST
  def voteup
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id] ,'up.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id],
      :user_id => current_user.id
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  # POST
  def votedown
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id],'down.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id],
      :user_id => current_user.id
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  protected
  def find_app
    @app ||= App.find(params[:app_id])
  end

  def set_requested_url
    if !user_signed_in?
      session[:requested_url] = app_post_url(params[:app_id], params[:id])
      logger.debug session[:requested_url]
    end
  end
end
