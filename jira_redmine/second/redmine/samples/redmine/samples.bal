import org.wso2.ballerina.connectors.redmine;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

function main (string[] args) {

    redmine:ClientConnector redmineConnector = create redmine:ClientConnector(args[1], args[2], args[3]);
    message redmineResponse;
    json redmineJSONResponse;

    if (args[0] == "getIssues") {
        redmineResponse = redmine:ClientConnector.getIssues (redmineConnector, "null", "null", "null", "null", "1",
                                                             "null", "null", "null", "null", "null", "null");
        redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "getIssuesStruct") {
        redmine:GetIssuesParams sampleRequestOptional = {issueId:"null", assignedToId:"null", statusId:"null",
                                                        projectId:"1", trackerId:"null", createdOn:"null", updatedOn:"null"};
        redmineResponse = redmine:ClientConnector.getIssues (redmineConnector, sampleRequestOptional);
        redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "getIssueStatuses") {
        redmineResponse = redmine:ClientConnector.getIssueStatuses (redmineConnector);
        redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "getUsers") {
        redmineResponse = redmine:ClientConnector.getUsers (redmineConnector, "null", "admin", "null");
        redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "getUsersStruct") {
        redmine:GetUsersParams getUsersOptional = {status:"null", name:"admin", groupId:"null"};
        redmineResponse = redmine:ClientConnector.getUsers (redmineConnector, getUsersOptional);
        redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "updateIssue") {
        redmineResponse = redmine:ClientConnector.updateIssue (redmineConnector, "1", "null", "null", "null",
                                                               "SalesForce Adapter", "null", "null");
        //redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        //system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "updateIssueStruct") {
        redmine:UpdateIssueParams updateIssueParams = {id:"1", projectId:"null", trackerId:"null", statusId:"null",
                                                      subject:"SalesForce Connector", notes:"null", privateNotes:"null"};
        redmineResponse = redmine:ClientConnector.updateIssue (redmineConnector, updateIssueParams);
        //redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        //system:println(jsons:toString(redmineJSONResponse));
    }

    if (args[0] == "updateIssueStructMandatoryOptional") {
        redmine:UpdateIssueMandatoryParams updateIssueMandatoryParams = {id:"1"};
        redmine:UpdateIssueOptionalParams updateIssueOptionalParams = {projectId:"null", trackerId:"null", statusId:"null",
                                                                      subject:"SalesForce REST Connector", notes:"null",
                                                                      privateNotes:"null"};
        redmineResponse = redmine:ClientConnector.updateIssue (redmineConnector, updateIssueMandatoryParams,
                                                               updateIssueOptionalParams);
        //redmineJSONResponse = messages:getJsonPayload(redmineResponse);
        //system:println(jsons:toString(redmineJSONResponse));
    }
}