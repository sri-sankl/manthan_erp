(function(angular, app) {
    "use strict";
    app.service("teachersService",["$http", function($http) {
        var getFacultyNamesServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_names_view.json"
            return $http.get(url);
        };
        var getFacultyGradeSectionsServiceView = function(){
            var url = "/teachers_time_tables/get_faculty_garde_sections_view.json"
            return $http.get(url);
        };
        var checkTeachersTimeTable = function(myTeacher){
            var url = "/teachers_time_tables/check_teachers_timetable.json"             
            return $http.get(url,{params:{my_Teacher: myTeacher}});  
        }; 

        var savePeriods = function(timeperiods){
            var url = "/teachers_time_tables/saveperiods.json"
            return $http.post(url, {time_periods: timeperiods});
            
        };
        
        var getPeriods = function(myTeacher){
            var url = "/teachers_time_tables/getperiods.json"
            return $http.post(url, {my_Teacher: myTeacher}); 
        }; 
       
        return {
            getFacultyNamesServiceView : getFacultyNamesServiceView,
            getFacultyGradeSectionsServiceView : getFacultyGradeSectionsServiceView,
            checkTeachersTimeTable : checkTeachersTimeTable,
            savePeriods : savePeriods,
            getPeriods : getPeriods
        };        
    }]);   

})(angular, myApp);
