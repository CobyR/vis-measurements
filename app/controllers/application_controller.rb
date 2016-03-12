class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :set_time_zone, if: :current_user

  def set_time_zone &block
    Time.use_zone(current_user.try(:time_zone) || 'UTC', &block)
  end

  def build_chart widget

    # we need to do some logic to figure out the chart to build

    categories = widget.data_sources.first.time_series.reverse.map { |p|
      Time.zone.parse(p[0]).strftime("%Y-%m-%d %I:%M:%S %P")}

    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories,
              crosshair: true)

      # Build the yAxis(s)
      yAxis = []
      widget.data_sources.each do |ds|
        axis = {
          labels:   { format: "{value}#{ds.symbol}" },
          title:    { text: ds.measurement.titleize },
          min:      ds.x_axis_min,
          opposite: ds.y_axis_side == 'RIGHT'
        }
        yAxis << axis
      end

      f.legend(verticalAlign: 'top', align: 'center', layout: 'horizontal')
      f.yAxis yAxis
      widget.data_sources.each_with_index do |ds, index|
        f.series(
                 type: 'spline',
                 name: "#{ds.device.location} #{ds.symbol}",
                 data: ds.time_series.reverse.map {|d| d[1]},
                 yAxis: index
                 )
      end
    end

    return chart
  end
end
