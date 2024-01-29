class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.references :location, null: false, foreign_key: true
      t.date :date
      t.integer :high_temperature
      t.integer :low_temperature

      t.timestamps
    end
  end
end
