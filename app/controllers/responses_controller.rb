class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.json
  def index
    if defined? params[:request_id]
      @request = Request.find(params[:request_id])
      @responses = @request.responses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @responses }
    end
    else
      @responses = Response.all
    end
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
      @response = Response.find(params[:id])
      @responses = @request.responses.build
      @employee = Employee.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end

  def new
    @request = Request.find_by_id(params[:request_id]) 
    @response = @request.responses.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end

  # POST /responses
  # POST /responses.json
  def create
      @request = Request.find_by_id(params[:request_id])
      @response = @request.responses.build(params[:response])
      @response.employee_id = current_employee.id

    respond_to do |format|
      if @response.save
        format.html { redirect_to edit_response_path(@response), notice: 'Response was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }        
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /responses/1/edit
  def edit
      @response = Response.find(params[:id])
  end

  # PUT /responses/1
  # PUT /responses/1.json
  def update
      @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to edit_response_path(@response), notice: 'Response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end

      def signed_in_employee
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_employee
      @employee = Employee.find(params[:id])
      redirect_to(root_path) unless current_employee?(@employee)
    end
end
