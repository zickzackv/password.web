class MembersController < ApplicationController
  load_and_authorize_resource :group, through: :current_user
  load_and_authorize_resource :member, through: :group, except: [:create]
  # GET /members
  # GET /members.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # POST /members
  # POST /members.json
  def create
    authorize! :create, Member
    password = params[:member].delete(:password)
    @member = @group.members.new(params[:member])
    acceptance_password = new_token
    secret = Secret.decode @group.secret_for(current_user), with: password
    @member.secret = Secret.encode(secret, with: acceptance_password)
    respond_to do |format|
      if @member.save
        p acceptance_password
        # TODO: Mail with acceptance_password !!!
        format.html { redirect_to group_members_url(@group), notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  def accepted
    @member.secret = params[:member][:secret]
    @member.accepted = true
    respond_to do |format|
      if @member.save
        format.html { redirect_to group_members_url(@group), notice: 'Membership was successfully acepted.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "accept" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to group_members_url(@group) }
      format.json { head :no_content }
    end
  end
end
