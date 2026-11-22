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
   537.4,
   338.0
  ],
  "boxes": [
   {
    "box": {
     "id": "md",
     "maxclass": "newobj",
     "text": "vb.model",
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
     "id": "vw",
     "maxclass": "newobj",
     "text": "vb.view",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      128.8,
      222.0,
      68.2,
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
      128.8,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d",
     "maxclass": "newobj",
     "text": "delay 400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      128.8,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "go",
     "maxclass": "message",
     "text": "a 5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      128.8,
      158.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "text": "sel 5",
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
     "id": "one",
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
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/view_basic/message_reaches_the_model_parameter",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      477.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      194.6,
      158.0,
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
      221.0,
      222.0,
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
      "d",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d",
      0
     ],
     "destination": [
      "go",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "go",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "md",
      0
     ],
     "destination": [
      "s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one",
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
      "d",
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
   }
  ]
 }
}
