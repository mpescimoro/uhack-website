class SuperUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: { case_sentitive: false }


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if email = conditions.delete(:email)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => email.downcase }]).first
    else
      where(conditions).first
    end
  end

end
