class AddForeignKeyToForecasts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :forecasts, :locations, on_delete: :cascade, name: 'forecasts_locations_fk'
  end
end
