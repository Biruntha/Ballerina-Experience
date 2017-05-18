package org.wso2.ballerina.connectors.jira;

import ballerina.doc;
import org.wso2.ballerina.connectors.basicauth;
import ballerina.lang.messages;
import ballerina.lang.jsons;

struct CREATE_ISSUE {
    json issueUpdates;
}

struct SEARCH_JIRA {
    string jqlQuery;
    string maxResults;
    string startAt;
    string fields;
    string validateQuery;
    string expand;
}

struct GET_PROJECT {
    string projectIdOrKey;
    string expand;
}

struct GET_PROJECT_MANDATORY {
    string projectIdOrKey;
}

struct GET_PROJECT_OPTIONAL {
    string expand;
}

struct GetIssueTypesResponse {
    json getIssueTypesResponse;
}

struct GetProjectResponse {
    json getProjectResponse;
}

@doc:Description {value:"Jira client connector"}
@doc:Param {value:"uri: URI of the JIRA instance"}
@doc:Param {value:"username: Username of the user used to log in to JIRA"}
@doc:Param {value:"password: Password of the user used to log in to JIRA"}
connector ClientConnector (string uri, string username, string password) {

    basicauth:ClientConnector jiraEP = create basicauth:ClientConnector(uri, username, password);

    @doc:Description {value:"Search jira using JQL"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"jqlQuery: The search query to be executed as a String"}
    @doc:Param {value:"maxResults: Maxium results to be shown"}
    @doc:Param {value:"startAt: Starts from"}
    @doc:Param {value:"fields: Specifies a comma-separated list of fields to be included in the response"}
    @doc:Param {value:"validateQuery: Whether to validate the JQL query"}
    @doc:Param {value:"expand: A comma-separated list of the parameters to expand"}
    @doc:Return {value:"response object"}
    action searchJira (ClientConnector jira, string jqlQuery, string maxResults, string startAt,
                       string fields, string validateQuery, string expand) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/search";

        json payload = {"jql": jqlQuery, "maxResults": maxResults, "startAt": startAt,
        "fields": fields, "validateQuery": validateQuery, "expand": expand};

        if (jqlQuery == "null") {
            jsons:remove(payload, "$.jql");
        }

        if (maxResults == "null") {
            jsons:remove(payload, "$.maxResults");
        }

        if (startAt == "null") {
            jsons:remove(payload, "$.startAt");
        }

        if (fields == "null") {
            jsons:remove(payload, "$.fields");
        }

        if (validateQuery == "null") {
            jsons:remove(payload, "$.validateQuery");
        }

        if (expand == "null") {
            jsons:remove(payload, "$.expand");
        }

        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Search jira using JQL"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"searchJira: It contains parameters (jqlQuery, maxResults, startAt, fields, validateQuery, expand) to search"}
    @doc:Return {value:"response object"}
    action searchJiraStruct (ClientConnector jira, SEARCH_JIRA searchJira) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/search";
        string jqlQuery = searchJira.jqlQuery;
        string maxResults = searchJira.maxResults;
        string startAt = searchJira.startAt;
        string fields = searchJira.fields;
        string validateQuery = searchJira.validateQuery;
        string expand = searchJira.expand;

        json payload = {"jql": jqlQuery, "maxResults": maxResults, "startAt": startAt,
        "fields": fields, "validateQuery": validateQuery, "expand": expand};

        if (jqlQuery == "null") {
            jsons:remove(payload, "$.jql");
        }

        if (maxResults == "null") {
            jsons:remove(payload, "$.maxResults");
        }

        if (startAt == "null") {
            jsons:remove(payload, "$.startAt");
        }

        if (fields == "null") {
            jsons:remove(payload, "$.fields");
        }

        if (validateQuery == "null") {
            jsons:remove(payload, "$.validateQuery");
        }

        if (expand == "null") {
            jsons:remove(payload, "$.expand");
        }

        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Creates many issues in one bulk operation"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"payload: It contains the array of objects containing the issue details"}
    @doc:Return {value:"response object"}
    action createBulkIssue (ClientConnector jira, json payload) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue/bulk";

        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Creates many issues in one bulk operation"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"createIssueRequest: It contains the array of objects containing the issue details"}
    @doc:Return {value:"response object"}
    action createBulkIssueStruct (ClientConnector jira, CREATE_ISSUE createIssueRequest) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue/bulk";
        json test = createIssueRequest.issueUpdates;
        json payload = {"issueUpdates": test};
        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Get issue types defined in the system"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Return {value:"response object"}
    action getIssueTypes (ClientConnector jira) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/issuetype";

        message response = basicauth:ClientConnector.get (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Get Jira Project information"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"projectIdOrKey: A String containing of the unique key for a project"}
    @doc:Param {value:"expand: The parameters to expand"}
    @doc:Return {value:"response object"}
    action getProject (ClientConnector jira, string projectIdOrKey, string expand) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/project/" + projectIdOrKey;

        if (expand != "null") {
            jiraPath = jiraPath + "?" + "expand=" + expand;
        }

        message response = basicauth:ClientConnector.get (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Get Jira Project information"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"getProject: It contains all parameters (projectIdOrKey, expand) to get the project"}
    @doc:Return {value:"response object"}
    action getProject (ClientConnector jira, GET_PROJECT getProject) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/project/" + getProject.projectIdOrKey;

        string expand = getProject.expand;
        if (expand != "null") {
            jiraPath = jiraPath + "?" + "expand=" + expand;
        }

        message response = basicauth:ClientConnector.get (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Get Jira Project information"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"getProjectMandatory: It contains all mandatory parameters (projectIdOrKey) to get the project"}
    @doc:Param {value:"getProjectOptional: It contains all optional parameters (expand) to get the project"}
    @doc:Return {value:"response object"}
    action getProject (ClientConnector jira, GET_PROJECT_MANDATORY getProjectMandatory,
                       GET_PROJECT_OPTIONAL getProjectOptional) (message) {
        message request = {};
        string uriParams;
        string jiraPath = "/rest/api/2/project/" + getProjectMandatory.projectIdOrKey;

        string expand = getProjectOptional.expand;
        if (expand != "null") {
            jiraPath = jiraPath + "?" + "expand=" + expand;
        }

        message response = basicauth:ClientConnector.get (jiraEP, jiraPath, request);

        return response;
    }
}