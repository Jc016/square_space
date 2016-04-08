private final  int SUBSIVISIONS = 16;
GestionnaireTuiles gt;

void setup(){
	size(800, 800);
	frameRate(60);
	gt = new GestionnaireTuiles(width, height, SUBSIVISIONS);
}

void draw(){
	background(0);
	gt.update();
}


