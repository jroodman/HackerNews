require 'rails_helper'

RSpec.describe Vote, type: :model do

  let!(:user) do
    User.create(
      username: "username123",
      email: "email@test.com",
      password: "password123"
    )
  end

  let!(:parent) do
    Link.create(
      title: "Sample Link",
      url: "Sample URL",
      user: user
    )
  end

  subject { Vote.create(votable: parent, user_id: user.id) }

  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :votable_type }
  it { should validate_presence_of :votable_id }

  it { should validate_uniqueness_of(:user_id).scoped_to([:votable_id, :votable_type]) }

  describe "#to_s" do
    it "returns the vote's type and id" do
      expect(subject.to_s).to eql "Link: #{parent.id}"
    end
  end
end
