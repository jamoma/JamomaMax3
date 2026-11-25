{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 0,
   "revision": 0,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   60.0,
   60.0,
   1994.6,
   402.0
  ],
  "boxes": [
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "text": "loadbang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "text": "t b b b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model smoke",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1240.1,
      286.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p1",
     "maxclass": "newobj",
     "text": "j.parameter a @type decimal @ramp/drive max @ramp/function linear",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      260.6,
      222.0,
      451.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p2",
     "maxclass": "newobj",
     "text": "j.parameter b @type array @ramp/drive max @ramp/function linear",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      735.6,
      222.0,
      437.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p3",
     "maxclass": "newobj",
     "text": "j.message c @type none",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      128.8,
      30.0,
      167.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r1",
     "maxclass": "message",
     "text": "0. , 1000. ramp 60000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      260.6,
      158.0,
      160.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r2",
     "maxclass": "message",
     "text": "0 0 0 , 1 2 3 ramp 60000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      445.2,
      158.0,
      180.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "js",
     "maxclass": "newobj",
     "text": "js smoke.js",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      158.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "text": "delay 2500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q",
     "maxclass": "message",
     "text": ";max quit",
     "numinlets": 2,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      222.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "c",
     "maxclass": "newobj",
     "text": "j.parameter c @type decimal @ramp/drive max @ramp/function linear",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1197.4,
      222.0,
      451.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rc",
     "maxclass": "newobj",
     "text": "j.receive c",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      320.0,
      30.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sc",
     "maxclass": "newobj",
     "text": "j.send c",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      320.0,
      94.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm",
     "maxclass": "message",
     "text": "0., 1. ramp 60000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      649.6,
      158.0,
      134.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "vw",
     "maxclass": "newobj",
     "text": "j.view /smoke",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      438.6,
      30.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm2",
     "maxclass": "newobj",
     "text": "j.remote a",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      1876.6,
      222.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "nd",
     "maxclass": "newobj",
     "text": "j.node n",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      570.4,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ui",
     "maxclass": "j.ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1771.2,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "lb2",
     "maxclass": "newobj",
     "text": "loadbang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      669.2,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 800",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      669.2,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pn",
     "maxclass": "message",
     "text": "preset:new p",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      807.8,
      158.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 600",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      933.0,
      158.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pr",
     "maxclass": "message",
     "text": "preset p",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1672.4,
      222.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "v5",
     "maxclass": "message",
     "text": "5.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1038.4,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1771.2,
      222.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ud",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1771.2,
      286.0,
      48.4,
      22.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "lb",
      0
     ],
     "destination": [
      "t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      2
     ],
     "destination": [
      "r1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      2
     ],
     "destination": [
      "r2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      1
     ],
     "destination": [
      "js",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      0
     ],
     "destination": [
      "dl",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dl",
      0
     ],
     "destination": [
      "q",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r1",
      0
     ],
     "destination": [
      "p1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r2",
      0
     ],
     "destination": [
      "p2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rm",
      0
     ],
     "destination": [
      "c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rc",
      0
     ],
     "destination": [
      "sc",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "t",
      2
     ],
     "destination": [
      "rm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lb2",
      0
     ],
     "destination": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "pn",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pn",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "v5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v5",
      0
     ],
     "destination": [
      "rm2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d2",
      0
     ],
     "destination": [
      "pr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pr",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d2",
      0
     ],
     "destination": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3",
      0
     ],
     "destination": [
      "ud",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ud",
      0
     ],
     "destination": [
      "ui",
      0
     ]
    }
   }
  ]
 }
}
