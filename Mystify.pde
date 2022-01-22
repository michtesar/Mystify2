Scene scene;

class Scene {
  Polygon[] polygons;
  ShadowBuffer[] shadows;

  Scene(int nPolygons) {
    polygons = new Polygon[nPolygons];
    shadows = new ShadowBuffer[nPolygons];
    for (int i = 0; i < nPolygons; i++) {
      polygons[i] = new Polygon();
      shadows[i] = new ShadowBuffer();
    }
  }

  void run() {
    for (int i = 0; i < polygons.length; i++) {
      polygons[i].update();
      polygons[i].show();
      shadows[i].add(polygons[i]);
      shadows[i].show();
    }
  }
}


class Polygon {
  int nVertices = 4;
  int thickness = 2;
  float maxSpeed = 10.0;

  PVector[] vertices = new PVector[nVertices];
  PVector[] velocity = new PVector[nVertices];
  color lineColor = color(random(255), random(255), random(255), 255);

  Polygon() {
    getRandomVertices();
    getRandomVelocities();
  }

  void getRandomVertices() {
    for (int i = 0; i < nVertices; i++) {
      vertices[i] = new PVector(random(width), random(height));
    }
  }

  void getRandomVelocities() {
    for (int i = 0; i < nVertices; i++) {
      velocity[i] = new PVector(random(1.0, maxSpeed), random(1.0, maxSpeed));
    }
  }

  boolean isOutsideScreenX(int i) {
    if ((vertices[i].x > width) || (vertices[i].x < 0)) {
      return true;
    } else {
      return false;
    }
  }

  boolean isOutsideScreenY(int i) {
    if ((vertices[i].y > height) || (vertices[i].y < 0)) {
      return true;
    } else {
      return false;
    }
  }

  void updateVertex(int i) {
    if (isOutsideScreenX(i)) {
      velocity[i].x *= -1.0;
    }
    if (isOutsideScreenY(i)) {
      velocity[i].y *= -1.0;
    }
    vertices[i].x += sin(velocity[i].x) * maxSpeed;
    vertices[i].y += cos(velocity[i].y) * velocity[i].y;
  }

  void update() {
    for (int i = 0; i < nVertices; i++) {
      updateVertex(i);
    }
  }

  void show() {
    strokeWeight(thickness);
    stroke(lineColor);
    for (int i = 1; i < nVertices; i++) {
      line(vertices[i-1].x, vertices[i-1].y, vertices[i].x, vertices[i].y);
    }
    line(vertices[nVertices-1].x, vertices[nVertices-1].y, vertices[0].x, vertices[0].y);
  }
}

class Shadow {
  int thickness;
  color lineColor;
  int nVertices;
  PVector[] vertices;

  Shadow(Polygon polygon) {
    thickness = polygon.thickness;
    lineColor = polygon.lineColor;
    nVertices = polygon.nVertices;

    vertices = new PVector[nVertices];
    for (int i = 0; i < nVertices; i++) {
      vertices[i] = new PVector(polygon.vertices[i].x, polygon.vertices[i].y);
    }
  }

  void show(int alpha) {
    strokeWeight(thickness);
    stroke(red(lineColor), green(lineColor), blue(lineColor), alpha);
    for (int i = 1; i < nVertices; i++) {
      line(vertices[i-1].x, vertices[i-1].y, vertices[i].x, vertices[i].y);
    }
    line(vertices[nVertices-1].x, vertices[nVertices-1].y, vertices[0].x, vertices[0].y);
  }
}

class ShadowBuffer {
  int n = 75;
  int nth = 5;
  int head = 0;
  Shadow[] buffer = new Shadow[n];

  boolean isBufferFull() {
    if (head > n-1) {
      return true;
    }
    return false;
  }

  void moveBufferByOne(Polygon polygon) {
    // FIXME: Problem with comming from normal to circular buffer
    if (head < n) {
      return;
    }
    Shadow[] newBuffer = new Shadow[n];
    newBuffer[0] = new Shadow(polygon);
    for (int i = 1; i < n; i++) {
      newBuffer[i] = buffer[i-1];
    }
    buffer = newBuffer;
  }

  void add(Polygon polygon) {
    if (isBufferFull()) {
      moveBufferByOne(polygon);
      //head = n;
    } else {
      buffer[head] = new Shadow(polygon);
      head++;
    }
  }

  void show() {
    for (int i = 0; i < head; i = i+nth) {
      buffer[i].show(255/2 - i);
    }
  }
}

void setup() {
  frameRate(60);
  fullScreen(P2D);
  scene = new Scene(2);
}

void draw() {
  background(0);
  scene.run();
}
