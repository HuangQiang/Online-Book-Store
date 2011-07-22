class Cart < ActiveRecord::Base
<<<<<<< HEAD
  has_many :line_items,:dependent => :destroy
=======
  has_many :line_items, :dependent => :destroy
>>>>>>> 269940add41ee18df983bbf99d80889df5b06e0d
end
