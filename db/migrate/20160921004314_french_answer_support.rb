class FrenchAnswerSupport < ActiveRecord::Migration
   def self.up
    add_column :answers, :title_fr, :string
    add_column :answers, :tagline_fr, :string
    add_column :steps, :step_fr, :text
    add_attachment :steps, :image_upload_fr
  end

  def self.down
    remove_column :answers, :title_fr
    remove_column :answers, :tagline_fr
    remove_column :steps, :step_fr, :text
    remove_attachment :steps, :image_upload_fr
  end
end
