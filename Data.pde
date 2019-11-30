class Data {
  final String dataPath = "data.json";
  public ArrayList<ParticipantDatum> participantdata = new ArrayList<ParticipantDatum>();
  
  public void load() {
    File f = new File(dataPath);
    if (!f.exists()) {
      return;  
    }
    
    JSONArray _participantdata = loadJSONArray(dataPath); 
    
    for (int i = 0; i < _participantdata.size(); i++) {
      JSONObject participantJSONObj = _participantdata.getJSONObject(i); 
      ParticipantDatum _participantdatum = new ParticipantDatum();
      _participantdatum.dateTime = participantJSONObj.getString("datetime");

      JSONArray _participantAnswers = participantJSONObj.getJSONArray("answers");
      for (int x = 0; x < _participantAnswers.size(); x++) {
        JSONObject _participantAnswer = _participantAnswers.getJSONObject(x); 
        String answer = _participantAnswer.getString("answer");
        _participantdatum.answers.add(answer);
      }      
    }
  }
  
  public void save() {
    JSONArray _participantdata = new JSONArray();
    
    for (int i = 0; i < participantdata.size(); i++) {
      JSONObject participantJSONObj = new JSONObject();
      participantJSONObj.setString("datetime", year()+"-"+month()+"-"+day()+" "+hour()+":"+minute()+":"+second());
      JSONArray participantJSONAnswers = new JSONArray();
      
      for (int x = 0; x < participantdata.get(i).answers.size(); x++) {
        JSONObject _answerJSONObj = new JSONObject();        
        _answerJSONObj.setString("answer", participantdata.get(i).answers.get(x));
        participantJSONAnswers.setJSONObject(x, _answerJSONObj);
      }
      
      participantJSONObj.setJSONArray("answers", participantJSONAnswers);
      _participantdata.setJSONObject(i, participantJSONObj);
    }
    
    saveJSONArray(_participantdata, "data.json");
  }    
}

class ParticipantDatum {
  public String dateTime;
  public ArrayList<String> answers = new ArrayList<String>();;
}
