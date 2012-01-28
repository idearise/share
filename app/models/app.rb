class App < ActiveRecord::Base
  # REQUIRES

  # INCLUDES
  include SavedBy

  # BEHAVIORS

  # ASSOCIATIONS
  belongs_to :user
  has_many :client_platforms, :dependent => :destroy
  has_many :platforms, :through => :client_platforms
  has_many :images

  # CALLBACKS

  # SCOPES

  # CONSTANTS

  # ATTRIBUTES
  accepts_nested_attributes_for :images
  attr_accessible :name, :website, :about, :platform_ids, :platforms, :thanks_to, :twitter, :facebook, :google_plus, :android, :itunes, :images_attributes

  # VALIDATIONS
  validates :name, :presence => true
  validates_uniqueness_of :name
  validates :about, :presence => true, :length => { :in => 32..4000 }
  validate :at_least_one_platform
  validates :thanks_to, :length => { :in => 0..1000 }
  validates :twitter, :length => { :in => 0..15 } # TODO increase for future?
  # validates_format_of :facebook, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :google_plus, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :android, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :itunes, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  # CLASS METHODS

  # INSTANCE METHODS

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private
  def at_least_one_platform
    # if client_platforms.empty? or client_platforms.all? {|c| c.marked_for_destruction? }
    #   errors.add :base, "Select at least one User Platform"
    # end
    if platform_ids.empty?
      errors.add :base, "Select at least one User Platform"
    end
  end
end
