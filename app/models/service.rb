class Service < ActiveRecord::Base
  # REQUIRES

  # INCLUDES

  # BEHAVIORS

  # ASSOCIATIONS
  belongs_to :user

  # CALLBACKS

  # SCOPES

  # CONSTANTS

  # ATTRIBUTES
  attr_accessible :provider, :uid, :uname, :uemail

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
end