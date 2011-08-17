class Comment < ActiveRecord::Base
  belongs_to :product
  
  validates :title, :content, :presence => true
end
