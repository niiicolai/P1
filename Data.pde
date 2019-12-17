// Defines an object used to handle saving and loading participant data
class Data {
  
  // The final path to the json file
  final String dataPath = "data.json";
  
  // An array list of the partcipant data
  public ArrayList<ParticipantDatum> participantdata = new ArrayList<ParticipantDatum>();
  
  // Call whenenver the saved participant data should be loaded again
  // This is done so that new participant data only is applied
  // instead of overwriting the data for each restart
  public void load() {
    
    // Load the json file at the given path
    // and create an instance of a JSONArray
    JSONArray _participantdata = loadJSONArray(dataPath); 
    
    // Loop through all participant data
    for (int i = 0; i < _participantdata.size(); i++) {
      
      // Declare a reference to the current JSON object 
      JSONObject participantJSONObj = _participantdata.getJSONObject(i); 
      
      // Create an instance of a new participant datum
      ParticipantDatum _participantdatum = new ParticipantDatum();
      
      // Set the date time of the participant datum to the value of 'dateTime' saved in the JSON object
      _participantdatum.dateTime = participantJSONObj.getString("dateTime");
      
      // Declare a reference of a JSONArray
      JSONArray _participantAnswers = participantJSONObj.getJSONArray("answers");
      
      // Loop through all the saved answers
      for (int x = 0; x < _participantAnswers.size(); x++) {
        
        // Declare a reference to a JSONObject
        JSONObject _participantAnswer = _participantAnswers.getJSONObject(x); 
        
        // Create an instance of a new participant answer
        ParticipantAnswer participantAnswer = new ParticipantAnswer();
        
        // Set the datetime of the paticipant answer
        participantAnswer.dateTime = _participantAnswer.getString("dateTime");
        
        // Set the question value of the paticipant answer
        participantAnswer.question = _participantAnswer.getString("question");
        
        // Set the answer value of the paticipant answer
        participantAnswer.answer = _participantAnswer.getString("answer");
        
        // Add the current created answer to the participantdatum's answers array list
        _participantdatum.answers.add(participantAnswer);
      }     

      // add the current created participant datum to the paticipant datum array list
      participantdata.add(_participantdatum);
    }
  }
  
  // Call to write the current participant datum array list to the JSON file
  public void save() {
    
    // Create an instance of a new JSON array
    JSONArray _participantdata = new JSONArray();
    
    // loop through all the participant data
    for (int i = 0; i < participantdata.size(); i++) {
      
      // Create an instance of a new JSON object
      JSONObject participantJSONObj = new JSONObject();
      
      // Add a key called "dateTime" and the value of the current date time
      participantJSONObj.setString("dateTime", dateTime());
      
      // Create an instance of a new JSON array
      JSONArray participantJSONAnswers = new JSONArray();
      
      // Loop through all answers within the current participant datum
      for (int x = 0; x < participantdata.get(i).answers.size(); x++) {
        
        // Create an instance of a new JSON object
        JSONObject _answerJSONObj = new JSONObject();        
        
         // Add a key called "dateTime" and the value of the answer's date time
        _answerJSONObj.setString("dateTime", participantdata.get(i).answers.get(x).dateTime);
        
        // Add a key called "question" and the value of the answer's question
        _answerJSONObj.setString("question", participantdata.get(i).answers.get(x).question);
        
        // Add a key called "answer" and the value of the answer's answer
        _answerJSONObj.setString("answer", participantdata.get(i).answers.get(x).answer);
        
        // Add current created JSON object to the reference of an JSON array
        participantJSONAnswers.setJSONObject(x, _answerJSONObj);
      }
      
      // Add that JSON array to the first created JSON object with a key called "answers" and the value of that JSON array
      participantJSONObj.setJSONArray("answers", participantJSONAnswers);
      
      // Add the first JSON object to the first JSON array
      _participantdata.setJSONObject(i, participantJSONObj);
    }
    
    // Write the first JSON array to JSON file
    saveJSONArray(_participantdata, "data.json");
  }    
  
  // Returns a dateTime formatted as "y-m-d H:M:S"
  public String dateTime() {
    return year()+"-"+month()+"-"+day()+" "+hour()+":"+minute()+":"+second();
  }
}

// Defines an object that holds a date time and an arraylist of participant answers
class ParticipantDatum {
  public String dateTime;
  public ArrayList<ParticipantAnswer> answers = new ArrayList<ParticipantAnswer>();
}

// Defines an object that holds the answers provided by a participant
class ParticipantAnswer {
  public String dateTime;
  public String question;
  public String answer;
}
