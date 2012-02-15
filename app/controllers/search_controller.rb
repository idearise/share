class SearchController < ApplicationController
  # GET
  def index
    if !params[:query].blank?
      @apps = App.search(params[:query])
      @users = User.search(params[:query])
    end
  end
end
