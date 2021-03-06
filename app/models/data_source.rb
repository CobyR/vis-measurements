# == Schema Information
#
# Table name: data_sources
#
#  id          :integer          not null, primary key
#  widget_id   :integer
#  device_id   :integer
#  measurement :string
#  x_axis_min  :decimal(, )
#  x_axis_max  :decimal(, )
#  units       :string
#  symbol      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  precision   :integer
#  y_axis_side :string
#

class DataSource < ApplicationRecord

  MEASUREMENTS = %w|temperature
                    humidity
                    pressure
                    brightness
                   |


  SIDES = %w|NONE
             LEFT
             RIGHT
            |


  belongs_to :widget
  belongs_to :device

  def current_value
    device.current_value(measurement).first
  end

  def time_series limit = 50
    device.time_series(measurement, limit)
  end

end
