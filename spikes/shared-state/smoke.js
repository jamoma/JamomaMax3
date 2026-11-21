// THROWAWAY SPIKE: compares the registry ids reported by j.spike.a and j.spike.b,
// writes the verdict to a file and tells the patcher to quit Max.
inlets = 1;
outlets = 1;

var seen = {};

/** Receives "<a|b> <registry id as hex> <loader attached 0|1>" from the two externals. */
function anything()
{
    seen[messagename] = arrayfromargs(arguments);
    if (seen.a && seen.b) {
        finish();
    }
}

/** Writes PASS/FAIL to the result file and asks the patcher to quit. */
function finish()
{
    var same = String(seen.a[0]) == String(seen.b[0]);
    var line = (same ? "PASS same-registry" : "FAIL split-registry") + " loader=" + seen.a[1];
    var f = new File("@RESULT@", "write", "TEXT");
    if (f.isopen) {
        f.writeline(line);
        f.close();
    }
    outlet(0, "bang");
}
