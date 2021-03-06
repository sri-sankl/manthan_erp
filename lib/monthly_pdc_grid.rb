class MonthlyPdcGrid

  def initialize(grades = []) 
    @monthly_pdc_grid = nil
    @grade_list = grades
  end
  
  def get_grid
    @monthly_pdc_grid ||= prepare_grid
  end

  def grid_headers
    months = Set.new
    @applied_grade_fee ||= get_grid
    @applied_grade_fee.each do |month_fees|
      month_fees.each{|fee| months.add(fee.post_dated_month)}
    end
    months.to_a
  end

  def self.get_object_list_from_grid(params, academic_year)
    params.map do |param|
      param.select{|sel_unit|  sel_unit["amount_in_rupees"].present? }.map do |unit|
        if unit["id"].present?
          t_w_f = MonthlyPdcAmount.find(unit["id"])
          t_w_f.amount_in_rupees =  unit["amount_in_rupees"] 
          t_w_f
        else
          MonthlyPdcAmount.new(:id => unit["id"], :fee_grade_bucket_id => unit["fee_grade_bucket_id"], :post_dated_cheque_id => unit["post_dated_cheque_id"], :amount_in_rupees => unit["amount_in_rupees"], :academic_year => academic_year)
        end
      end
    end.flatten
  end


  private

  def get_grade_buckets_from_map
    FeeGradeBucket.where(:id =>GradeBucketMapping.belongs_to_grades(@grade_list).map{|gr_map| gr_map.fee_grade_bucket_id})
  end

  def prepare_grid
    amount_conversion = AmountConversion.new 
    get_grade_buckets_from_map.map do |bucket|
      total = bucket.grade_wise_fees.inject(0){|tot, fee| tot+fee.amount_in_rupees}
      PostDatedCheque.all.map do |pdc|
        pdc_amount = MonthlyPdcAmount.belongs_to_fee_grade_bucket(bucket).belongs_to_post_dated_cheque(pdc).first
        if pdc_amount.present?
          MonthlyPdcUnit.new(:id => pdc_amount.id, :fee_grade_bucket_id => bucket.id, :post_dated_cheque_id => pdc.id, :fee_grade_bucket_name => bucket.bucket_name, :post_dated_month => pdc.month, :amount_in_rupees => pdc_amount.amount_in_rupees)
        else
          MonthlyPdcUnit.new(:fee_grade_bucket_id => bucket.id, :post_dated_cheque_id => pdc.id, :fee_grade_bucket_name => bucket.bucket_name, :post_dated_month => pdc.month, :amount_in_rupees => amount_conversion.part_percentage_from_total_percentage(total, pdc.amount_per))
        end
      end
    end
  end
  
  class MonthlyPdcUnit
    include Virtus.model
    attribute :id, String
    attribute :fee_grade_bucket_id, String
    attribute :post_dated_cheque_id, String
    attribute :amount_in_rupees, String
    attribute :fee_grade_bucket_name, String
    attribute :post_dated_month, String
  end

end
