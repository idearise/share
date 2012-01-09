class Platform < ActiveRecord::Base
  # REQUIRES

  # INCLUDES

  # BEHAVIORS

  # ASSOCIATIONS
  has_many :client_platforms, :dependent => :destroy
  has_many :apps, :through => :client_platforms

  # CALLBACKS

  # SCOPES
  scope :order_display, :order => 'platforms.display_order ASC'  

  # CONSTANTS

  # ATTRIBUTES
  #attr_accessible :name

  # VALIDATIONS

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
end
