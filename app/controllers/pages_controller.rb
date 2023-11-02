class PagesController < ApplicationController
    def home
      session[:customer] = nil
    end
  end
  