require 'rails_helper'

RSpec.describe "BillingInfos", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/billing_infos/new"
      expect(response).to have_http_status(:success)
    end
  end

end
