class AddAttachmentPhotosToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :photos
    end
  end

  def self.down
    drop_attached_file :photos, :photos
  end
end
