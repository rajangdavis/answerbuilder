class AddUsersAssociationToAnswers < ActiveRecord::Migration
   def self.up
    add_column :answers, :user_id, :integer
    add_index 'answers', ['user_id'], :name => 'index_user_id'
  end

  def self.down
    remove_column :answers, :user_id
  end
end
