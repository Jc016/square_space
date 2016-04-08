BanqueCouleurs bc = new BanqueCouleurs();
color currentColor;
void setup(){
  size(800,800);
  frameRate(60);
  currentColor = bc.getRandomColor();
}

void draw(){
  fill(currentColor);
  noStroke();
  ellipse(width/2,height/2,400,400);
}

void mousePressed(){
	currentColor = bc.getRandomColor();
}
