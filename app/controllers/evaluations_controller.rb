class EvaluationsController < ApplicationController

  def index    
    @evaluations = Evaluation.all  

    respond_to do |format|      
    format.html # index.html.erb      
    format.json { render json: @evaluations }    
    end  
  end  

  def show   # @response = Response.find_by_id(params[:response_id])    
    @evaluation = Evaluation.find(params[:id]) 
    @response = @evaluation.response    
    @request = @response.request   
    @employee = @response.employee  
  end  

  def new    
    @response = Response.find_by_id(params[:response_id])    
    @employee = @response.employee    
    @request = @response.request    
    @evaluation = @response.build_evaluation
  end  

  def edit  #  @response = Response.find_by_id(params[:response_id])    
    @evaluation = Evaluation.find(params[:id])    
    @response = @evaluation.response    
    @employee = @response.employee    
    @request = @response.request    
    @skill_evaluations = @evaluation.employee_skill_evaluations  
  end  

  def create    
    @response = Response.find_by_id(params[:response_id])    
    @evaluation = @response.build_evaluation(params[:evaluation])    

    respond_to do |format|      
      if @evaluation.save        
        format.html {           
        redirect_to response_evaluation_path(@response,@evaluation),           
        notice: 'Employee Skill Evaluation was successfully created.' }        
        format.json { render json:           
        @evaluation, status: :created, location: @evaluation }      
      else        
        format.html { render action: "new" }        
        format.json { render json: @evaluation.errors,           
        status: :unprocessable_entity }      
      end    
    end  
  end  

  def update   # @response = Response.find_by_id(params[:response_id])    
  @evaluation = Evaluation.find(params[:id])    
  @response = @evaluation.response    

  respond_to do |format|      
    if @evaluation.update_attributes(params[:evaluation])        
      format.html {           
      redirect_to response_evaluation_path(@response,@evaluation),           
      notice: 'Evaluation was successfully updated.' }        
      format.json { head :no_content }      
    else        
      format.html { render action: "edit" }        
      format.json { render json: @evaluation.errors,           
      status: :unprocessable_entity }      
    end    
  end  
  end  

  def destroy   # @response = Response.find_by_id(params[:response_id])   
  @evaluation = Evaluation.find(params[:id])    
  @response = @evaluation.response    
  @evaluation.destroy    

  respond_to do |format|      
    format.html { redirect_to         
      employee_requests_path(current_employee) }      
      format.json { head :no_content }    
    end  
  end
  end