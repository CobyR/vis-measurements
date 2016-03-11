# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  identifier :string
#  name       :string
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
