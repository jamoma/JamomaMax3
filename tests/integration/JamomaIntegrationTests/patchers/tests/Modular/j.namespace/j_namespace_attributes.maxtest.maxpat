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
   638.4,
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
      85.8,
      22.0
     ],
     "text": "j.namespace",
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
      139.8,
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
      139.8,
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
      139.8,
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
      238.0,
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
      348.2,
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
      139.8,
      286.0,
      468.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/attributes/every_attribute_can_be_read"
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
      139.8,
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
