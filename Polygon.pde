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
