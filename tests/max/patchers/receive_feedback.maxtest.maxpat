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
   820.5,
   530.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model fb",
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
     "text": "j.parameter a @type integer @repetitions/filter 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      438.5,
      222.0,
      345.4,
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
      142.0,
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
      142.0,
      94.0,
      74.8,
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
      260.6,
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
      359.4,
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
      372.6,
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
     "text": "7",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      399.0,
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
     "text": "delay 900",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      478.0,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ask",
     "maxclass": "message",
     "text": "value",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      478.0,
      158.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "text": "route value",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      438.5,
      286.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q",
     "maxclass": "newobj",
     "text": "== 7",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      438.5,
      350.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/receive_feedback/terminates",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      438.5,
      478.0,
      352.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 4000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      260.6,
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
      260.6,
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
      438.5,
      414.0,
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
      "s",
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
      "a",
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
      "ask",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ask",
      0
     ],
     "destination": [
      "a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a",
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
      "lb",
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
   }
  ]
 }
}
