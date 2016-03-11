class AddPrecisionToDataSources < ActiveRecord::Migration[5.0]
  def change
    add_column :data_sources, :precision, :integer
  end
end
