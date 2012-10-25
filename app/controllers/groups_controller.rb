class GroupsController < ApplicationController

  load_and_authorize_resource :group, through: 'current_user', except: [:create]

  # GET /groups
  # GET /groups.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    authorize! :create, Group

    password = params[:group].delete(:password)
    @group = Group.new(params[:group])
    raise(CanCan::AccessDenied, 'Wrong password') unless current_user.valid_password?(password)
    Group.transaction do
      @group.save!
      member          = Member.new
      member.group    = @group
      member.user     = current_user
      member.secret   = Secret.encode(new_token(32), with: password)
      member.accepted = true
      member.save!
      current_user.members << member
      current_user.save!
    end
    respond_to do |format|
      format.html { redirect_to @group, notice: 'Group was successfully created.' }
      format.json { render json: @group, status: :created, location: @group }
    end
  rescue
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    raise(CanCan::AccessDenied, 'Wrong password') unless current_user.valid_password?(params[:group].delete(:password))
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
