class UserMenu
  
  def initialize(user, context = nil, controller_name = nil)
    @user = user
    @context = context
    @controller_name = controller_name
  end


  def main_menu
    if @user.admin? or @user.accountant?
      return admin_main_menu
    elsif @user.parent?
      return admin_main_menu
    else
      return admin_main_menu
    end
  end
  
  def sub_menu
    if @context.present?
      if @user.admin?
        return @context.admin_sub_menu
      elsif @user.parent?
        return @context.parent_sub_menu
      elsif @user.accountant?
        return @context.accountant_sub_menu
      elsif @user.teacher?
        return @context.teacher_sub_menu 
      elsif @user.librarian?
        return @context.librarian_sub_menu
      elsif @user.swamy?
        return @context.swamy_sub_menu 
      end
    end
    []
  end

  private
  
  def admin_main_menu
    main_menu = []
    main_menu << MenuItem.new(:label => "Fee Management", :klass => ContextDetector.mapped_module_name(@controller_name) == "fee_management"? "active" :"", :icon => "bank", :href => "/")
    main_menu << MenuItem.new(:label => "Admissions", :klass => ContextDetector.mapped_module_name(@controller_name) == "enquiry_admission"? "active" :"", :icon => "book", :href => "/admissions/admission_home")
    main_menu << MenuItem.new(:label => "Academics", :klass => ContextDetector.mapped_module_name(@controller_name) == "academic"? "active" :"", :icon => "graduation-cap", :href => "/academics")
    main_menu << MenuItem.new(:label => "Results", :klass => ContextDetector.mapped_module_name(@controller_name) == "result"? "active" :"", :icon => "bullhorn", :href => "#")
    main_menu << MenuItem.new(:label => "HRM", :klass => ContextDetector.mapped_module_name(@controller_name) == "hrm"? "active" :"", :icon => "group", :href => "#")
    main_menu << MenuItem.new(:label => "Recruitment", :klass => ContextDetector.mapped_module_name(@controller_name) == "recruitment_sub_menu"? "active" :"", :icon => "user", :href => "/forms")
    main_menu << MenuItem.new(:label => "Defaults", :klass => ContextDetector.mapped_module_name(@controller_name) == "default_master_sub_menu"? "active" :"", :icon => " edit", :href => "/default_masters")
    main_menu
    main_menu << MenuItem.new(:label => "Library", :klass => ContextDetector.mapped_module_name(@controller_name) == "library"? "active" :"", :icon => " book", :href => "books/home_index")
    main_menu
  end

end
