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
