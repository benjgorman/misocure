class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :line_items
  
  has_many :songs, :through => :line_items
  
  has_one :payment

end
