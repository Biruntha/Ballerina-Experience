package org.wso2.ballerina.connectors.jira;

import ballerina.doc;
import org.wso2.ballerina.connectors.basicauth;
import ballerina.lang.messages;
import ballerina.lang.jsons;

struct CreateIssue {
    string project_id;
    string issueTypeID;
    string description;
    string assigneeName;
    string summary;
}

struct CreateIssueMandatory {
    string project_id;
    string issueTypeID;
    string summary;
}

struct CreateIssueOptional {
    string description;
    string assigneeName;
}

struct SearchJira {
    string jqlQuery;
    string maxResults;
    string startAt;
    string fields;
    string validateQuery;
    string expand;
}

struct GetProject {
    string projectIdOrKey;
    string expand;
}

struct GetProjectMandatory {
    string projectIdOrKey;
}

struct GetProjectOptional {
    string expand;
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
    action searchJiraWithStruct (ClientConnector jira, SearchJira searchJira) (message) {
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
    @doc:Param {value:"project_id: Id of the project"}
    @doc:Param {value:"summary: The summary of the issue"}
    @doc:Param {value:"issueTypeID: Id of the issue type"}
    @doc:Param {value:"assigneeName: Name of the assignee"}
    @doc:Param {value:"description: Description of the project"}
    @doc:Return {value:"response object"}
    action createIssue (ClientConnector jira, string project_id, string summary, string issueTypeID,
                            string assigneeName, string description) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue";

        json payload = {"fields":{ "project":{ "id": project_id }, "summary": summary, "issuetype":{ "id": issueTypeID }
                                 , "assignee":{ "name": assigneeName },
                                "description": description}};

        if (description == "null") {
            jsons:remove(payload, "$.description");
        }

        if (assigneeName == "null") {
            jsons:remove(payload, "$.assigneeName");
        }

        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Creates many issues in one bulk operation"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"createIssue: It contains all parameters (project_id, summary, issueTypeID, assigneeName, description) to create issue"}
    @doc:Return {value:"response object"}
    action createIssueWithStruct (ClientConnector jira, CreateIssue createIssue) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue";
        string project_id = createIssue.project_id;
        string summary = createIssue.summary;
        string issueTypeID = createIssue.issueTypeID;
        string assigneeName = createIssue.assigneeName;
        string description = createIssue.description;

        json payload = {"fields":{ "project":{ "id": project_id }, "summary": summary,
                                 "issuetype":{ "id": issueTypeID }, "assignee":{ "name": assigneeName },
                                 "description": description}};

        if (description == "null") {
            jsons:remove(payload, "$.description");
        }

        if (assigneeName == "null") {
            jsons:remove(payload, "$.assigneeName");
        }

        messages:setJsonPayload(request, payload);
        message response = basicauth:ClientConnector.post (jiraEP, jiraPath, request);

        return response;
    }

    @doc:Description {value:"Creates many issues in one bulk operation"}
    @doc:Param {value:"jira: The Jira Connector instance"}
    @doc:Param {value:"createIssueMandatory: It contains all mandatory parameters (project_id, summary, issueTypeID) to create issue"}
    @doc:Param {value:"createIssueOptional: It contains all optional parameters (assigneeName, description) to create issue"}
    @doc:Return {value:"response object"}
    action createIssueWithStructs (ClientConnector jira, CreateIssueMandatory createIssueMandatory,
                                   CreateIssueOptional createIssueOptional) (message) {
        message request = {};
        string jiraPath = "/rest/api/2/issue";
        string project_id = createIssueMandatory.project_id;
        string summary = createIssueMandatory.summary;
        string issueTypeID = createIssueMandatory.issueTypeID;
        string assigneeName = createIssueOptional.assigneeName;
        string description = createIssueOptional.description;

        json payload = {"fields":{ "project":{ "id": project_id }, "summary": summary,
                                 "issuetype":{ "id": issueTypeID }, "assignee":{ "name": assigneeName },
                                 "description": description}};

        if (description == "null") {
            jsons:remove(payload, "$.description");
        }

        if (assigneeName == "null") {
            jsons:remove(payload, "$.assigneeName");
        }

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
    action getProjectWithStruct (ClientConnector jira, GetProject getProject) (message) {
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
    action getProjectWithStructs (ClientConnector jira, GetProjectMandatory getProjectMandatory,
                       GetProjectOptional getProjectOptional) (message) {
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