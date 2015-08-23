class AlterUser < ActiveRecord::Migration
  def up
    rename_table :users, :admin_users
    add_column :admin_users, 'username' , :string, limit: 35, after: :email
    change_column :admin_users, :email, :string, limit: 80, null: false
    rename_column :admin_users, :password, :password_digest
    puts '****** adding an index next ... ******'
    add_index :admin_users, :username
  end

  def down
    remove_index :admin_users, :username
    rename_column :admin_users, :password_digest, :password
    change_column :admin_users, :email, null: false
    remove_column :admin_users, 'username'
    rename_table :admin_users, :users
  end

end
