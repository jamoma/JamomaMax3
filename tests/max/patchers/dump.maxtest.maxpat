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
   1000.0,
   500.0
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
      20.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      250.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "text": "j.parameter d @type integer @range 0 10",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      710.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "text": "route type range",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      20.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "text": "sel integer",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      250.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m1",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/dump/type",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "newobj",
     "text": "unpack 0. 0.",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      20.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e",
     "maxclass": "newobj",
     "text": "expr $f2 - $f1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "newobj",
     "text": "== 10",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/dump/range",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "text": "delay 600",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "term",
     "maxclass": "newobj",
     "text": "test.terminate",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      170.0,
      200.0,
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
      1
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
      "t",
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
      "m",
      0
     ],
     "destination": [
      "p",
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
      "term",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p",
      1
     ],
     "destination": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      0
     ],
     "destination": [
      "s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m1",
      0
     ],
     "destination": [
      "a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      1
     ],
     "destination": [
      "u",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u",
      0
     ],
     "destination": [
      "e",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u",
      1
     ],
     "destination": [
      "e",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e",
      0
     ],
     "destination": [
      "e2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e2",
      0
     ],
     "destination": [
      "a2",
      0
     ]
    }
   }
  ]
 }
}