class BanqueCouleurs{
  private final color[] COLORS_BANK_ARRAY = {#150501, #FFFDFC, #5AB1E5, #23CDDB, #25CBA9, #E0A524, #E07726, #E0D126,  #7E2222, #F05429};
  private color _lastColor;
  private int _lastColorIndex;
  private final int  NUMBER_OF_COLOR = COLORS_BANK_ARRAY.length;
  BanqueCouleurs(){
	_lastColor = COLORS_BANK_ARRAY[0];
	_lastColorIndex = 0;
  }

  public color getRandomColor(){
  	_lastColorIndex = (int)random(NUMBER_OF_COLOR);
  	_lastColor = COLORS_BANK_ARRAY[_lastColorIndex];
  	return _lastColor;
  }

  public color getLastColor(){
  	return COLORS_BANK_ARRAY[_lastColorIndex];
  }

  public color getNeighborsOfLastColor(){
  	_lastColorIndex = (_lastColorIndex + 1) % NUMBER_OF_COLOR;
  	return COLORS_BANK_ARRAY[_lastColorIndex];
  }

}
