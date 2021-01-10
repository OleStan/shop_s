class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :adress
      t.string :email
      t.string :password
      t.datetime :bithday
      t.string :avatar

      t.timestamps
    end
  end
end