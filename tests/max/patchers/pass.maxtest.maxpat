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
     "text": "t b b b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
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
     "id": "m1",
     "maxclass": "message",
     "text": "/a 5",
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
     "id": "m2",
     "maxclass": "message",
     "text": "zz 7",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
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
     "id": "m3",
     "maxclass": "message",
     "text": "b 3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
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
     "id": "p",
     "maxclass": "newobj",
     "text": "j.pass a b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
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
     "id": "r1",
     "maxclass": "newobj",
     "text": "route a",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
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
     "id": "r2",
     "maxclass": "newobj",
     "text": "route zz",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
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
     "id": "r3",
     "maxclass": "newobj",
     "text": "route b",
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
     "id": "e1",
     "maxclass": "newobj",
     "text": "== 5",
     "numinlets": 1,
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
     "text": "== 7",
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
     "id": "e3",
     "maxclass": "newobj",
     "text": "== 3",
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
     "id": "a1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/pass/strips_slash_and_matches",
     "numinlets": 1,
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
     "id": "a2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/pass/overflow",
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
   },
   {
    "box": {
     "id": "a3",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/pass/second_outlet",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
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
      20.0,
      220.0,
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
      2
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
      "t",
      1
     ],
     "destination": [
      "m2",
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
      "m3",
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
      "term",
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
      "p",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m2",
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
      "m3",
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
      "p",
      0
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
      "p",
      1
     ],
     "destination": [
      "r3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p",
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
      "r1",
      0
     ],
     "destination": [
      "e1",
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
      "e2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r3",
      0
     ],
     "destination": [
      "e3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e1",
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
      "e2",
      0
     ],
     "destination": [
      "a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e3",
      0
     ],
     "destination": [
      "a3",
      0
     ]
    }
   }
  ]
 }
}