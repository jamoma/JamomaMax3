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
   737.6,
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
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 1800",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      254.0,
      94.0,
      88.0,
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
      267.2,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 4500",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      94.0,
      88.0,
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
      128.8,
      158.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "newobj",
     "text": "sel 7",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      191.7,
      286.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "b1",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      199.2,
      350.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a1",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/send_relative/own_model_reached",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      378.4,
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
      454.6,
      222.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 4000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      441.4,
      94.0,
      88.0,
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
      461.2,
      158.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q4",
     "maxclass": "newobj",
     "text": "== 4",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      461.2,
      286.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a2",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/send_relative/other_model_keeps_its_value",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      263.2,
      350.0,
      444.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "newobj",
     "text": "p one",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      191.7,
      222.0,
      55.0,
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
       645.7,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "m",
         "maxclass": "newobj",
         "text": "j.model m",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          81.4,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "a",
         "maxclass": "newobj",
         "text": "j.parameter a @type integer @default 3",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          135.4,
          30.0,
          272.8,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "r",
         "maxclass": "newobj",
         "text": "j.receive a",
         "numinlets": 1,
         "numoutlets": 3,
         "outlettype": [
          "",
          "",
          ""
         ],
         "patching_rect": [
          521.1,
          94.0,
          94.6,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "s",
         "maxclass": "newobj",
         "text": "j.send a",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          422.3,
          94.0,
          74.8,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "i0",
         "maxclass": "newobj",
         "text": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          432.2,
          30.0,
          55.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "i1",
         "maxclass": "newobj",
         "text": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          511.2,
          30.0,
          55.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "o",
         "maxclass": "newobj",
         "text": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          537.6,
          158.0,
          61.6,
          22.0
         ]
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "i0",
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
          "i1",
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
          "r",
          0
         ],
         "destination": [
          "o",
          0
         ]
        }
       }
      ]
     }
    }
   },
   {
    "box": {
     "id": "two",
     "maxclass": "newobj",
     "text": "p two",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      128.8,
      30.0,
      55.0,
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
       645.7,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "m",
         "maxclass": "newobj",
         "text": "j.model m",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          81.4,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "a",
         "maxclass": "newobj",
         "text": "j.parameter a @type integer @default 4",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          135.4,
          30.0,
          272.8,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "r",
         "maxclass": "newobj",
         "text": "j.receive a",
         "numinlets": 1,
         "numoutlets": 3,
         "outlettype": [
          "",
          "",
          ""
         ],
         "patching_rect": [
          521.1,
          94.0,
          94.6,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "s",
         "maxclass": "newobj",
         "text": "j.send a",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          422.3,
          94.0,
          74.8,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "i0",
         "maxclass": "newobj",
         "text": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          432.2,
          30.0,
          55.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "i1",
         "maxclass": "newobj",
         "text": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          511.2,
          30.0,
          55.0,
          22.0
         ]
        }
       },
       {
        "box": {
         "id": "o",
         "maxclass": "newobj",
         "text": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          537.6,
          158.0,
          61.6,
          22.0
         ]
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "i0",
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
          "i1",
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
          "r",
          0
         ],
         "destination": [
          "o",
          0
         ]
        }
       }
      ]
     }
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
      "seven",
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
      "s1",
      0
     ],
     "destination": [
      "b1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b1",
      0
     ],
     "destination": [
      "a1",
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
      "q4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "q4",
      0
     ],
     "destination": [
      "a2",
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
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "two",
      0
     ],
     "destination": [
      "zr",
      1
     ]
    }
   }
  ]
 }
}
