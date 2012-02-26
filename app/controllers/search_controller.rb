class SearchController < ApplicationController
  # GET
  def index
    if !params[:query].blank?
    	q = Sanitize.clean(params[:query])
      @apps = App.search(q)
      @users = User.search(q)
    end
  end
end
