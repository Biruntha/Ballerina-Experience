import ballerina.net.http;
import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import org.wso2.ballerina.connectors.jira;
import org.wso2.ballerina.connectors.redmine;

@http:BasePath{value:"/redmineJiraScenario"}
service redmineJiraScenarioService {
    @http:POST {}
    resource redmineJiraScenarioResource( message m) {
        json jsonRequest = messages:getJsonPayload(m);
        string jiraApiInstance = jsons:getString(jsonRequest, "$.jiraApiInstance");
        string jiraUsername = jsons:getString(jsonRequest, "$.jiraUsername");
        string jiraPassword = jsons:getString(jsonRequest, "$.jiraPassword");
        string redmineApiInstance = jsons:getString(jsonRequest, "$.redmineApiInstance");
        string redmineApiKey = jsons:getString(jsonRequest, "$.redmineApiKey");
        string redmineResponseFormat = jsons:getString(jsonRequest, "$.redmineResponseFormat");
        string redmineOffset = jsons:getString(jsonRequest, "$.redmineOffset");
        string redmineLimit = jsons:getString(jsonRequest, "$.redmineLimit");
        string redmineSort = jsons:getString(jsonRequest, "$.redmineSort");
        string redmineIssueId = jsons:getString(jsonRequest, "$.redmineIssueId");
        string redmineProjectId = jsons:getString(jsonRequest, "$.redmineProjectId");
        string redmineSubprojectId = jsons:getString(jsonRequest, "$.redmineSubprojectId");
        string redmineTrackerId = jsons:getString(jsonRequest, "$.redmineTrackerId");
        string redmineStatusId = jsons:getString(jsonRequest, "$.redmineStatusId");
        string redmineAssignedToId = jsons:getString(jsonRequest, "$.redmineAssignedToId");
        string redmineCreatedOn = jsons:getString(jsonRequest, "$.redmineCreatedOn");
        string redmineUpdatedOn = jsons:getString(jsonRequest, "$.redmineUpdatedOn");

        redmine:ClientConnector redmineConnector = create redmine:ClientConnector(redmineApiInstance, redmineApiKey,
                                                                                  redmineResponseFormat);
        jira:ClientConnector jiraConnector = create jira:ClientConnector(jiraApiInstance, jiraUsername, jiraPassword);
        message jiraResponse;
        json jiraJSONResponse;

        message redmineResponse = redmine:ClientConnector.getIssues (redmineConnector, redmineOffset, redmineLimit,
                                                                     redmineSort, redmineIssueId, redmineProjectId,
                                                                     redmineSubprojectId, redmineTrackerId, redmineStatusId,
                                                                     redmineAssignedToId, redmineCreatedOn, redmineUpdatedOn);
        json redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        //system:println(jsons:toString(redmineJSONResponse));

        message jiraGetIssueTypesResponse = jira:ClientConnector.getIssueTypes (jiraConnector);
        json jiraGetIssueTypesJSONResponse = messages:getJsonPayload(jiraGetIssueTypesResponse);
        system:println(jsons:toString(jiraGetIssueTypesJSONResponse));

        jira:CreateIssue createIssueRequest = {};

        int issueCount = jsons:getInt(redmineJSONResponse, "$.issues.length()");
        int i = 0;
        while (i < issueCount) {
            string summary = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].subject");
            string description = jsons:getString(redmineJSONResponse, "$.issues[" + i + "].description");

            json var1 = jsons:getJson(jiraGetIssueTypesJSONResponse, "$.[?(@.name=='" +
                                                                     jsons:getString(redmineJSONResponse, "$.issues[" + i + "].tracker.name") + "')].id");
            string issueTypeId = jsons:getString(var1, "$.[0]");

            message jiraGetProjectResponse = jira:ClientConnector.getProject (jiraConnector,
                                                                              jsons:getString(redmineJSONResponse, "$.issues[" + i + "].project.name"), "null");
            json jiraGetProjectJSONResponse = messages:getJsonPayload(jiraGetProjectResponse);
            system:println(jsons:toString(jiraGetProjectJSONResponse));
            string projectId = jsons:getString(jiraGetProjectJSONResponse, "$.id");

            jira:CreateIssue createIssue = {};
            transform {
                createIssue.project_id = projectId;
                createIssue.summary = summary;
                createIssue.description = description;
                createIssue.issueTypeID = issueTypeId;
            }

            jiraResponse = jira:ClientConnector.createIssueWithStruct (jiraConnector, createIssue);
            jiraJSONResponse = messages:getJsonPayload(jiraResponse);
            system:println(jsons:toString(jiraJSONResponse));

            i = i + 1;
        }

        system:println(jiraGetIssueTypesResponse);
        http:convertToResponse( m );
        reply m;

    }

}