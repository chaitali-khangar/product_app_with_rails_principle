class Product < ActiveRecord::Base

  validates_presence_of :name
  validate :format_of_price
  validate :validate_inward_date

  TYPES = %w{Notebook Pen}

  def self.get_class(type)
  	return self if type.nil?
  	eval(type) rescue nil
  end

  def validate_inward_date
  	unless (Date.today-1.month..Date.today).include?(self.inward_date)
  		errors.add(:inward_date,"is not valid date.Please enter date between #{(Date.today-1.month)} to current date")
  	end
  end

  def format_of_price
  	if self.price.present? && self.price.to_s.match(/\A\d{8}.\d{2}\z/).nil?
  	  errors.add(:price, "is not valid price. Precision should be 8 and scala should be 2")
  	end
  end

  def method_missing(m, *args, &block)
    self.decorate.send(m) if ProductDecorator.instance_methods(true).include?(m)
  end

end
