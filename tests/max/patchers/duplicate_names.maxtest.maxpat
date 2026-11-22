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
   853.8,
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
      30.0,
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
     "text": "0.5",
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
     ]
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "message",
     "text": "0.7",
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
     ]
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "text": "j.parameter same @type decimal",
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
     ]
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "text": "j.parameter same @type decimal",
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
     ]
    }
   },
   {
    "box": {
     "id": "ea",
     "maxclass": "newobj",
     "text": "test.equals 0.5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      412.4,
      286.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "eb",
     "maxclass": "newobj",
     "text": "test.equals 0.7",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      286.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "aa",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/duplicate_names/first",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      511.4,
      414.0,
      312.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ab",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/duplicate_names/second",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      168.4,
      414.0,
      319.0,
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
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      158.0,
      114.4,
      22.0
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
      511.4,
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
      "pa",
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
      "pb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pa",
      0
     ],
     "destination": [
      "ea",
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
      "eb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ea",
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
      "eb",
      0
     ],
     "destination": [
      "tg_ab",
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
   },
   {
    "patchline": {
     "source": [
      "tg_ab",
      0
     ],
     "destination": [
      "ab",
      0
     ]
    }
   }
  ]
 }
}
