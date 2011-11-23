class Artist < ActiveRecord::Base
  attr_accessible :bio, :name, :user_id, :photo
  
  belongs_to :user
  
  has_many :albums, :dependent => :destroy
  
  validates :name, :presence => true, :length => { :maximum => 50}
  validates :bio, :presence => true, :length => { :maximum => 200}
  validates :user_id, :presence => true
  
  
  
  default_scope :order => 'artists.created_at DESC'
  
  #paperclip
  has_attached_file :photo,
     :styles => {
       :thumb=> "50x50#",
       :small  => "100x100>" },
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :s3_permissions => 'public-read',
     :path => "/artistphotos/:style/:id/:filename"
     
     validates_attachment_presence :photo
     
end
