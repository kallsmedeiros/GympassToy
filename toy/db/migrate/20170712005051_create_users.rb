class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :kind
      t.string :email
      t.string :password
      t.integer :work_location_id
      t.integer :home_location_id

      t.timestamps
    end
  end
end
