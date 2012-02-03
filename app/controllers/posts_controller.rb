class PostsController < ApplicationController
  before_filter :current_app
  
  def show
    @post_id = params[:id] #this is actually the source key
  end
  
  def current_app
    @app ||= App.find(params[:app_id])
  end
  
  def create
    #[Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key
    response = RestClient.post(([Share.config.endpoint, 'sources.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source => params[:source], :dimension_ids => @app.id
    })
    
    render :text => response.body
  end

  def voteup
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id] ,'up.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  def votedown
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:id],'down.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_keys => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end
  
end
