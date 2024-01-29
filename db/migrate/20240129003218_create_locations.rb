class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :ip_address
      t.string :text_address

      t.timestamps
    end
  end
end
