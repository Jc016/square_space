class Tuile {

	private final int PADDING = 8, DYING_DURATION = 2500;
	private final float ROTATION_RESISTANCE = 0.001, FORCE_RESISTANCE= 0.99;
	private PGraphics _canvas;
	private PVector _originalPosition, _position, _dimensions, _endPosition, _speed, _acceleration;
	private float _rotationAngle, _rotationSpeed, _rotationAcceleration;
	private float _opacity;
	private BanqueCouleurs _banqueCouleurs;
	private color _backgroundColor;
	private GestionnaireTuiles _refGestionnaireTuiles;
	private int _dyingElapsedTime, _startedDyingTime;
	private boolean _isDying;

    Tuile(GestionnaireTuiles refGestionnaireTuiles, PVector position, PVector dimensions){
    	_refGestionnaireTuiles = refGestionnaireTuiles;
    	_position = position;
    	_dimensions = dimensions;
    	init();
	}

    Tuile(GestionnaireTuiles refGestionnaireTuiles, TuileTemplate tuileTemplate){
    	_refGestionnaireTuiles = refGestionnaireTuiles;
    	_position = tuileTemplate.getPosition();
    	_dimensions = tuileTemplate.getDimensions();
    	init();
	}

	private void init(){
    	_originalPosition = _position.copy();
    	_rotationAngle = 0;
    	_opacity = 255;
    	_dyingElapsedTime=0;
    	_startedDyingTime = 0;
    	processEndPosition();
    	resetSpeed();
    	resetAcceleration();
    	resetRotationSpeed();
    	resetRotationAcceleration();
    	_banqueCouleurs = new BanqueCouleurs();
    	_backgroundColor  =_banqueCouleurs.getRandomColor();
    	_isDying = false;
    	generateCanvas();
	}

	public void update(){
		if(_isDying)
			processDeath();
		else
			checkIfDyingBegan();
		processForces();
		draw();
	}

	private void draw(){
		noStroke();
		pushMatrix();
		translate(_position.x + _dimensions.x/2, _position.y + _dimensions.y/2);
		rotate(_rotationAngle);
		tint(255, _opacity); 
		image(_canvas, -_dimensions.x/2, -_dimensions.y/2) ;
		popMatrix();
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
	}

	public void sendForceToProcess (ForceAlterationTuiles forceAlterationTuiles){
		if(forceIsValid(forceAlterationTuiles)){
			_acceleration = forceAlterationTuiles.getForce();
			_rotationAcceleration = forceAlterationTuiles.getRotationForce();
		}
	}

	private boolean pointInTuile(PVector point){
		return point.x >= _position.x && point.x <= _endPosition.x && point.y >= _position.y && point.y <= _endPosition.y ? true : false ;
	};
	
	private void processEndPosition(){
		_endPosition = PVector.add(_position, _dimensions);
	}

	private boolean forceIsValid(ForceAlterationTuiles forceAlterationTuiles){
		return pointInTuile(forceAlterationTuiles.getOrigin()) || pointInTuile(forceAlterationTuiles.getEnd()) ? true : false ;
	}

	private void resetSpeed(){
		_speed = new PVector();
	}

	private void resetAcceleration(){
		_acceleration = new PVector();
	}

	private void resetRotationSpeed(){
		_rotationSpeed = 0;
	}

	private void resetRotationAcceleration(){
		_rotationAcceleration = 0;
	}

	private void processForces(){
		_speed.add(_acceleration);
		_speed.mult(FORCE_RESISTANCE);
		_position.add(_speed);
		_rotationSpeed += _rotationAcceleration;
		_rotationAngle += _rotationSpeed;
		if(_rotationSpeed >= 0)
			_rotationSpeed = constrain(_rotationSpeed - ROTATION_RESISTANCE, 0,  _rotationSpeed);
		else
			_rotationSpeed = constrain(_rotationSpeed + ROTATION_RESISTANCE, _rotationSpeed, 0);
		
		resetAcceleration();
		resetRotationAcceleration();
	}

	private void processOpacity(){
		_opacity = map(_dyingElapsedTime, 0,  DYING_DURATION, 255, 0);
	}

	private void processDeath(){
		_dyingElapsedTime = millis() - _startedDyingTime;
		processOpacity();
		checkIfDead();
	}

	private void checkIfDyingBegan(){
		if(PVector.dist(_originalPosition, _position) != 0 || _rotationAngle != 0)
			initDying();
		
	}

	private void initDying(){
		_isDying = true;
		_startedDyingTime = millis();
	}

	private void checkIfDead(){
		if(_dyingElapsedTime > DYING_DURATION)
			_refGestionnaireTuiles.deleteTuile(this);
	}

	public TuileTemplate exportToTemplate(){
		return new TuileTemplate(_originalPosition.copy(), _dimensions.copy());
	}

}
