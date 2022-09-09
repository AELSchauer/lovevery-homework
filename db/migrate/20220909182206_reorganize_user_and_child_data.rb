class ReorganizeUserAndChildData < ActiveRecord::Migration[6.0]
  def data_before
    Child.all.each do |child|
      child.user.create(full_name: child.parent_name)
    end
  end
  
  def up
    remove_column :children, :parent_name
    remove_index :children, name: "index_children_on_full_name_and_birthdate_and_parent_name"
  end
  
  def down
    add_column :children, :parent_name, :string
    add_index :children, [ :full_name, :birthdate, :parent_name ], unique: true
  end
  
  def rollback
    Child.all.each do |child|
      child.update(parent_name: child.user.full_name)
    end
  end
end
