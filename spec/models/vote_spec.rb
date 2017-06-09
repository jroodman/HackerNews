require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe "#to_s" do
    it "returns the vote's type and id" do
      user = User.create(username: "Sample_Username", email: "secret_email", password: "secret_password")
      parent = Link.create(title: "Sample Link", url: "Sample URL", user: user)

      expect(Vote.new(votable: parent).to_s).to eql "Link: #{parent.id}"
    end
  end
end
