class WelcomeController < ApplicationController
  def welcome
    @widgets = Widget.all.where(public_display: true).order(order: :asc)
    @title = "Public Widgets"

    @widget_charts = {}

    @widgets.each do |widget|
      @widget_charts[widget.id] = build_chart widget
    end

    render 'dashboards/index' and return
  end
end
