class DataSourcesController < ApplicationController
  before_action :set_data_source, only: [:show, :edit, :update, :destroy]

  # GET /data_sources
  # GET /data_sources.json
  def index
    @data_sources = DataSource.all
  end

  # GET /data_sources/1
  # GET /data_sources/1.json
  def show
  end

  # GET /data_sources/new
  def new widget_id
    @widget = current_user.widgets.find(widget_id)
    @data_source = DataSource.new
    @data_source.widget = @widget
  end

  # GET /data_sources/1/edit
  def edit
  end

  # POST /data_sources
  # POST /data_sources.json
  def create widget_id, data_source
    @widget = current_user.widgets.find(widget_id)
    @data_source = DataSource.new(data_source_params)
    @data_source.widget = @widget

    respond_to do |format|
      if @data_source.save
        flash[:success] = 'Data source was successfully created.'
        format.html { redirect_to widget_path(@widget) }
        format.json { render :show, status: :created, location: @data_source }
      else
        format.html { render :new }
        format.json { render json: @data_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_sources/1
  # PATCH/PUT /data_sources/1.json
  def update
    respond_to do |format|
      if @data_source.update(data_source_params)
        flash[:success] = 'Data source was successfully updated.'
        format.html { redirect_to edit_widget_path(@widget) }
        format.json { render :show, status: :ok, location: @data_source }
      else
        format.html { render :edit }
        format.json { render json: @data_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_sources/1
  # DELETE /data_sources/1.json
  def destroy
    @data_source.destroy
    respond_to do |format|
      flash[:success] = 'Data source was successfully destroyed.'
      format.html { redirect_to widget_path(@data_source.widget) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_source
      @data_source = DataSource.find(params[:id])
      @widget = @data_source.widget
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_source_params
      params.require(:data_source).permit!
    end
end
