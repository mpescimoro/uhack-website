class PagesController < ApplicationController
  def index
    @news = Post.where.not(published_at: nil).order(published_at: :desc).take(7)
  end

  def chi_siamo
    @us = SuperUser.all.shuffle.take 10
  end

  def partecipa
  end
end
