require 'rails_helper'

RSpec.describe HackerNews::VoteLookupService do

  describe "#vote" do

    let!(:user) do
      User.create(
        username: "username123",
        email: "email@test.com",
        password: "password123",
        password_confirmation: "password123"
      )
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

      subject { HackerNews::VoteLookupService.new(user: user, votable: votable) }

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

      subject { HackerNews::VoteLookupService.new user: user, votable: votable }

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

  describe "#links" do

    let!(:user) do
      User.create(
        username: "username123",
        email: "email@test.com",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    let!(:votable1) do
      Link.create(
        title: 'Test Link1',
        url: 'http://www.testlink1.com/',
        user: user
      )
    end

    let!(:votable2) do
      Link.create(
        title: 'Test Link2',
        url: 'http://www.testlink2.com/',
        user: user
      )
    end

    let!(:vote1) do
      Vote.create(
        user_id: user.id,
        votable: votable1
      )
    end

    let!(:vote2) do
      Vote.create(
        user_id: user.id,
        votable: votable2
      )
    end

    subject { HackerNews::VoteLookupService.new(user: user) }

    it "returns all the links the given user has voted on" do
      expect(subject.links).to eq [votable1, votable2]
    end

  end

end
