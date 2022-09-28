public type StudentArr Student[];

public type InlineResponse201 record {
    # the student number of the student newly created
    int studentNumber?;
};

public type Error record {
    string errorType?;
    string message?;
};

public type Student record {
    # the student number of the student
    int studentNumber?;
    # the first name of the student
    string firstname?;
    # the last name of the student
    string lastname?;
    # student email address
    string email?;
    # assessments
    string assessments?;
    # assessment weight
    int weight?;
    # student marks
    int marks?;
    # course enrolled in
    string course?;
    # code of the course
    int courseCode?;
};
