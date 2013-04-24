class EmployeeSkillEvaluationsController < ApplicationController

	def new
    @response = Response.find_by_id(params[:response_id])
    @employee_skill_evaluation = @response.employee_skill_evaluations.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee_skill_evaluation }
    end
  end

  # GET /employee_skill_evaluations/1
  # GET /employee_skill_evaluations/1.json
  def show
      @employee_skill_evaluation = Selection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee_skill_evaluation }
    end
  end

  # POST /employee_skill_evaluations
  # POST /employee_skill_evaluations.json
  def create
      @response = Response.find_by_id(params[:response_id])
      @employee_skill_evaluation = @response.employee_skill_evaluations.build(params[:employee_skill_evaluation])
      @employee_skill_evaluation.employee_id = @response.employee_id

    respond_to do |format|
      if @employee_skill_evaluation.save
        format.html { redirect_to requests_path, notice: 'employee_skill_evaluation was successfully created.' }
        format.json { render json: @employee_skill_evaluations, status: :created, location: @employee_skill_evaluation }        
      else
        format.html { render action: "new" }
        format.json { render json: @employee_skill_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
