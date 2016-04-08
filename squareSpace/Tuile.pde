class Tuile{
	
	private PVector _position, _dimensions;
	private BanqueCouleurs _banqueCouleurs;
	private color _backgroundColor;
	private GestionnaireTuiles _refGestionnaireTuiles;
	private int _id;

    Tuile(GestionnaireTuiles refGestionnaireTuiles, int id, PVector position, PVector dimensions){
    	_refGestionnaireTuiles = refGestionnaireTuiles;
    	_id = id;
    	_position = position;
    	_dimensions = dimensions;
    	_banqueCouleurs = new BanqueCouleurs();
    	_backgroundColor  =_banqueCouleurs.getRandomColor();
	}

	public void update(){
		draw();
	}

	private void draw(){
		drawBackground();
	}

	private void drawBackground (){
		pushMatrix();
		noStroke();
		fill(_backgroundColor);
		rect(_position.x, _position.y, _dimensions.x, _dimensions.y);
		popMatrix();
	}
}
