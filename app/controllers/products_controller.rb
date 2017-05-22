class ProductsController < ApplicationController
  before_action :permit_params, :only=>[:create]

  def index
    @products = Product.all.decorate
  end

  def new
    @product = Product.get_class(params[:type]).new
  end

  def create
   @product = Product.new(permit_params)
    respond_to do |format|
      if @product.save
        format.html{redirect_to products_path,notice: "#{@product.type} is successfully created"}
      else
        format.html{render :new}
      end
    end
  end

  private

  def permit_params
   new_product = Product.new(type:params[:product][:type])
   params.require(:product).permit(new_product.permited_parameters)
  end


end
