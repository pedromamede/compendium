class ShortenersController < ApplicationController

  before_action :get_shortener, only: [:show]

  def new
    
  end

  def show
    redirect_to @shortener.full_url_redirect
  end

  def create
    @shortener = Shortener.new(shortener_params)

    respond_to do |format|
      if @shortener.save
        format.js { render :create, status: :created }
      else
        format.js { render create: @shortener.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_shortener
    @shortener = Shortener.find_by(short_url: params[:short_url])
  end
  
  def shortener_params
    params.require(:shortener).permit(:full_url)
  end
end
