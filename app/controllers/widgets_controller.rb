class WidgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_widget, only: [:show, :edit, :update, :destroy]

  # GET /widgets
  # GET /widgets.json
  def index
    @widgets = current_user.widgets.all
  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
    redirect_to edit_widget_path @widget
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
    @chart = build_chart @widget
  end

  # POST /widgets
  # POST /widgets.json
  def create
    @widget = Widget.new(widget_params)
    @widget.user = current_user

    respond_to do |format|
      if @widget.save
        flash[:success] = 'Your widget was successfully saved.'
        format.html { redirect_to edit_widget_path(@widget)}
        format.json { render :show, status: :created, location: @widget }
      else
        format.html { render :new }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    respond_to do |format|
      if @widget.update(widget_params)
        flash[:success] = 'Widget was successfully updated.'
        format.html { redirect_to edit_widget_path @widget }
        format.json { render :show, status: :ok, location: @widget }
      else
        format.html { render :edit }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget.destroy
    respond_to do |format|
      flash[:success] = 'Widget was successfully destroyed.'
      format.html { redirect_to widgets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def widget_params
      params.require(:widget).permit!
    end
end
