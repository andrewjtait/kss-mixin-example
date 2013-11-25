class StyleguideController < ApplicationController
  def index
  end

  def styleguide
    Kss::Parser.new("app/assets/stylesheets")
  end
end
