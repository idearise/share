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
  attr_accessible :description, :file, :file_cache, :remove_file, :remove_file_cache

  # VALIDATIONS
  validates :description, :length => { :in => 0..32 }

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
end