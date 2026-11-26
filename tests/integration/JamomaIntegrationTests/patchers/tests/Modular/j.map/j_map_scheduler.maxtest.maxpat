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
   557.6,
   530.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
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
      51.0,
      22.0
     ],
     "text": "j.map"
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
      30.0,
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
      30.0,
      94.0,
      68.4,
      22.0
     ],
     "text": "delay 20"
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      68.4,
      22.0
     ],
     "text": "t b 0.25"
    }
   },
   {
    "box": {
     "id": "h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      350.0,
      196.0,
      22.0
     ],
     "text": "expr abs($f1 - 0.25) < 0.00001"
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
      122.4,
      94.0,
      74.2,
      22.0
     ],
     "text": "delay 300"
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
      122.4,
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
      30.0,
      478.0,
      497.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/scheduler/answers_at_once_on_the_scheduler_thread"
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
      30.0,
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
      "later",
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
      1
     ],
     "destination": [
      "m",
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
      "h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m",
      0
     ],
     "destination": [
      "h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "h",
      0
     ],
     "destination": [
      "c",
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
      "c",
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
