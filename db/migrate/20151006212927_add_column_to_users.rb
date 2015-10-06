class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null:false
    add_column :users, :last_name, :string, null:false
    add_column :users, :login, :string, unique: true, null:false
    add_column :users, :age, :integer, null:false

  end
end
