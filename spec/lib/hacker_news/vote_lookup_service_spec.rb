require 'rails_helper'

RSpec.describe HackerNews::VoteLookupService do

  describe "#vote" do

    let!(:user) do
      User.create(
        username: "username123",
        email: "email@test.com",
        password: "password123",
        password_confirmation: "password123")
    end

    let!(:link) do
      Link.create(
        title: 'Test Link',
        url: 'http://www.testlink.com/',
        user: user
      )
    end

    context "when initialized with a user and comment" do

      let!(:votable) do
        Comment.create(
          text: 'Test text',
          user: user,
          link: link
        )
      end

      subject { HackerNews::VoteLookupService.new(user, votable) }

      context "and there is no existing vote between the two" do

        it "returns nil" do
           expect(subject.vote).to eq nil
        end

      end

      context "and there's an existing vote between the two" do

        let!(:vote) do
          Vote.create(
            user_id: user.id,
            votable: votable
          )
        end

        it "returns the existing vote" do
          expect(subject.vote).to eq vote
        end

      end

    end

    context "when initialized with a user and link" do

      let!(:votable) { link }

      subject { HackerNews::VoteLookupService.new user, votable }

      context "and there is no existing vote between the two" do

        it "returns nil" do
	         expect(subject.vote).to eq nil
        end

      end

      context "and there's an existing vote between the two" do

        let!(:vote) do
          Vote.create(
            user_id: user.id,
            votable: votable
          )
        end

        it "returns the existing vote" do
          expect(subject.vote).to eq vote
        end

      end

    end

  end

end
