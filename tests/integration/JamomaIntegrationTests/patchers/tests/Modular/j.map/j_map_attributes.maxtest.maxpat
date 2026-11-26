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
   34.0,
   96.0,
   568.8,
   338.0
  ],
  "boxes": [
   {
    "box": {
     "id": "o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      51.0,
      22.0
     ],
     "text": "j.map",
     "varname": "target"
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      105.0,
      30.0,
      68.4,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "later",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      105.0,
      94.0,
      74.2,
      22.0
     ],
     "text": "delay 200"
    }
   },
   {
    "box": {
     "id": "js",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      105.0,
      158.0,
      184.4,
      22.0
     ],
     "text": "js attribute_reads.js target"
    }
   },
   {
    "box": {
     "id": "end",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      203.2,
      94.0,
      74.2,
      22.0
     ],
     "text": "delay 600"
    }
   },
   {
    "box": {
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      313.4,
      158.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      105.0,
      286.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/attributes/every_attribute_can_be_read"
    }
   },
   {
    "box": {
     "id": "tg_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      105.0,
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
      "later",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "later",
      0
     ],
     "destination": [
      "js",
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
      "end",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "end",
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
      "js",
      0
     ],
     "destination": [
      "tg_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a",
      0
     ],
     "destination": [
      "a",
      0
     ]
    }
   }
  ]
 }
}
