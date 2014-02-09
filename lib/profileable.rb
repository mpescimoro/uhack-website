module Profileable
	
	def self.included(includer)
    includer.class_eval do
      before_save :set_default_image
    end
  end

	private
  def set_default_image
    if self.image_url.blank?
      figures = ('a'..'f').to_a.shuffle!
      self.image_url = "http://placehold.it/500/#{figures.join("")}/ffffff&text=no+pic"
    end
  end

end