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
   1295.8,
   466.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model modelA",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "text": "j.parameter a @type integer @default 1 @priority 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      168.4,
      30.0,
      352.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "text": "j.parameter b @type integer @default 2 @priority 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      544.4,
      30.0,
      352.0,
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
      920.4,
      30.0,
      61.6,
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
      356.4,
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
      356.4,
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
      356.4,
      222.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "eq",
     "maxclass": "newobj",
     "text": "== 21",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      356.4,
      286.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/model_init/priority_order",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      356.4,
      414.0,
      338.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "st",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      920.4,
      94.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/model_init/init_start_bang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      920.4,
      222.0,
      345.4,
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
      984.4,
      94.0,
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
      356.4,
      350.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      920.4,
      158.0,
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
      "pa",
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
      "pb",
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
      "eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq",
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
      "ji",
      0
     ],
     "destination": [
      "st",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "st",
      0
     ],
     "destination": [
      "tg_as2",
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
      "tg_as2",
      0
     ],
     "destination": [
      "as2",
      0
     ]
    }
   }
  ]
 }
}
