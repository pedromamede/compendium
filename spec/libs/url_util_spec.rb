require "rails_helper"

describe UrlUtil do
  describe ".protocol_present?" do
    subject { UrlUtil.protocol_present? url }
    
    context "when url has http protocol" do
      let(:url){ 'http://google.com' }
      it{ expect(subject).to be_truthy }
    end

    context "when url has https protocol" do
      let(:url){ 'https://google.com' }
      it{ expect(subject).to be_truthy }
    end

    context "when url has no protocol" do
      let(:url){ 'google.com' }
      it{ expect(subject).to be_falsey }
    end
  end

  describe ".with_protocol" do
    subject { UrlUtil.with_protocol url }

    let(:url_with_http_protocol) { 'http://google.com' }
    let(:url_with_https_protocol){ 'https://google.com' }
    
    context "when url has http protocol" do
      let(:url){ url_with_http_protocol }
      it{ expect(subject).to eq url_with_http_protocol }
    end

    context "when url has https protocol" do
      let(:url){ url_with_https_protocol }
      it{ expect(subject).to eq url_with_https_protocol }
    end

    context "when url has no protocol" do
      let(:url){ 'google.com' }
      it{ expect(subject).to eq url_with_http_protocol }
    end
  end

  describe ".valid_url" do
    subject{ UrlUtil.valid_url? url }

    context "url with valid public sufix" do
      let(:url){ "google.com" }
      it{ expect(subject).to be_truthy }
    end

    context "with no valid public suffix" do
      let(:url){ "exampletldnotlisted" }
      it{ expect(subject).to be_falsey }
    end
  end

  describe ".shortening_algorithm" do
    it{ expect(UrlUtil.shortening_algorithm(1)).to    eq "a"   }
    it{ expect(UrlUtil.shortening_algorithm(25)).to   eq "y"   }
    it{ expect(UrlUtil.shortening_algorithm(26)).to   eq "z"   }
    it{ expect(UrlUtil.shortening_algorithm(64)).to   eq "bl"  }
    it{ expect(UrlUtil.shortening_algorithm(1530)).to eq "bfv" }
  end

  describe ".shortening_algorithm_recursive" do
    it{ expect(UrlUtil.shortening_algorithm_recursive(1)).to    eq "a"   }
    it{ expect(UrlUtil.shortening_algorithm_recursive(25)).to   eq "y"   }
    it{ expect(UrlUtil.shortening_algorithm_recursive(26)).to   eq "z"   }
    it{ expect(UrlUtil.shortening_algorithm_recursive(64)).to   eq "bl"  }
    it{ expect(UrlUtil.shortening_algorithm_recursive(1530)).to eq "bfv" }
  end
end