class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :user_labels]
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]
  before_filter :find_services, :only => [:edit, :update]
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
  def user_labels
    @users = User.find(params[:user_ids].split(",").map(&:to_i).uniq)
  end
  
  def update
    # TODO permissions
    if @user.id == current_user.id
      @user.attributes = params[:user]
      # TODO Sanitize links
      # [:nickname, :email, :website, :twitter, :linkedin, :facebook, :google].each do |x|
      #   @user.attributes[x] = Sanitize.clean(@user.attributes[x])
      # end    
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

  def find_services
    @services = current_user.services.order("provider asc")
  end
end