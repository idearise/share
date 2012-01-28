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
end
