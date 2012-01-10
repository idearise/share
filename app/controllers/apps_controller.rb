class AppsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :popular, :recent, :show]
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]
  before_filter :find_platforms, :only => [:new, :create, :edit, :update]
  protect_from_forgery :except => [:index, :popular, :recent]

  # GET
  # def index
  # end

  # GET
  # def popular
  # end

  # GET
  # def recent
  # end

  # GET
  def new
    @app = App.new
  end

  # POST
  def create
    @app = App.new(params[:app])
    @app.attributes = {'platform_ids' => []}.merge(params[:app] || {})
    @app.user_id = current_user.id
    # TODO Sanitize links
    # TODO Use sanitized basic html or use markdown with a markdown editor
    # [:name, :website, :twitter, :facebook, :google_plus, :android, :itunes].each do |x|
    #   @app.attributes[x] = Sanitize.clean(@app.attributes[x])
    # end    
    # @app.text = Sanitize.clean(
    #               view_context.auto_link(
    #                 view_context.truncate(@app.text, 
    #                                         :length => 2000, 
    #                                         :omission => '... (truncated)'),
    #                                         :sanitize => false),
    #               Sanitize::Config::RELAXED)
    if @app.save_new_by(current_user.id, request.remote_ip)
      flash[:notice] = "Successfully added."
      redirect_to app_path(@app)
    else
      render "new"
    end
  end

  # GET
  # def show
  # end

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
      # TODO Use sanitized basic html or use markdown with a markdown editor
      # [:name, :website, :twitter, :facebook, :google_plus, :android, :itunes].each do |x|
      #   @app.attributes[x] = Sanitize.clean(@app.attributes[x])
      # end    
      # @app.text = Sanitize.clean(
      #               view_context.auto_link(
      #                 view_context.truncate(@app.text, 
      #                                         :length => 2000, 
      #                                         :omission => '... (truncated)'),
      #                                         :sanitize => false),
      #               Sanitize::Config::RELAXED)
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
end
