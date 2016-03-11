class CreateWidgets < ActiveRecord::Migration[5.0]
  def change
    create_table :widgets do |t|
      t.integer :user_id
      t.string  :name
      t.boolean :active
      t.string  :size
      t.integer :order
      t.string  :display_type

      t.timestamps
    end
  end
end
