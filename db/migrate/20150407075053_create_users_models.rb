class CreateUsersModels < ActiveRecord::Migration
  def change
    create_table :users_models do |t|
      t.string :username
      t.string :password
      t.integer :count, default: 1

#      t.timestamps null: false
    end
    add_index :users_models, :username, unique: true
  end
end
