package org.wso2.ballerina.connectors.gmail;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.utils;

struct CreateDraftRequest {
    string to;
    string subject;
    string from;
    string messageBody;
    string cc;
    string bcc;
    string id;
    string threadId;
}

struct UpdateDraftRequest {
    string to;
    string subject;
    string from;
    string messageBody;
    string cc;
    string bcc;
    string id;
    string threadId;
}

struct SendMailRequest {
    string to;
    string subject;
    string from;
    string messageBody;
    string cc;
    string bcc;
    string id;
    string threadId;
}

struct ReadThreadRequest {
    string format;
    string metaDataHeaders;
}

struct ReadMailRequest {
    string format;
    string metaDataHeaders;
}

struct ReadDraftRequest {
    string format;
}

struct ListThreadsRequest {
    string includeSpamTrash;
    string labelIds;
    string maxResults;
    string pageToken;
    string q;
}

struct ListMailsRequest {
    string includeSpamTrash;
    string labelIds;
    string maxResults;
    string pageToken;
    string q;
}

struct ListDraftsRequest {
    string includeSpamTrash;
    string maxResults;
    string pageToken;
    string q;
}

struct ListHistoryRequest {
    string labelId;
    string maxResults;
    string pageToken;
}

struct EmailLabel {
    string types;
    string messagesTotal;
    string messagesUnread;
    string threadsTotal;
    string threadsUnread;
}

struct Response {
    json response;
}

struct GetUserProfileResponse {
    string emailAddress;
    int messagesTotal;
    int threadsTotal;
    string historyId;
}

struct ResponseStatusCode {
    string responseStatusCode;
}

@doc:Description { value:"Gmail client connector"}
@doc:Param { value:"userId: The userId of the Gmail account which means the email id"}
@doc:Param { value:"accessToken: The accessToken of the Gmail account to access the gmail REST API"}
@doc:Param { value:"refreshToken: The refreshToken of the Gmail App to access the gmail REST API"}
@doc:Param { value:"clientId: The clientId of the App to access the gmail REST API"}
@doc:Param { value:"clientSecret: The clientSecret of the App to access the gmail REST API"}
connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                           string clientSecret) {

    string refreshTokenEP = "https://www.googleapis.com/oauth2/v3/token";
    string baseURL = "https://www.googleapis.com/gmail";

    oauth2:ClientConnector gmailEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
                                                                   refreshToken, refreshTokenEP);
    @doc:Description { value:"Retrieve the user profile"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Return { value:"response struct"}
    action getUserProfile (ClientConnector g) (Response) {
        message request = {};

        string getProfilePath = "/v1/users/" + userId + "/profile";
        message responseMessage = oauth2:ClientConnector.get (gmailEP, getProfilePath, request);

        json getUserProfileJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:getUserProfileJSONResponse};

        return response;
    }

    @doc:Description { value:"Create a draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"createDraft: It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId) to create draft message"}
    @doc:Return { value:"response struct"}
    action createDraft (ClientConnector g, CreateDraftRequest createDraft) (Response) {
        message request = {};
        string concatRequest;
        if (createDraft != null) {
            string to = createDraft.to;
            string subject = createDraft.subject;
            string from = createDraft.from;
            string messageBody = createDraft.messageBody;
            string cc = createDraft.cc;
            string bcc = createDraft.bcc;
            string id = createDraft.id;
            string threadId = createDraft.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }

            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }

            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }

            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }

            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }

            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }

            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }

            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = utils:base64encode(concatRequest);
        json createDraftRequest = {"message":{"raw":encodedRequest}};

        string createDraftPath = "/v1/users/" + userId + "/drafts";
        messages:setJsonPayload(request, createDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, createDraftPath, request);

        json createDraftJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:createDraftJSONResponse};

        return response;
    }

    @doc:Description { value:"Update a draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to update"}
    @doc:Param { value:"updateDraft: It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId) to update draft"}
    @doc:Return { value:"response struct"}
    action updateDraft (ClientConnector g, string draftId, UpdateDraftRequest updateDraft) (Response) {
        message request = {};
        string concatRequest;
        if (updateDraft != null) {
            string to = updateDraft.to;
            string subject = updateDraft.subject;
            string from = updateDraft.from;
            string messageBody = updateDraft.messageBody;
            string cc = updateDraft.cc;
            string bcc = updateDraft.bcc;
            string id = updateDraft.id;
            string threadId = updateDraft.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }

            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }

            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }

            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }

            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }

            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }

            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }

            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = utils:base64encode(concatRequest);
        json updateDraftRequest = {"message":{"raw":encodedRequest}};

        string updateDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        messages:setJsonPayload(request, updateDraftRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.put (gmailEP, updateDraftPath, request);

        json updateDraftJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:updateDraftJSONResponse};

        return response;
    }

    @doc:Description { value:"Retrieve a particular draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to retrieve"}
    @doc:Param { value:"readDraft: It is a struct. Which contains all optional parameters (format) to read draft"}
    @doc:Return { value:"response struct"}
    action readDraft (ClientConnector g, string draftId, ReadDraftRequest readDraft) (Response) {
        message request = {};
        string readDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;

        if (readDraft != null) {
            string format = readDraft.format;

            if (format != "") {
                readDraftPath = readDraftPath + "?format=" + format;
            }
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readDraftPath, request);

        json readDraftJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:readDraftJSONResponse};

        return response;
    }

    @doc:Description { value:"Lists the drafts in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listDrafts: It is a struct. Which contains all optional parameters (includeSpamTrash,maxResults,pageToken,q) to list drafts"}
    @doc:Return { value:"response struct"}
    action listDrafts (ClientConnector g, ListDraftsRequest listDrafts) (Response) {
        message request = {};
        string uriParams;
        string listDraftPath = "/v1/users/" + userId + "/drafts";

        if (listDrafts != null) {
            string includeSpamTrash = listDrafts.includeSpamTrash;
            string maxResults = listDrafts.maxResults;
            string pageToken = listDrafts.pageToken;
            string q = listDrafts.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }
        if (uriParams != "") {
            listDraftPath = listDraftPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listDraftPath, request);

        json listDraftJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:listDraftJSONResponse};

        return response;
    }

    @doc:Description { value:"Delete a particular draft"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"draftId: Id of the draft to delete"}
    @doc:Return { value:"response struct"}
    action deleteDraft (ClientConnector g, string draftId) (ResponseStatusCode) {
        message request = {};

        string deleteDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteDraftPath, request);

        string deleteDraftJSONResponse = http:getStatusCode(responseMessage);
        ResponseStatusCode response = {responseStatusCode:deleteDraftJSONResponse};

        return response;
    }

    @doc:Description { value:"Lists the history to of all changes to the given mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"startHistoryId: Returns history records after the specified startHistoryId"}
    @doc:Param { value:"listHistory: It is a struct. Which contains all optional parameters (labelId,maxResults,pageToken)"}
    @doc:Return { value:"response struct"}
    action listHistory (ClientConnector g, string startHistoryId, ListHistoryRequest listHistory) (Response) {
        message request = {};
        string listHistoryPath = "/v1/users/" + userId + "/history?startHistoryId=" + startHistoryId;

        if (listHistory != null) {
            string labelId = listHistory.labelId;
            string maxResults = listHistory.maxResults;
            string pageToken = listHistory.pageToken;

            if (labelId != "") {
                listHistoryPath = listHistoryPath + "&labelId=" + labelId;
            }

            if (maxResults != "") {
                listHistoryPath = listHistoryPath + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                listHistoryPath = listHistoryPath + "&pageToken=" + pageToken;
            }
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listHistoryPath, request);

        json listHistoryJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:listHistoryJSONResponse};

        return response;
    }

    @doc:Description { value:"Create a new label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelName: The display name of the label"}
    @doc:Param { value:"messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param { value:"labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param { value:"createLabel: It is a struct. Which contains all optional parameters (types,messagesTotal,messagesUnread,threadsTotal,threadsUnread)"}
    @doc:Return { value:"response struct"}
    action createLabel (ClientConnector g, string labelName, string messageListVisibility, string labelListVisibility,
                        EmailLabel createLabel) (Response) {
        message request = {};
        string createLabelPath = "/v1/users/" + userId + "/labels";
        json createLabelRequest = {"name":labelName, "messageListVisibility":messageListVisibility,
                                  "labelListVisibility":labelListVisibility};
        if (createLabel != null) {
            string types = createLabel.types;
            string messagesTotal = createLabel.messagesTotal;
            string messagesUnread = createLabel.messagesUnread;
            string threadsTotal = createLabel.threadsTotal;
            string threadsUnread = createLabel.threadsUnread;

            if (types != "") {
                createLabelRequest.type = types;
            }

            if (messagesTotal != "") {
                createLabelRequest.messagesTotal = messagesTotal;
            }

            if (messagesUnread != "") {
                createLabelRequest.messagesUnread = messagesUnread;
            }

            if (threadsTotal != "") {
                createLabelRequest.threadsTotal = threadsTotal;
            }

            if (threadsUnread != "") {
                createLabelRequest.threadsUnread = threadsUnread;
            }
        }
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, createLabelRequest);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, createLabelPath, request);

        json createLabelJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:createLabelJSONResponse};

        return response;
    }

    @doc:Description { value:"Delete a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: Id of the label to delete"}
    @doc:Return { value:"response struct"}
    action deleteLabel (ClientConnector g, string labelId) (ResponseStatusCode) {
        message request = {};
        string deleteLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteLabelPath, request);

        string deleteLabelJSONResponse = http:getStatusCode(responseMessage);
        ResponseStatusCode response = {responseStatusCode:deleteLabelJSONResponse};

        return response;
    }

    @doc:Description { value:"Lists all labels in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Return { value:"response struct"}
    action listLabels (ClientConnector g) (Response) {
        message request = {};
        string listLabelPath = "/v1/users/" + userId + "/labels/";
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listLabelPath, request);

        json listLabelsJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:listLabelsJSONResponse};

        return response;
    }

    @doc:Description { value:"Update a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: The Id of the label to update"}
    @doc:Param { value:"labelName: The display name of the label"}
    @doc:Param { value:"messageListVisibility: The visibility of messages with this label in the message list in the
                                        Gmail web interface"}
    @doc:Param { value:"labelListVisibility: The visibility of the label in the label list in the Gmail web interface"}
    @doc:Param { value:"updateLabel: It is a struct. Which contains all optional parameters (types,messagesTotal,messagesUnread,threadsUnread)"}
    @doc:Return { value:"response struct"}
    action updateLabel (ClientConnector g, string labelId, string labelName, string messageListVisibility,
                        string labelListVisibility, EmailLabel updateLabel) (Response) {
        message request = {};
        string updateLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        json updateLabelRequest = {"id":labelId, "name":labelName, "messageListVisibility":messageListVisibility,
                                  "labelListVisibility":labelListVisibility};

        if (updateLabel != null) {
            string types = updateLabel.types;
            string messagesTotal = updateLabel.messagesTotal;
            string messagesUnread = updateLabel.messagesUnread;
            string threadsTotal = updateLabel.threadsTotal;
            string threadsUnread = updateLabel.threadsUnread;

            if (types != "") {
                updateLabelRequest.type = types;
            }

            if (messagesTotal != "") {
                updateLabelRequest.messagesTotal = messagesTotal;
            }

            if (messagesUnread != "") {
                updateLabelRequest.messagesUnread = messagesUnread;
            }

            if (threadsTotal != "") {
                updateLabelRequest.threadsTotal = threadsTotal;
            }

            if (threadsUnread != "") {
                updateLabelRequest.threadsUnread = threadsUnread;
            }
        }
        messages:setHeader(request, "Content-Type", "Application/json");
        messages:setJsonPayload(request, updateLabelRequest);
        message responseMessage = oauth2:ClientConnector.put (gmailEP, updateLabelPath, request);

        json updateLabelJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:updateLabelJSONResponse};

        return response;
    }

    @doc:Description { value:"Retrieve a particular label"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"labelId: Id of the label to retrieve"}
    @doc:Return { value:"response struct"}
    action readLabel (ClientConnector g, string labelId) (Response) {
        message request = {};
        string readLabelPath = "/v1/users/" + userId + "/labels/" + labelId;
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readLabelPath, request);

        json readLabelJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:readLabelJSONResponse};

        return response;
    }

    @doc:Description { value:"Retrieve a particular Thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to retrieve"}
    @doc:Param { value:"readThread: It is a struct. Which contains all optional parameters (format,metaDataHeaders)"}
    @doc:Return { value:"response struct"}
    action readThread (ClientConnector g, string threadId, ReadThreadRequest readThread) (Response) {
        message request = {};
        string uriParams;
        string readThreadPath = "/v1/users/" + userId + "/threads/" + threadId;

        if (readThread != null) {
            string format = readThread.format;
            string metaDataHeaders = readThread.metaDataHeaders;

            if (format != "") {
                uriParams = uriParams + "&format=" + format;
            }

            if (metaDataHeaders != "") {
                uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
            }
        }

        if (uriParams != "") {
            readThreadPath = readThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readThreadPath, request);

        json readThreadJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:readThreadJSONResponse};

        return response;
    }

    @doc:Description { value:"Lists the threads in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listThreads: It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds,maxResults,pageToken,q)"}
    @doc:Return { value:"response struct"}
    action listThreads (ClientConnector g, ListThreadsRequest listThreads) (Response) {
        message request = {};
        string uriParams;
        string listThreadPath = "/v1/users/" + userId + "/threads";

        if (listThreads != null) {
            string includeSpamTrash = listThreads.includeSpamTrash;
            string labelIds = listThreads.labelIds;
            string maxResults = listThreads.maxResults;
            string pageToken = listThreads.pageToken;
            string q = listThreads.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (labelIds != "") {
                uriParams = uriParams + "&labelIds=" + labelIds;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }

        if (uriParams != "") {
            listThreadPath = listThreadPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listThreadPath, request);

        json listThreadsJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:listThreadsJSONResponse};

        return response;
    }

    @doc:Description { value:"Delete a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to delete"}
    @doc:Return { value:"response struct"}
    action deleteThread (ClientConnector g, string threadId) (ResponseStatusCode) {
        message request = {};
        string deleteThreadPath = "/v1/users/" + userId + "/threads/" + threadId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteThreadPath, request);

        string deleteThreadJSONResponse = http:getStatusCode(responseMessage);
        ResponseStatusCode response = {responseStatusCode:deleteThreadJSONResponse};

        return response;
    }

    @doc:Description { value:"Trash a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to Trash"}
    @doc:Return { value:"response struct"}
    action trashThread (ClientConnector g, string threadId) (Response) {
        message request = {};
        string trashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/trash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, trashThreadPath, request);

        json trashThreadJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:trashThreadJSONResponse};

        return response;
    }

    @doc:Description { value:"UnTrash a particular thread"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"threadId: Id of the thread to unTrash"}
    @doc:Return { value:"response struct"}
    action unTrashThread (ClientConnector g, string threadId) (Response) {
        message request = {};
        string unTrashThreadPath = "/v1/users/" + userId + "/threads/" + threadId + "/untrash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, unTrashThreadPath, request);

        json unTrashThreadJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:unTrashThreadJSONResponse};

        return response;
    }

    @doc:Description { value:"Lists the messages in the user's mailbox"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"listMails: It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds,maxResults,pageToken,q)"}
    @doc:Return { value:"response struct"}
    action listMails (ClientConnector g, ListMailsRequest listMails) (Response) {
        message request = {};
        string uriParams;
        string listMailPath = "/v1/users/" + userId + "/messages";

        if (listMails != null) {
            string includeSpamTrash = listMails.includeSpamTrash;
            string labelIds = listMails.labelIds;
            string maxResults = listMails.maxResults;
            string pageToken = listMails.pageToken;
            string q = listMails.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (labelIds != "") {
                uriParams = uriParams + "&labelIds=" + labelIds;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }

        if (uriParams != "") {
            listMailPath = listMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, listMailPath, request);

        json listMailsJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:listMailsJSONResponse};

        return response;
    }

    @doc:Description { value:"Send a mail"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"sendMail: It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId)"}
    @doc:Return { value:"response struct"}
    action sendMail (ClientConnector g, SendMailRequest sendMail) (Response) {//TODO
        message request = {};
        string concatRequest;
        if (sendMail != null) {
            string to = sendMail.to;
            string subject = sendMail.subject;
            string from = sendMail.from;
            string messageBody = sendMail.messageBody;
            string cc = sendMail.cc;
            string bcc = sendMail.bcc;
            string id = sendMail.id;
            string threadId = sendMail.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }

            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }

            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }

            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }

            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }

            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }

            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }

            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }

        string encodedRequest = utils:base64encode(concatRequest);
        json sendMailRequest = {"raw":encodedRequest};
        string sendMailPath = "/v1/users/" + userId + "/messages/send";
        messages:setJsonPayload(request, sendMailRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, sendMailPath, request);

        json sendMailJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:sendMailJSONResponse};

        return response;
    }

    @doc:Description { value:"Modifies the labels on the specified message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: The ID of the message to modifies the labels"}
    @doc:Param { value:"addLabelIds: A list of IDs of labels to add to this message"}
    @doc:Param { value:"removeLabelIds: A list IDs of labels to remove from this message"}
    @doc:Return { value:"response struct"}
    action modifyExistingMessage (ClientConnector g, string messageId, string addLabelIds,
                                  string removeLabelIds) (Response) {
        message request = {};
        json modifyExistingMessageRequest = {};
        string modifyExistingMessagePath = "/v1/users/" + userId + "/messages/" + messageId + "/modify";

        if (addLabelIds != "null") {
            modifyExistingMessageRequest.addLabelIds = [addLabelIds];
        }

        if (removeLabelIds != "null") {
            modifyExistingMessageRequest.removeLabelIds = [removeLabelIds];
        }
        messages:setJsonPayload(request, modifyExistingMessageRequest);
        messages:setHeader(request, "Content-Type", "Application/json");
        message responseMessage = oauth2:ClientConnector.post (gmailEP, modifyExistingMessagePath, request);

        json modifyExistingMessageJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:modifyExistingMessageJSONResponse};

        return response;
    }

    @doc:Description { value:"Retrieve a particular Message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to retrieve"}
    @doc:Param { value:"readMail: It is a struct. Which contains all optional parameters (format,metaDataHeaders)"}
    @doc:Return { value:"response struct"}
    action readMail (ClientConnector g, string messageId, ReadMailRequest readMail) (Response) {
        message request = {};
        string uriParams;
        string readMailPath = "/v1/users/" + userId + "/messages/" + messageId;

        if (readMail != null) {
            string format = readMail.format;
            string metaDataHeaders = readMail.metaDataHeaders;

            if (format != "") {
                uriParams = uriParams + "&format=" + format;
            }

            if (metaDataHeaders != "") {
                uriParams = uriParams + "&metaDataHeaders=" + metaDataHeaders;
            }
        }

        if (uriParams != "") {
            readMailPath = readMailPath + "?" + strings:subString(uriParams, 1, strings:length(uriParams));
        }
        message responseMessage = oauth2:ClientConnector.get (gmailEP, readMailPath, request);

        json readMailJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:readMailJSONResponse};

        return response;
    }

    @doc:Description { value:"Delete a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to delete"}
    @doc:Return { value:"response struct"}
    action deleteMail (ClientConnector g, string messageId) (ResponseStatusCode) {
        message request = {};
        string deleteMailPath = "/v1/users/" + userId + "/messages/" + messageId;
        message responseMessage = oauth2:ClientConnector.delete (gmailEP, deleteMailPath, request);

        string deleteMailJSONResponse = http:getStatusCode(responseMessage);
        ResponseStatusCode response = {responseStatusCode:deleteMailJSONResponse};

        return response;
    }

    @doc:Description { value:"Trash a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to Trash"}
    @doc:Return { value:"response struct"}
    action trashMail (ClientConnector g, string messageId) (Response) {
        message request = {};
        string trashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/trash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, trashMailPath, request);

        json trashMailJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:trashMailJSONResponse};

        return response;
    }

    @doc:Description { value:"UnTrash a particular message"}
    @doc:Param { value:"g: The gmail Connector instance"}
    @doc:Param { value:"messageId: Id of the message to unTrash"}
    @doc:Return { value:"response struct"}
    action unTrashMail (ClientConnector g, string messageId) (Response) {
        message request = {};
        string unTrashMailPath = "/v1/users/" + userId + "/messages/" + messageId + "/untrash";
        http:setContentLength(request, 0);
        message responseMessage = oauth2:ClientConnector.post (gmailEP, unTrashMailPath, request);

        json unTrashMailJSONResponse = messages:getJsonPayload(responseMessage);
        Response response = {response:unTrashMailJSONResponse};

        return response;
    }
}