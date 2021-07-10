require 'rails_helper'

RSpec.describe "Forgot Password", type: :request do
  describe "GET /users/password/new" do
    it "returns http success" do
      get "/users/password/new"
      expect(response).to have_http_status(:success)
    end
  end

end
