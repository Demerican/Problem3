import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://localhost:8080/vle/api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Get all students added
    #
    # + return - A list of students 
    remote isolated function getAll() returns Student[]|error {
        string resourcePath = string `/Student`;
        Student[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new student
    #
    # + return - Student successfully created 
    remote isolated function insert(Student payload) returns InlineResponse201|error {
        string resourcePath = string `/Student`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        InlineResponse201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a student
    #
    # + studentNumber - student number of the student 
    # + return - student response 
    remote isolated function getStudent(int studentNumber) returns Student|error {
        string resourcePath = string `/students/${getEncodedUri(studentNumber)}`;
        Student response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing student
    #
    # + studentNumber - student number of the student 
    # + return - Student was successfully updated 
    remote isolated function updateStudent(int studentNumber, Student payload) returns Student|error {
        string resourcePath = string `/students/${getEncodedUri(studentNumber)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Student response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an existing student
    #
    # + studentNumber - student number of the student 
    # + return - Student was successfully deleted 
    remote isolated function deleteStudent(int studentNumber) returns http:Response|error {
        string resourcePath = string `/students/${getEncodedUri(studentNumber)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
}
