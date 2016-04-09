private final  int SUBSIVISIONS = 16;
GestionnaireTuiles gt;

void setup(){
	size(800, 800);
	frameRate(30);
	gt = new GestionnaireTuiles(width, height, SUBSIVISIONS);
}

void draw(){
	gt.update();
}



