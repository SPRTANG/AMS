class AssignmentsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  respond_to  :html, :js

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = if params[:term]
               @assignments = current_user.assignments.where('title LIKE ?', "%#{params[:term]}%").order('id DESC').paginate(page: params[:page])
             else
               @assignments = current_user.assignments.paginate(page: params[:page])
             end

  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = current_user.assignments.find(params[:id])
  end

  # GET /assignments/new
  def new
    @assignment = current_user.assignments.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = current_user.assignments.new(assignment_params)
    @assignment.user_id = current_user.id
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    @assignment.user_id = current_user.id
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_attachment
    assignment = params[:assignment]
    file_path = current_user.assignments.find(assignment).attachment_path_url.sub('%3A', ':')
    file_name = File.basename(file_path)
    send_file(file_path, filename: file_name)
  end

  # Check upcoming assignment which is soon dued (< 2 weeks).
  def check_upcoming_dued_assignment
    @upcomming_dued_assignment = current_user.assignments.where(:is_submitted => 0).where("due_date - CURDATE() < ?", 14)
    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
      format.json {render json: @stats}
    end
  end

  # Check stats of assignment
  def check_stats
    @totalAssignments = current_user.assignments.count
    @noncompletedAssignment = current_user.assignments.where(:is_submitted => 0).count
    respond_to do |format|
      format.js { render layout: false, content_type: 'text/javascript' }
      format.json {render json: {:totalAssignments => @totalAssignments,
                                 :noncompletedAssignment => @noncompletedAssignment }}
    end
  end


  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = current_user.assignments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      # params.fetch(:assignment, {})
      params.require(:assignment).permit(:content, :title, :attachment_path, :due_date, :is_submitted, :user_id, :term)
    end


end
