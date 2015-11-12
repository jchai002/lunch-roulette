class SearchesController < ApplicationController
before_action :set_search, only: [:show]

  def index
    @searches = Search.all
  end

  # GET /searchs/1
  # GET /searchs/1.json
  def show
  @search = Search.find(params[:id])  
  coordinates = { latitude: @search.lat.to_f, longitude: @search.long.to_f }
  params = { term: 'restaurant',
              radius_filter: @search.radius.to_i
         }
  valids=[]
  Yelp.client.search_by_coordinates(coordinates,params).businesses.each do |b|
        valids<<b if b.rating>=@search.rating.to_f
  end

    valid= valids.sample

    @name = valid.name
    @address = valid.location.display_address[0]
    @image = valid.image_url.gsub!('ms.jpg','l.jpg') 
  end

  # GET /searchs/new
  def new
    @search = Search.new
  end

  # GET /searchs/1/edit
  def edit
  end

  # POST /searchs
  # POST /searchs.json
  def create
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
