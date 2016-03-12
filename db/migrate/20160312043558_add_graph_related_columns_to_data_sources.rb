class AddGraphRelatedColumnsToDataSources < ActiveRecord::Migration[5.0]
  def change
    add_column :data_sources, :y_axis_side, :string
  end
end
