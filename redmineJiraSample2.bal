import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import org.wso2.ballerina.connectors.jira;
import org.wso2.ballerina.connectors.redmine;

function main (string[] args) {
    redmine:ClientConnector redmineConnector = create redmine:ClientConnector(args[0], args[1], args[2]);
    jira:ClientConnector jiraConnector = create jira:ClientConnector(args[3], args[4], args[5]);
    message jiraResponse;
    json jiraJSONResponse;

    message redmineResponse = redmine:ClientConnector.getIssues(redmineConnector, "null", "null", "null", "null", "null", "null", "null", "null", "null", "null", "null");
    json redmineJSONResponse = messages:getJsonPayload(redmineResponse);
    system:println(jsons:toString(redmineJSONResponse));

    message jiraGetIssueTypesResponse = jira:ClientConnector.getIssueTypes(jiraConnector);
    json jiraGetIssueTypesJSONResponse = messages:getJsonPayload(jiraGetIssueTypesResponse);
    system:println(jsons:toString(jiraGetIssueTypesJSONResponse));

    int issueCount = jsons:getInt(redmineJSONResponse, "$.issues.length()");
    int i = 0;
    while (i < issueCount) {
        string summary = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].subject");
        string description = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].description");

        json var1 = jsons:getJson(jiraGetIssueTypesJSONResponse , "$.[?(@.name=='" +
                    jsons:getString(redmineJSONResponse, "$.issues[" + i + "].tracker.name") +"')].id");
        string issueTypeId = jsons:getString(var1 , "$.[0]");

        message jiraGetProjectResponse = jira:ClientConnector.getProject(jiraConnector,
                       jsons:getString(redmineJSONResponse, "$.issues[" + i + "].project.name"), "null");
        json jiraGetProjectJSONResponse = messages:getJsonPayload(jiraGetProjectResponse);
        system:println(jsons:toString(jiraGetProjectJSONResponse));
        string projectId = jsons:getString(jiraGetProjectJSONResponse, "$.id");

        jira:CREATE_ISSUE sample = jsonToStruct_Mapping(projectId, issueTypeId, summary, description);
        system:println(sample.issueUpdates);

        jiraResponse = jira:ClientConnector.createBulkIssueStruct(jiraConnector, sample);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));

        i = i + 1;
    }
}

function jsonToStruct_Mapping(string projectId, string issueTypeId, string summary, string description) (jira:CREATE_ISSUE) {
    json x = `{"fields": {"project":{"id": ""}, "summary": "", "description": "",
    "issuetype": {"id": ""}}}`;

    jsons:set(x , "fields.project.id" , projectId);
    jsons:set(x , "fields.summary" , summary);
    jsons:set(x , "fields.description" , description );
    jsons:set(x , "fields.issuetype.id" , issueTypeId);
    json y = `[${x}]`;
    jira:CREATE_ISSUE sampleRequest_2 = { issueUpdates: y };

    return sampleRequest_2;
}