class ReorganizeChildrenAndUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :full_name, null: false, comment: "The users's full name"
      t.string :email_address, comment: "This user's email address"
      
      t.timestamps
    end
    
    add_reference :children, :user, foreign_key: true, comment: "To which user does this child belong?"
    add_index :children, [ :user_id, :full_name, :birthdate ], unique: true
    add_index :users, :email_address
  end

  def down
    remove_index :children, [ :user_id, :full_name, :birthdate ]
    remove_reference :children, :user
    drop_table :users
  end
end
