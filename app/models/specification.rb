class Specification < ActiveRecord::Base
  belongs_to :product
  belongs_to :attribute
  belongs_to :specification

  has_one :trait
  has_one :bool_trait
  has_one :measurement

  has_many :specifications

  def value=(v)
    type = v.class.to_s
    raise "Specification can't be used as value." if type == 'Specification'
    if attribute.attribute_type != 'Composite'
      raise "Attribute missmatch. #{attribute.attribute_type} - #{type}" if attribute.attribute_type != type # TODO move to validation
      self.send("#{type.underscore.to_sym}=", v)
    end
  end

  def title
    attribute.title
  end

  def type
    attribute.attribute_type
  end

  def unit
    return '' if type != 'Measurement'

    self.send(type.underscore).unit
  end

  def value
    return nil if attribute.attribute_type == 'Composite'

    self.send(attribute.attribute_type.underscore).value
  end
end
