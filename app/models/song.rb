class Song < ActiveRecord::Base
  belongs_to :album
  
  has_many :line_items
  
  #paperclip
  has_attached_file :song,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :s3_permissions => 'authenticated-read',
     :path => "/songs/:style/:id/:filename"
     
  validates_attachment_presence :song
  validates_attachment_content_type :song, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :song, :less_than => 10.megabytes

end
