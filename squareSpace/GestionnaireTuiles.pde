class GestionnaireTuiles{
  final color BACKGROUND_FILL_COLOR = #f9f8ea;
  ArrayList<Tuile> _arrayTuiles;
  int _subdivisions;
  PVector _canvasDimensions;
  PVector _tuilesDimensions;
  boolean _changeOccured;
  ForceAlterationTuiles _forceAlterationTuiles;

  GestionnaireTuiles(float canvasWidth, float canvasHeight, int subdivisions){
  	_subdivisions = subdivisions;
  	_canvasDimensions = new PVector(canvasWidth, canvasHeight);
    _arrayTuiles = new ArrayList<Tuile>();
    _tuilesDimensions = new PVector(canvasWidth / subdivisions, canvasHeight / subdivisions);
    _changeOccured = false;
    _forceAlterationTuiles = new ForceAlterationTuiles();
    createTuiles();
  }

  public void update(){
    processMouseEvents();
    background(BACKGROUND_FILL_COLOR);
    for(Tuile t : _arrayTuiles){
      t.sendForceToProcess(_forceAlterationTuiles);
      t.update();
    } 
  }

  private void createTuile(PVector position, PVector dimensions){
  	_arrayTuiles.add(new Tuile(this, _arrayTuiles.size(), position, dimensions));
    _changeOccured = true;
  }

  private void createTuiles(){
  	println("started create tuiles");
  	for(int i = 0 ; i < (int)_subdivisions; i++){
  		for(int j=0; j < (int)_subdivisions; j++){
  			createTuile(
  				new PVector(_tuilesDimensions.x * j, _tuilesDimensions.y * i), 
  				new PVector(_tuilesDimensions.x, _tuilesDimensions.y)
			 );
  		}
  	}
  	println("ended create tuiles");
  }
  private void processMouseEvents(){
    if(mousePressed){
      _forceAlterationTuiles.recordForce(new PVector(pmouseX, pmouseY), new PVector(mouseX, mouseY));
      _changeOccured = true;
    }else{
      _forceAlterationTuiles.reset();
    }
  }

}


