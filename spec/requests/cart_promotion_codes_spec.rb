# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartPromotionCodes', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/cart_promotion_codes/new'
      expect(response).to have_http_status(:success)
    end
  end
end
