class WelcomeController < ApplicationController
  def welcome
    limit = params[:limit].to_i || 5
    @widgets = Widget.all.where(public_display: true).order(order: :asc).limit(limit)
    @title = "Public Widgets"

    @widget_charts = {}

    @widgets.each do |widget|
      @widget_charts[widget.id] = build_chart widget
    end

    render 'dashboards/index' and return
  end
end
