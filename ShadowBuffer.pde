/* Shadow buffer that holds a full trajecotry of the
 polygons and visualize only each nth shadow from the
 buffer of the size of n. */
class ShadowBuffer {
  int n = 75;
  int nth = 5;
  int head = 0;

  // Actual buffer
  Shadow[] buffer = new Shadow[n];

  // Check if buffer is full of not
  boolean isBufferFull() {
    if (head > n-1) {
      return true;
    }
    return false;
  }


  // Method for appending to empty buffer
  void appendToEmptyBuffer(Polygon polygon) {
    buffer[head] = new Shadow(polygon);
    head++;
  }

  // Method for appending to full buffer
  void appendToFullBuffer(Polygon polygon) {
    Shadow[] newBuffer = new Shadow[n];
    for (int i=0; i < n-1; i++) {
      newBuffer[i] = buffer[i+1];
    }
    newBuffer[n-1] = new Shadow(polygon);
    buffer = newBuffer;
  }

  // Injector method for adding a new polygon
  void add(Polygon polygon) {
    if (isBufferFull()) {
      appendToFullBuffer(polygon);
    } else {
      appendToEmptyBuffer(polygon);
    }
  }

  // Main show method
  void show() {
    for (int i = 0; i < head; i = i+nth) {
      buffer[i].show(255/2 - i);
    }
  }
}
