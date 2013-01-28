import processing.video.*;
Capture v;
int totalOffset = 0; //helper var for counting xOffset for each Letter obj
PImage flip; //buffer for horizontally flipped image
String fallingLetters = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam non aliquam ante. Nullam at ligula mi. Nam orci metus";
Letter[] letters; 
PFont font;
int fontSize = 32;
float thresh = 100; // brightness threshold, Use UP and DOWN to alter
float sampleFloor = 40; //stop sampling pixels 20 rows from the bottom
color activeColor = color (255,0,255);
color fallColor = color(20,100);


void setup() {
  size(1280,720);
  v = new Capture(this,width,height,30);
  flip = createImage(width,height,RGB);
  font = loadFont("UniversLTStd-LightCn-32.vlw");
  textFont(font,fontSize); 
  initLetters();
}

void draw() {
  v.read();
  v.loadPixels();
  flip.loadPixels();
  flipImage(); //flip the image
  v.updatePixels();
  image(flip,0,0);
  for(int i = 0; i < letters.length; i++) {
    letters[i].draw();
  }
  flip.updatePixels();

}

void initLetters() {
  letters = new Letter[fallingLetters.length()];
  for(int i = 0; i < letters.length; i++) {
        letters[i] = new Letter(i,totalOffset,fallingLetters.charAt(i));
        totalOffset+= textWidth(fallingLetters.charAt(i));
  }
}

void flipImage() {
  for(int y = 0; y < v.height; y++) {
    for(int x = 0; x < v.width; x++) {
      int i = y*v.width + x;
      int j = y*v.width + v.width-1-x;
      flip.pixels[j] = v.pixels[i];
    }
  }
}

void keyPressed() {
   if (keyCode == UP) thresh++;
   else if (keyCode == DOWN) thresh--;
   println(int(thresh));
}



