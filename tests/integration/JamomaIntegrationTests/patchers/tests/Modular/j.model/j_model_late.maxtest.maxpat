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
   1526.6,
   402.0
  ],
  "boxes": [
   {
    "box": {
     "bubble": 1,
     "id": "obj-6",
     "linecount": 2,
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      30.0,
      30.0,
      352.0,
      20.0
     ],
     "text": "This object is script-created as part of the patch"
    }
   },
   {
    "box": {
     "id": "px",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      406.0,
      30.0,
      272.8,
      22.0
     ],
     "text": "j.parameter x @type integer @default 5"
    }
   },
   {
    "box": {
     "id": "rx",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      702.8,
      30.0,
      94.6,
      22.0
     ],
     "text": "j.receive x"
    }
   },
   {
    "box": {
     "id": "sx",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1237.2,
      286.0,
      121.0,
      22.0
     ],
     "text": "j.send /lateM/x"
    }
   },
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
      821.4,
      30.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      821.4,
      94.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "mk",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      821.4,
      158.0,
      292.6,
      22.0
     ],
     "text": "script newdefault lm 30 600 j.model lateM"
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      821.4,
      222.0,
      94.6,
      22.0
     ],
     "save": [
      "#N",
      "thispatcher",
      ";",
      "#Q",
      "end",
      ";"
     ],
     "text": "thispatcher"
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1138.0,
      158.0,
      81.4,
      22.0
     ],
     "text": "delay 700"
    }
   },
   {
    "box": {
     "id": "v",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1138.0,
      222.0,
      40.0,
      22.0
     ],
     "text": "7"
    }
   },
   {
    "box": {
     "id": "sr",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      702.8,
      94.0,
      55.0,
      22.0
     ],
     "text": "sel 7"
    }
   },
   {
    "box": {
     "id": "one1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      702.8,
      158.0,
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
     "id": "as1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      828.2,
      286.0,
      385.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/late/receive_follows"
    }
   },
   {
    "box": {
     "id": "sp",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      406.0,
      94.0,
      55.0,
      22.0
     ],
     "text": "sel 7"
    }
   },
   {
    "box": {
     "id": "one2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      406.0,
      158.0,
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
     "id": "as2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      406.0,
      286.0,
      398.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/late/parameter_follows"
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1382.2,
      286.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
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
      1382.2,
      350.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
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
      940.0,
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
      406.0,
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
     "destination": [
      "d2",
      0
     ],
     "order": 0,
     "source": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "mk",
      0
     ],
     "order": 1,
     "source": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "v",
      0
     ],
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "term",
      0
     ],
     "source": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d1",
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
      "tp",
      0
     ],
     "source": [
      "mk",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_as1",
      0
     ],
     "source": [
      "one1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_as2",
      0
     ],
     "source": [
      "one2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "sp",
      0
     ],
     "source": [
      "px",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "sr",
      0
     ],
     "source": [
      "rx",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "one2",
      0
     ],
     "source": [
      "sp",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "one1",
      0
     ],
     "source": [
      "sr",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as1",
      0
     ],
     "source": [
      "tg_as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as2",
      0
     ],
     "source": [
      "tg_as2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d3",
      0
     ],
     "order": 0,
     "source": [
      "v",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "sx",
      0
     ],
     "order": 1,
     "source": [
      "v",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
