class ClientPlatform < ActiveRecord::Base
  # REQUIRES

  # INCLUDES
  include SavedBy

  # BEHAVIORS

  # ASSOCIATIONS
  belongs_to :platform
  belongs_to :app

  # CALLBACKS

  # SCOPES

  # CONSTANTS

  # ATTRIBUTES
  attr_accessible :platform, :app

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
end
