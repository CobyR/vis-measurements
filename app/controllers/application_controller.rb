class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :set_time_zone, if: :current_user

  def set_time_zone &block
    Time.use_zone(current_user.try(:time_zone) || 'UTC', &block)
  end

  def build_chart widget, limit = 50

    # we need to do some logic to figure out the chart to build
    return nil if widget.data_sources.count == 0

    categories = widget.data_sources.first.time_series(limit).reverse.map { |p|
      Time.zone.parse(p[0]).strftime("%Y-%m-%d %I:%M:%S %P")}

    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories,
              crosshair: true)

      # Build the yAxis(s)
      y_axis = []
      y_axis_index_hash = {}
      y_axis_index = 0

      widget.data_sources.each do |ds|
        axis = {
          labels:   { format: "{value}#{ds.symbol}" },
          title:    { text: ds.measurement.titleize },
          min:      ds.x_axis_min,
          max:      ds.x_axis_max,
          opposite: ds.y_axis_side == 'RIGHT'
        }
        unless y_axis_index_hash.key?(ds.measurement.downcase)
          y_axis << axis
          y_axis_index_hash[ds.measurement.downcase] = y_axis_index
          y_axis_index += 1
        end
      end

      f.legend(verticalAlign: 'top', align: 'center', layout: 'horizontal')
      f.yAxis y_axis
      widget.data_sources.each_with_index do |ds, index|
        f.series(
                 type: 'spline',
                 name: "#{ds.device.location} #{ds.symbol}",
                 data: ds.time_series(limit).reverse.map {|d| d[1]},
                 yAxis: y_axis_index_hash[ds.measurement.downcase]
                 )
      end
    end

    return chart
  end

  def build_chart_hourly widget, limit
    return nil if widget.data_sources.count == 0

    dsp = Utils.get_categories_time_sliced_data widget, limit

    categories = dsp.first.map {|k,v|
      Time.zone.at(k).strftime("%Y-%m-%D %I:%M:%S %P")}

    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories,
              crosshair: true)

      # Build the yAxis(s)
      y_axis = []
      y_axis_index_hash = {}
      y_axis_index = 0

      widget.data_sources.each_with_index do |ds, index|
        axis = {
          labels:   { format: "{value}#{ds.symbol}" },
          title:    { text: ds.measurement.titleize },
          min:      ds.x_axis_min,
          max:      ds.x_axis_max,
          opposite: ds.y_axis_side == 'RIGHT'
        }
        unless y_axis_index_hash.key?(ds.measurement.downcase)
          y_axis << axis
          y_axis_index_hash[ds.measurement.downcase] = y_axis_index
          y_axis_index += 1
        end
      end

      f.legend(verticalAlign: 'top', align: 'center', layout: 'horizontal')
      f.yAxis y_axis
      widget.data_sources.each_with_index do |ds, index|
        f.series(
                 type: 'spline',
                 name: "#{ds.device.location} #{ds.symbol}",
                 data: dsp[index].map {|k,v| v.average},
                 yAxis: y_axis_index_hash[ds.measurement.downcase]
                 )
      end
    end

    return chart

  end
end
