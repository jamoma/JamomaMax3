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
   629.6,
   466.0
  ],
  "boxes": [
   {
    "box": {
     "id": "g",
     "maxclass": "newobj",
     "text": "zl group 2",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      168.3,
      94.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "newobj",
     "text": "unpack 0 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      168.4,
      158.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "e",
     "maxclass": "newobj",
     "text": "expr $i1*10+$i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      222.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "q",
     "maxclass": "newobj",
     "text": "== 34",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      286.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/receive_relative/each_follows_its_model",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      168.4,
      414.0,
      431.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dl",
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
     "id": "d",
     "maxclass": "newobj",
     "text": "delay 4000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
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
      30.0,
      158.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "newobj",
     "text": "p one",
     "numinlets": 1,
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
       556.8,
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
          432.2,
          30.0,
          94.6,
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
          432.2,
          94.0,
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
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      207.8,
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
       556.8,
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
          432.2,
          30.0,
          94.6,
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
          432.2,
          94.0,
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
     "id": "tg_as",
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
      "g",
      0
     ],
     "destination": [
      "u",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u",
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
      "u",
      1
     ],
     "destination": [
      "e",
      1
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
      "q",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "q",
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
      "dl",
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
      "term",
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
      "g",
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
      "g",
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
