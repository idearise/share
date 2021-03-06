class User < ActiveRecord::Base
  # REQUIRES
  require "digest/md5"

  # INCLUDES
  include SavedBy

  # BEHAVIORS

  # ASSOCIATIONS
  has_many :services, :dependent => :destroy
  has_many :apps

  # CALLBACKS

  # SCOPES
  
  # CONSTANTS

  # ATTRIBUTES
  attr_accessible :nickname, :avatar, :last_ip, 
                  :website, :twitter, :linkedin, :facebook, :google_plus, 
                  :about

  # VALIDATIONS
  validates :name, :presence => true
  validates :nickname, :presence => true, :length => { :in => 1..32 }
  validates :about, :length => { :in => 0..2000 }
  validates :website, :length => { :in => 0..64 }
  validates :twitter, :length => { :in => 0..15 } # TODO increase for future?
  validates :linkedin, :length => { :in => 0..64 }
  validates :facebook, :length => { :in => 0..64 }
  validates :google_plus, :length => { :in => 0..64 }
  # validates_format_of :linkedin, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :facebook, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_format_of :google_plus, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  # validates_inclusion_of :is_notifiable, :in => [true, false]

  # CLASS METHODS
  def self.new_by_service_session_and_request(session, request)
    user = self.new
    user.name = session[:authhash][:name]
    user.nickname = user.name.slice(0,32) if !user.name.blank?
    user.email = session[:authhash][:email]
    user.last_ip = request.remote_ip
    user.services.build(:provider => session[:authhash][:provider], :uid => session[:authhash][:uid], :uname => session[:authhash][:name], :uemail => session[:authhash][:email])
    user
  end

  # INSTANCE METHODS
  def admin?
    nil
  end

  def picture(size=50)
    if avatar.nil?
      hash = Digest::MD5.hexdigest(self.email)
      "http://www.gravatar.com/avatar/#{hash}.jpg?s=#{size}"
    else
      avatar
    end
  end
  
  def picture_small(size=36)
    hash = Digest::MD5.hexdigest(self.email)
    "http://www.gravatar.com/avatar/#{hash}.jpg?s=#{size}"
  end

  def to_s
    self.nickname.blank? ? self.name : self.nickname
  end

  # PROTECTED METHODS
  protected

  # PRIVATE METHODS
  private

end

class Creator < User
  has_many :apps, :foreign_key => "created_by"
end

class Updater < User
  has_many :apps, :foreign_key => "updated_by"
end