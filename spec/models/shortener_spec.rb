require "rails_helper"

describe Shortener do
  before do
    @shortener  = Shortener.create(full_url: "google.com", counter: 2)
    @shortener2 = Shortener.create(full_url: "google.com", counter: 3)
    @shortener3 = Shortener.create(full_url: "google.com", counter: 0)
    @shortener4 = Shortener.create(full_url: "google.com", counter: 1)
  end

  subject{ Shortener.top_100 }  

  describe ".top_100" do
    it "return shorteners ordered by counter desc" do
      expect(subject.to_a).to eq [@shortener2, @shortener, @shortener4, @shortener3]  
    end
  end

  describe "#full_url_redirect" do
    let(:shortener){ Shortener.new(full_url: @full_url) }
    let(:url_http_protocol)    { "http://google.com" }
    let(:url_https_protocol)   { "https://google.com" }
    let(:url_http_no_protocol) { "google.com" }
    
    subject{ shortener.full_url_redirect }

    context "when url has http protocol" do
      before do
        @full_url = url_http_protocol
      end

      it "return the original url" do
        expect(subject).to eq shortener.full_url
      end
    end

    context "when url has https protocol" do
      before do
        @full_url = url_https_protocol
      end
      
      it "return the original url" do
        expect(subject).to eq shortener.full_url
      end
    end

    context "when url has no protocol" do
      before do
        @full_url = url_http_no_protocol
      end
      
      it "return the original with http protocol appended" do
        expect(subject).to eq url_http_protocol
      end
    end
  end  
  
  describe "#generate_short_url" do
    let(:shortener){ Shortener.new(full_url: "google.com") }
    let(:short_url) { "abc" }

    before do
      #these methods will be tested on the UrlUtil spec and requests spec (black box testing)
      allow(shortener).to receive(:next_number_for_shortening_sequence){ 1 }
      allow(UrlUtil).to receive(:shortening_algorithm).with(1){ short_url }
    end
    
    it "set the short url before validation" do
      expect(shortener.short_url).to be_nil
      shortener.valid?
      expect(shortener.short_url).to eq short_url
    end
  end

  describe "#next_number_for_shortening_sequence" do
    let(:shortener){ Shortener.new(full_url: "google.com") }

    subject{ shortener.send(:next_number_for_shortening_sequence) }

    context "when there is not shortener in the database" do
      before do
        allow(Shortener).to receive(:last){ nil }
      end
      
      it { expect(subject).to eq 1 }
    end

    context "when the last shortener id is 10" do
      before do
        allow(Shortener).to receive(:last){ Shortener.new(id: 10) }
      end
      
      it { expect(subject).to eq 11 }
    end
  end
end