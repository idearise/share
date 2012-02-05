class HomeController < ApplicationController
  
  def index 
    @apps = App.limit(2)
    @recent = App.limit(1).order("created_at desc")
  end
end
