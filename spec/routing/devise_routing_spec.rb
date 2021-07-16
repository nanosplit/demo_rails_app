require "rails_helper"

RSpec.describe DeviseController, type: :routing do
  describe "routing" do
    context "user registration" do
      it "routes to #new" do
        expect(get: "/users/sign_up").to route_to("devise/registrations#new")
      end

      it "routes to #edit" do
        expect(get: "/users/edit").to route_to("devise/registrations#edit")
      end

      it "routes to #cancel" do
        expect(get: "/users/cancel").to route_to("devise/registrations#cancel")
      end

      it "routes to #create via POST" do
        expect(post: "/users").to route_to("devise/registrations#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/users").to route_to("devise/registrations#update")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/users").to route_to("devise/registrations#update")
      end

      it "routes to #destroy via DELETE" do
        expect(delete: "/users").to route_to("devise/registrations#destroy")
      end
    end

    context "user session" do
      it "routes to #new" do
        expect(get: "/users/sign_in").to route_to("devise/sessions#new")
      end

      it "routes to #create via POST" do
        expect(post: "/users/sign_in").to route_to("devise/sessions#create")
      end

      it "routes to #destroy via DELETE" do
        expect(delete: "/users/sign_out").to route_to("devise/sessions#destroy")
      end
    end

    context "user password" do
      it "routes to #new" do
        expect(get: "/users/password/new").to route_to("devise/passwords#new")
      end

      it "routes to #edit" do
        expect(get: "/users/password/edit").to route_to("devise/passwords#edit")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/users/password").to route_to("devise/passwords#update")
      end

      it "routes to #update via PUT" do
        expect(put: "/users/password").to route_to("devise/passwords#update")
      end

      it "routes to #update via POST" do
        expect(post: "/users/password").to route_to("devise/passwords#create")
      end
    end
  end
end
