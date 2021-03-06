class FormsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy]
  def create
    @form = Form.new(form_params)
    @form.update(:status => "Enquiry Created")
    if @form.save
      flash[:success] = I18n.t :success, :scope => [:form, :create]
      redirect_to forms_path
    else
      render "new"
    end
    end
  def index
    @forms = Form.all
    @forms = Form.search(params[:search])
   
  end
def home_index
   @form = Form.find(params[:id])
  @forms = Form.forms
  end
  def new
    @form = Form.new
  end
def edit
  @form = Form.find(params[:id])
  end
  def show
    @form = Form.find(params[:id])
  end
  def update
    @form = Form.find(params[:id])
    @form.update(:status => "Assessment Scheduled")
    if @form.update(form_params)
      flash[:success] = I18n.t :success, :scope => [:form, :update]
      redirect_to forms_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:form, :update]
      render "edit"
    end
    end
  def destroy
    @form = Form.find(params[:id])    
    if @form.destroy
      flash[:success] = I18n.t :success, :scope => [:form, :destroy]
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:form, :destroy]
    end
    redirect_to forms_path
    end
  

  def form_params
    params.require(:form).permit(:name, :dob, :gender, :email,:mobile_no, :address, :klass, :language, :subject, :experience, :expected_salary, :education_qualification, :nationality, :enquiry_no,  :status)
  end
end
