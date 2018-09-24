float dx;
float dy;
float dr;
float gyc = 100;
float gy;
PImage dog;
PImage dogear;
float dw = 383;
float dh = 118;
float df = 1;
boolean dwalk = false;
int stepAni = 0;
int anLen = 20;
float dyv = 0;
float dxv = 0;

boolean[] keys = new boolean[255];

void keyPressed() {

  if (keys.length-1<key) {
    keys=expand(keys, key+1);
  }
  keys[key]=true;
}
void keyReleased() {
  if (!keyPressed) {
    if (keys.length-1<key) {
      keys=expand(keys, key+1);
    }
    keys[key]=false;
  }
}

void leftStep() {
  if(stepAni == anLen){
    dxv = -4;
    dyv = -2.1;
  }
  if (stepAni > 0) {

    stepAni--;
  } else {
    dwalk = false;
  }
  if(stepAni >= anLen*0.5){
    dr+=(PI/15)/(anLen*0.5);  
  } else {
    dr-=(PI/15)/(anLen*0.5);
  }
  
  dxv+= 1/(anLen);
  dyv+= 2.1/(anLen/2);
 
  dx += dxv;
  dy += dyv;
}
void rightStep() {
  if(stepAni == anLen){
    dxv = 4;
    dyv = -2.1;
  }
  if (stepAni > 0) {

    stepAni--;
  } else {
    dwalk = false;
  }
  if(stepAni >= anLen*0.5){
    dr+=(PI/15)/(anLen*0.5);  
  } else {
    dr-=(PI/15)/(anLen*0.5);
  }
  dxv-= 1/(anLen);
  dyv+= 2.1/(anLen/2);
 
  dx += dxv;
  dy += dyv;
}

void setup() {
  size(1500, 1200);
  gy = height-gyc;
  dx = width/2;

  dog = loadImage("dog.png");
  dogear = loadImage("dogear.png");
  dy = gy-(dh/2);
}

void draw() {
  imageMode(CENTER);
  background(255, 0, 0);
  pushMatrix();
  translate(dx, dy);
  scale(df, 1);
  rotate(dr);
  if(stepAni <= anLen*0.9 && stepAni >= anLen*0.25){
    image(dogear, 0, -26, dw, 170); 
  } else {
    image(dog, 0, 0, dw, dh);
  }
  popMatrix();
  rect(0, gy, width, gyc);
  if (keyPressed) {
    if (key == 'a' && !dwalk) {
      dx--;
      df = 1;
      dwalk = true;
      stepAni = anLen;
    } else if (key == 'd' && !dwalk) {
      dx++;
      df = -1;
      dwalk = true;
      stepAni = anLen;
    }
  }


  if (stepAni > 0) {
    if (df < 0) {
      rightStep();
    }
    if (df > 0) {
      leftStep();
    }
  } else {
   dwalk = false; 
  }

  println(stepAni);
  if(dy > gy-(dh/2)){
   dy = gy-(dh/2); 
  }
}