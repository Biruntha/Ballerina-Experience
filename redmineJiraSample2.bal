import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import org.wso2.ballerina.connectors.jira;
import org.wso2.ballerina.connectors.redmine;

function main (string[] args) {
    redmine:ClientConnector redmineConnector = create redmine:ClientConnector(args[0], args[1], args[2]);
    jira:ClientConnector jiraConnector = create jira:ClientConnector(args[3], args[4], args[5]);
    message redmineResponse;
    json redmineJSONResponse;
    message jiraResponse;
    json jiraJSONResponse;

    redmineResponse = redmine:ClientConnector.getIssues(redmineConnector, "null", "null", "null", "null", "1", "null", "null", "null", "null", "null", "null");
    redmineJSONResponse = messages:getJsonPayload(redmineResponse);
    system:println(jsons:toString(redmineJSONResponse));

    int issueCount = jsons:getInt(redmineJSONResponse, "$.issues.length()");
    int i = 0;
    while (i < issueCount) {
        string summary = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].subject");
        string description = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].description");
        string issueTypeId = "10103";
        string projectId = "10001";

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