class GestionnaireTuiles{
  ArrayList<Tuile> _arrayTuiles;
  int _subdivisions;
  PVector _canvasDimensions;
  PVector _tuilesDimensions;
  int _nextTuileCreatedId;

  GestionnaireTuiles(float canvasWidth, float canvasHeight, int subdivisions){
  	_subdivisions = subdivisions;
  	_canvasDimensions = new PVector(canvasWidth, canvasHeight);
    _arrayTuiles = new ArrayList<Tuile>();
    _tuilesDimensions = new PVector(canvasWidth / subdivisions, canvasHeight / subdivisions);
    _nextTuileCreatedId = 0;

    createTuiles();
  }

  public void update(){
  	for(Tuile t : _arrayTuiles)
  		t.update();
  }

  private void createTuile(PVector position, PVector dimensions){
  	_arrayTuiles.add(new Tuile(this, _nextTuileCreatedId, position, dimensions));
  	_nextTuileCreatedId ++;
  }

  private void createTuiles(){
  	for(int i = 0 ; i < _canvasDimensions.y; i++){
  		for(int j=0; j< _canvasDimensions.x; j++){
  			createTuile(
  				new PVector(_tuilesDimensions.x * j, _tuilesDimensions.y * i), 
  				new PVector(_tuilesDimensions.x, _tuilesDimensions.y)
			);
  		}
  	}
  }
}
