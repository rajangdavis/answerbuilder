class Answers < ActiveRecord::Migration
  def change
  	create_table :answers do |t|
      t.string :language
      t.string :series
      t.text :tagline
      t.string :title

      t.timestamps
	  end
	end
end
