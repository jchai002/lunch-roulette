class SomethingsController < ApplicationController
  before_action :set_something, only: [:show, :edit, :update, :destroy]

  # GET /somethings
  # GET /somethings.json
  def index
    @somethings = Something.all
  end

  # GET /somethings/1
  # GET /somethings/1.json
  def show
    @something = Something.find(params[:id])
    
  coordinates = { latitude: @something.lat.to_f, longitude: @something.long.to_f }
  params = { term: 'food',
              radius_filter: @something.radius.to_i
         }
  valids=[]

  Yelp.client.search_by_coordinates(coordinates,params).businesses.each do |b|
        valids<<b if b.rating>=@something.rating.to_f
    end

    @valid= valids.sample
  end

  # GET /somethings/new
  def new
    @something = Something.new
  end

  # GET /somethings/1/edit
  def edit
  end

  # POST /somethings
  # POST /somethings.json
  def create
    @something = Something.new(something_params)

    respond_to do |format|
      if @something.save
        format.html { redirect_to @something, notice: 'Something was successfully created.' }
        format.json { render :show, status: :created, location: @something }
      else
        format.html { render :new }
        format.json { render json: @something.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /somethings/1
  # PATCH/PUT /somethings/1.json
  def update
    respond_to do |format|
      if @something.update(something_params)
        format.html { redirect_to @something, notice: 'Something was successfully updated.' }
        format.json { render :show, status: :ok, location: @something }
      else
        format.html { render :edit }
        format.json { render json: @something.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /somethings/1
  # DELETE /somethings/1.json
  def destroy
    @something.destroy
    respond_to do |format|
      format.html { redirect_to somethings_url, notice: 'Something was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_something
      @something = Something.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def something_params
      params.require(:something).permit(:lat, :long, :radius, :rating)
    end
end
