module Price
  extend ActiveSupport::Concern
  def self.price_sum(type)
  	eval(type).sum(:price)
  end
end