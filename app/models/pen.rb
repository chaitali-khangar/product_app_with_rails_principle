class Pen < Product
	validates_presence_of :color
	def self.permitted_attributes_from_params(params)
		parameters = ActionController::Parameters.new(params)
		parameters.permit(:name, :price,:inward_date,:color)
	end	
end