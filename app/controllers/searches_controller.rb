class SearchesController < ApplicationController
before_action :set_search, only: [:show]
include SearchesHelper
  # GET /searchs/1
  # GET /searchs/1.json
  def show
  @search = Search.find(params[:id])  
  coordinates = { latitude: @search.lat.to_f, longitude: @search.long.to_f }
  params = { term: 'restaurant',
              radius_filter: mile_to_meter(@search.radius.to_i)
         }
  valids=[]
  Yelp.client.search_by_coordinates(coordinates,params).businesses.each do |b|
        valids<<b if b.rating>=@search.rating.to_f
  end

    valid= valids.sample

    if valid.name
    @name = valid.name
    end

    if valid.location
    @address = valid.location.display_address[0]
    end

    if valid.image_url
    @image = valid.image_url.gsub!('ms.jpg','l.jpg')
    end 

  end

  # GET /searchs/new
  def new
    @search = Search.new
  end

  # POST /searchs
  # POST /searchs.json
  def create
    Search.all.each do |e|
      e.destroy
    end

    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:lat, :long, :radius, :rating)
    end
end
