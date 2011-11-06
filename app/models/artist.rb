class Artist < ActiveRecord::Base
  attr_accessible :bio, :name, :user_id
  
  belongs_to :user
  
  validates :name, :presence => true, :length => { :maximum => 50}
  validates :bio, :presence => true, :length => { :maximum => 200}
  validates :user_id, :presence => true
  validates_attachment_presence :photo
  
  
  default_scope :order => 'artists.created_at DESC'
  
  #paperclip
  has_attached_file :photo,
     :styles => {
       :thumb=> "100x100#",
       :small  => "400x400>" },
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "/:style/:id/:filename"
end
