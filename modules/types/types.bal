import ballerina/http;


public type CreatedInlineResponse201 record {|
    *http:Created;
    InlineResponse201 body;
|};


public type Student record{|
    readonly int studentNumber;
    string firstname;
    string lastname;
    string[] Course;
    string email;
    |};

public type InlineResponse201 record {
    # the student number of the newly added student
    int studentNumber?;
    int courseCode?;
};

public type Course record{|
readonly int courseCode;
string name;
string[] assessments;
float weight;
float marks;
|};

public type Error record {
    string errorType?;
    string message?;
};
