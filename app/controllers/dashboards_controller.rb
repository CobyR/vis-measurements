class DashboardsController < ApplicationController
  def index
    @devices = current_user.devices
  end
end
