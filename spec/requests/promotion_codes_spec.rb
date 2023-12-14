require 'rails_helper'

RSpec.describe "PromotionCodes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/promotion_codes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/promotion_codes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
