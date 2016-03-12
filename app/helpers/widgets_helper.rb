module WidgetsHelper

  def render_widget widget
    render partial: "dashboards/#{widget.display_type.downcase}", locals: { widget: widget }
  end

  def display_current_value data_source
    value = data_source.current_value
    f_symbol = content_tag(:span,data_source.symbol,class: 'symbol')
    string_value = "%.#{data_source.precision || 0}f" % value || 0
  end

  def build_cart widget
    fds = widget.data_sources.first
    m_count = widget.data_sources.map {|ds| ds.measurement }.uniq.count
    categories = fds.time_series.reverse.map {|p| Time.zone.parse(p[0]).strftime("%Y-%m-%d %I:%M:%S %P")}

    chart = LazyHighCharts::HighChart.new('graph') do |f|
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

    return chart
  end
end
