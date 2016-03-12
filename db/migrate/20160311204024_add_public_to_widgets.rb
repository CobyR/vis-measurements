class AddPublicToWidgets < ActiveRecord::Migration[5.0]
  def change
    add_column :widgets, :public_display, :boolean, default: false
  end
end
