class Library

  def initialize(args)
    @controller = args[:controller]
  end

  def admin_sub_menu
    sub_menu = []
    sub_menu << home
    sub_menu << books
   
end
  def librarian_sub_menu
    
    sub_menu = []
    sub_menu << home
    sub_menu << books
    sub_menu << issuing_books
    sub_menu << damage_books
    sub_menu << block_books
    sub_menu << approval_for_books
  end
  def parent_sub_menu
    sub_menu = []
    sub_menu << request_new_books
    sub_menu
  end
  def teacher_sub_menu
    sub_menu = []
    sub_menu << suggest_new_books
    sub_menu
  end
  private 
  def home
    MenuItem.new(:label => "Home", :klass => "", :icon => "home ", :href => "books/home_index")
  end
  def  books
    MenuItem.new(:label => "Books", :klass => "", :icon => "book ", :href => "/books")
  end
  def issuing_books
    MenuItem.new(:label => "Issuing Books", :klass => "", :icon => "cubes", :href => "/issuings")
  end
  def damage_books
    MenuItem.new(:label => "Damage/Loss Books", :klass => "", :icon => "file-excel-o ", :href => "/damagebooks")
  end
  def block_books
    MenuItem.new(:label => "Block Books", :klass => "", :icon => "file-excel-o ", :href => "/block_books")
  end
  def request_new_books
    MenuItem.new(:label => "Suggest New Book", :klass => "", :icon => "file-excel-o ", :href => "/request_new_books")
  end
  def suggest_new_books
    MenuItem.new(:label => "Suggest New Book", :klass => "", :icon => "file-excel-o ", :href => "/request_new_books/request_new")
  end
  def approval_for_books
    MenuItem.new(:label => "Approval For New Book", :klass => "", :icon => "file-excel-o ", :href => "/request_new_books/request_approval")
  end
end
