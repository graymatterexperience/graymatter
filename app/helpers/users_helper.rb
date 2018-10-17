module UsersHelper
  require 'securerandom'
  def generate_password
    SecureRandom.hex(4)
  end
end
