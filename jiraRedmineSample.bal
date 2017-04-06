import ballerina.lang.system;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import ballerina.utils;
import ballerina.net.http;

function main (string[] args) {
    http:ClientConnector redmineEP = create http:ClientConnector(args[0]);
    http:ClientConnector jiraEP = create http:ClientConnector(args[1]);
    string apiKey = args[2];
    string userName = args[3];
    string password = args[4];
    string responseType = args[5];

    message requestRedmine = {};
    messages:setHeader(requestRedmine, "X-Redmine-API-Key", apiKey);

    message requestJira = {};
    string encodedBasicAuthValue = utils:base64encode(userName + ":" + password);
    messages:setHeader(requestJira, "Authorization", "Basic "+ encodedBasicAuthValue);

    string jiraSearchIssuePath = "/rest/api/2/search";

    json payload = `{"jql": "updated < '1h'"}`;

    messages:setJsonPayload(requestJira, payload);
    message jiraSearchIssueResponse = http:ClientConnector.get(jiraEP, jiraSearchIssuePath, requestJira);
    json jiraSearchIssueJsonResponse = messages:getJsonPayload(jiraSearchIssueResponse);

    string redmineGetIssueStatusPath = "/issue_statuses." + responseType;

    message redmineGetIssueStatusResponse = http:ClientConnector.get(redmineEP, redmineGetIssueStatusPath, requestRedmine);
    json redmineGetIssueStatusJsonResponse = messages:getJsonPayload(redmineGetIssueStatusResponse);

    string redmineGetAdminUserPath = "/users." + responseType + "?name=admin";
    message redmineGetAdminUserResponse = http:ClientConnector.get(redmineEP, redmineGetAdminUserPath, requestRedmine);
    json redmineGetAdminUserJsonResponse = messages:getJsonPayload(redmineGetAdminUserResponse);
    system:println(jsons:toString(redmineGetAdminUserJsonResponse));

    int issueCount = jsons:getInt(jiraSearchIssueJsonResponse, "$.issues.length()");
    int i = 0;
    while (i < issueCount) {
        json var1 = jsons:getJson(redmineGetIssueStatusJsonResponse , "$.issue_statuses[?(@.name=='" + jsons:getString(jiraSearchIssueJsonResponse, "$.issues[" + i + "].fields.status.name") +"')].id");
        string issueStatusId = jsons:getInt(var1 , "$.[0]");

        string projectId = jsons:getString(jiraSearchIssueJsonResponse, "$.issues[" + i + "].fields.customfield_10119");
        string issueId = jsons:getString(jiraSearchIssueJsonResponse, "$.issues[" + i + "].fields.customfield_10120");


        string redmineGetUserPath = "/users." + responseType + "?name=" + jsons:getString(jiraSearchIssueJsonResponse, "$.issues[" + i + "].fields.assignee.name");
        message redmineGetUserResponse = http:ClientConnector.get(redmineEP, redmineGetUserPath, requestRedmine);
        json redmineGetUserJsonResponse = messages:getJsonPayload(redmineGetUserResponse);
        int assigned_to_id;
        if(jsons:getInt(redmineGetUserJsonResponse, "$.total_count") < 1) {
            assigned_to_id = jsons:getInt(redmineGetAdminUserJsonResponse, "$.users[0].id");
        } else {
            assigned_to_id = jsons:getInt(redmineGetUserJsonResponse, "$.users[0].id");
        }
        system:println(assigned_to_id);
        string redmineUpdateIssuePath = "/issues/"+ issueId + "." + responseType;

        string payloadIssue = "{\"issue\": {\"status_id\": \"" + issueStatusId + "\", \"assigned_to_id\" : \"" + assigned_to_id + "\"}}";
        json payloadIssue1 = (json) payloadIssue;
        system:println(payloadIssue1);
        messages:setJsonPayload(requestRedmine, payloadIssue1);
        message redmineUpdateIssueResponse = http:ClientConnector.put(redmineEP, redmineUpdateIssuePath, requestRedmine);
        system:println(http:getStatusCode(redmineUpdateIssueResponse));

        i = i + 1;
    }
}
