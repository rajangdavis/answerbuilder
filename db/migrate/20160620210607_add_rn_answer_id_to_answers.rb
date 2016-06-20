class AddRnAnswerIdToAnswers < ActiveRecord::Migration
  def change
  	add_column :answers, :rightnow_answer_id, :integer
  end
end
