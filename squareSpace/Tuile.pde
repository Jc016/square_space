class Tuile {
	private final int PADDING = 8;
	private PGraphics _canvas;
	private PVector _position, _dimensions;
	private BanqueCouleurs _banqueCouleurs;
	private color _backgroundColor;
	private GestionnaireTuiles _refGestionnaireTuiles;
	private int _id;

    Tuile(GestionnaireTuiles refGestionnaireTuiles, int id, PVector position, PVector dimensions){
    	println("initializing tuile: "+ id);
    	_refGestionnaireTuiles = refGestionnaireTuiles;
    	_id = id;
    	_position = position;
    	_dimensions = dimensions;
    	_banqueCouleurs = new BanqueCouleurs();
    	_backgroundColor  =_banqueCouleurs.getRandomColor();

    	generateCanvas();
	}

	public void update(){
		draw();
	}

	private void draw(){
		noStroke();
		image(_canvas, _position.x, _position.y);
	}

	private void drawBackground (){
		_canvas.beginDraw();
		_canvas.noStroke();
		_canvas.fill(_backgroundColor);
		_canvas.rect(0, 0, _dimensions.x, _dimensions.y);
		_canvas.endDraw();
	}

	private void drawCirclePattern(){
		_canvas.beginDraw();
		_canvas.noStroke();
		_canvas.fill(_banqueCouleurs.getRandomColor());
		for(int i = (int)_dimensions.x - PADDING; i>=0; i --){
			_canvas.fill(_banqueCouleurs.getMaybeLastColor());
			_canvas.ellipse(_dimensions.x/2, _dimensions.y/2, i, i);
		}
		_canvas.endDraw();
	}

	private void generateCanvas(){
		_canvas = createGraphics((int)_dimensions.x, (int)_dimensions.y);
		drawBackground();
		drawCirclePattern();
		println("created canvas");	
	}
}
