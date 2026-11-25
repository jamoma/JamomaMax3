{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 2,
   "revision": 2,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   134.0,
   168.0,
   873.8,
   658.0
  ],
  "boxes": [
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      30.0,
      30.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "patching_rect": [
      30.0,
      94.0,
      55.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      48.4,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      279.4,
      22.0
     ],
     "text": "j.parameter d @type integer @range 0 10"
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "numinlets": 3,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      127.6,
      22.0
     ],
     "text": "route type range"
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      30.0,
      350.0,
      94.6,
      22.0
     ],
     "text": "sel integer"
    }
   },
   {
    "box": {
     "id": "m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "a1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      391.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/dump/type"
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "float",
      "float"
     ],
     "patching_rect": [
      148.6,
      350.0,
      101.2,
      22.0
     ],
     "text": "unpack 0. 0."
    }
   },
   {
    "box": {
     "id": "e",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      148.6,
      414.0,
      114.4,
      22.0
     ],
     "text": "expr $f2 - $f1"
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      148.6,
      478.0,
      55.0,
      22.0
     ],
     "text": "== 10"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "a2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      445.6,
      606.0,
      398.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/dump/range"
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      102.4,
      158.0,
      81.4,
      22.0
     ],
     "text": "delay 600"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      333.4,
      222.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_a1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      445.6,
      542.0,
      24.0,
      24.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "term",
      0
     ],
     "source": [
      "dl",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "e2",
      0
     ],
     "source": [
      "e",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a2",
      0
     ],
     "source": [
      "e2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t",
      0
     ],
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "p",
      0
     ],
     "source": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a1",
      0
     ],
     "source": [
      "m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt",
      0
     ],
     "source": [
      "p",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s",
      0
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "u",
      0
     ],
     "source": [
      "rt",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m1",
      0
     ],
     "source": [
      "s",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl",
      0
     ],
     "source": [
      "t",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "source": [
      "t",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a1",
      0
     ],
     "source": [
      "tg_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a2",
      0
     ],
     "source": [
      "tg_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "e",
      1
     ],
     "source": [
      "u",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "e",
      0
     ],
     "source": [
      "u",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
