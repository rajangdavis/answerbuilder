class AddImageUploadToSteps < ActiveRecord::Migration
  def self.up
    add_attachment :steps, :image_upload
  end

  def self.down
    remove_attachment :steps, :image_upload
  end
end
