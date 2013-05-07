class EmployeeSkillEvaluationsController < ApplicationController
  before_filter :signed_in_employee

  def index    
  	@employee_skill_evaluations = EmployeeSkillEvaluation.all  
  end

  def show    
  	@response = Response.find_by_id(params[:response_id])    
  	@employee_skill_evaluation = EmployeeSkillEvaluation.find(params[:id])  
  end

  def new    
  	@response = Response.find_by_id(params[:response_id])    
  	@employee = @response.employee    
  	@request = @response.request    
  	@employee_skill_evaluation = @response.employee_skill_evaluations.build  
  end

  def edit    
  	@response = Response.find_by_id(params[:response_id])    
  	@employee = @response.employee    
  	@request = @response.request    
  	@employee_skill_evaluation = EmployeeSkillEvaluation.find(params[:id])  
  end

  def create    
  	@response = Response.find_by_id(params[:response_id])    
  	@employee_skill_evaluation = @response.employee_skill_evaluations.build(params[:employee_skill_evaluation])      
  	respond_to do |format|      
  		if @employee_skill_evaluation.save        
  			format.html { redirect_to response_employee_skill_evaluation_path(@response,@employee_skill_evaluation), notice: 'Developer evaluation was successfully created.' }        
  			format.json { render json: @employee_skill_evaluation, status: :created, location: @employee_skill_evaluation }      
  		else        
  			format.html { render action: "new" }        
  			format.json { render json: @employee_skill_evaluation.errors, status: :unprocessable_entity }      
  		end    
  	end  
  end

  def update    
  	@response = Response.find_by_id(params[:response_id])    
  	@employee_skill_evaluation = EmployeeSkillEvaluation.find(params[:id])    
  	respond_to do |format|      
  		if @employee_skill_evaluation.update_attributes(params[:employee_skill_evaluation])        
  			format.html { redirect_to response_employee_skill_evaluation_path(@response,@employee_skill_evaluation), notice: 'Developer evaluation was successfully updated.' }        
  			format.json { head :no_content }      
  		else        
  			format.html { render action: "edit" }        
  			format.json { render json: @employee_skill_evaluation.errors, status: :unprocessable_entity }      
  		end    
  	end  
  end

  def destroy    @employee_skill_evaluation = EmployeeSkillEvaluation.find(params[:id])    
  	@employee_skill_evaluation.destroy    
  	respond_to do |format|      
  		format.html { redirect_to employee_skill_evaluations_url }      
  		format.json { head :no_content }    
  	end  
  end

end
