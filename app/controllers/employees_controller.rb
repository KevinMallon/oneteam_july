class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:index, :edit, :update]
  before_filter :correct_employee,   only: [:edit, :update]
  before_filter :admin_employee,     only: :destroy

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.json
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employee }
    end
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        flash[:success] = "Welcome to OneTeam! Profile was successfully created."
        sign_in @employee
        format.html { redirect_to @employee}
        format.json { render json: @employee, status: :created, location: @employee }
      else
        format.html { render action: "new" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        flash[:success] = "Profile updated."
        sign_in @employee
        format.html { redirect_to @employee }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    Employee.find(params[:id]).destroy
    flash[:success] = "Employee deleted."

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

private
    def signed_in_employee
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_employee
      @employee = Employee.find(params[:id])
      redirect_to(root_path) unless current_employee?(@employee)
    end

    def admin_employee
      redirect_to(root_path) unless current_employee.admin?
    end
end

