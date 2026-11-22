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
   936.3,
   786.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model rf",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "px",
     "maxclass": "newobj",
     "text": "j.parameter x @type decimal @default 0.5 @ramp/drive system",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      158.0,
      411.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm",
     "maxclass": "newobj",
     "text": "j.remote x",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      577.4,
      350.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ui",
     "maxclass": "flonum",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "patching_rect": [
      577.4,
      286.0,
      40.0,
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
      142.0,
      30.0,
      61.6,
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
      788.2,
      542.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "fl",
     "maxclass": "newobj",
     "text": "float",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      415.7,
      478.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      227.6,
      30.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      306.6,
      30.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s0",
     "maxclass": "message",
     "text": "100. ramp 600",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      94.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d0",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      577.4,
      158.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "message",
     "text": "7.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      577.4,
      222.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      641.4,
      286.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      689.4,
      414.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      689.4,
      478.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dwait",
     "maxclass": "newobj",
     "text": "delay 900",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      689.4,
      350.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dend",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      788.2,
      478.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "f7s",
     "maxclass": "newobj",
     "text": "sel 7.",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      415.7,
      542.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "f7o",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      415.7,
      606.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "f7a",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/remote_feedback/dragged_value_wins_over_the_ramp",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      415.7,
      734.0,
      490.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_f7a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      415.7,
      670.0,
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
      "rm",
      0
     ],
     "destination": [
      "ui",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ui",
      0
     ],
     "destination": [
      "rm",
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
      "fl",
      1
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
      "s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "px",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "d0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d0",
      0
     ],
     "destination": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
      0
     ],
     "destination": [
      "ui",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
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
      "s2",
      0
     ],
     "destination": [
      "fl",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
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
      "d1",
      0
     ],
     "destination": [
      "dwait",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dwait",
      0
     ],
     "destination": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "dend",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dend",
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
      "fl",
      0
     ],
     "destination": [
      "f7s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f7s",
      0
     ],
     "destination": [
      "f7o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "f7o",
      0
     ],
     "destination": [
      "tg_f7a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_f7a",
      0
     ],
     "destination": [
      "f7a",
      0
     ]
    }
   }
  ]
 }
}
