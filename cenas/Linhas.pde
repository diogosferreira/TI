void detetaPincel() {
  float Min = 500; 
  float cX = 0;
  float cY = 0;


  if (video.available()) {
    video.read();
    video.loadPixels(); 

    //pushMatrix();
    //scale(-1, 1);
    //image(video,  -video.width/1.3, 0, video.width, height); // Draw the webcam video onto the screen
    //popMatrix();

    int index = 0;
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {
        // Get the color stored in the pixel

        color current = video.pixels[index];
        float rc = red(current);
        float gc = green(current);
        float bc = blue(current);
        float rt = red(track);
        float gt = green(track);
        float bt = blue(track);

        //Euclidean distance to color
        float d = dist(rc, gc, bc, rt, gt, bt);

        if (d < Min) {
          Min = d;
          cX = x;
          cY = y;
        }
        index++;
      }
    }

    fill(255, 204, 0, 128);
    noStroke();
    ellipse(video.width/1.3-cX, cY, 20, 20);

    //stroke(0);
    //strokeWeight(4);
    //vertex(video.width/1.3-cX, cY);

    x_list.add(video.width/1.3-cX);
    y_list.add(cY);
  }
}

void desenha(int transp) {
  beginShape();
  for ( int i=0; i<x_list.size(); i++) { 
    noFill();
    strokeWeight(4);
    stroke(0, transp);
    curveVertex(x_list.get(i), y_list.get(i));
  }
  endShape();
}