class TargetSkillsController < ApplicationController
  # GET /target_skills
  # GET /target_skills.json
  def index
    @target_skills = TargetSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @target_skills }
    end
  end

  # GET /target_skills/1
  # GET /target_skills/1.json
  def show
    @target_skill = TargetSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @target_skill }
    end
  end

  # GET /target_skills/new
  # GET /target_skills/new.json
  def new
    @target_skill = TargetSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @target_skill }
    end
  end

  # GET /target_skills/1/edit
  def edit
    @target_skill = TargetSkill.find(params[:id])
  end

  # POST /target_skills
  # POST /target_skills.json
  def create
    @target_skill = TargetSkill.new(params[:target_skill])

    respond_to do |format|
      if @target_skill.save
        format.html { redirect_to @target_skill, notice: 'Target skill was successfully created.' }
        format.json { render json: @target_skill, status: :created, location: @target_skill }
      else
        format.html { render action: "new" }
        format.json { render json: @target_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /target_skills/1
  # PUT /target_skills/1.json
  def update
    @target_skill = TargetSkill.find(params[:id])

    respond_to do |format|
      if @target_skill.update_attributes(params[:target_skill])
        format.html { redirect_to @target_skill, notice: 'Target skill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @target_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /target_skills/1
  # DELETE /target_skills/1.json
  def destroy
    @target_skill = TargetSkill.find(params[:id])
    @target_skill.destroy

    respond_to do |format|
      format.html { redirect_to target_skills_url }
      format.json { head :no_content }
    end
  end
end
