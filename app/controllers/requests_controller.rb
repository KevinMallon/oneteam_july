class RequestsController < ApplicationController
  before_filter :signed_in_employee, only: :create
  before_filter :correct_employee,   only: :destroy
  before_filter :admin_employee,     only: :destroy

  # GET /requests
  # GET /requests.json
  def index
    @myrequests = current_employee.requests.paginate(page: params[:page])
    @requests = Request.all
    @employee = current_employee
    @skills = Skill.all 
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
      @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @employee = current_employee
    @request = Request.new
    @skills = Skill.all 

    respond_to do |format|

      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit

  def edit
      @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
 
  def create
    @request = current_employee.requests.build(params[:request])
    @request.skills_needed = params[:skills_needed].to_a     

    respond_to do |format|

      if @request.save
        format.html { redirect_to requests_path, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        redirect_to my_requests_path(current_employee.id), :alert => "Unable to update request."
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity, notice: 'Unable to update request.' }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def cancel_active
      @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      requests_path
    else
      render 'edit'
    end

    respond_to do |format|
      if @request.update_attributes(active: "0")
        format.html { redirect_to @request, notice: 'Request cancelled.' }
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
    @employee = @correct_employee.id
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


