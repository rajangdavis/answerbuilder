class Steps < ActiveRecord::Migration
  def change
  	create_table :steps do |t|
      t.integer :number
      t.string :step
      t.text :image
      t.string :image_size

      t.timestamps
	  end
	end
end
