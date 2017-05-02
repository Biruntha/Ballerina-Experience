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

    if (args[0] == "searchJiraStruct") {
        jira:SEARCH_JIRA searchJira = {jqlQuery:"project=ESBCONNECT", maxResults:"5", startAt:"2", fields:"null",
                                      validateQuery:"null", expand:"null"};
        jiraResponse = jira:ClientConnector.searchJiraStruct (jiraConnector, searchJira);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "createBulkIssue" && argumentLength == 5) {
        json payload = (json)args[4];
        jiraResponse = jira:ClientConnector.createBulkIssue (jiraConnector, payload);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "createBulkIssueStruct" && argumentLength == 4) {
        json j = `[{"update": {},"fields": {"project": {"id": "10001"}, "summary": "Issue 1", "issuetype": {"id": "10103" }}}]`;
        jira:CREATE_ISSUE sampleRequest_2 = {issueUpdates:j};

        jiraResponse = jira:ClientConnector.createBulkIssue (jiraConnector, sampleRequest_2);
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

    if (args[0] == "getProject" && argumentLength == 4) {
        jira:GET_PROJECT sampleRequest = {projectIdOrKey:"ESBCONNECT", expand:"schema,names"};
        jiraResponse = jira:ClientConnector.getProject (jiraConnector, sampleRequest);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }

    if (args[0] == "getProject" && argumentLength == 4) {
        jira:GET_PROJECT_MANDATORY sampleRequestMandatory = {projectIdOrKey:"ESBCONNECT"};
        jira:GET_PROJECT_OPTIONAL sampleRequestOptional = {expand:"schema,names"};
        jiraResponse = jira:ClientConnector.getProject (jiraConnector, sampleRequestMandatory, sampleRequestOptional);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));
    }
}