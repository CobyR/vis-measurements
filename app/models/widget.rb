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

  LIMITS = [
            ['last 50 values',50],
            ['last 100 values', 100],
            ['last 500 values', 500],
            ['last 1,000 values', 1000],
            ['last 5,000 values', 5000],
            ['last hour', 'H|1'],
            ['last three hours','H|3'],
            ['last six hours', 'H|6'],
            ['last 12 hours', 'H|12'],
            ['last 24 hours', 'H|24'],
            ['last 48 hours', 'H|48'],
            ['last three days', 'H|72'],
            ['last seven days', 'H|168'],
            ['last 10 days', 'H|240'],
            ['last 2 weeks', 'H|336'],
            ['last 4 weeks', 'H|672'],
            ['last 30 days', 'H|720']
           ]

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
