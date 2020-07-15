static final int SIZE = 16;
static final int NUM_GENERATIONS = 128;
static final int BOX_SIZE = 1;

boolean[][] cells = new boolean[NUM_GENERATIONS][SIZE*SIZE];

// int bool2int(boolean left, boolean center, boolean right) {
//   int res = 0;
//   res <<= 1;
//   res += left ? 1 : 0;
//   res <<= 1;
//   res += center ? 1 : 0;
//   res <<= 1;
//   res += right ? 1 : 0;
//   return res;
// }

// boolean automaton_old(boolean left, boolean center, boolean right) {
//   int m = bool2int(left, center, right);
//   final int b111 = 0b111;
//   final int b110 = 0b110;
//   final int b101 = 0b101;
//   final int b100 = 0b100;
//   final int b011 = 0b011;
//   final int b010 = 0b010;
//   final int b001 = 0b001;
//   final int b000 = 0b000;
//   switch(m) {
//   case b111:
//     return false;
//   case b110:
//     return false;
//   case b101:
//     return false;
//   case b100:
//     return true;
//   case b011:
//     return true;
//   case b010:
//     return true;
//   case b001:
//     return true;
//   case b000:
//     return false;
//   default:
//     return false;
//   }
// }

int[] genKernel2D(int x, int y, int size) {
  int[] res = new int[9];
  int left = (size + x - 1) % size;
  int right = (x + 1) % size;
  int top = ((size + y - 1) % size) * size;
  int bottom = ((y + 1) % size) * size;
  res[0] = top + left;
  res[1] = top + x;
  res[2] = top + right;
  res[3] = (y * size) + left;
  res[4] = (y * size) + x;
  res[5] = (y * size) + right;
  res[6] = bottom + left;
  res[7] = bottom + x;
  res[8] = bottom + right;
  return res;
}

int[] genKernel1D(int x, int size) {
  int[] res = new int[3];
  res[0] = (size + x - 1) % size;
  res[1] = x;
  res[2] = (x + 1) % size;
  return res;
}

int evalKernel(int[] kernel, boolean[] space) {
  int value = 0;
  for (int idx : kernel) {
    value = value << 1;
    value += space[idx] ? 1 : 0;
  }
  return value;
}

boolean automaton(int[] kernel, boolean[] space) {
  int value = evalKernel(kernel, space);
  final int b111 = 0b111;
  final int b110 = 0b110;
  final int b101 = 0b101;
  final int b100 = 0b100;
  final int b011 = 0b011;
  final int b010 = 0b010;
  final int b001 = 0b001;
  final int b000 = 0b000;
  switch(value) {
  case b111:
    return false;
  case b110:
    return false;
  case b101:
    return false;
  case b100:
    return true;
  case b011:
    return true;
  case b010:
    return true;
  case b001:
    return true;
  case b000:
    return false;
  default:
    return false;
  }
}

void reorientCamera(int generation) {
  camera(
    float(BOX_SIZE*SIZE)/2.0, float(BOX_SIZE*SIZE)*-2, float(BOX_SIZE*NUM_GENERATIONS)/2.0,
    float(BOX_SIZE*SIZE)/2.0, float(BOX_SIZE*SIZE)/2.0, float(BOX_SIZE*generation)/2.0,
    0, 0, -1
  );
}

void setup() {
  size(128, 128, P3D);
  frameRate(20);

  println("computing");
  for (int i = 0; i < SIZE * SIZE; i++) {
    cells[0][i] = int(random(0, 2)) == 1;
  }
  for (int plane = 1; plane < NUM_GENERATIONS; plane++) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        int[] kernel = genKernel2D(col, row, SIZE);
        boolean val = automaton2(kernel, cells[plane-1]);
        cells[plane][row * SIZE + col] = val;
      }
    }
  }
  println("done");
}

void draw() {
  int plane = (frameCount - 1) % NUM_GENERATIONS;
  if (plane == NUM_GENERATIONS - 1) {
    noLoop();
    return;
  }
  draw3D(plane);
  // noLoop();
}

void draw3D(int generation) {
  // println("generation: "+generation);
  reorientCamera(generation);
  background(128);
  for (int plane = 0; plane <= generation; plane++) {
    for (int row = 0; row < SIZE; row++) {
      for (int col = 0; col < SIZE; col++) {
        if (cells[plane][row*SIZE+col]) {
          pushMatrix();
          translate(BOX_SIZE * row, BOX_SIZE * col, BOX_SIZE * plane);
          box(BOX_SIZE);
          popMatrix();
        }
      }
    }
  }
}

void draw2D(int plane) {
  loadPixels();
  for (int row = 0; row < SIZE; row++) {
    for (int col = 0; col < SIZE; col++) {
      pixels[row*SIZE+col] = cells[plane][row*SIZE+col] ? color(0) : color(255);
    }
  }
  updatePixels();
}

// void keyPressed() {
//   if (key == ' ') {
//     loop();
//   }
// }
