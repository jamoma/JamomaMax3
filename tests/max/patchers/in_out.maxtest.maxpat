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
   1000.0,
   500.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model io",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      20.0,
      20.0,
      200.0,
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
      250.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "o",
     "maxclass": "newobj",
     "text": "j.out 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      480.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "i",
     "maxclass": "newobj",
     "text": "j.in 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      710.0,
      20.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "text": "j.receive data/out.1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      20.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "five",
     "maxclass": "message",
     "text": "5",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "seven",
     "maxclass": "message",
     "text": "7",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "mute",
     "maxclass": "message",
     "text": "mute 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      70.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "six",
     "maxclass": "message",
     "text": "6",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q5",
     "maxclass": "newobj",
     "text": "== 5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a5",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/in_out/out_passes_values",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "zr",
     "maxclass": "newobj",
     "text": "zl reg",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      120.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "text": "bang",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e5",
     "maxclass": "newobj",
     "text": "== 5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ah",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/in_out/muted_out_is_silent",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rq",
     "maxclass": "newobj",
     "text": "== 5",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      170.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ar",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/in_out/node_is_visible_to_receive",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      220.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q7",
     "maxclass": "newobj",
     "text": "== 7",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      220.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a7",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/in_out/in_passes_values",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      220.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 100",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      710.0,
      220.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 600",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      270.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 1200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      270.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 2000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      480.0,
      270.0,
      200.0,
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
      710.0,
      270.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d5",
     "maxclass": "newobj",
     "text": "delay 3000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      20.0,
      320.0,
      200.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d6",
     "maxclass": "newobj",
     "text": "delay 4500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      250.0,
      320.0,
      200.0,
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
      480.0,
      320.0,
      200.0,
      22.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "ji",
      1
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
      "five",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "five",
      0
     ],
     "destination": [
      "o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "o",
      0
     ],
     "destination": [
      "q5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "q5",
      0
     ],
     "destination": [
      "a5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "o",
      0
     ],
     "destination": [
      "zr",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      0
     ],
     "destination": [
      "rq",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rq",
      0
     ],
     "destination": [
      "ar",
      0
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
      "seven",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "seven",
      0
     ],
     "destination": [
      "i",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "i",
      0
     ],
     "destination": [
      "q7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "q7",
      0
     ],
     "destination": [
      "a7",
      0
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
      "mute",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mute",
      0
     ],
     "destination": [
      "o",
      0
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
      "d4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d4",
      0
     ],
     "destination": [
      "six",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "six",
      0
     ],
     "destination": [
      "o",
      0
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
      "d5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d5",
      0
     ],
     "destination": [
      "bg",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bg",
      0
     ],
     "destination": [
      "zr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "zr",
      0
     ],
     "destination": [
      "e5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "e5",
      0
     ],
     "destination": [
      "ah",
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
      "d6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d6",
      0
     ],
     "destination": [
      "term",
      0
     ]
    }
   }
  ]
 }
}