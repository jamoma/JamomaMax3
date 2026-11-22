# Milestone 1 conformance results

Run of `conformance/m1-tests.txt` (the 82 old `j.parameter` integration tests) in Max 9 on macOS arm64, with
`scripts/run-maxtests.sh`. **78 of 82 pass.** Own Max tests (`conformance/own-tests.txt`): 5 of 5 pass.
Other checks: 177 core unit tests pass (also under ThreadSanitizer and under AddressSanitizer/UndefinedBehaviorSanitizer, no reports);
all seven help patchers open without missing objects; the reference pages match the implemented attributes and
messages; Max quits by itself with live models, parameters and running ramps and writes no crash report
(`scripts/max-smoke.sh tests/smoke/quit_live_objects`).

This is one complete run, made after the fixes from the final review, with no Max crash.

## Not passing, with the cause

| Test | Cause |
|---|---|
| `j.parameter/type_array/dataspace/j_parameter_type_array_dataspace_aed2xyz.maxtest.maxpat` | needs `j.unit` (milestone 2 or later) |
| `j.parameter/type_array/dataspace/j_parameter_type_array_dataspace_xyz2aed.maxtest.maxpat` | needs `j.unit` (milestone 2 or later) |
| `j.parameter/type_array/ramp_dataspace/j_parameter_type_array_ramp_and_dataspace.maxtest.maxpat` | needs `j.unit` (milestone 2 or later) |
| `j.parameter/type_integer/repetitions/j_parameter_type_integer_repetition_receive_symbols.maxtest.maxpat` | a standalone `j.parameter` should output once from initialisation (the test counts three outputs, we give two); cause not established, hypothesis: the old object initialises itself when there is no model. Open item. |

## All results

| Test | Result | Detail |
|---|---|---|
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_both.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_fold.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_high.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_low.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_none.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/clipmode/j_parameter_type_array_clipmode_wrap.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_array/dataspace/j_parameter_type_array_dataspace_aed2xyz.maxtest.maxpat` | FAIL | failed: Jamoma/Modular/j.parameter/type_array/dataspace/aed2xyz_2, Jamoma/Modular/j.parameter/type_array/dataspace/aed2x |
| `j.parameter/type_array/dataspace/j_parameter_type_array_dataspace_no_unit.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_array/dataspace/j_parameter_type_array_dataspace_xyz2aed.maxtest.maxpat` | FAIL | failed: Jamoma/Modular/j.parameter/type_array/dataspace/xyz2aed_2, Jamoma/Modular/j.parameter/type_array/dataspace/xyz2a |
| `j.parameter/type_array/default_attr_value/j.parameter_type_array_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_array/default_attr_value/j.parameter_type_array_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_array/default_attr_value/j.parameter_type_array_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_array/default_attr_value/j.parameter_type_array_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_array/default_attr_value/j.parameter_type_array_default_attr_value_value.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_array/messages/j.parameter_type_array_messages.maxtest.maxpat` | PASS | 12 assertions |
| `j.parameter/type_array/ramp/j_parameter_type_array_ramp_and_clipmode.maxtest.maxpat` | PASS | 5 assertions |
| `j.parameter/type_array/ramp/j_parameter_type_array_ramp_correct_value_and_timing.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_array/ramp_dataspace/j_parameter_type_array_ramp_and_dataspace.maxtest.maxpat` | FAIL | failed: Jamoma/Modular/j.parameter/type_array/ramp_and_dataspace/overriding_unit |
| `j.parameter/type_array/repetitions/j_parameter_type_array_repetition_receive_decimals.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_array/repetitions/j_parameter_type_array_repetition_receive_integers.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_array/repetitions/j_parameter_type_array_repetition_receive_lists.maxtest.maxpat` | PASS | 6 assertions |
| `j.parameter/type_array/repetitions/j_parameter_type_array_repetition_receive_symbols.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_boolean/default_attr_value/j.parameter_type_boolean_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_boolean/default_attr_value/j.parameter_type_boolean_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_boolean/default_attr_value/j.parameter_type_boolean_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_boolean/default_attr_value/j.parameter_type_boolean_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_boolean/default_attr_value/j.parameter_type_boolean_default_attr_value_value.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_boolean/j.parameter_type_boolean_messages.maxtest.maxpat` | PASS | 10 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_both.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_fold.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_high.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_low.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_none.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/clipmode/j_parameter_type_decimal_clipmode_wrap.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_decimal/dataspace/j_parameter_type_decimal_dataspace_linear2midi.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_decimal/dataspace/j_parameter_type_decimal_dataspace_midi2db.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_decimal/dataspace/j_parameter_type_decimal_dataspace_no_unit.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_decimal/default_attr_value/j.parameter_type_decimal_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_decimal/default_attr_value/j.parameter_type_decimal_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_decimal/default_attr_value/j.parameter_type_decimal_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_decimal/default_attr_value/j.parameter_type_decimal_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_decimal/default_attr_value/j.parameter_type_decimal_default_attr_value_value.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_decimal/messages/j.parameter_type_decimal_messages.maxtest.maxpat` | PASS | 11 assertions |
| `j.parameter/type_decimal/ramp/j_parameter_type_decimal_ramp_and_clipmode.maxtest.maxpat` | PASS | 5 assertions |
| `j.parameter/type_decimal/ramp/j_parameter_type_decimal_ramp_correct_value_and_timing.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_decimal/ramp_dataspace/j_parameter_type_decimal_ramp_and_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_decimal/repetitions/j_parameter_type_decimal_repetition_receive_decimals.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_decimal/repetitions/j_parameter_type_decimal_repetition_receive_integers.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_decimal/repetitions/j_parameter_type_decimal_repetition_receive_lists.maxtest.maxpat` | PASS | 6 assertions |
| `j.parameter/type_decimal/repetitions/j_parameter_type_decimal_repetition_receive_symbols.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_generic/default_attr_value/j.parameter_type_generic_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_generic/default_attr_value/j.parameter_type_generic_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_generic/default_attr_value/j.parameter_type_generic_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_generic/default_attr_value/j.parameter_type_generic_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_generic/default_attr_value/j.parameter_type_generic_default_attr_value_value.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_both.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_fold.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_high.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_low.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_none.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/clipmode/j_parameter_type_integer_clipmode_wrap.maxtest.maxpat` | PASS | 4 assertions |
| `j.parameter/type_integer/dataspace/j_parameter_type_integer_dataspace_linear2midi.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_integer/dataspace/j_parameter_type_integer_dataspace_midi2db.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_integer/dataspace/j_parameter_type_integer_dataspace_no_unit.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_integer/default_attr_value/j.parameter_type_integer_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_integer/default_attr_value/j.parameter_type_integer_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_integer/default_attr_value/j.parameter_type_integer_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_integer/default_attr_value/j.parameter_type_integer_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_integer/default_attr_value/j.parameter_type_integer_default_attr_value_value.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_integer/messages/j.parameter_type_integer_messages.maxtest.maxpat` | PASS | 10 assertions |
| `j.parameter/type_integer/ramp/j_parameter_type_integer_ramp_and_clipmode.maxtest.maxpat` | PASS | 5 assertions |
| `j.parameter/type_integer/ramp/j_parameter_type_integer_ramp_correct_value_and_timing.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_integer/ramp_dataspace/j_parameter_type_integer_ramp_and_dataspace.maxtest.maxpat` | PASS | 1 assertions |
| `j.parameter/type_integer/repetitions/j_parameter_type_integer_repetition_receive_decimals.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_integer/repetitions/j_parameter_type_integer_repetition_receive_integers.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_integer/repetitions/j_parameter_type_integer_repetition_receive_lists.maxtest.maxpat` | PASS | 6 assertions |
| `j.parameter/type_integer/repetitions/j_parameter_type_integer_repetition_receive_symbols.maxtest.maxpat` | FAIL | failed: Jamoma/Modular/j.parameter/type_integer/msg_symbol/repetitions_filter/0 |
| `j.parameter/type_string/default_attr_value/j.parameter_type_string_default_attr_value_dataspace.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_string/default_attr_value/j.parameter_type_string_default_attr_value_others.maxtest.maxpat` | PASS | 7 assertions |
| `j.parameter/type_string/default_attr_value/j.parameter_type_string_default_attr_value_ramp.maxtest.maxpat` | PASS | 3 assertions |
| `j.parameter/type_string/default_attr_value/j.parameter_type_string_default_attr_value_range.maxtest.maxpat` | PASS | 2 assertions |
| `j.parameter/type_string/default_attr_value/j.parameter_type_string_default_attr_value_value.maxtest.maxpat` | PASS | 2 assertions |

## What remains of the 22 objects used by the pass-bar set

Implemented now: `j.parameter`, `j.message`, `j.return`, `j.model`, `j.init`, `j.savebang` (and `j.pass`, used by the test helpers).
Remaining and where they belong (`docs/inventory/coverage-baseline.md`): `j.send`, `j.receive` (milestone 2); `j.remote`, `j.view`, `j.ui`,
`j.textslider` (milestone 3); `j.unit`, `j.map`, `j.cue`, `j.namespace`, `j.node`, `j.out`, `j.in` (to be decided in the milestone 2 plan);
`j.out~`, `j.in~`, `j.limiter~` (audio objects, later).
