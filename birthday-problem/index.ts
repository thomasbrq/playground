import type { BooleansData } from "./interfaces";
import { cycle_runner } from "./runner";
import { fg, donut } from "ervy";

const num_cycle = 1000;
const num_person = 23;

const r: BooleansData = cycle_runner(num_cycle, num_person);

const donut_data = [
  { key: "same birthday", value: r.true, style: fg("cyan", "s") },
  { key: "different birthday", value: r.false, style: fg("blue", "d") },
];

console.log(donut(donut_data, { left: 1 }));
