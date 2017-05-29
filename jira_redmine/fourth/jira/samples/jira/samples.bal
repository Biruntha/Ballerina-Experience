import org.wso2.ballerina.connectors.jira;
import ballerina.lang.arrays;
import ballerina.lang.jsons;
import ballerina.lang.system;
import ballerina.lang.messages;

function main (string[] args) {
    jira:ClientConnector jiraConnector = create jira:ClientConnector(args[1], args[2], args[3]);

    message jiraResponse;
    json jiraJSONResponse;
    int argumentLength = arrays:length(args);
    system:println(argumentLength);

    if (args[0] == "searchJira") {
        jiraResponse = jira:ClientConnector.searchJira (jiraConnector, args[4], args[5], args[6], args[7], args[8],
                                                        args[9]);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "searchJiraWithStruct") {
        jira:SearchJira searchJira = {jqlQuery:"project=ESBCONNECT", maxResults:"5", startAt:"2", fields:"null",
                                      validateQuery:"null", expand:"null"};
        jiraResponse = jira:ClientConnector.searchJiraWithStruct (jiraConnector, searchJira);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "createIssue") {
        jiraResponse = jira:ClientConnector.createIssue (jiraConnector, args[4], args[5], args[6], args[7], args[8]);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "createIssueWithStruct") {
        jira:CreateIssue createIssue = {project_id:"10001", summary:"schema,names", issueTypeID: "10100",
                                          assigneeName: "admin", description:"This is describtion"};
        jiraResponse = jira:ClientConnector.createIssueWithStruct (jiraConnector, createIssue);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "createIssueWithStructs") {
        jira:CreateIssueMandatory createIssueMandatory = {project_id:"10001", summary:"schema,names", issueTypeID:"10100"};
        jira:CreateIssueOptional createIssueOptional = {assigneeName:"admin", description:"This is describtion"};

        jiraResponse = jira:ClientConnector.createIssueWithStructs (jiraConnector, createIssueMandatory, createIssueOptional);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "getIssueTypes") {
        jiraResponse = jira:ClientConnector.getIssueTypes (jiraConnector);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "getProject" && argumentLength == 6) {
        jiraResponse = jira:ClientConnector.getProject (jiraConnector, args[4], args[5]);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "getProjectWithStruct" && argumentLength == 4) {
        jira:GetProject getProject = {projectIdOrKey:"ESBCONNECT", expand:"schema,names"};
        jiraResponse = jira:ClientConnector.getProjectWithStruct (jiraConnector, getProject);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "getProjectWithStructs" && argumentLength == 4) {
        jira:GetProjectMandatory getProjectMandatory = {projectIdOrKey:"ESBCONNECT"};
        jira:GetProjectOptional getProjectOptional = {expand:"schema,names"};
        jiraResponse = jira:ClientConnector.getProjectWithStructs (jiraConnector, getProjectMandatory, getProjectOptional);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }
}