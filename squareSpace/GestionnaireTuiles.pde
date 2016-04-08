class GestionnaireTuiles{
  ArrayList<Tuile> _arrayTuiles;
  int _subdivisions;
  PVector _canvasDimensions;
  PVector _tuilesDimensions;

  GestionnaireTuiles(float canvasWidth, float canvasHeight, int subdivisions){
  	_subdivisions = subdivisions;
  	_canvasDimensions = new PVector(canvasWidth, canvasHeight);
    _arrayTuiles = new ArrayList<Tuile>();
    _tuilesDimensions = new PVector(canvasWidth / subdivisions, canvasHeight / subdivisions);

    createTuiles();
  }

  public void update(){
  	for(Tuile t : _arrayTuiles)
  		t.update();
  }

  private void createTuile(PVector position, PVector dimensions){
  	_arrayTuiles.add(new Tuile(this, _arrayTuiles.size(), position, dimensions));
  }

  private void createTuiles(){
  	println("started create tuiles");
  	for(int i = 0 ; i < (int)_subdivisions; i++){
  		for(int j=0; j< (int)_subdivisions; j++){
  			createTuile(
  				new PVector(_tuilesDimensions.x * j, _tuilesDimensions.y * i), 
  				new PVector(_tuilesDimensions.x, _tuilesDimensions.y)
			);
  		}
  	}
  	println("ended create tuiles");
  }
}
