require 'date'
require 'rails_helper'
describe ProductsController, type: :controller do
  context 'when product is valid' do
    it 'redirect to index page' do
      post :create, notebook: {name: "Notebook1",price: 12345678.12,inward_date: Date.today}
      expect(response.status).to eq(200)
    end
  end
end
