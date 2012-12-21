class RequestsController < ApplicationController
  before_filter :signed_in_employee, only: [:create, :destroy]

  # GET /requests
  # GET /requests.json
  def index
         @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @employee = Employee.find_by_id(params[:employee_id])
    @request = Request.find(params[:id])
    @response = @request.responses.build
    @responses = @request.responses

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @employee = Employee.find_by_id(params[:employee_id])
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @employee = Employee.find_by_id(params[:employee_id])
    @request = current_employee.requests.build(params[:request])

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      flash[:success] = "Request updated."
      sign_in @request
      redirect_to @request
    else
      render 'edit'
    end

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_url }
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
