# == Schema Information
#
# Table name: users
#
#  id               :bigint(8)        not null, primary key
#  first_name       :string
#  last_name        :string
#  email            :string
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  role             :string
#  reset_digest     :string
#  reset_sent_at    :datetime
#  cohort_id        :integer
#  user_information :jsonb            not null
#

class User < ApplicationRecord
  has_secure_password
  attr_accessor :reset_token
  store_accessor :user_information, :avatar, :phone, :school, :grade
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many :posts, class_name: 'Post', foreign_key: :auther_id, primary_key: :id
  has_and_belongs_to_many :cohorts

  def user_tag
    name.insert(0, '@')
  end

  def student?
    role == 'student'
  end

  def admin?
    role == 'admin'
  end

  def mentor?
    role == 'mentor'
  end

  def name
    "#{first_name} #{last_name}"
  end

  def archived?
    archive == true
  end

  # Returns a random token
  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # Sets the password reset attributes.
  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_attribute(:reset_digest,  User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  # end

  # Sends password reset email.
  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # Returns true if a password reset has expired.
  # def password_reset_expired?
  #   reset_sent_at < 2.hours.ago
  # end
end
