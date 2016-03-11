class DashboardsController < ApplicationController
  def index
    @widgets = current_user.widgets.where(active: true)

    @widget_charts = {}

    @widgets.each do |widget|
      categories = widget.data_sources.first.time_series.map {|p| p[0]}

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:xAxis][:categories] = categories
        widget.data_sources.each do |ds|
          f.series(type: 'spline',
                   name: ds.measurement.titleize + " " + ds.symbol,
                   data: ds.time_series.map {|d| d[1]})
        end
        f.legend layout: 'horizontal'
      end
      @widget_charts[widget.id] = chart
    end
  end
end
