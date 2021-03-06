class Issuing < ActiveRecord::Base
  acts_as_paranoid
  attr_accessor :is_returned
  belongs_to :book
 
  
  belongs_to :student, :class_name => "StudentMaster"
   
  scope :belongs_to_student, lambda{|student| where(:student_master_id => student)}
    
  def self.student_book_issuings(student)
    Issuing.joins(:book).select("issuings.id", "issuings.book_issue_date", "issuings.book_return_date", "books.name").belongs_to_student(student).order("issuings.book_issue_date DESC").group_by{|b| b.book.name}
  end
  
end
