class Cell {
  private boolean alive;
  private int age = 0;
  private int neighbors = 0;

  Cell() {
    this.alive = false;
    this.age = 0;
    this.neighbors = 0;
  }

  Cell(boolean alive, int age, int neighbors) {
    this.alive = alive;
    this.age = age;
    this.neighbors = neighbors;
  }

  int age() {
    return this.age;
  }

  int neighbors() {
    return this.neighbors;
  }

  boolean alive() {
    return this.alive;
  }

  int fill() {
    colorMode(HSB, 360, 100, 100);
    int hue = (120 + this.neighbors * 12) % 360;
    color val = color(hue, 90, 90);
    colorMode(RGB, 255, 255, 255);
    return val;
  }
}
