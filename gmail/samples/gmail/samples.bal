import org.wso2.ballerina.connectors.gmail;

import ballerina.lang.system;

function main (string[] args) {

    gmail:ClientConnector gmailConnector = create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);

    gmail:Response gmailResponse;
    gmail:ResponseStatusCode gmailResponseStatusCode;

    if (args[0] == "getUserProfile") {
        gmailResponse = gmail:ClientConnector.getUserProfile (gmailConnector);
        system:println(gmailResponse.response);
    }

    if (args[0] == "createDraft") {
        gmail:CreateDraftRequest createDraft = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                               from:"birunthagnanes@gmail.com"};
        gmailResponse = gmail:ClientConnector.createDraft (gmailConnector, createDraft);
        system:println(gmailResponse.response);
    }

    if (args[0] == "updateDraft") {
        string draftId = args[6];
        gmail:UpdateDraftRequest updateDraft = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                               from:"birunthagnanes@gmail.com"};
        gmailResponse = gmail:ClientConnector.updateDraft (gmailConnector, draftId, updateDraft);
        system:println(gmailResponse.response);
    }

    if (args[0] == "readDraft") {
        string draftId = args[6];
        gmail:ReadDraftRequest readDraft = {format:"full"};
        gmailResponse = gmail:ClientConnector.readDraft (gmailConnector, draftId, readDraft);
        system:println(gmailResponse.response);
    }

    if (args[0] == "listDrafts") {
        gmail:ListDraftsRequest listDrafts = {includeSpamTrash:"false", pageToken:"2"};
        gmailResponse = gmail:ClientConnector.listDrafts (gmailConnector, listDrafts);
        system:println(gmailResponse.response);
    }

    if (args[0] == "deleteDraft") {
        string draftId = args[6];
        gmailResponseStatusCode = gmail:ClientConnector.deleteDraft (gmailConnector, draftId);
        system:println("Status code : " + gmailResponseStatusCode.responseStatusCode);
    }

    if (args[0] == "listHistory") {
        string startHistoryId = args[6];
        gmail:ListHistoryRequest listHistory = {maxResults:"3"};
        gmailResponse = gmail:ClientConnector.listHistory (gmailConnector, startHistoryId, listHistory);
        system:println(gmailResponse.response);
    }

    if (args[0] == "createLabel") {
        string labelName = args[6];
        string messageListVisibility = args[7];
        string labelListVisibility = args[8];
        gmail:EmailLabel createLabel = {types:"user"};
        gmailResponse = gmail:ClientConnector.createLabel (gmailConnector, labelName, messageListVisibility,
                                                           labelListVisibility, createLabel);
        system:println(gmailResponse.response);
    }

    if (args[0] == "deleteLabel") {
        string labelId = args[6];
        gmailResponseStatusCode = gmail:ClientConnector.deleteLabel (gmailConnector, labelId);
        system:println("Status code : " + gmailResponseStatusCode.responseStatusCode);
    }

    if (args[0] == "listLabels") {
        gmailResponse = gmail:ClientConnector.listLabels (gmailConnector);
        system:println(gmailResponse.response);
    }

    if (args[0] == "updateLabel") {
        string labelId = args[6];
        string labelName = args[7];
        string messageListVisibility = args[8];
        string labelListVisibility = args[9];
        gmail:EmailLabel updateLabel = {types:"user"};
        gmailResponse = gmail:ClientConnector.updateLabel (gmailConnector, labelId, labelName, messageListVisibility,
                                                           labelListVisibility, updateLabel);
        system:println(gmailResponse.response);
    }

    if (args[0] == "readLabel") {
        string labelId = args[6];
        gmailResponse = gmail:ClientConnector.readLabel (gmailConnector, labelId);
        system:println(gmailResponse.response);
    }

    if (args[0] == "readThread") {
        string threadId = args[6];
        gmail:ReadThreadRequest readThread = {format:"full"};
        gmailResponse = gmail:ClientConnector.readThread (gmailConnector, threadId, readThread);
        system:println(gmailResponse.response);
    }

    if (args[0] == "listThreads") {
        gmail:ListThreadsRequest listThreads = {includeSpamTrash:"false"};
        gmailResponse = gmail:ClientConnector.listThreads (gmailConnector, listThreads);
        system:println(gmailResponse.response);
    }

    if (args[0] == "deleteThread") {
        string threadId = args[6];
        gmailResponseStatusCode = gmail:ClientConnector.deleteThread (gmailConnector, threadId);
        system:println("Status code : " + gmailResponseStatusCode.responseStatusCode);
    }

    if (args[0] == "trashThread") {
        string threadId = args[6];
        gmailResponse = gmail:ClientConnector.trashThread (gmailConnector, threadId);
        system:println(gmailResponse.response);
    }

    if (args[0] == "unTrashThread") {
        string threadId = args[6];
        gmailResponse = gmail:ClientConnector.unTrashThread (gmailConnector, threadId);
        system:println(gmailResponse.response);
    }

    if (args[0] == "listMails") {
        gmail:ListMailsRequest listMails = {includeSpamTrash:"false"};
        gmailResponse = gmail:ClientConnector.listMails (gmailConnector, listMails);
        system:println(gmailResponse.response);
    }

    if (args[0] == "sendMail") {
        gmail:SendMailRequest sendMail = {to:"birunthagnanes@gmail.com", subject:"This is subject",
                                         from:"birunthagnanes@gmail.com"};
        gmailResponse = gmail:ClientConnector.sendMail (gmailConnector, sendMail);
        system:println(gmailResponse.response);
    }

    if (args[0] == "modifyExistingMessage") {
        string messageId = args[6];
        string addLabelIds = args[7];
        string removeLabelIds = args[8];
        gmailResponse = gmail:ClientConnector.modifyExistingMessage (gmailConnector, messageId, addLabelIds,
                                                                     removeLabelIds);
        system:println(gmailResponse.response);
    }

    if (args[0] == "readMail") {
        string messageId = args[6];
        gmail:ReadMailRequest readMail = {format:"full"};
        gmailResponse = gmail:ClientConnector.readMail (gmailConnector, messageId, readMail);
        system:println(gmailResponse.response);
    }

    if (args[0] == "deleteMail") {
        string messageId = args[6];
        gmailResponseStatusCode = gmail:ClientConnector.deleteMail (gmailConnector, messageId);
        system:println("Status code : " + gmailResponseStatusCode.responseStatusCode);
    }

    if (args[0] == "trashMail") {
        string messageId = args[6];
        gmailResponse = gmail:ClientConnector.trashMail (gmailConnector, messageId);
        system:println(gmailResponse.response);
    }

    if (args[0] == "unTrashMail") {
        string messageId = args[6];
        gmailResponse = gmail:ClientConnector.unTrashMail (gmailConnector, messageId);
        system:println(gmailResponse.response);
    }
}