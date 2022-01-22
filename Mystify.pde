Scene scene;

void setup() {
  frameRate(60);
  fullScreen(P2D);
  scene = new Scene(3);
}

void draw() {
  background(0);
  scene.run();
}
