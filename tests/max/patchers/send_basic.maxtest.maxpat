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
   1097.8,
   594.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model sb",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a",
     "maxclass": "newobj",
     "text": "j.parameter a @type integer",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      30.0,
      200.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "text": "j.receive a",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      366.2,
      30.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "text": "j.send a",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.2,
      222.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "g",
     "maxclass": "newobj",
     "text": "zl group 2",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      366.2,
      94.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "newobj",
     "text": "unpack 0 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      366.2,
      158.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e",
     "maxclass": "newobj",
     "text": "expr $i1*10+$i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      366.2,
      222.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q",
     "maxclass": "newobj",
     "text": "== 5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      366.2,
      286.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/send_basic/value_arrives",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      366.2,
      414.0,
      332.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ra",
     "maxclass": "newobj",
     "text": "route address",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      623.2,
      286.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sl",
     "maxclass": "newobj",
     "text": "sel /sb/a",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      623.2,
      350.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      722.4,
      414.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "aa",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/send_basic/reports_address",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      722.4,
      542.0,
      345.4,
      22.0
     ]
    }
   },
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
      484.8,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ji",
     "maxclass": "newobj",
     "text": "j.init",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      583.6,
      30.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 100",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      596.8,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "set",
     "maxclass": "message",
     "text": "5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.2,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 3000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      484.8,
      94.0,
      88.0,
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
      484.8,
      158.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      366.2,
      350.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_aa",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      722.4,
      478.0,
      24.0,
      24.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "r",
      0
     ],
     "destination": [
      "g",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "g",
      0
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
      "q",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "q",
      0
     ],
     "destination": [
      "tg_as",
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
      "ra",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ra",
      0
     ],
     "destination": [
      "sl",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sl",
      0
     ],
     "destination": [
      "one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one",
      0
     ],
     "destination": [
      "tg_aa",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ji",
      1
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
      "set",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "set",
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
      "lb",
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
      "term",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as",
      0
     ],
     "destination": [
      "as",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_aa",
      0
     ],
     "destination": [
      "aa",
      0
     ]
    }
   }
  ]
 }
}
