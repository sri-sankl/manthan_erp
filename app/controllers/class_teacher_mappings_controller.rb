class ClassTeacherMappingsController < ApplicationController
  
  def get_class_teacher_mappings
    respond_to do |format|
      format.json do
        my_Grade = params[:my_Grade].to_i
        classteachermappings = ClassTeacherMapping.where('grade_master_id = '+"#{my_Grade}") 
        classteachermappings = classteachermappings.all.map do |mapping|
          {id: mapping.id, grade_master_id: mapping.grade_master_id, grade_name: mapping.grade_master.grade_name, section_master_id: mapping.section_master_id,  section_name: mapping.section_master.section_name, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name}          
        end        
        render :json =>classteachermappings        
      end
    end
  end


  def get_grade_wise_mappings    
    respond_to do |format|
      format.json do
        my_Grade = params[:my_Grade]
           
        teachersgrademappings = TeacherGradeMapping.where('grade_master_id = '+"#{my_Grade}")        
      
        teachersgrademappings = teachersgrademappings.all.map do |mapping|
          if  (mapping.subject_master_id.present?)
            sub_name = mapping.subject_master.subject_name
          else
            sub_name = nil
          end
          if  (mapping.grade_master_id.present?)
            grad_name = mapping.grade_master.grade_name
          else
            grad_name = nil
          end
          if  (mapping.section_master_id.present?)
            sec_name = mapping.section_master.section_name
          else
            sec_name = nil
          end
          {id: "",  grade_master_id: mapping.grade_master_id.to_i, grade_name: grad_name, section_master_id: mapping.section_master_id.to_i, section_name: sec_name, grade_section: mapping.grade_master_id.to_s+"-"+mapping.section_master_id.to_s, faculty_master_id:"", faculty_name:""}
          
        end          
        t = teachersgrademappings.uniq { |h| h[:grade_section] }        
        render :json =>t
       
      end
    end
  end

  def get_grade_wise_faculty_names
    respond_to do |format|
      format.json do
        p my_Grade = params[:my_Grade]
        
        teachersgrademappings = TeacherGradeMapping.where('grade_master_id = '+"#{my_Grade}")        
        
        teachersgrademappings = teachersgrademappings.all.map do |mapping|
          {id: mapping.id, faculty_master_id: mapping.faculty_master_id, faculty_name: mapping.faculty_master.faculty_name}
        end               
        t = teachersgrademappings.uniq { |h| h[:faculty_master_id] }        
        render :json =>t        
      end
    end
  end

  def save_mappings
    respond_to do |format|
      format.json do  
        mappings = params[:mappings]
        p mappings 
        mappings.each do |map|
          if  map[:id].present?    
            temp = ClassTeacherMapping.find(map[:id])
            temp.grade_master_id = map["grade_master_id"]
            temp.section_master_id = map["section_master_id"]
            temp.faculty_master_id = map["faculty_master_id"]    
            temp.save  
          else              
            @mapping = ClassTeacherMapping.new(add_params(map))
            @mapping.save
          end
        end            
        render :json => true
      end
    end
  end  

  def deletemappings
    respond_to do |format|
      format.json do         
        if params[:_delete_mapping_id].present?
          ClassTeacherMapping.find(params[:_delete_mapping_id]).destroy 
        end
        render :json => true
      end
    end
  end

  def check_for_teacher_mapping
    respond_to do |format|
      format.json do         
        faculty_ids = ClassTeacherMapping.all
        faculty_ids = faculty_ids.all.map do |mapping|
          {faculty_id: mapping.faculty_master_id}
        end
        render :json =>  faculty_ids
      end
    end    
  end
  def add_params(params)   
    params.permit( :section_master_id, :grade_master_id, :faculty_master_id)
  end
end
