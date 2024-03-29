require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :terms
  
  has_many :artists, :dependent => :destroy
  has_many :orders
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 50}
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :password, :presence => true,
                       :confirmation => true,
                       :length      => { :within =>6..40 }
                     
   validates_acceptance_of :terms
   
   before_save :encrypt_password
   
   def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end      
  end
   
   
   # Return true if the user's password matchs the submitted password
   def has_password? (submitted_password)
     encrypted_password == encrypt(submitted_password)
   end
   
   def self.authenticate(email, submitted_password)
     user = find_by_email(email)
     return nil if user.nil?
     return user if user.has_password?(submitted_password)
   end
   
   def self.authenticate_with_salt(id, cookie_salt)
     user = find_by_id(id)
     (user && user.salt == cookie_salt) ? user : nil #crazy boolean
   end
   
   
   private
   
     def encrypt_password
       self.salt = make_salt if new_record?
       self.encrypted_password = encrypt(password)
       
       self.verify_token = encrypt2(Time.now.utc)
     end
     
     def secure_hash2(string)
       Digest::SHA1.hexdigest(string)
     end
     
     def encrypt2(string)
       secure_hash2("#{salt}--#{string}")
     end
     
     def encrypt(string)
       secure_hash("#{salt}--#{string}")
     end
     
     def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
     end
     
     def secure_hash(string)
       Digest::SHA2.hexdigest(string)
     end
  
end
