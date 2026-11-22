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
   1091.0,
   466.0
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
      517.7,
      94.0,
      68.2,
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
      589.3,
      158.0,
      48.4,
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
      661.7,
      158.0,
      48.4,
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
      734.1,
      158.0,
      41.8,
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
      569.5,
      222.0,
      88.0,
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
      244.1,
      286.0,
      68.2,
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
      893.8,
      286.0,
      74.8,
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
      597.0,
      286.0,
      68.2,
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
      254.0,
      350.0,
      48.4,
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
      907.0,
      350.0,
      48.4,
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
      606.9,
      350.0,
      48.4,
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
      95.6,
      414.0,
      365.2,
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
      801.4,
      414.0,
      259.6,
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
      484.8,
      414.0,
      292.6,
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
      112.3,
      158.0,
      81.4,
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
      95.8,
      222.0,
      114.4,
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
