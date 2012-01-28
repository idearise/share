class Image < ActiveRecord::Base
  # REQUIRES

  # INCLUDES
  mount_uploader :file, FileUploader

  # BEHAVIORS

  # ASSOCIATIONS
  belongs_to :app

  # CALLBACKS

  # SCOPES

  # CONSTANTS

  # ATTRIBUTES
  # accepts_nested_attributes_for
  # attr_accessible

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
end