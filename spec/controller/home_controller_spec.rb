require 'rails_helper'
require 'database_cleaner'
RSpec.describe HomeController, type: :controller do
  render_views

  let(:store_params) { {name: Faker::Company.name, location: "Faker::Address.street_address", open_hour: Time.new(2002, 10, 1, 8, 0, 0), close_hour: Time.new(2002, 10, 1, 22, 0, 0), description: "An Exclusive SPA offering luxurious cacials & therapeutic massages.",phone_number: '123456789'} }

  describe 'GET #index' do
    it "list all the stores" do
      store1 = Store.create!(store_params)
      store2 = Store.create!(store_params)
      store3 = Store.create!(store_params)

      get :index

      expect(Store.count).to eq(3)
      expect(response.body).to include("img-circle")
      expect(response.body).to include(store2.location)
    end
  end
end