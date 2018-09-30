require 'rails_helper'

RSpec.describe StudentsHelper, type: :helper do
  describe 'StudentsHelper' do
    describe "#get_social_icons" do
      let(:valid_arg) { ["facebook", "www.facebook.com"] }
      let(:inValid_arg) { ["myspace", "www.myspace.com"] }
      let(:inValid_arg_two) { [nil, "www.myspace.com"] }
      let(:inValid_arg_three) { ["twitter", nil] }
      let(:inValid_arg_three) { [nil, nil] }
      let(:inValid_arg_four) { ["", ""] }
        
      it "expect valid response HTML safe string for facebook" do
        response = get_social_media(valid_arg)

        expect(response).to match("a href=\"www.facebook.com\"")
        expect(response).to match("src=\"/images/facebook.png\"")
      end

      it "expect nil for invalid arguments" do
        response = get_social_media(inValid_arg)
        expect(response).to be(nil)
        response = get_social_media(inValid_arg_two)
        expect(response).to be(nil)
      end

      it "expect to recieve a nil" do
        response = get_social_media(inValid_arg_three)

        # TODO must rendor a a partial with someting like wrong address check the address
        expect(response).to be(nil)
      end

      it "expect to recieve a nil" do
        response = get_social_media(inValid_arg_four)

        # TODO must rendor a a partial with someting like wrong address check the address
        expect(response).to be(nil)
      end
    end
  end
end
