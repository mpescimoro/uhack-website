class Guest < ActiveRecord::Base

	has_many :comments, as: :commenter, dependent: :destroy

  validates :username, presence: { message: 'campo obbligatorio' }
  validates :email, presence: { message: 'campo obbligatorio' }
  validates_format_of :email, with: Devise::email_regexp

  def self.find_or_create(guest_params)
    Guest.create_with(username: guest_params[:username]).find_or_create_by(email: guest_params[:email])
  end

  def image_url
    "http://placehold.it/500/8BC4E6/ffffff&text=guest"
  end
end
