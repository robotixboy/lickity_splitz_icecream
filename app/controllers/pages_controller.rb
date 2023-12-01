class PagesController < ApplicationController
    def home
      #reset_session
      Time.zone = 'Eastern Time (US & Canada)'
      session["Time"] = Time.zone.now
    end
  end
  