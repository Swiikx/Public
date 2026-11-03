import assert from "node:assert/strict";
import { test } from "node:test";

import { greet } from "./index.js";

test("greet avec un nom", () => {
  assert.equal(greet("Ada"), "Bonjour, Ada !");
});

test("greet sans argument", () => {
  assert.equal(greet(), "Bonjour, monde !");
});
