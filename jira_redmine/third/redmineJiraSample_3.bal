import ballerina.lang.system;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import org.wso2.ballerina.connectors.jira;

import org.wso2.ballerina.connectors.redmine;

function main (string[] args) {
    string jiraApiInstance = args[0];
    string jiraUsername = args[1];
    string jiraPassword = args[2];
    string redmineApiInstance = args[3];
    string redmineApiKey = args[4];
    string redmineResponseFormat = args[5];
    string redmineOffset = args[6];
    string redmineLimit = args[7];
    string redmineSort = args[8];
    string redmineIssueId = args[9];
    string redmineProjectId = args[10];
    string redmineSubprojectId = args[11];
    string redmineTrackerId = args[12];
    string redmineStatusId = args[13];
    string redmineAssignedToId = args[14];
    string redmineCreatedOn = args[15];
    string redmineUpdatedOn = args[16];
    redmine:ClientConnector redmineConnector = create redmine:ClientConnector(redmineApiInstance, redmineApiKey, redmineResponseFormat);
    jira:ClientConnector jiraConnector = create jira:ClientConnector(jiraApiInstance, jiraUsername, jiraPassword);
    message jiraResponse;
    json jiraJSONResponse;

    redmine:GetIssuesResponse redmineResponse = redmine:ClientConnector.getIssues (redmineConnector, redmineOffset, redmineLimit,
                                                                                   redmineSort, redmineIssueId, redmineProjectId,
                                                                                   redmineSubprojectId, redmineTrackerId, redmineStatusId,
                                                                                   redmineAssignedToId, redmineCreatedOn, redmineUpdatedOn);

    jira:GetIssueTypesResponse jiraGetIssueTypesResponse = jira:ClientConnector.getIssueTypes (jiraConnector);

    int issueCount = jsons:getInt(redmineResponse.getIssueResponse, "$.issues.length()");

    int i = 0;
    while (i < issueCount) {
        jira:GetProjectResponse jiraGetProjectResponse = jira:ClientConnector.getProject (jiraConnector,
                                                                                          jsons:getString(redmineResponse.getIssueResponse, "$.issues[" + i + "].project.name"), "null");
        system:println(jiraGetProjectResponse.getProjectResponse);
        jira:CREATE_ISSUE sample = jsonToStruct_Mapping(redmineResponse, jiraGetIssueTypesResponse, jiraGetProjectResponse);
        //system:println(sample.issueUpdates);

        jiraResponse = jira:ClientConnector.createBulkIssueStruct (jiraConnector, sample);
        jiraJSONResponse = messages:getJsonPayload(jiraResponse);
        system:println(jsons:toString(jiraJSONResponse));

        i = i + 1;
    }
}

function jsonToStruct_Mapping (redmine:GetIssuesResponse redmineResponse, jira:GetIssueTypesResponse jiraGetIssueTypesResponse,
                               jira:GetProjectResponse jiraGetProjectResponse) (jira:CREATE_ISSUE) {
    string projectId = jsons:getString(jiraGetProjectResponse.getProjectResponse, "$.id");
    json var1 = jsons:getJson(jiraGetIssueTypesResponse.getIssueTypesResponse, "$.[?(@.name=='" +
                                                                               jsons:getString(redmineResponse.getIssueResponse, "$.issues[0].tracker.name") + "')].id");
    string issueTypeId = jsons:getString(var1, "$.[0]");
    string summary = jsons:getString(redmineResponse.getIssueResponse, "$.issues[0].subject");
    string description = jsons:getString(redmineResponse.getIssueResponse, "$.issues[0].description");

    json x = {"fields":{"project":{"id":""}, "summary":"", "description":"", "issuetype":{"id":""}}};

    jsons:set(x, "fields.project.id", projectId);
    jsons:set(x, "fields.summary", summary);
    jsons:set(x, "fields.description", description);
    jsons:set(x, "fields.issuetype.id", issueTypeId);
    json y = [x];
    jira:CREATE_ISSUE sampleRequest_2 = {issueUpdates:y};

    return sampleRequest_2;
}