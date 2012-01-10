class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:index, :show]

  # GET
  # def index
  # end

  # GET
  # def show
  # end

  # GET
  # def edit
  # end

  # PUT / POST
  def update
    # TODO permissions
    if @user.id == current_user.id
      @user.attributes = params[:user]
      # TODO Sanitize links
      # TODO Use sanitized basic html or use markdown with a markdown editor
      # [:nickname, :email, :website, :twitter, :linkedin, :facebook, :google].each do |x|
      #   @user.attributes[x] = Sanitize.clean(@user.attributes[x])
      # end    
      # @user.bio = Sanitize.clean(
      #               view_context.auto_link(
      #                 view_context.truncate(@user.bio, 
      #                                         :length => 2000, 
      #                                         :omission => '... (truncated)'),
      #                                         :sanitize => false),
      #               Sanitize::Config::RELAXED)
      if @user.save_update_by(current_user.id, request.remote_ip)
        flash[:notice] = "Successfully updated."
        redirect_to user_path(@user)
      else
        render "edit"
      end
    else
      flash[:error] = "You are not allowed to update this user."
      redirect_to user_path(@user)
    end
  end

  # DELETE
  # def destroy
  # end

  protected
  def find_user
    @user = User.find(params[:id])
  end
end