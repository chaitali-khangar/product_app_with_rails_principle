class ProductsController < ApplicationController
  before_action :permit_params, :only=>[:create]

  def index
    @products = Product.all.decorate
  end

  def new
    @product = Product.get_class(params[:type]).new
  end

  def create
   model_name = get_type_name[0]
   @product = model_name.camelize.constantize.new(permit_params)
    if @product.save
      redirect_to products_path,notice: "#{model_name.camelize} is successfully created"
    else
      render :new
    end
  end

  private

  def get_type_name
    type_name,attributes = if params[:notebook].present?
      ["notebook",[:name,:price,:inward_date]]
    elsif params[:pen].present?
      ["pen",[:name,:price,:inward_date,:color]]
    end
    [type_name,attributes]
  end

  def permit_params
    model_name,attributes = get_type_name
  	params.require(model_name).permit(attributes)
  end


end
