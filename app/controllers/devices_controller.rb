require 'json'
require 'open-uri'

class DevicesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = current_user.devices.all

    
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
    @device.user = current_user
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    @device.user = current_user

    respond_to do |format|
      if @device.save
        flash[:success] = 'Device was successfully created.'
        format.html { redirect_to devices_url }
        format.json { render :show, status: :created, location: @device }
      else
        flash[:error] = 'Device was not created.'
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      flash[:success] = 'Device was successfully destroyed.'
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = current_user.devices.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:name, :location, :identifier)
    end
end
