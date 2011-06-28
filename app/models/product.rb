class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category

  has_many :specifications
  has_many :attributes, :through => :specifications

  def specs(group)
    specifications
    .joins({ :attribute => :group })
    .where("\"#{Group.table_name}\".\"id\" = #{group.id}")
    .where("\"#{Specification.table_name}\".\"specification_id\" IS NULL")
  end

  def groups
    Group
    .select("DISTINCT ON(\"#{Group.table_name}\".\"id\") \"#{Group.table_name}\".*")
    .joins({ :attributes => :products })
    .where({ :attributes => { :products => { :id => id } } })
    #.includes({ :attributes => :products })
  end
end
