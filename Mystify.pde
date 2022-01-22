/* Mystify2

An educational remake of famous screen saver from the 90s
in Java implementation of Processing toolbox.

MIT License
Michael Tesar 
2022, Amsterdam
*/
private final int FPS = 60;
private final int N_OBJECTS = 3;

Scene scene;

void setup() {
  frameRate(FPS);
  fullScreen(P2D);
  scene = new Scene(N_OBJECTS);
}

void draw() {
  background(0);
  scene.run();
}
