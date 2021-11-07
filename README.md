PhoneBookConverter

 

This program was made to convert your Mac OS phonebook export to an xml file
that your Yealink phone can import and use. It is written in the Pascal IDE
Lazarus v2.0.12 and should compile and work on other operating systems than Mac
OS as well. I have not tested it on Windows or Linux yet.

 

Operation on Mac OS

First, inside Mac OS contacts, you have to select all your contacts that you
want to export and then export them using File -\> Export -\> vCard Export

Use this vCard file as input to PhoneBookConverter.

Now start PhoneBookConverter, select your exported phonebook as input and create
a new phonebook xml-file using the „Save as“ dialog.

Put this xml file into the directory of your web server on your Mac (or any
other http server) and select it from your YeaLink phone using the published URL
as input under Directory -\> External Phonebook

Enter the URL that points to the converted phonebook, including the
xml-filename.

Now on your phone you will see this phonebook and can import it.
