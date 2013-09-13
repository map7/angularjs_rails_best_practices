# Retain search variables whilst moving through the application
app.service('searchService', ->
  subject = ''
  body = ''
  getSubject : -> return subject
  setSubject : (text) -> subject = text
  
  getBody : -> return body
  setBody : (text) -> body = text
)
