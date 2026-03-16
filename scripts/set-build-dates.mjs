// Compute FROM_DATE and TO_DATE at build time, then run the given command.
// FROM_DATE = 1 month ago, TO_DATE = 6 months from now.
import { execSync } from "node:child_process";

const now = new Date();
const from = new Date(now);
from.setMonth(from.getMonth() - 1);
const to = new Date(now);
to.setMonth(to.getMonth() + 6);

const fmt = (d) => d.toISOString().slice(0, 10) + " 00:00";

process.env.FROM_DATE = process.env.FROM_DATE || fmt(from);
process.env.TO_DATE = process.env.TO_DATE || fmt(to);

const command = process.argv.slice(2).join(" ") || "elm-constants && elm-pages build";
execSync(command, { stdio: "inherit", env: process.env });
