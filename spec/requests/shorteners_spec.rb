require "rails_helper"

RSpec.describe "Shortener resources", :type => :request do
  describe "GET /shorteners" do
    before do
      @shortener = Shortener.create(full_url: "google.com")
    end
    
    it "render index template" do
      get "/shorteners" 
      expect(response).to render_template(:index)
    end

    it "assign shorterners" do
      get "/shorteners" 
      expect(assigns(:shorteners)).to eq [@shortener]
    end

    it "render shorterners attributes" do
      get "/shorteners" 
      expect(response.body).to include(@shortener.short_url)
      expect(response.body).to include(@shortener.full_url)
      expect(response.body).to include(@shortener.counter.to_s)
    end
  end

  describe "GET /" do
    it "renders the new template" do
      get "/"
      expect(response).to render_template(:new)
    end

    it "render full url input with place holder" do
      get "/"
      expect(response.body).to include("<input class=\"form-control\" placeholder=\"Type your full URL here.\" type=\"text\" name=\"shortener[full_url]\" id=\"shortener_full_url\" />")
    end
  end

  describe "GET /shorteners/new" do
    it "renders the new template" do
      get "/shorteners/new"
      expect(response).to render_template(:new)
    end
  end

  describe "POST shorteners" do
    subject{ post "/shorteners", :params => { format: :js, :shortener => {:full_url => full_url_param} } }

    let(:full_url_param){ "google.com" }
    
    before do
      subject
    end
    
    it{ expect(response).to have_http_status(:created) }
    it{ expect(response).to render_template(:create) }
    
    it "return content-type text/javascript" do
      expect(response.content_type).to eq("text/javascript; charset=utf-8")
    end
    
    it "includes short url link in its response body" do
      last_short_url = Shortener.last.short_url
      expect(response.body).to include("http://www.example.com/#{last_short_url}")
    end

    it "includes copy button in its response body" do
      expect(response.body).to include("<a class=\\'btn btn-dark mt-4\\' onclick=\\'copyUrl()\\'> Copy <\\/a>")
    end

    context "when it's a invalid shortener" do
      let(:full_url_param){ "" }

      it{ expect(response).to have_http_status(:unprocessable_entity) }
      it{ expect(response).to render_template(:create) }
      
      it "return content-type text/javascript" do
        expect(response.content_type).to eq("text/javascript; charset=utf-8")
      end
      
      it "includes errors in its response body" do
        expect(response.body).to include("URL can&#39;t be blank")
      end
    end
  end

  describe "GET /:short_url" do
    subject{ get "/#{short_url}" }
    let(:shortener){ Shortener.create(full_url: 'google.com') }
    let(:short_url){ shortener.short_url }

    it "increment the shortener's counter" do
      expect{subject}.to change{Shortener.find(shortener.id).counter}.by 1
    end

    it "redirect to the full_url" do
      subject
      expect(response).to redirect_to "http://google.com"
    end

    context "when it's an invalid short url" do
      let(:short_url){ "fake_short_url" }
      it{ subject;expect(response).to have_http_status(:not_found) }

      it "renders a 404 page" do
        subject
        expect(response.body).to include("The page you were looking for doesn't exist.")
      end
    end
  end
end