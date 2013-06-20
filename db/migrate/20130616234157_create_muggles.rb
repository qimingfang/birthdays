class CreateMuggles < ActiveRecord::Migration
  def change
    create_table :muggles do |t|
      t.string :name
      t.string :why
      t.string :msg
      t.string :email

      t.timestamps
    end
  end
end
