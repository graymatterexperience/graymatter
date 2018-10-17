require "rails_helper"

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'User sign up mailer' do
    let(:user) { create(:student_user) }
    let(:mail) { UserNotifierMailer.send_signup_email(user) }
    it 'send a email to the user' do
      expect(mail.to).to include(user.email)
      expect(mail.subject).to eq('Welcome to the Gray Matter Experience')
      # TODO: change once in production
      expect(mail.from).to include('troyleach@outlook.com')
      expect(mail.body.encoded).to include(user.name)
    end
  end
end
