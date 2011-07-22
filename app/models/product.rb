class Product < ActiveRecord::Base
<<<<<<< HEAD
  default_scope :order => 'title'
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :title
  validates_format_of :image_url,:with => %r{\.(gif|jpg|png)$}i,:message => 'must be a URL for GIF, JPG or PNG image'
  protected
  def price_must_be_at_least_a_cent
    errors.add(:price,'should be at least 0.01') if price.nil? || price < 0.01
  end
  
  def ensure_not_referenced_by_any_line_item
=======
  
  default_scope :order => 'title'
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  #ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    
>>>>>>> 269940add41ee18df983bbf99d80889df5b06e0d
    if line_items.count.zero?
      return true
    else
      errors[:base] << "Line Items present"
      return false
    end
<<<<<<< HEAD
  end

end
=======
    
  end
  
  
  validates :title, :description, :image_url, :presence => true
  
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  
  validates :title, :uniqueness => true
  
  validates :image_url, :format => {
    :with        => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPC or PNG image.'
  }
end
>>>>>>> 269940add41ee18df983bbf99d80889df5b06e0d
