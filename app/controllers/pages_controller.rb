class PagesController < ApplicationController
  def index
    @news = Post.where.not(published_at: nil).order(published_at: :desc).take(7)
  end

  def chi_siamo
  end

  def partecipa
  end
end
