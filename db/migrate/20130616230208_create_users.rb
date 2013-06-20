class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :why
      t.integer :msg
      t.integer :email

      t.timestamps
    end
  end
end
