class ChangePasswordFieldType < ActiveRecord::Migration
  def up
    change_column :admin_users, :password_digest, :string
  end

  def down
    change_column :admin_users, :password_digest, :string
  end
end
