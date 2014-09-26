(function(angular, app) {
    "use strict";
    app.controller('BooksController',["$scope","resourceService", function($scope, resourceService) {
        $scope.books = resourceService.Book.query(); 
        $scope.delivered_requests = resourceService.RequestBook.delivered_requests(); 
               
        $scope.getPurchaseDate = function(){           
            $scope.dateFormat = $scope.purchasedDate.getFullYear()+"-"+($scope.purchasedDate.getMonth()+1)+"-"+$scope.purchasedDate.getDate();             
       }        
        $scope.getEditPurchaseDate = function(){          
            $scope.dateFormat = $scope.book.purchased_date.getFullYear()+"-"+($scope.book.purchased_date.getMonth()+1)+"-"+$scope.book.purchased_date.getDate();             
        }
       
        $scope.newBook = function(){  
            alert($scope.delivered_requests.length);
            $scope.newBooks = [];
            for(var i=0; i<3; i++){
                $scope.newBooks.push({"name": "", "isbn": "", "author": "", "year_of_publishing": "", "book_type": "", "purchased_date": ""});
            };
            $('#createModal').modal('show')
        };

        $scope.submitBooks = function(){           
            for(var i=0; i< $scope.newBooks.length; i++){
                $scope.newBooks[i]['purchased_date'] =  $scope.dateFormat;
            };           
            resourceService.Book.bulk({bulk_book: $scope.newBooks})
                .$promise.then(function(responce){
                    $scope.books = resourceService.Book.query()
                    $('#createModal').modal('hide')
                })
        };
        
        $scope.editBooks = function(book){
            $scope.book = book;                     
            $('#editBookModal').modal('show')
        };  
     
        $scope.destroy = function(book){
            book.$delete()
                .then(function(responce){
                    $scope.books.splice($scope.books.indexOf(book), 1)
                })
        };  
        
        $scope.update = function(){
            $scope.book.$update()
                .then(function(responce){                  
                })
        };  
    
	$scope.addMorebooks = function(){           
            var lnt = parseInt($scope.newBooks.length)
            for(var i=lnt; i< lnt+3; i++){
                $scope.newBooks.push({"name": "", "isbn": "", "author": "", "year_of_publishing": "", "book_type": "", "purchased_date": $scope.dateFormat});
            };
        };

        
    }]);    
})(angular, myApp);
