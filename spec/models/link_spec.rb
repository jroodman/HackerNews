require 'rails_helper'

RSpec.describe Link, type: :model do

  let!(:user) do
    User.create(
      username: "username",
      email: "email",
      password: "password"
    )
  end

  subject { Link.create(title: "title", url: "url", user: user) }

  it { should belong_to(:user) }
  it { should have_many(:votes) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :url }
  it { should validate_presence_of :votes_count }
  it { should validate_presence_of :user_id }

  it { should validate_uniqueness_of :title }
  it { should validate_uniqueness_of :url }

  describe "#to_s" do
    it "returns the link's title" do
      expect(Link.new(title: "Sample Title").to_s).to eql "Sample Title"
    end
  end
end
