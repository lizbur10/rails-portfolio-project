# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements - JQUERY IS USED FOR GET REQUESTS TO REPORTS#INDEX AND REPORTS#SHOW (WITH DATATYPE JSON) AND A POST REQUEST TO REPORTS#ADD_BIRDS (WITH DATATYPE SCRIPT)
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend. - ON THE BANDER SHOW PAGE, YOU CAN CLICK ON ANY POSTED REPORT AND IT'S RENEDERED ON THE PAGE VIA JSON
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend. - CLICKING THE 'VIEW POSTED REPORTS' LINK RENDERS A LIST OF THE POSTED REPORTS ON THE PAGE VIA JSON
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM. - EACH REPORT HAS MANY BANDING RECORDS (BIRDS) WHICH ARE RENDERED ON THE PAGE VIA JSON
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh. - THERE IS AN 'ADD BIRDS' PAGE WHERE BANDING RECORDS ARE CREATED AND RENDERED USING AJAX
- [x] Translate JSON responses into js model objects. - WHEN A REPORT IN THE LIST OF POSTED REPORTS IS CLICKED A JS REPORT OBJECT IS CREATED
- [x] At least one of the js model objects must have at least one method added by your code to the prototype. - THE CLASS INCLUDES METHODS TO GET THE REPORT'S URL, FORMAT THE DATE, AND RENDER THE REPORT

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
