# Retain search variables whilst moving through the application
app.service('searchService', ->
  subject = ''
  
  return {
    getSubject : -> return subject
    setSubject : (text) -> subject = text
  }
)
