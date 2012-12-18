//TOSC
import oscP5.*;
import netP5.*;
OscP5 oscP5;

float v_push1 = 0.0f;

float bpm = 0;
float duration0 = 0;
float duration1 = 0;
float duration2 = 0;
float duration3 = 0;
float time0 = 0;
float time1 = 0;

void setup() {
  size (50, 50);
  oscP5 = new OscP5(this, 8000);
}

void draw() {
  if (keyPressed == true || v_push1 == 1.0f) {
    time1 = time0;
    time0 = millis();
    if (abs(time0 - time1) > 2000) {
      duration0 = 0;
      duration1 = 0;
      duration2 = 0;
      duration3 = 0;
      println ("0");
    } 
    else {
      if (abs(time0 - time1) > 100) {
        duration3 = duration2;
        duration2 = duration1;
        duration1 = duration0;
        duration0 = time1 - time0;
        if (duration1 == 0 || duration2 == 0 || duration3 == 0) {
          bpm = 0;
        } 
        else {
          bpm = 1000 * (60 / (abs((duration0 + duration1 + duration2 + duration3)/4)));
          println (bpm);
        }
      }
    }
  }
}

void oscEvent(OscMessage theOscMessage) {


  String addr = theOscMessage.addrPattern();
  float  val  = theOscMessage.get(0).floatValue();
  
  if(addr.equals("/2/push1") || addr.equals("/2/push2")) {v_push1 = val;}
  
  //println(addr);
  //println(val);
}
