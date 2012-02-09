class App < ActiveRecord::Base
  # REQUIRES

  # INCLUDES
  include SavedBy

  # BEHAVIORS
  paginates_per 8

  # ASSOCIATIONS
  belongs_to :user
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updater, :class_name => "User", :foreign_key => "updated_by"
  has_many :client_platforms, :dependent => :destroy
  has_many :platforms, :through => :client_platforms
  has_many :images, :dependent => :destroy

  # CALLBACKS

  # SCOPES
  scope :order_recent, order("updated_at DESC")
  scope :order_created, order("created_at DESC")

  # CONSTANTS

  # ATTRIBUTES
  accepts_nested_attributes_for :images, :allow_destroy => true
  attr_accessible :name, :website, :about,
                  :twitter, :facebook, :google_plus, :android, :itunes,
                  :platform_ids, :platforms, 
                  :images_attributes

  # VALIDATIONS
  validates :name, :presence => true
  validates_uniqueness_of :name, :case_sensitive => false
  validates :about, :presence => true, :length => { :in => 32..4000 }
  validate :at_least_one_platform
  validates :twitter, :length => { :in => 0..15 } # TODO increase for future?
  validates :facebook, :length => { :in => 0..255 }
  validates :google_plus, :length => { :in => 0..255 }
  validates :android, :length => { :in => 0..255 }
  validates :itunes, :length => { :in => 0..255 }
  # validates_format_of :facebook, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :google_plus, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :android, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :itunes, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix

  # CLASS METHODS
  def self.by_platform(platform_id)
    joins(:client_platforms).
    where("client_platforms.platform_id = ?", platform_id)
  end

  def self.by_updated_at(d)
    where("updated_at > ?", d.to_i.days.ago)
  end

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
