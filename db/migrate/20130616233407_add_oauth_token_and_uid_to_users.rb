class AddOauthTokenAndUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_token, :string
    add_column :users, :uid, :string
  end
end
