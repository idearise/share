class AppsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :popular, :recent, :show]
  before_filter :set_requested_url, :only => [:show]
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]
  before_filter :find_platforms, :only => [:new, :create, :edit, :update]
  protect_from_forgery :except => [:index, :popular, :recent]

  # GET
  def index
    if params[:platform].blank?
      @apps = App.order_created.page(params[:page]).per(8)
    else
      @apps = App.by_platform(params[:platform]).
                  order_created.page(params[:page]).per(8)
    end
  end

  # GET
  # FIXME Get popularity from Sortary
  def popular
    if params[:platform].blank?
      @apps = App.order_recent.page(params[:page]).per(8)
    else
      @apps = App.by_platform(params[:platform]).
                  order_recent.page(params[:page]).per(8)
    end
  end

  # GET
  def recent
    days = (params[:days].blank? ? 30 : params[:days]) 
    @apps = App.by_updated_at(days).
            order_recent.page(params[:page]).per(8)
  end

  # GET
  def new
    @app = App.new
    # @app.images.build
  end

  # POST
  def create
    @app = App.new
    @app.attributes = {'platform_ids' => []}.merge(params[:app] || {})
    @app.user_id = current_user.id
    # TODO Sanitize links
    # [:name, :website, :twitter, :facebook, :google_plus, :android, :itunes].each do |x|
    #   @app.attributes[x] = Sanitize.clean(@app.attributes[x])
    # end
    
    if @app.save_new_by(current_user.id, request.remote_ip)
      response = RestClient.post(([Share.config.endpoint, 'categories.json'].join('/') + "?api_key=" + Share.config.api_key), {
        :category_type_key => Share.config.category_type_key, 
        :category => {
          :name => @app.name,
          :key => @app.id
        }
      })

      json = HashWithIndifferentAccess.new(ActiveSupport::JSON.decode(response.body))
      if json[:success]
        redirect_to app_path(@app), :notice => "Successfully added."
      else
        redirect_to app_path(@app), :notice => "Successfully added."#"But posts are disabled. . :("
      end
      
      
    else
      render "new"
    end
  end

  # GET
  def show
    @platforms = @app.platforms
  end

  # GET
  # def edit
  # end

  # PUT / POST
  def update
    # TODO permissions
    if @app.user_id == current_user.id
      # @app.attributes = params[:app]
      @app.attributes = {'platform_ids' => []}.merge(params[:app] || {})
      # TODO Sanitize links
      # [:name, :website, :twitter, :facebook, :google_plus, :android, :itunes].each do |x|
      #   @app.attributes[x] = Sanitize.clean(@app.attributes[x])
      # end
      if @app.save_update_by(current_user.id, request.remote_ip)
        flash[:notice] = "Successfully updated."
        redirect_to app_path(@app)
      else
        render "edit"
      end
    else
      flash[:error] = "You are not allowed to update the app."
      redirect_to app_path(@app)
    end
  end

  # DELETE
  # def destroy
  # end

  protected
  def find_app
    @app = App.find(params[:id])
  end

  def find_platforms
    @platforms = Platform.order_display
  end

  def set_requested_url
    if !user_signed_in?
      session[:requested_url] = app_url(params[:id])
    end
  end
end
