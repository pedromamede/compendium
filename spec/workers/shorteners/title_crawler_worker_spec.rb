require "rails_helper"

RSpec.describe Shortener::TitleCrawlerWorker, type: :worker do

  describe "#perform" do
    let(:shortener){ Shortener.create(full_url: "google.com") }

    before do
      allow(Shortener).to receive(:find).with(shortener.id){ shortener }
      allow(HTTParty).to  receive(:get){ mock_response }
    end
    
    context "when there's no title in the body" do
      let(:mock_response) { double(:mock, body: "fake") }
      
      it "it doesnt update the title" do
        expect(shortener).to_not receive(:update)
        subject.perform shortener.id
      end
    end

    context "when a title in the body" do
      let(:mock_response) { double(:mock, body: "<head><title>Google</title></head>") }

      it "update the shortener title with the crawled text" do
        expect(shortener.html_title).to be_nil
        subject.perform shortener.id
        expect(shortener.html_title).to eq "Google"
      end
    end
  end
end