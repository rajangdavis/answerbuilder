class FrenchAnswerSupport < ActiveRecord::Migration
   def self.up
    add_column :answers, :title_fr, :string
    add_column :answers, :tagline_fr, :string
    add_column :steps, :step_fr, :text
    add_column :steps, :image_upload_fr_file_name, :string
    add_column :steps, :image_upload_fr_content_type, :string
    add_column :steps, :image_upload_fr_file_size, :integer
    add_column :steps, :image_upload_fr_updated_at, :datetime
  end

  def self.down
    remove_column :answers, :title_fr
    remove_column :answers, :tagline_fr
    remove_column :steps, :image_upload_fr_file_name
	remove_column :steps, :image_upload_fr_content_type
	remove_column :steps, :image_upload_fr_file_size
	remove_column :steps, :image_upload_fr_updated_at
  end
end
