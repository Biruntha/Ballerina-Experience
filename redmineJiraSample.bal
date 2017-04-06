import ballerina.lang.system;
import ballerina.net.http;
import ballerina.lang.strings;
import ballerina.lang.messages;
import ballerina.lang.jsons;
import ballerina.utils;
import ballerina.lang.arrays;

function main (string[] args) {
    int argumentLength = arrays:length(args);
    if(argumentLength < 6) {
        system:println("Incorrect number of arguments");
        system:println("Please specify: RedmineEndpoint, JiraEndpoint, APIKey of Redmine, Username of Jira, Password
        of Jira, Response type in Redmine");
    } else {
        http:ClientConnector redmineEP = create http:ClientConnector(args[0]);
        http:ClientConnector jiraEP = create http:ClientConnector(args[1]);
        string apiKey = args[2];
        string userName = args[3];
        string password = args[4];
        string responseType = args[5];

        message requestRedmine = {};
        messages:setHeader(requestRedmine, "X-Redmine-API-Key", apiKey);
        string redminePath = "/issues." + responseType;

        message redmineResponse = http:ClientConnector.get(redmineEP, redminePath, requestRedmine);
        json redmineJsonResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJsonResponse));

        message requestJira = {};
        string encodedBasicAuthValue = utils:base64encode(userName + ":" + password);
        messages:setHeader(requestJira, "Authorization", "Basic "+ encodedBasicAuthValue);

        string jiraGetIssueTypesPath = "/rest/api/2/issuetype";
        message jiraGetIssueTypesResponse = http:ClientConnector.get(jiraEP, jiraGetIssueTypesPath, requestJira);
        json jiraGetIssueTypesJsonResponse = messages:getJsonPayload(jiraGetIssueTypesResponse);
        int issueTypeCount = jsons:getInt(jiraGetIssueTypesJsonResponse, "$.length()");

        system:println(issueTypeCount);
        string jiraGetProjectPath;
        string issueTypeId;
        int issueCount = jsons:getInt(redmineJsonResponse, "$.issues.length()");
        string payload = "{\"issueUpdates\": [";
        int i = 0;
        while (i < issueCount) {
            json var1 = jsons:getJson(jiraGetIssueTypesJsonResponse , "$.[?(@.name=='" +
                        jsons:getString(redmineJsonResponse, "$.issues[" + i + "].tracker.name") +"')].id");
            issueTypeId = jsons:getString(var1 , "$.[0]");

            jiraGetProjectPath = "/rest/api/2/project/" + jsons:getString(redmineJsonResponse, "$.issues[" + i + "].project.name");
            message jiraGetprojectResponse = http:ClientConnector.get(jiraEP, jiraGetProjectPath, requestJira);
            json jiraGetProjectJsonResponse = messages:getJsonPayload(jiraGetprojectResponse);
            system:println(jsons:getString(jiraGetProjectJsonResponse, "$.id"));

            payload = payload + "{\"fields\": { \"project\": { \"id\": \"" + jsons:getString(jiraGetProjectJsonResponse, "$.id")
                      + "\"}, \"summary\": \"" + jsons:getString(redmineJsonResponse, "$.issues[" + i + "].subject") + "\", \"issuetype\": {
                    \"id\": \"" + issueTypeId + "\" }, \"customfield_10119\": \"" + jsons:getInt(redmineJsonResponse, "$.issues[" + i + "].project.id") +
                      "\",\"customfield_10120\": \"" + jsons:getInt(redmineJsonResponse, "$.issues[" + i + "].id") + "\",
                     \"description\": \"" + jsons:getString(redmineJsonResponse, "$.issues[" + i + "].description") + "\"}},";
            i = i + 1;
        }
        payload = strings:subString(payload, 0, strings:length(payload)-1) + "]}";

        json payloadJson = (json) payload;

        string jiraCreateIssuePath = "/rest/api/2/issue/bulk";

        messages:setJsonPayload(requestJira, payloadJson);
        message jiraCreateIssueResponse = http:ClientConnector.post(jiraEP, jiraCreateIssuePath, requestJira);
        json jiraCreateIssueJSONResponse = messages:getJsonPayload(jiraCreateIssueResponse);
        system:println(jsons:toString(jiraCreateIssueJSONResponse));
    }
}