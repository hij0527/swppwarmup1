class CreateUsersModels < ActiveRecord::Migration
  def change
    create_table :users_models do |t|
      t.string :username
      t.string :password
      t.integer :count

      t.timestamps null: false
    end
  end
end
