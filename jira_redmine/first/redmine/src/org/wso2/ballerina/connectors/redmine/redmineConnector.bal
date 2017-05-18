package org.wso2.ballerina.connectors.redmine;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.doc;
import ballerina.lang.strings;
import ballerina.lang.jsons;

struct GetIssuesParams {
    string offset;
    string limit;
    string sort;
    string issueId;
    string projectId;
    string subprojectId;
    string trackerId;
    string statusId;
    string assignedToId;
    string createdOn;
    string updatedOn;
}

struct GetIssuesResponse {
    json getIssueResponse;
}

struct GetUsersParams {
    string status;
    string name;
    string groupId;
}

struct UpdateIssueParams {
    string id;
    string projectId;
    string trackerId;
    string statusId;
    string subject;
    string notes;
    string privateNotes;
}

struct UpdateIssueMandatoryParams {
    string id;
}

struct UpdateIssueOptionalParams {
    string projectId;
    string trackerId;
    string statusId;
    string subject;
    string notes;
    string privateNotes;
}

@doc:Description {value:"Redmine client connector"}
@doc:Param {value:"uri: URI of the Redmine instance"}
@doc:Param {value:"apiKey: API key of the user used to log in to Redmine"}
connector ClientConnector (string uri, string apiKey, string format) {

    http:ClientConnector redmineEP = create http:ClientConnector(uri);

    @doc:Description {value:"Get the list of Issues"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"offset: Skip this number of issues in response"}
    @doc:Param {value:"limit: The number of issues per page"}
    @doc:Param {value:"sort: Column to sort with. Append :desc to invert the order"}
    @doc:Param {value:"issueId: Get issue with the given id or multiple issues by comma separated ids"}
    @doc:Param {value:"projectId: Get issues from the project with the given id"}
    @doc:Param {value:"subprojectId: Get issues from the subproject with the given id"}
    @doc:Param {value:"trackerId: Get issues from the tracker with the given id"}
    @doc:Param {value:"statusId: Get issues with the given status id only"}
    @doc:Param {value:"assignedToId: Get issues which are assigned to the given user id"}
    @doc:Param {value:"createdOn: To fetch issues created after a certain date or timestamp"}
    @doc:Param {value:"updatedOn: To fetch issues updated after a certain date or timestamp"}
    @doc:Return {value:"response object"}
    action getIssues (ClientConnector redmine, string offset, string limit, string sort, string issueId, string projectId,
                      string subprojectId, string trackerId, string statusId, string assignedToId, string createdOn,
                      string updatedOn) (message) {
        message request = {};
        string uriParams;
        string redminePath = "/issues." + format;

        if (offset != "null") {
            uriParams = uriParams + "&offset=" + offset;
        }

        if (limit != "null") {
            uriParams = uriParams + "&limit=" + limit;
        }

        if (sort != "null") {
            uriParams = uriParams + "&sort=" + sort;
        }

        if (issueId != "null") {
            uriParams = uriParams + "&issue_id=" + issueId;
        }

        if (projectId != "null") {
            uriParams = uriParams + "&project_id=" + projectId;
        }

        if (subprojectId != "null") {
            uriParams = uriParams + "&subproject_id=" + subprojectId;
        }

        if (trackerId != "null") {
            uriParams = uriParams + "&tracker_id=" + trackerId;
        }

        if (statusId != "null") {
            uriParams = uriParams + "&status_id=" + statusId;
        }

        if (assignedToId != "null") {
            uriParams = uriParams + "&assigned_to_id=" + assignedToId;
        }

        if (createdOn != "null") {
            uriParams = uriParams + "&created_on=" + createdOn;
        }

        if (updatedOn != "null") {
            uriParams = uriParams + "&updated_on=" + updatedOn;
        }

        if (uriParams != "") {
            redminePath = redminePath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.get (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Get the list of Issues"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"getIssuesParams: It contains the URI parameters"}
    @doc:Return {value:"response object"}
    action getIssues (ClientConnector redmine, GetIssuesParams getIssuesParams) (message) {
        message request = {};
        string uriParams;
        string redminePath = "/issues." + format;

        if (getIssuesParams.offset != "null") {
            uriParams = uriParams + "&offset=" + getIssuesParams.offset;
        }

        if (getIssuesParams.limit != "null") {
            uriParams = uriParams + "&limit=" + getIssuesParams.limit;
        }

        if (getIssuesParams.sort != "null") {
            uriParams = uriParams + "&sort=" + getIssuesParams.sort;
        }

        if (getIssuesParams.issueId != "null") {
            uriParams = uriParams + "&issue_id=" + getIssuesParams.issueId;
        }

        if (getIssuesParams.projectId != "null") {
            uriParams = uriParams + "&project_id=" + getIssuesParams.projectId;
        }

        if (getIssuesParams.subprojectId != "null") {
            uriParams = uriParams + "&subproject_id=" + getIssuesParams.subprojectId;
        }

        if (getIssuesParams.trackerId != "null") {
            uriParams = uriParams + "&tracker_id=" + getIssuesParams.trackerId;
        }

        if (getIssuesParams.statusId != "null") {
            uriParams = uriParams + "&status_id=" + getIssuesParams.statusId;
        }

        if (getIssuesParams.assignedToId != "null") {
            uriParams = uriParams + "&assigned_to_id=" + getIssuesParams.assignedToId;
        }

        if (getIssuesParams.createdOn != "null") {
            uriParams = uriParams + "&created_on=" + getIssuesParams.createdOn;
        }

        if (getIssuesParams.updatedOn != "null") {
            uriParams = uriParams + "&updated_on=" + getIssuesParams.updatedOn;
        }

        if (uriParams != "") {
            redminePath = redminePath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.get (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Get the list of Issue statuses"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Return {value:"response object"}
    action getIssueStatuses (ClientConnector redmine) (message) {
        message request = {};
        string redminePath = "/issue_statuses." + format;

        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.get (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Get the list of Users"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"status: Get only users with the given status"}
    @doc:Param {value:"name: Filter the users on their login, firstname, lastname and mail "}
    @doc:Param {value:"groupId: Get only users who are members of the given group"}
    @doc:Return {value:"response object"}
    action getUsers (ClientConnector redmine, string status, string name, string groupId) (message) {
        message request = {};
        string uriParams;
        string redminePath = "/users." + format;

        if (status != "null") {
            uriParams = uriParams + "&status=" + status;
        }

        if (name != "null") {
            uriParams = uriParams + "&name=" + name;
        }

        if (groupId != "null") {
            uriParams = uriParams + "&group_id=" + groupId;
        }

        if (uriParams != "") {
            redminePath = redminePath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.get (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Get the list of Users"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"getUsersParams: It contains the URI parameters"}
    @doc:Return {value:"response object"}
    action getUsers (ClientConnector redmine, GetUsersParams getUsersParams) (message) {
        message request = {};
        string uriParams;
        string redminePath = "/users." + format;

        if (getUsersParams.status != "null") {
            uriParams = uriParams + "&status=" + getUsersParams.status;
        }

        if (getUsersParams.name != "null") {
            uriParams = uriParams + "&name=" + getUsersParams.name;
        }

        if (getUsersParams.groupId != "null") {
            uriParams = uriParams + "&group_id=" + getUsersParams.groupId;
        }

        if (uriParams != "") {
            redminePath = redminePath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }

        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.get (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Update the Issue"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"id: The id of the issue"}
    @doc:Param {value:"projectId: The project id of the issue"}
    @doc:Param {value:"trackerId: The tracker id of the issue"}
    @doc:Param {value:"statusId: The status id of the issue"}
    @doc:Param {value:"subject: The subject of the issue"}
    @doc:Param {value:"notes: Comments about the update"}
    @doc:Param {value:"privateNotes: true if notes are private"}
    @doc:Return {value:"response object"}
    action updateIssue (ClientConnector redmine, string id, string redmineProjectId, string trackerId, string statusId,
                        string subject, string notes, string privateNotes) (message) {
        message request = {};
        string redminePath = "/issues/" + id + ".json";

        json payload = { "issue": { "project_id": redmineProjectId, "tracker_id": trackerId,
                "status_id": statusId, "subject": subject, "notes": notes, "private_notes": privateNotes }};

        if (redmineProjectId == "null") {
            jsons:remove(payload, "$.issue.project_id");
        }

        if (trackerId == "null") {
            jsons:remove(payload, "$.issue.tracker_id");
        }

        if (statusId == "null") {
            jsons:remove(payload, "$.issue.status_id");
        }

        if (subject == "null") {
            jsons:remove(payload, "$.issue.subject");
        }

        if (notes == "null") {
            jsons:remove(payload, "$.issue.notes");
        }

        if (privateNotes == "null") {
            jsons:remove(payload, "$.issue.private_notes");
        }

        messages:setJsonPayload(request, payload);
        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.put (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Update the Issue"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"updateIssueParams: It contains parameters (id, redmineProjectId, trackerId, statusId, subject,
                notes, privateNotes) to search"}
    @doc:Return {value:"response object"}
    action updateIssue (ClientConnector redmine, UpdateIssueParams updateIssueParams) (message) {
        message request = {};
        string redminePath = "/issues/" + updateIssueParams.id + ".json";

        string redmineProjectId = updateIssueParams.projectId;
        string trackerId = updateIssueParams.trackerId;
        string statusId = updateIssueParams.statusId;
        string subject = updateIssueParams.subject;
        string notes = updateIssueParams.notes;
        string privateNotes = updateIssueParams.privateNotes;

        json payload = { "issue": {"project_id": redmineProjectId, "tracker_id": trackerId,
                        "status_id": statusId, "subject": subject, "notes": notes,
                         "private_notes": privateNotes }};

        if (updateIssueParams.projectId == "null") {
            jsons:remove(payload, "$.issue.project_id");
        }

        if (updateIssueParams.trackerId == "null") {
            jsons:remove(payload, "$.issue.tracker_id");
        }

        if (updateIssueParams.statusId == "null") {
            jsons:remove(payload, "$.issue.status_id");
        }

        if (updateIssueParams.subject == "null") {
            jsons:remove(payload, "$.issue.subject");
        }

        if (updateIssueParams.notes == "null") {
            jsons:remove(payload, "$.issue.notes");
        }

        if (updateIssueParams.privateNotes == "null") {
            jsons:remove(payload, "$.issue.private_notes");
        }

        messages:setJsonPayload(request, payload);
        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.put (redmineEP, redminePath, request);

        return response;
    }

    @doc:Description {value:"Update the Issue"}
    @doc:Param {value:"redmine: The Redmine Connector instance"}
    @doc:Param {value:"updateIssueMandatoryParams: It contains the mandatory parameters (id) to search"}
    @doc:Param {value:"updateIssueOptionalParams: It contains the optional parameters ( projectId, trackerId, statusId,
                subject, notes, privateNotes) to search"}
    @doc:Return {value:"response object"}
    action updateIssue (ClientConnector redmine, UpdateIssueMandatoryParams updateIssueMandatoryParams,
                        UpdateIssueOptionalParams updateIssueOptionalParams) (message) {
        message request = {};
        string redminePath = "/issues/" + updateIssueMandatoryParams.id + ".json";

        string redmineProjectId = updateIssueOptionalParams.projectId;
        string trackerId = updateIssueOptionalParams.trackerId;
        string statusId = updateIssueOptionalParams.statusId;
        string subject = updateIssueOptionalParams.subject;
        string notes = updateIssueOptionalParams.notes;
        string privateNotes = updateIssueOptionalParams.privateNotes;

        json payload = { "issue": {"project_id": redmineProjectId, "tracker_id": trackerId,
                                "status_id": statusId, "subject": subject, "notes": notes,
                                 "private_notes": privateNotes }};

        if (updateIssueOptionalParams.projectId == "null") {
            jsons:remove(payload, "$.issue.project_id");
        }

        if (updateIssueOptionalParams.trackerId == "null") {
            jsons:remove(payload, "$.issue.tracker_id");
        }

        if (updateIssueOptionalParams.statusId == "null") {
            jsons:remove(payload, "$.issue.status_id");
        }

        if (updateIssueOptionalParams.subject == "null") {
            jsons:remove(payload, "$.issue.subject");
        }

        if (updateIssueOptionalParams.notes == "null") {
            jsons:remove(payload, "$.issue.notes");
        }

        if (updateIssueOptionalParams.privateNotes == "null") {
            jsons:remove(payload, "$.issue.private_notes");
        }

        messages:setJsonPayload(request, payload);
        messages:setHeader(request, "X-Redmine-API-Key", apiKey);
        message response = http:ClientConnector.put (redmineEP, redminePath, request);

        return response;
    }
}