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
   655.8,
   530.0
  ],
  "boxes": [
   {
    "box": {
     "id": "pin",
     "maxclass": "newobj",
     "text": "p inner",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      68.2,
      22.0
     ],
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
       464.6,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "im",
         "maxclass": "newobj",
         "text": "j.model inner",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          107.8,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "ip",
         "maxclass": "newobj",
         "text": "j.parameter p @type integer @default 3",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          161.8,
          30.0,
          272.8,
          22.0
         ]
        }
       }
      ],
      "lines": []
     }
    }
   },
   {
    "box": {
     "id": "om",
     "maxclass": "newobj",
     "text": "j.model outer",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      122.2,
      30.0,
      107.8,
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
      254.0,
      30.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "text": "j.receive /outer/inner/p",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      254.0,
      222.0,
      180.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "text": "sel 3",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      254.0,
      286.0,
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
      254.0,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/nested_model/inner_below_outer",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      254.0,
      478.0,
      371.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d",
     "maxclass": "newobj",
     "text": "delay 100",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      254.0,
      94.0,
      81.4,
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
      254.0,
      158.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.4,
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
      458.4,
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
      254.0,
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
      "r",
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
      "ji",
      1
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
      "r",
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
