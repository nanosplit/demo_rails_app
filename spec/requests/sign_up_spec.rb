require 'rails_helper'

RSpec.describe "Sign Up", type: :request do
  describe "GET /users/sign_up" do
    it "returns http success" do
      get "/users/sign_up"
      expect(response).to have_http_status(:success)
    end
  end

end
