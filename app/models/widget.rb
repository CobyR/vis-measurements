# == Schema Information
#
# Table name: widgets
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  name           :string
#  active         :boolean
#  size           :string
#  order          :integer
#  display_type   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  color          :string
#  public_display :boolean          default("false")
#

class Widget < ApplicationRecord

  SIZES = %w|1x
             2x
             3x
             4x
            |

  DISPLAY_TYPES = %w|CURRENT
                     TIME_SERIES
                    |

  COLORS = %w|default
              primary
              info
              success
              warning
              danger
             |

  belongs_to :user

  has_many :data_sources

  validates :size, :order, :display_type, :name, presence: true


  scope :display, -> { where(active: true) }

  default_scope { order(order: :asc) }


  def safe_color
    if self.color.nil? || self.color.empty?
      return 'default'
    else
      return self.color
    end
  end

end
