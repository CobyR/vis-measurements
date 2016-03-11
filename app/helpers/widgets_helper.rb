module WidgetsHelper

  def render_widget widget
    render partial: widget.display_type.downcase, locals: { widget: widget }
  end

  def display_current_value data_source
    value = data_source.current_value
    f_symbol = content_tag(:span,data_source.symbol,class: 'symbol')
    string_value = "%.#{data_source.precision || 0}f" % value

    string_value.html_safe + f_symbol.html_safe
  end
end
