class Attribute < ActiveRecord::Base
  belongs_to :group

  has_many :specifications
  has_many :products, :through => :specifications

  validates :title, :uniqueness => { :scope => :group_id }
end
