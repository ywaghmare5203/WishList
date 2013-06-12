class Product < ActiveRecord::Base
  attr_accessible  :name, :descripton, :wish_date,  :lat, :lng

  belongs_to :user
  has_many :photos,:dependent => :destroy
end
