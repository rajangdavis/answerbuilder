class AddRolesToUsersAddTranslationInfoToAnswersAndAddJapaneseStepsForSteps < ActiveRecord::Migration
  def change
  	add_column :users, :role, :string
  	add_column :answers, :translation_status, :string
  	add_column :answers, :translation_needed, :string
  	add_column :steps, :step_jp, :text
  end
end
