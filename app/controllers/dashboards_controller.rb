# -*- coding: utf-8 -*-
class DashboardsController < ApplicationController
  def index
    if params[:time_series]
      @limit = params[:time_series][:limit]
    else
      @limit = 50
    end

    @widgets = current_user.widgets.where(active: true)

    @widget_charts = {}

    @widgets.each do |widget|
      @widget_charts[widget.id] = build_chart widget, @limit
    end
  end

  def refresh
    limit = params[:time_series][:limit]

    @widgets = current_user.widgets.where(active: true)

    @widgets_charts = {}
    @w
  end
end
