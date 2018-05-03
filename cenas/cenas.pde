
import processing.video.*;
import processing.serial.*;

Serial myPort;
String val=null;

Capture video;
color track = color(35, 167, 191);

int transp = 0; //0:sem_cor 255:opaco
ArrayList<Float> x_list = new ArrayList();
ArrayList<Float> y_list = new ArrayList();

int textSize = 100;
ArrayList<Float> type_x = new ArrayList();
ArrayList<Float> type_y = new ArrayList();

void setup() {

  printArray(Serial.list());
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 
  myPort.clear();
  myPort.bufferUntil('\n');

  textFont(createFont("HelveticaLTStd-Bold.otf", textSize));
  size(495, 700);
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, 1280, 720);
  video.start();  
  noStroke();
  smooth();
}

void draw() {
  detetaPincel();

  background(255); 
  desenha(transp);
  if (type_x.size()>=1) {
    for (int i = 0; i < type_x.size(); i++) {
      desenhaletra(type_x.get(i), type_y.get(i));
    }
  }
}

void keyPressed() {
  if ( key == 'd' || key == 'D' ) {
    //apagar tudo e desenhar outra coisa
    x_list = new ArrayList();
    y_list = new ArrayList();
    type_x = new ArrayList();
    type_y = new ArrayList();
  } else if ( key == 'c' ) {
    type_x.add(x_list.get(x_list.size()-1));
    type_y.add(y_list.get(y_list.size()-1));
  }
}

void adicionaTexto(){
      type_x.add(x_list.get(x_list.size()-1));
      type_y.add(y_list.get(y_list.size()-1));
}

void desenhaletra(float x, float y) {
  textAlign(CENTER, CENTER);
  fill(0);
  text("c", x, y);
}

void serialEvent(Serial myPort) {
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  if (myPort.available()>0) val = myPort.readString();

  if (val!=null) {
    //Important, because it may fail on the first reads
    String[] list = split(trim(val), '\n');
    transp = parseInt(list[0]);
    if (transp!=0) {
      adicionaTexto();
    }
  }
}