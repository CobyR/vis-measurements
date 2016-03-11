class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.string :identifier
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
