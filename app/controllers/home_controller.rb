class HomeController < ApplicationController
  def index
    @store1 = Store.all[0]
    @store2 = Store.all[1]
    @store3 = Store.all[2]
  end
end