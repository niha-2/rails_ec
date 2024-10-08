# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def set_cart
    if session[:cart_id]
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end
end
