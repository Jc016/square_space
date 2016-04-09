class GestionnaireTuiles{

  private final color BACKGROUND_FILL_COLOR = #fef7e0;
  private final int RESPAWN_INTERVAL = 20;
  private ArrayList<Tuile> _arrayTuiles;
  private ArrayList<TuileTemplate> _arrayTuileTemplates;
  private int _subdivisions;
  private PVector _canvasDimensions;
  private PVector _tuilesDimensions;
  private boolean _isBuildingTiles;
  private ForceAlterationTuiles _forceAlterationTuiles;
  private int _timeSinceLastRespawn, _lastRespawnTimeStamp;

  GestionnaireTuiles(float canvasWidth, float canvasHeight, int subdivisions){
  	_subdivisions = subdivisions;
  	_canvasDimensions = new PVector(canvasWidth, canvasHeight);
    _tuilesDimensions = new PVector(canvasWidth / subdivisions, canvasHeight / subdivisions);
    _isBuildingTiles = false;
    reset();
  }

  public void update(){
    if(!_isBuildingTiles){
      processKeyPressEvents();
      processMouseEvents();
      background(BACKGROUND_FILL_COLOR);
      for(int i = _arrayTuiles.size() -1; i>= 0; i--){
        Tuile t = _arrayTuiles.get(i);
        t.sendForceToProcess(_forceAlterationTuiles);
        t.update();
      }
      processTuilesRespawn(); 
    }
  }

  private void createTuile(PVector position, PVector dimensions){
  	_arrayTuiles.add(new Tuile(this, position, dimensions));
  }

  private void createTuile(TuileTemplate tuileTemplate){
    _arrayTuiles.add(new Tuile(this, tuileTemplate));
  }

  private void createTuiles(){
  	for(int i = 0 ; i < (int)_subdivisions; i++){
  		for(int j=0; j < (int)_subdivisions; j++){
  			createTuile(
  				new PVector(_tuilesDimensions.x * j, _tuilesDimensions.y * i), 
  				new PVector(_tuilesDimensions.x, _tuilesDimensions.y)
  		 );
  		}
  	}
  }
  private void processMouseEvents(){
    if(mousePressed){
      _forceAlterationTuiles.recordForce(new PVector(pmouseX, pmouseY), new PVector(mouseX, mouseY));
    }else{
      _forceAlterationTuiles.reset();
    }
  }

  private void processKeyPressEvents(){
    if(keyPressed){
      switch (key) {
        case 'r': reset(); break;
      }
    }
  }

  private void reset(){
    background(BACKGROUND_FILL_COLOR);
    _timeSinceLastRespawn = 0;
    _lastRespawnTimeStamp = 0;
    _isBuildingTiles=true;
    _arrayTuiles = new ArrayList<Tuile>();
    _arrayTuileTemplates = new ArrayList<TuileTemplate>();
    _forceAlterationTuiles = new ForceAlterationTuiles();
    createTuiles();
    _isBuildingTiles = false;
  }

  private void deleteTuile(Tuile tuile){
    addTuileTemplate(tuile.exportToTemplate());
    _arrayTuiles.remove(tuile);
    tuile = null;
  }

  private void addTuileTemplate(TuileTemplate tuileTemplate){
    _arrayTuileTemplates.add(tuileTemplate);
  }

  private void processTuilesRespawn(){
    _timeSinceLastRespawn = millis() - _lastRespawnTimeStamp;
    if(_timeSinceLastRespawn > RESPAWN_INTERVAL && _arrayTuileTemplates.size() > 0 && !mousePressed){
      createTuile(_arrayTuileTemplates.get(0));
      _arrayTuileTemplates.remove(0);
      _lastRespawnTimeStamp = millis();

    }
  }

}


