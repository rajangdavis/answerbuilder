class AddOffsetToSteps < ActiveRecord::Migration
  def change
  	add_column :steps, :offset, :integer
  end
end
