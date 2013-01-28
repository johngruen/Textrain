class Letter {
 int index; //just a good thing to know, used for debugging
 int xOffset; //offset horizontally of letter registration
 float speed; //speed
 char c; //what letter am i
 float curYPos, prevYPos; //current and previous y position. used for easing.
 int state = 0; // we use a tiny state switcher to control the flow. either the letter is falling or it isn't
 float topBrightPixel;//get top bright pixel;
 
Letter(int index_,int xOffset_,char c_) {
  index = index_;
  xOffset = xOffset_;
  c = c_;
  curYPos = int(random(-200,-100));//set currentYPos somewhere above the video
  speed = int(random(5,12));
} 

void draw() {
   senseBrightness();
   compareToCurrent();
   update();
   text(c,xOffset,curYPos); 
}

void senseBrightness() {
  topBrightPixel = 0;
  for(int i = xOffset; i < flip.pixels.length-flip.width*sampleFloor; i+=flip.width) {
    if(brightness(flip.pixels[i]) < thresh) { 
      break;
   }
   topBrightPixel++;
  }
}

void compareToCurrent() {
   if (topBrightPixel > curYPos + 2*speed || topBrightPixel >= flip.height - sampleFloor) {
     state = 0;
     //speed = random(5,12);
   } else {
     state = 1;
   }
}

void update() {      
    switch (state) {
      case 0:
        fill (fallColor);
        curYPos+=speed;
        speed = speed * 1.02;
        if (curYPos > height + 50)  {
          curYPos = random(-50,-200);
          speed = random(5,12);
        }
        break;
      case 1:
        fill(activeColor);
        curYPos += .6* (topBrightPixel - prevYPos);
        speed = random(5,12);
        break;
    }
      prevYPos = curYPos;
 }

}

