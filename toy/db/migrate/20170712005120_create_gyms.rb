class CreateGyms < ActiveRecord::Migration[5.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.integer :location_id
      t.integer :manager_id
      t.time :opening
      t.time :closing

      t.timestamps
    end
  end
end
