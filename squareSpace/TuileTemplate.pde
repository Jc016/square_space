class TuileTemplate{
	
	PVector _position, _dimensions;
	TuileTemplate(PVector position, PVector dimensions){
		_position = position;
		_dimensions = dimensions;
	}

	public PVector getPosition(){
		return _position;
	}

	public PVector getDimensions(){
		return _dimensions;
	}
}