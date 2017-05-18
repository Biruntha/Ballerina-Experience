# Jira Client Connector

The Jira connector allows you to access the Jira REST API through ballerina. And the actions are being invoked
with a ballerina main function or a service. The following section provide you the details on connector actions.

## searchJira
  The Jira action allows to Search jira issues.
  
##### Parameters:
  jqlQuery: The search query to be executed as a String
  maxResults: Maxium results to be shown
  startAt: The index of the first issue to return
  fields: Specifies a comma-separated list of fields to be included in the response
  validateQuery: Whether to validate the JQL query
  expand: A comma-separated list of the parameters to expand
  
###### Related Jira API documentation
   [searchJira](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e4071)

## searchJiraStruct
  The Jira action allows to Search jira issues.
  
##### Parameters:
  searchJira: You need to pass the request parameters as one struct. It contains parameters (jqlQuery, maxResults,
              startAt, fields, validateQuery, expand) to search jira issues
  
      jqlQuery: The search query to be executed as a String
      maxResults: Maxium results to be shown
      startAt: The index of the first issue to return
      fields: Specifies a comma-separated list of fields to be included in the response
      validateQuery: Whether to validate the JQL query
      expand: A comma-separated list of the parameters to expand
  
###### Related Jira API documentation
   [searchJira](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e4071)
   
## createBulkIssue
   The Jira action allows to create many issues in one bulk operation.

##### Parameters:
  payload: It contains the array of objects containing the issue details
  
###### Related Jira API documentation
   [createBulkIssue](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e1294)

## createBulkIssueStruct
   The Jira action allows to create many issues in one bulk operation.

##### Parameters:
  createIssueRequest: You need to pass request parameters as struct. 
                      It contains the array of objects containing the issue details
  
###### Related Jira API documentation
   [createBulkIssue](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e1294)
   
## getIssueTypes
   The Jira action allows to get issue types defined in the system.

##### Parameters:
  
###### Related Jira API documentation
   [getIssueTypes](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e704)

## getProject
   The Jira action allows to get Jira Project information.

##### Parameters:
   projectIdOrKey: A String containing of the unique key for a project
   expand: The parameters to expand
  
###### Related Jira API documentation
   [getProject](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e2990)

## getProject
   The Jira action allows to get Jira Project information.

##### Parameters:
   getProject: You need to pass the all request as one struct. It contains all parameters
               (projectIdOrKey, expand) to get the project.
   
       projectIdOrKey: A String containing of the unique key for a project
       expand: The parameters to expand
  
###### Related Jira API documentation
   [getProject](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e2990)
   
## getProject
  The Jira action allows to get Jira Project information.

##### Parameters:
  You need to pass the request parameters as getProjectMandatory, getProjectOptional.
  
  getProjectMandatory: It contains all mandatory parameters (projectIdOrKey) to get the project
  getProjectOptional: It contains all optional parameters (expand) to get the project
  
      projectIdOrKey: A String containing of the unique key for a project
      expand: The parameters to expand
 
###### Related Jira API documentation
  [getProject](https://developer.atlassian.com/static/rest/jira/6.1.html#d2e2990)
  
# How to run the sample

To test a connector action written in Ballerina language use the run command as follows.

###### Invoke the actions

Copy the `<Connector>`/samples/`<Connector>`/samples.bal into `<ballerina_home>`/bin folder 
and run the command like in below,

###### NOTE

If the template parameter is indicate as optional you must pass null as default value to run this
action.

1. searchJira  
    `bin$ ./ballerina run main samples.bal searchJira <apiInstance:-Required> <username:-Required> 
    <password:-Required> <jqlQuery:-Required> <maxResults:-Optional> <startAt:-Optional> 
    <fields:-Optional> <validateQuery:-Optional> <expand:-Optional>`
    
2. searchJiraStruct
    `bin$ ./ballerina run main samples.bal searchJira <apiInstance:-Required> <username:-Required> 
    <password:-Required> <searchJira:-Optional>`
    
3. createBulkIssue
    `bin$ ./ballerina run main samples.bal createBulkIssue <apiInstance:-Required> <username:-Required> 
    <password:-Required> <payload:-Required>`
    
4. createBulkIssueStruct  
    `bin$ ./ballerina run main samples.bal updateIssue <apiInstance:-Required> <username:-Required> 
    <password:-Required> <issueIdOrKey:-Required> <createIssueRequest:-Required>`
    
5. getIssueTypes  
    `bin$ ./ballerina run main samples.bal getIssueTypes <apiInstance:-Required> <username:-Required> 
    <password:-Required>`

6. getProject  
    `bin$ ./ballerina run main samples.bal getProject <apiInstance:-Required> <username:-Required> 
    <password:-Required> <projectIdOrKey:-Required> <expand:-Optional>`
    
7. getProject  
    `bin$ ./ballerina run main samples.bal getStatusesOfProject <apiInstance:-Required> <username:-Required> 
    <password:-Required> <getProject:-Required>`
    
8. getProject  
    `bin$ ./ballerina run main samples.bal getCommentById <apiInstance:-Required> <username:-Required> 
    <password:-Required> <getProjectMandatory:-Required> <getProjectOptional:-Optional>`