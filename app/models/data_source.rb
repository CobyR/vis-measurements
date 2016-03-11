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
#

class DataSource < ApplicationRecord

  MEASUREMENTS = %w|temperature
                    humdity
                    pressure
                    brightness
                   |

  belongs_to :widget
  belongs_to :device

end
