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

Cell automaton2(int[] neighborhood, Cell[] space) {
  int value = evalNeighborhood(neighborhood, space);
  int numBits = sumBits(value);
  boolean alive = (numBits > 3) && (numBits < 8);
  int age = 0;
  if (alive) {
    int previousIndex = neighborhood[neighborhood.length/2+1];
    Cell previousCell = space[previousIndex];
    age = previousCell.age() + 1;
  }
  return new Cell(alive, age, numBits);
}
