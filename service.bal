import ballerina/http;
import Problem3.types as Types;
import Problem3.datastore as Datastore;

listener http:Listener ep0 = new (1900, config ={host:"localhost"});

isolated service /vle/api/v1 on ep0 {
    resource function get students() returns Types:Student[]|http:Response {
        return Datastore:student.toArray();
    }
    resource function post student (@http:Payload Types:Student payload) returns Types:CreatedInlineResponse201|Types:Error {
        int[] conflictingStudentNumber = from var {studentNumber} in Datastore:student
        where studentNumber == payload.studentNumber
        select studentNumber;
         //Check if student number is existing
        if conflictingStudentNumber.length() > 0 {
            return <Types:Error>{
                errorType: "Student number already exists", 
                message: string `student with studentNumber ${payload.studentNumber} already exists` 
            };
        
        }
        else {
            Datastore:student.put(payload);
            return <Types:CreatedInlineResponse201>{
                body: {studentNumber: payload.studentNumber}
            };
        }
    }
    //function to add assessments 
    resource function post assessments (@http:Payload Types:Course payload) returns Types:CreatedInlineResponse201|Types:Error {
        int[] validcourse = from var {courseCode} in Datastore:course
        where courseCode == payload.courseCode
        select courseCode;
     //Check if course exists
        if validcourse.length() <= 0 {
            return <Types:Error>{
                errorType: "This course does not exist", 
                message: string `Course with course code ${payload.courseCode} does not exist` 
            };
        
        }
        else {
            Datastore:course.put(payload);
            return <Types:CreatedInlineResponse201>{
                body: {courseCode: payload.courseCode}
            };
        }
    }
    //get student function
    resource function post student/[int studentNumber](@http:Payload Types:Student payload) returns Types:Student|Types:Error{
        Types:Student? theStudent = Datastore:student.get(studentNumber);

        if theStudent == () {
            return <Types:Error>{
                errorType: "Student not found",
                message: string `Student with studentNumber ${studentNumber} not found`
            };
        } else {
            //if statement for first name
            string? firstname = payload.firstname;
            if firstname != () {
                theStudent.firstname = firstname;
            }
            //if statement for last name
            string? lastname = payload.lastname;
            if lastname != () {
                theStudent.lastname = lastname;
            }
            //if statement for email
            string? email = payload.email;
            if email != () {
                theStudent.email = email;
            }
            
            return theStudent;
        }
    }
    resource function post course/[int courseCode](@http:Payload Types:Course payload) returns Types:Course|Types:Error{
        Types:Course? theCourse = Datastore:course.get(courseCode);
        if theCourse == () {
                return <Types:Error>{
                    errorType: "Course not found",
                    message: string `Course with course code ${courseCode} not found`
                };
        }
            else{
           //if statement for course name
            string? name = payload.name;
            if  name != () {
                theCourse.name = name;
            }
            float? weight = payload.weight;
            if weight != () {
                theCourse.weight = weight;
            }
            float? marks = payload.marks;
            if marks != () {
                theCourse.marks = marks;
            }
            return theCourse;
            }
    } 


    resource function delete students/[int studentNumber]() returns http:NoContent|Types:Error {
        Types:Student? theStudent = Datastore:student.get(studentNumber);
        if theStudent == () {
            return <Types:Error>{
                errorType: "Student not found",
                message: string `Student with studentNumber ${studentNumber} not found`
            };
        }
        else {
            http:NoContent noContent = { };
            return noContent;
        }
    }


}

 

