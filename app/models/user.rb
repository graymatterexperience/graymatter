# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#

class User < ApplicationRecord
  attr_accessor :reset_token
  before_save { self.email = email.downcase }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :posts, class_name: 'Post', foreign_key: :auther_id, primary_key: :id

  def user_tag
    "@#{self.first_name} #{self.last_name}"
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


