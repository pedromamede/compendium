class UrlsController < ApplicationController
  before_action :set_url, only: %i[ show edit update destroy ]

  def index
    @urls = Url.order(counter: :desc).limit(100)
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)

    if @url.save
      redirect_to @url, notice: "Url was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:full)
    end
end
