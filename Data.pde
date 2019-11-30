class Data {
  final String dataPath = "data.json";
  public ArrayList<ParticipantDatum> participantdata = new ArrayList<ParticipantDatum>();
  
  public void load() {
    JSONArray _participantdata = loadJSONArray(dataPath); 
    
    for (int i = 0; i < _participantdata.size(); i++) {
      JSONObject participantJSONObj = _participantdata.getJSONObject(i); 
      ParticipantDatum _participantdatum = new ParticipantDatum();
      _participantdatum.dateTime = participantJSONObj.getString("dateTime");

      JSONArray _participantAnswers = participantJSONObj.getJSONArray("answers");
      for (int x = 0; x < _participantAnswers.size(); x++) {
        JSONObject _participantAnswer = _participantAnswers.getJSONObject(x); 
        ParticipantAnswer participantAnswer = new ParticipantAnswer();
        participantAnswer.dateTime = _participantAnswer.getString("dateTime");
        participantAnswer.question = _participantAnswer.getString("question");
        participantAnswer.answer = _participantAnswer.getString("answer");
        _participantdatum.answers.add(participantAnswer);
      }     

      participantdata.add(_participantdatum);
    }
  }
  
  public void save() {
    JSONArray _participantdata = new JSONArray();
    
    for (int i = 0; i < participantdata.size(); i++) {
      JSONObject participantJSONObj = new JSONObject();
      participantJSONObj.setString("dateTime", dateTime());
      JSONArray participantJSONAnswers = new JSONArray();
      
      for (int x = 0; x < participantdata.get(i).answers.size(); x++) {
        JSONObject _answerJSONObj = new JSONObject();        
        _answerJSONObj.setString("dateTime", participantdata.get(i).answers.get(x).dateTime);
        _answerJSONObj.setString("question", participantdata.get(i).answers.get(x).question);
        _answerJSONObj.setString("answer", participantdata.get(i).answers.get(x).answer);
        participantJSONAnswers.setJSONObject(x, _answerJSONObj);
      }
      
      participantJSONObj.setJSONArray("answers", participantJSONAnswers);
      _participantdata.setJSONObject(i, participantJSONObj);
    }
    
    saveJSONArray(_participantdata, "data.json");
  }    
  
  public String dateTime() {
    return year()+"-"+month()+"-"+day()+" "+hour()+":"+minute()+":"+second();
  }
}

class ParticipantDatum {
  public String dateTime;
  public ArrayList<ParticipantAnswer> answers = new ArrayList<ParticipantAnswer>();
}

class ParticipantAnswer {
  public String dateTime;
  public String question;
  public String answer;
}
