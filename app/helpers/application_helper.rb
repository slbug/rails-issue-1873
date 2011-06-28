module ApplicationHelper

  def value_format(spec, units = true)
    case spec.type
    when 'BoolTrait'
      if spec.format?
        t(spec.title).html_safe
      else
        if spec.value
          image_tag('tick_64.png', :size => '16x16').html_safe
        else
          image_tag('delete_64.png', :size => '16x16').html_safe
        end
      end
    when 'Trait'
      t(spec.value).html_safe
    when 'Measurement'
      if spec.unit == 'default'
        # format big numbers as thousands, millions, etc..
        return number_to_human(spec.value, :delimiter => ' ')
      elsif spec.unit == 'byte'
        return number_to_human_size(spec.value)
      elsif spec.unit.present? && units
        unit = 'human.' + spec.unit
      else
        unit = { :unit => '' }
      end
      number_to_human(spec.value, :delimiter => ' ', :units => unit)
    when 'Composite'
      case spec.format
      when 'list'
        ('<ul><li>' + spec.specifications.collect{|s| t(s.title) + ': ' + value_format(s, false)}.join('</li><li>') + '</li></ul>').html_safe
      when 'titles'
        spec.specifications.collect{|s| t(s.title).html_safe}.join(', ').html_safe
      when nil
        spec.specifications.collect{|s| value_format(s, false)}.flatten.join(', ').html_safe
      else
        values = {}
        units = {}
        spec.specifications.each do |s|
          raise "something wrong with #{spec.inspect}" if values[s.title.to_sym].present?
          values[s.title.to_sym] = value_format(s, false)
          units["#{s.title}_unit".to_sym] = t(s.unit, :count => (s.value < 1 ? 2 : s.value)) if s.unit.present?
        end
        main_unit = units.values.uniq
        units[:unit] = main_unit.first if main_unit.size == 1
        values = values.merge(units) if units.present?
        sprintf(spec.format, values).html_safe
      end
    end
  end

  def ie_tag(name = :html, attrs = {}, &block)
    attrs.symbolize_keys!
    haml_concat("<!--[if lt IE 7]> #{ tag(name, add_class('ie6 oldie', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 7]> #{ tag(name, add_class('ie7 oldie', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if IE 8]> #{ tag(name, add_class('ie8 oldie', attrs), true) } <![endif]-->".html_safe)
    haml_concat("<!--[if gt IE 8]><!-->".html_safe)
    haml_tag name, attrs do
      haml_concat("<!--<![endif]-->".html_safe)
      block.call
    end
  end

  def ie_html(attrs = {}, &block)
    ie_tag(:html, attrs, &block)
  end

  private
    def add_class(name, attrs)
      classes = attrs[:class] || ''
      classes.strip!
      classes = ' ' + classes if !classes.blank?
      classes = name + classes
      attrs.merge(:class => classes)
    end

end
