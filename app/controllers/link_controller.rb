class LinkController < ApplicationController
  def index
  end

  def create
    @link = Link.new(link_params)
      if @link.save
        ScrapeJob.perform_async(@link.id)
        ScreenshotJob.perform_async(@link.id)
        redirect_to link_path(@link), notice: 'Link was successfully created.'
      else
        redirect_to root_path, notice: 'Link was not created'
      end
    end

  def show
    if params[:slug]
      @link = Link.find_by_slug(params[:slug])
      @link.clicks += 1
      @link.save
      redirect_to @link.target_url
    else
      @link = Link.find(params[:id])
      #render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

private

  def link_params
    params.require(:link).permit(:target_url)
  end
end
