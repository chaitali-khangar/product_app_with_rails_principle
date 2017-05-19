require 'date'
require 'rails_helper'
require 'pry'
describe ProductsController, type: :controller do
  context 'when product is valid' do
    it 'redirect to index page' do
      post :create, notebook: {name: "Notebook1",price: 12345678.12,inward_date: Date.today}
      expect(response).to redirect_to "/products"
      expect(response.status).to eq(200)
    end
  end
end
