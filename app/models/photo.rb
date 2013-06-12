class Photo < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :photos
  belongs_to :product

  has_attached_file :photos,
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"
end
