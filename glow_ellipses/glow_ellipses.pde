import ddf.minim.analysis.*;
import ddf.minim.*;

//TOSC
import oscP5.*;
import netP5.*;
OscP5 oscP5;

float v_rotary1 = 0.0f;
float v_rotary2 = 0.0f;
float v_rotary3 = 0.0f;


int iGlowRad = 0;
int iGlowBlur = 0;

Minim minim;
AudioInput in;
FFT fft;

int w;


void setup() {
  size(800, 800, OPENGL);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(60, 7);

  oscP5 = new OscP5(this, 8000);



  stroke(255);
  colorMode(HSB, 255);
  background(0, 0, 0);
  //frameRate(24);
  smooth();


  w = width/fft.avgSize();
}

void draw() {
  float fade = v_rotary2 *30;
  fill(0, 0, 0, fade);
 // noStroke();
 // rect(0, 0, width, height);
  stroke(255);
  strokeWeight(2);
  
  println(frameRate);

  fft.forward(in.mix);

float glowRad = v_rotary1 * 8;
iGlowRad = int(glowRad);

float glowBlur = v_rotary3 * 8;
iGlowBlur = int(glowBlur);


  glow(iGlowRad, iGlowBlur);

  for (int i = 0; i < fft.avgSize() - 1; i++) {
    stroke(fft.getAvg(i)*80, 255, 255);
    //line(i * w, (height/2) + fft.getAvg(i)*20, (i+1) * w, (height/2) + fft.getAvg(i+1)*20);
    //line(i * w, (height/2) - fft.getAvg(i)*20, (i+1) * w, (height/2) - fft.getAvg(i+1)*20);
    if (fft.getAvg(i) > 0.3) {
      ellipse(width/2, height/2, i * w, i * w);
    }
  }
}

void oscEvent(OscMessage theOscMessage) {


  String addr = theOscMessage.addrPattern();
  float  val  = theOscMessage.get(0).floatValue();

  if (addr.equals("/1/rotary1")) {
    v_rotary1 = val;
  } else if (addr.equals("/1/rotary2")) {
    v_rotary2 = val;
  } else if (addr.equals("/1/rotary3")) {
    v_rotary3 = val;
  }

  //println(addr);
  //println(val);
}

