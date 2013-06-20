class RemoveWhyAndMsgAndEmailFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :why
    remove_column :users, :msg
    remove_column :users, :email
  end

  def down
    add_column :users, :email, :string
    add_column :users, :msg, :string
    add_column :users, :why, :string
  end
end
