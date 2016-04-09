class ForceAlterationTuiles{
	
	private final float FORCE_SENSIBILITY = 0.05, ROTATION_FORCE_SENSIBILITY = 0.03;
	private PVector _origin, _end, _force;
	float  _rotationForce;
	ForceAlterationTuiles(){
		reset();
	}

	public void recordForce(PVector origin, PVector end){
		_origin = origin;
		_end = end;
		_force = PVector.sub(_end, _origin).mult(FORCE_SENSIBILITY);
		_rotationForce = _force.x * ROTATION_FORCE_SENSIBILITY;
	}

	public void reset(){
		_origin = new PVector();
		_end = new PVector();
		_force = new PVector();
	}

	public PVector getOrigin(){
		return _origin.copy();
	}

	public PVector getEnd(){
		return _end.copy();
	}

	public PVector getForce(){
		return _force.copy();
	}

	public float getRotationForce(){
		return _rotationForce;
	}

}