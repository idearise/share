class CommentsController < ApplicationController
  
  def create
    Rails.logger.debug(([Share.config.endpoint, 'sources', params[:post_id], 'comments.json'].join('/') + "?api_key=" + Share.config.api_key))
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:post_id], 'comments.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :comment => (params[:comment].merge(:source_id => params[:post_id])), 
      :dimension_identifiers => params[:app_id]
    })
    Rails.logger.debug(response.inspect)
    render :text => response.body
    
  end

  def voteup
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:post_id], 'comments', params[:id] ,'up.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_identifiers => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end

  def votedown
    response = RestClient.post(([Share.config.endpoint, 'sources', params[:post_id], 'comments', params[:id] ,'down.json'].join('/') + "?api_key=" + Share.config.api_key), {
      :source_id => params[:post_id], 
      :dimension_identifiers => params[:app_id]
    })
    #Rails.logger.debug(response.inspect)
    render :text => response.body
  end
end
