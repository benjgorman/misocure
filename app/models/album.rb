class Album < ActiveRecord::Base
  belongs_to :artist
  belongs_to :order
  
  has_many :songs, :dependent => :destroy
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end      
  end
  #paperclip
  has_attached_file :photo,
     :styles => {
       :thumb=> "50x50#",
       :small  => "400x400>" },
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :s3_permissions => 'public-read',
     :path => "/albumartwork/:style/:id/:filename"
     
     validates_attachment_presence :photo
end
