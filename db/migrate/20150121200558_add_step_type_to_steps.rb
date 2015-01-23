class AddStepTypeToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :step_type, :string
  end
end
