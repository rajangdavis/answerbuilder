class MoreThingsToAddForSteps < ActiveRecord::Migration
  def change
  	add_attachment :steps, :image_upload_jp
  	add_column :answers, :title_jp, :string
  	add_column :answers, :tagline_jp, :text
  end
end
