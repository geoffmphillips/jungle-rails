class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: "jungle", password: "book", except: :index

  def show
  end
end
