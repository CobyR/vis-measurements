class CreateDataSources < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sources do |t|
      t.integer :widget_id
      t.integer :device_id
      t.string :measurement
      t.decimal :x_axis_min
      t.decimal :x_axis_max
      t.string :units
      t.string :symbol

      t.timestamps
    end
  end
end
