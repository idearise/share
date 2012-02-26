class HomeController < ApplicationController
  # GET
  def index 
    @apps = App.limit(2)
    @recent = App.limit(2).order("created_at desc")
  end
end
