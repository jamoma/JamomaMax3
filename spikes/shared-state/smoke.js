// THROWAWAY SPIKE: compares the registry ids reported by j.spike.a and j.spike.b,
// writes the verdict to a file and tells the patcher to quit Max.
inlets = 1;
outlets = 1;

var seen = {};
var done = false;

/** Writes one line to the result file, replacing it. */
function writeResult(line)
{
    var f = new File("@RESULT@", "write", "TEXT");
    if (f.isopen) {
        f.writeline(line);
        f.close();
    }
}

/** Receives "<a|b> <registry id as hex> <loader attached 0|1>" from the two externals, or "timeout". */
function anything()
{
    if (done) {
        return;
    }
    if (messagename == "timeout") {
        done = true;
        writeResult("FAIL timeout seen=" + Object.keys(seen).join(","));
        outlet(0, "bang");
        return;
    }
    seen[messagename] = arrayfromargs(arguments);
    if (seen.a && seen.b) {
        done = true;
        var same = String(seen.a[0]) == String(seen.b[0]);
        writeResult((same ? "PASS same-registry" : "FAIL split-registry") + " loader=" + seen.a[1]);
        outlet(0, "bang");
    }
}
