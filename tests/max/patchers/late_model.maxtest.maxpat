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
   1071.4,
   402.0
  ],
  "boxes": [
   {
    "box": {
     "id": "px",
     "maxclass": "newobj",
     "text": "j.parameter x @type integer @default 5",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      272.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rx",
     "maxclass": "newobj",
     "text": "j.receive x",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      326.8,
      30.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sx",
     "maxclass": "newobj",
     "text": "j.send /lateM/x",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      782.0,
      286.0,
      121.0,
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
      445.4,
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
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      445.4,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "mk",
     "maxclass": "message",
     "text": "script newdefault lm 30 600 j.model lateM",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      445.4,
      158.0,
      292.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "text": "thispatcher",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      460.6,
      222.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 700",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      762.0,
      158.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "v",
     "maxclass": "message",
     "text": "7",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      762.0,
      222.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sr",
     "maxclass": "newobj",
     "text": "sel 7",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      326.8,
      94.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one1",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/late_model/receive_follows",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      412.6,
      286.0,
      345.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sp",
     "maxclass": "newobj",
     "text": "sel 7",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one2",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/late_model/parameter_follows",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      358.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      927.0,
      286.0,
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
      927.0,
      350.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      412.6,
      222.0,
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
      30.0,
      222.0,
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
      "lb",
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
      "mk",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mk",
      0
     ],
     "destination": [
      "tp",
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
      "v",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v",
      0
     ],
     "destination": [
      "sx",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rx",
      0
     ],
     "destination": [
      "sr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sr",
      0
     ],
     "destination": [
      "one1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one1",
      0
     ],
     "destination": [
      "tg_as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "px",
      0
     ],
     "destination": [
      "sp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sp",
      0
     ],
     "destination": [
      "one2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one2",
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
      "v",
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
      "tg_as1",
      0
     ],
     "destination": [
      "as1",
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
