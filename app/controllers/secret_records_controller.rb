class SecretRecordsController < ApplicationController
  load_and_authorize_resource :group, through: 'current_user'
  load_and_authorize_resource :secret_record, through: 'group'
  
  # GET /secret_records
  # GET /secret_records.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secret_records }
    end
  end

  # GET /secret_records/1
  # GET /secret_records/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secret_record }
    end
  end

  # GET /secret_records/new
  # GET /secret_records/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secret_record }
    end
  end

  # GET /secret_records/1/edit
  def edit
  end

  # POST /secret_records
  # POST /secret_records.json
  def create
    respond_to do |format|
      if @secret_record.save
        format.html { redirect_to @group, notice: 'Secret record was successfully created.' }
        format.json { render json: @secret_record, status: :created, location: @secret_record }
      else
        format.html { render action: "new" }
        format.json { render json: @secret_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secret_records/1
  # PUT /secret_records/1.json
  def update
    respond_to do |format|
      if @secret_record.update_attributes(params[:secret_record])
        format.html { redirect_to @group, notice: 'Secret record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @secret_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secret_records/1
  # DELETE /secret_records/1.json
  def destroy
    @secret_record.destroy

    respond_to do |format|
      format.html { redirect_to @group }
      format.json { head :no_content }
    end
  end
end
