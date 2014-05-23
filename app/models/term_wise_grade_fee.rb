class TermWiseGradeFee < ActiveRecord::Base
  belongs_to :fee_grade_bucket
  belongs_to :term_definition
  
  scope :belongs_to_fee_grade_bucket, lambda{|bucket| where("fee_grade_bucket_id = ?", bucket.id)}

  scope :belongs_to_term_difinition, lambda{|term| where("term_definition_id = ?", term.id)}


  def amount_in_rupees
    (read_attribute(:amount_in_rupees).to_f/RuleEngine.new.value(:amount, :unit))
  end
  
  def amount_in_rupees=(amt)
    write_attribute(:amount_in_rupees, (amt.to_f * RuleEngine.new.value(:amount, :unit)))
  end

end