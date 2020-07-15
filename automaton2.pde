int sumBits(int value) {
  int number = 0;
  while (value > 0) {
    if (value % 2 > 0) {
      number += 1;
    }
    value = value >> 1;
  }
  return number;
}

boolean automaton2(int[] kernel, boolean[] space) {
  int value = evalKernel(kernel, space);
  int numBits = sumBits(value);
  return (numBits > 2) && (numBits < 8);
}
