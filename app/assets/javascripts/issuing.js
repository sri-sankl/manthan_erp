$(function() {
    $(".changed ").on("click", function(event) {	
       	id =  $(this).data("id");
	this_klass = $(this)
	this_klass.removeClass("btn-danger").addClass("btn-success");   	this_klass.text('Approval_Sent');
        
	$.ajax({
            
	    url: "/request_new_books/"+id+"/update_request_new_book.json",
	    type: 'PUT',
	    data: "status=success",
	    success:function(data) {
	      	if (status == "Approval_Sent")
		{
                    this_klass.text('Approval_Sent');
                    
                }
	    }
            
	});
        
    });
    
})

