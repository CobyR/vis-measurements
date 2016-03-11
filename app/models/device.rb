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
    data = JSON.parse open("#{SOURCE_URL}/api/measurements?device=#{self.identifier.upcase}").read
  end

end
