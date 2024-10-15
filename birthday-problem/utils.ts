function get_random_number(min: number, max: number): number {
  const min_ceiled = Math.ceil(min);
  const max_floored = Math.floor(max);

  return Math.floor(
    Math.random() * (max_floored - min_ceiled + 1) + min_ceiled,
  );
}

function array_has_duplicates(array: number[]): boolean {
  return array.some((val: number, i: number) => array.indexOf(val) !== i);
}

export { get_random_number, array_has_duplicates };
