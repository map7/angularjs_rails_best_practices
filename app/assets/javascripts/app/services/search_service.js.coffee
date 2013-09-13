app.service('searchService', ->
  subject = ''
  
  return {
    getSubject : ->
      return subject

    setSubject : (text) ->
      subject = text
  }
)
