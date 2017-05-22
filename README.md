# MailCore2Example
Example to use MailCore2 and some helpful links

[MailCore/mailcore2](https://github.com/MailCore/mailcore2)

[Issues: Set htmlBodyRenderingOperationWithMessage formatting delegate? #1132](https://github.com/MailCore/mailcore2/issues/1132)

[Issues: Removing info about attachments from email body #813](https://github.com/MailCore/mailcore2/issues/813)

[Issues: Set htmlBodyRenderingOperationWithMessage formatting delegate? #1132](https://github.com/MailCore/mailcore2/issues/1132)

[Issues: Adding Inline Attachments? #164](https://github.com/MailCore/mailcore2/issues/164)

[Wiki: Embedding images in HTML rendered message](https://github.com/MailCore/mailcore2/wiki/Embedding-images-in-HTML-rendered-message) // This for bodyData full downloaded.

[STARTTLS vs SSL/TLS [closed]](http://stackoverflow.com/questions/5540374/starttls-vs-ssl-tls)


#### POP3

- There are no folders with POP.
- There's no notion of unread messages on POP3.
- POP3 only connects to the inbox.
- The pop session seems cannot fetch new emails received after the session's initial time. Call `disconnectOperation`.
- The `index` of pop message will change if receive mail or delete mail, the `uid` will not change.

[Fetching the inbox count on POP? #82](https://github.com/MailCore/mailcore2/issues/82)

[iOS:how to fetch messages in different folder when use POP ? #1508](https://github.com/MailCore/mailcore2/issues/1508)

[How to Fetch message with header, email subject, email content and without attachments #1442](https://github.com/MailCore/mailcore2/issues/1442)

[pop3 - point to inbox once connected? #601](https://github.com/MailCore/mailcore2/issues/601)
