import { get_random_number, array_has_duplicates } from "./utils";
import type { BooleansData } from "./interfaces";

function run_cycle(num_roll: number): boolean {
  const result = [];

  for (let i = 0; i < num_roll; i++) {
    const num = get_random_number(1, 365);
    result.push(num);
  }

  return array_has_duplicates(result);
}

function cycle_runner(num_cycle: number, num_roll: number): BooleansData {
  let total_true = 0;
  let total_false = 0;

  for (let i = 0; i < num_cycle; i++) {
    const cycle = run_cycle(num_roll);
    if (cycle == true) total_true++;
    if (cycle == false) total_false++;
  }

  return {
    true: total_true,
    false: total_false,
  };
}

export { cycle_runner };
