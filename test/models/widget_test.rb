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

require 'test_helper'

class WidgetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
