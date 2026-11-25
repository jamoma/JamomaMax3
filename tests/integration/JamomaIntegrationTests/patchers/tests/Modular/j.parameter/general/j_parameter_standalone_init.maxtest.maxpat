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
   596.8,
   274.0
  ],
  "boxes": [
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "text": "j.parameter solo @type integer",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      220.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e",
     "maxclass": "newobj",
     "text": "== 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a",
     "maxclass": "newobj",
     "text": "test.assert Jamoma/Modular/j.parameter/general/standalone_init/outputs_default",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      536.8,
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
      274.0,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "text": "delay 600",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      274.0,
      94.0,
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
      274.0,
      158.0,
      114.4,
      22.0
     ]
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
      "p",
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
      "e",
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
      "lb",
      0
     ],
     "destination": [
      "dl",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dl",
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
