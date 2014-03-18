module Profileable

	def self.included(includer)
    includer.class_eval do
      before_save :set_default_image
    end
  end

  def full_name
    name.to_s + " " + surname.to_s
  end

  def full_name?
    name and surname
  end

  def profile_title
    full_name? ? full_name + " (#{username})" : username
  end

  def title
    full_name? ? full_name : username
  end

	private
  def set_default_image
    if self.image_url.blank?
      figures = ('a'..'f').to_a.shuffle!
      self.image_url = "http://placehold.it/500/#{figures.join("")}/ffffff&text=no+pic"
    end
  end

end
