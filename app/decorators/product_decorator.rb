class ProductDecorator < Draper::Decorator
  delegate_all

  def get_color
  	self.color? ? self.color : "Color is not available"
  end

  def display_inward_date
  	self.inward_date.strftime("%m/%d/%Y") rescue "No Inward Date Available"
  end

  def display_heading
    "Create #{self.object.class.name}"
  end


end
