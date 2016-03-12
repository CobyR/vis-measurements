# -*- coding: utf-8 -*-
class DashboardsController < ApplicationController
  def index
    @widgets = current_user.widgets.where(active: true)

    @widget_charts = {}

    @widgets.each do |widget|
      fds = widget.data_sources.first
      m_count = widget.data_sources.map {|ds| ds.measurement }.uniq.count
      categories = fds.time_series.reverse.map {|p| Time.zone.parse(p[0]).strftime("%Y-%m-%d %I:%M:%S %P")}

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        #f.xAxis(type: 'datetime',
        #        dateTimeLabelFormats: {
        #          month: '%e %b',
        #          day: '%e' },
        f.xAxis(categories: categories,
                crosshair: true)
        if m_count == 2
          f.yAxis [
                   { labels: { format: "{value}#{fds.symbol}" },
                     title:  { text: 'Temperature' },
                     min: 40},
                   { labels: { format: "{value}%" },
                     title:  { text: 'Humidity' },
                     min: 40,
                     opposite: true }
                  ]
        else
          f.yAxis( labels: { format: "{value}#{fds.symbol}" },
                   title:  { text: 'Temperature' } )
        end
        f.legend(verticalAlign: 'top', align: 'center', layout: 'horizontal')

        widget.data_sources.each do |ds|
          f.series(
                   type: 'spline',
                   name: "#{ds.device.location} #{ds.symbol}",
                   data: ds.time_series.reverse.map {|d| d[1]},
                   yAxis: "#{ds.measurement == 'temperature' ? 0 : 1}".to_i
                   )
        end
      end
      @widget_charts[widget.id] = chart
    end
  end
end
