class Guest < ActiveRecord::Base

	has_many :comments, as: :commenter

  validates :username, presence: { message: 'campo obbligatorio' }
  validates :email, presence: { message: 'campo obbligatorio' }
  validates_format_of :email, with: Devise::email_regexp

  def self.find_or_create(guest_params)
    Guest.create_with(username: guest_params[:username]).find_or_create_by(email: guest_params[:email])
  end
end
