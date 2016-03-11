class AddColorToWidgets < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :color, :string
  end
end
