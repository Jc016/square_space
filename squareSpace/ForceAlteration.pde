class ForceAlterationTuiles{
	private PVector _origin, _end, _force;
	ForceAlterationTuiles(){
		reset();
	}

	public void recordForce(PVector origin, PVector end){
		_origin = origin;
		_end = end;
		_force = PVector.sub(_end, _origin);
	}

	public void reset(){
		_origin = new PVector(0,0);
		_end = new PVector(0,0);
	}

	public getOrigin(){
		return _origin;
	}

	public getEnd(){
		return _end;
	}

}