/* Representation of Mystify2 scene */
class Scene {
  // All available polygons in scene
  Polygon[] polygons;
  // All appropriate shadows that are casted
  ShadowBuffer[] shadows;

  // Scene contructor
  Scene(int nPolygons) {
    polygons = new Polygon[nPolygons];
    shadows = new ShadowBuffer[nPolygons];
    for (int i = 0; i < nPolygons; i++) {
      polygons[i] = new Polygon();
      shadows[i] = new ShadowBuffer();
    }
  }

  // Main run function
  void run() {
    for (int i = 0; i < polygons.length; i++) {
      polygons[i].update();
      polygons[i].show();
      shadows[i].add(polygons[i]);
      shadows[i].show();
    }
  }
}
