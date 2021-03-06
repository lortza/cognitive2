class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_record, only: [:show, :edit, :update]

  # GET /records
  # GET /records.json
  def index
    @records = Record.where(user_id: current_user.id).order(date: 'desc')
    # @experienced_unhealthy_thought_types = @records.unhealthy_thought_type_counter
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    def correct_user_record
      unless (current_user_admin?) || (current_user.records.include? @record)
        redirect_to records_url, notice: "Whoops! That wasn't your record."
      end #if
    end #correct_user_record

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:date, :event, :thought_about_event, :feeling_about_thought, :unhealthy_action, :unhealthy_thought_type_id, :healthy_thought_type_id, :reframe_statement, :healthy_action, :star, :user_id)
    end
end
