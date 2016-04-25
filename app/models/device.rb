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

require 'json'
require 'open-uri'

class Device < ApplicationRecord

  SOURCE_URL = "https://imp-app-part-deux.herokuapp.com"

  belongs_to :user

  def defined?
    data = JSON.parse open("#{SOURCE_URL}/api/devices").read

    device = data.select {|d| d['identifier'] == self.identifier.upcase}.first

    !device.nil?
 end

  def measurements
    if self.defined?
      data = JSON.parse open("#{SOURCE_URL}/api/measurements?device=#{self.identifier.upcase}").read
    else
      []
    end
  end

  def time_series measurement, limit = 50
    url = "#{SOURCE_URL}/api/measurements?device=#{self.identifier.upcase}&format=ts&name=#{measurement}&limit=#{limit}"
   @time_series = JSON.parse open(url).read
  end

  def current_value measurement
    data = JSON.parse open("#{SOURCE_URL}/api/measurements?device=#{self.identifier.upcase}&limit=1&name=#{measurement}").read

    return data.first['value'], data.first['created_at']

  end
end
