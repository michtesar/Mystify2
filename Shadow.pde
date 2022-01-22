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
