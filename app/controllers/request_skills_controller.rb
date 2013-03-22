class RequestSkillsController < ApplicationController
  # GET /request_skills
  # GET /request_skills.json
  def index
    @request_skills = RequestSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @request_skills }
    end
  end

  # GET /request_skills/1
  # GET /request_skills/1.json
  def show
    @request_skill = RequestSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request_skill }
    end
  end

  # GET /request_skills/new
  # GET /request_skills/new.json
  def new
    @request_skill = RequestSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request_skill }
    end
  end

  # GET /request_skills/1/edit
  def edit
    @request_skill = RequestSkill.find(params[:id])
  end

  # POST /request_skills
  # POST /request_skills.json
  def create
    @request_skill = RequestSkill.new(params[:request_skill])

    respond_to do |format|
      if @request_skill.save
        format.html { redirect_to @request_skill, notice: 'Request skill was successfully created.' }
        format.json { render json: @request_skill, status: :created, location: @request_skill }
      else
        format.html { render action: "new" }
        format.json { render json: @request_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /request_skills/1
  # PUT /request_skills/1.json
  def update
    @request_skill = RequestSkill.find(params[:id])

    respond_to do |format|
      if @request_skill.update_attributes(params[:request_skill])
        format.html { redirect_to @request_skill, notice: 'Request skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_skills/1
  # DELETE /request_skills/1.json
  def destroy
    @request_skill = RequestSkill.find(params[:id])
    @request_skill.destroy

    respond_to do |format|
      format.html { redirect_to request_skills_url }
      format.json { head :no_content }
    end
  end
end
