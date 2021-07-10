require 'rails_helper'

RSpec.describe "Sign In", type: :request do
  describe "GET /users/sign_in" do
    it "returns http success" do
      get "/users/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

end
