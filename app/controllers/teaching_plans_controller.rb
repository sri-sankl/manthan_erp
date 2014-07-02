class TeachingPlansController < ApplicationController
  def index
    @teaching_plans = TeachingPlan.all
  end
  def new
    @teaching_plan = TeachingPlan.new
  end
  def edit
    @teaching_plan = TeachingPlan.find(params[:id])
  end
  def update
    @teaching_plan = TeachingPlan.find(params[:id])
    if @teaching_plan.update(teachingplan_params)
      flash[:success] = I18n.t :success, :scope => [:teachingplan, :update]
      redirect_to teaching_plans_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:teachingplan, :update]
      render "edit"
    end
  end
  def show
    @teaching_plan = TeachingPlan.find(params[:id])
  end
  def gradeserviceview
    respond_to do |format|
      format.json do
        grades = TeacherGradeMapping.all.map do |grade|
          {grade: grade.grade_master.grade_name, id: grade.id}
        end
        render :json => grades
      end
    end  
  end
  def sectionserviceview
    respond_to do |format|
      format.json do
        sections = TeacherGradeMapping.all.map do |section|
          {section: section.section_master.section, id: section.id,grade_master_id: section.grade_master_id  }
        end
        render :json => sections
      end
    end  
  end
  def create
    @teaching_plan = TeachingPlan.new(teachingplan_params)
    respond_to do |format|
      if @teaching_plan.save
        format.html { redirect_to @teaching_plan, notice: 'Plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @teaching_plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @teaching_plan.errors, status: :unprocessable_entity }
      end
    end
  end
  def teachingplan_params
    params.require(:teaching_plan).permit(:grade_master_id, :section_master_id,:teaching_date,:plan_month  )
  end
end
