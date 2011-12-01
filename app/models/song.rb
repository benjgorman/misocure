class Song < ActiveRecord::Base
  belongs_to :album
  
  has_many :line_items
  
  #paperclip
  has_attached_file :song,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :s3_permissions => 'authenticated-read',
     :path => "/songs/:style/:id/:filename",
     :s3_headers => { :content_disposition => 'attachment' }
     
  validates_attachment_presence :song
  validates_attachment_content_type :song, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :song, :less_than => 10.megabytes

  def self.search(search)
      if search
        find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      else
        find(:all)
     end      
  end
  def download_url(style = nil, include_updated_timestamp = true)
    url = Paperclip::Interpolations.interpolate('/songs/:style/:id/:filename', song, style || song.default_style)
    include_updated_timestamp && song.updated_at ? [url, song.updated_at].compact.join(url.include?("?") ? "&" : "?") : url
  end

  def authenticated_url(style = nil, expires_in = 100.seconds)
   AWS::S3::S3Object.url_for(song.path(style || song.default_style), song.bucket_name, :expires_in => expires_in, :use_ssl => song.s3_protocol == 'https')
  end

end
