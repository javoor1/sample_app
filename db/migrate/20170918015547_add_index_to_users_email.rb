class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
  	#add index es un método 
    add_index :users, :email, unique: true
  end
end