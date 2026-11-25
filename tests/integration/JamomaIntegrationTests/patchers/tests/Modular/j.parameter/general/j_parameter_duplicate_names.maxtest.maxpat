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
   1170.6,
   466.0
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
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "bang",
      "bang"
     ],
     "patching_rect": [
      30.0,
      94.0,
      68.2,
      22.0
     ],
     "text": "t b b b"
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
      234.2,
      158.0,
      41.8,
      22.0
     ],
     "text": "0.5"
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      158.0,
      41.8,
      22.0
     ],
     "text": "0.7"
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      412.4,
      222.0,
      220.0,
      22.0
     ],
     "text": "j.parameter same @type decimal"
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      168.4,
      222.0,
      220.0,
      22.0
     ],
     "text": "j.parameter same @type decimal"
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
     "id": "ea",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      412.4,
      286.0,
      121.0,
      22.0
     ],
     "text": "test.equals 0.5"
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
     "id": "eb",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      286.0,
      121.0,
      22.0
     ],
     "text": "test.equals 0.7"
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
     "id": "aa",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      669.8,
      414.0,
      470.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/duplicate_names/first"
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
     "id": "ab",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      414.0,
      477.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/duplicate_names/second"
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
      30.0,
      158.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
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
      669.8,
      350.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_ab",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      168.4,
      350.0,
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
      "tg_aa",
      0
     ],
     "source": [
      "ea",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_ab",
      0
     ],
     "source": [
      "eb",
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
      "pa",
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
      "pb",
      0
     ],
     "source": [
      "m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ea",
      0
     ],
     "source": [
      "pa",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "eb",
      0
     ],
     "source": [
      "pb",
      0
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
      "t",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m2",
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
      "term",
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
      "aa",
      0
     ],
     "source": [
      "tg_aa",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ab",
      0
     ],
     "source": [
      "tg_ab",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
