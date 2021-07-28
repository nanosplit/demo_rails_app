require 'rails_helper'

RSpec.describe "/portfolios", type: :request do
  let(:user) { create(:user) }
  let(:portfolio) { create(:portfolio) }

  let(:valid_attributes) {
    {
      name: "Name",
      website: "website",
      description: "description",
      start_date: Date.today,
      end_date: Date.today,
      actively_working: false,
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      start_date: nil,
    }
  }

  context "as a visitor" do
    describe "GET /index" do
      it "renders a successful response" do
        Portfolio.create! valid_attributes
        get portfolios_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "rejects an unauthenticated visitor" do
        get portfolio_path(portfolio)
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end

    describe "GET /new" do
      it "rejects an unauthenticated visitor" do
        get new_portfolio_path
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end

    describe "GET /edit" do
      it "rejects an unauthenticated visitor" do
        get edit_portfolio_path(portfolio)
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end

    describe "PATCH /update" do
      it "rejects an unauthenticated visitor" do
        patch portfolio_path(portfolio)
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end

    describe "PUT /update" do
      it "rejects an unauthenticated visitor" do
        put portfolio_path(portfolio)
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end

    describe "DELETE /destroy" do
      it "rejects an unauthenticated visitor" do
        delete portfolio_path(portfolio)
        expect(response).to have_http_status(:redirect).and redirect_to(new_user_session_path)
      end
    end
  end

  context "as a logged in user" do
    before(:each) do
      sign_in user
    end

    describe "GET /show" do
      it "renders a successful response" do
        portfolio = Portfolio.create! valid_attributes
        get portfolio_url(portfolio)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_portfolio_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "render a successful response" do
        portfolio = Portfolio.create! valid_attributes
        get edit_portfolio_url(portfolio)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Portfolio" do
          expect {
            post portfolios_url, params: { portfolio: valid_attributes }
          }.to change(Portfolio, :count).by(1)
        end

        it "redirects to the created portfolio" do
          post portfolios_url, params: { portfolio: valid_attributes }
          expect(response).to redirect_to(portfolio_url(Portfolio.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Portfolio" do
          expect {
            post portfolios_url, params: { portfolio: invalid_attributes }
          }.to change(Portfolio, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post portfolios_url, params: { portfolio: invalid_attributes }
          expect(response).to be_unprocessable
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          {
            name: "New Name",
            website: "new website",
            start_date: 5.days.ago.to_date,
            end_date: Date.yesterday,
          }
        }

        it "updates the requested portfolio" do
          portfolio = Portfolio.create! valid_attributes
          patch portfolio_url(portfolio), params: { portfolio: new_attributes }
          portfolio.reload
          expect(portfolio.attributes.values_at(*new_attributes.keys.map(&:to_s))).to eq(new_attributes.values)
        end

        it "redirects to the portfolio" do
          portfolio = Portfolio.create! valid_attributes
          patch portfolio_url(portfolio), params: { portfolio: new_attributes }
          portfolio.reload
          expect(response).to redirect_to(portfolio_url(portfolio))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          portfolio = Portfolio.create! valid_attributes
          patch portfolio_url(portfolio), params: { portfolio: invalid_attributes }
          expect(response).to be_unprocessable
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested portfolio" do
        portfolio = Portfolio.create! valid_attributes
        expect {
          delete portfolio_url(portfolio)
        }.to change(Portfolio, :count).by(-1)
      end

      it "redirects to the portfolios list" do
        portfolio = Portfolio.create! valid_attributes
        delete portfolio_url(portfolio)
        expect(response).to redirect_to(portfolios_url)
      end
    end
  end
end
