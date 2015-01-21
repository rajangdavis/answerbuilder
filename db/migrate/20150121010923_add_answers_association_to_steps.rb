class AddAnswersAssociationToSteps < ActiveRecord::Migration
   def self.up
    add_column :steps, :answer_id, :integer
    add_index 'steps', ['answer_id'], :name => 'index_answer_id'
  end

  def self.down
    remove_column :steps, :answer_id
  end
end
