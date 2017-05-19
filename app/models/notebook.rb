class Notebook < Product
	def self.permitted_attributes_from_params(params)
		parameters = ActionController::Parameters.new(params)
		parameters.permit(:name, :price,:inward_date)
	end	
end