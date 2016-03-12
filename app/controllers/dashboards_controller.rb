# -*- coding: utf-8 -*-
class DashboardsController < ApplicationController
  def index
    @widgets = current_user.widgets.where(active: true)

    @widget_charts = {}

    @widgets.each do |widget|
      @widget_charts[widget.id] = build_chart widget
    end
  end
end
