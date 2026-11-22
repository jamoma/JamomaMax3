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
   900.0,
   320.0
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
      20,
      20,
      260.0,
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
      20,
      50,
      260.0,
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
      20,
      90,
      260.0,
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
      20,
      130,
      260.0,
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
      320,
      130,
      260.0,
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
      620,
      130,
      260.0,
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
      20,
      170,
      260.0,
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
      320,
      170,
      260.0,
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
      620,
      50,
      260.0,
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
      20,
      210,
      260.0,
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
      20,
      250,
      260.0,
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
   }
  ]
 }
}