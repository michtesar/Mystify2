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

  void appendToEmptyBuffer(Polygon polygon) {
    buffer[head] = new Shadow(polygon);
    head++;
  }

  void appendToFullBuffer(Polygon polygon) {
    Shadow[] newBuffer = new Shadow[n];
    for (int i=0; i < n-1; i++) {
      newBuffer[i] = buffer[i+1];
    }
    newBuffer[n-1] = new Shadow(polygon);
    buffer = newBuffer;
  }

  void add(Polygon polygon) {
    if (isBufferFull()) {
      appendToFullBuffer(polygon);
    } else {
      appendToEmptyBuffer(polygon);
    }
  }

  void show() {
    for (int i = 0; i < head; i = i+nth) {
      buffer[i].show(255/2 - i);
    }
  }
}
