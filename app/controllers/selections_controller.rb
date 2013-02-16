class SelectionsController < ApplicationController

  def new
    @response = Response.find_by_id(params[:response_id])
    @selection = @response.selections.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @selection }
    end
  end

  # GET /selections/1
  # GET /selections/1.json
  def show
      @selection = Selection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @selection }
    end
  end

  # POST /selections
  # POST /selections.json
  def create
      @response = Response.find_by_id(params[:response_id])
      @selection = @response.selections.build(params[:selection])
      @selection.employee_id = current_employee.id

    respond_to do |format|
      if @selection.save
        format.html { redirect_to requests_path, notice: 'selection was successfully created.' }
        format.json { render json: @selections, status: :created, location: @selection }        
      else
        format.html { render action: "new" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /selections/1/edit
  def edit
      @selection = Selection.find(params[:id])
  end

  # PUT /selections/1
  # PUT /selections/1.json
  def update
      @selection = Selection.find(params[:id])

    respond_to do |format|
      if @selection.update_attributes(params[:selection])
        format.html { redirect_to edit_selection_path(@selection), notice: 'selection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /selections/1
  # DELETE /selections/1.json
  def destroy
    @selection = Selection.find(params[:id])
    @selection.destroy

    respond_to do |format|
      format.html { redirect_to selections_url }
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
