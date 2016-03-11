# == Schema Information
#
# Table name: widgets
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  active       :boolean
#  size         :string
#  order        :integer
#  display_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Widget < ApplicationRecord

  belongs_to :user

  has_many :data_sources

  validates :size, :order, :display_type, :name, presence: true

end
