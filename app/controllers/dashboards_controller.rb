# -*- coding: utf-8 -*-
class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:time_series]
      @limit = params[:time_series][:limit]
    else
      @limit = 'H|12'
    end

    @widgets = current_user.widgets.where(active: true)

    @widget_charts = {}

    @widgets.each do |widget|
      unless @limit.to_i == 0
        @widget_charts[widget.id] = build_chart widget, @limit
      else
        @widget_charts[widget.id] = build_chart_hourly widget, @limit
      end
    end
  end

  def refresh
    limit = params[:time_series][:limit]

    @widgets = current_user.widgets.where(active: true)

    @widgets_charts = {}
    @w
  end
end
