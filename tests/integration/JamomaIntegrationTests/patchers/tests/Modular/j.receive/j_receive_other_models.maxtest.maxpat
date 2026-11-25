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
   80.0,
   96.0,
   1246.2,
   786.0
  ],
  "boxes": [
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
      30.0,
      41.8,
      22.0
     ],
     "text": "p a",
     "varname": "a",
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
       80.0,
       96.0,
       845.2,
       240.0
      ],
      "autosave": 0,
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
          30.0,
          68.2,
          22.0
         ],
         "text": "j.model"
        }
       },
       {
        "box": {
         "id": "x",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          122.2,
          30.0,
          305.8,
          22.0
         ],
         "text": "j.parameter grp/x @type string @default foo"
        }
       },
       {
        "box": {
         "id": "y",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          452.0,
          30.0,
          299.2,
          22.0
         ],
         "text": "j.parameter grp/y @type integer @default 2"
        }
       },
       {
        "box": {
         "id": "o",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          775.2,
          30.0,
          40.0,
          22.0
         ],
         "comment": ""
        }
       }
      ],
      "lines": []
     }
    }
   },
   {
    "box": {
     "id": "b",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      95.8,
      30.0,
      41.8,
      22.0
     ],
     "text": "p b",
     "varname": "b",
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
       80.0,
       96.0,
       589.8,
       240.0
      ],
      "autosave": 0,
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
          30.0,
          68.2,
          22.0
         ],
         "text": "j.model"
        }
       },
       {
        "box": {
         "id": "z",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          122.2,
          30.0,
          305.8,
          22.0
         ],
         "text": "j.parameter grp/z @type decimal @default 1."
        }
       },
       {
        "box": {
         "id": "r",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 3,
         "outlettype": [
          "",
          "",
          ""
         ],
         "patching_rect": [
          452.0,
          30.0,
          107.8,
          22.0
         ],
         "text": "j.receive */*"
        }
       },
       {
        "box": {
         "id": "o",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          452.0,
          94.0,
          40.0,
          22.0
         ],
         "comment": ""
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "destination": [
          "o",
          0
         ],
         "source": [
          "r",
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
     "id": "tp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      299.9,
      414.0,
      94.6,
      22.0
     ],
     "text": "thispatcher"
    }
   },
   {
    "box": {
     "id": "del",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      299.9,
      350.0,
      121.0,
      22.0
     ],
     "text": "script delete a"
    }
   },
   {
    "box": {
     "id": "open",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      234.1,
      286.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "gt",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      227.5,
      350.0,
      48.4,
      22.0
     ],
     "text": "gate"
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      95.8,
      94.0,
      94.6,
      22.0
     ],
     "text": "route foo 2"
    }
   },
   {
    "box": {
     "id": "rt2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      95.8,
      158.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "zero1",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      95.8,
      222.0,
      40.0,
      22.0
     ],
     "text": "0"
    }
   },
   {
    "box": {
     "id": "zero2",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.9,
      478.0,
      40.0,
      22.0
     ],
     "text": "0"
    }
   },
   {
    "box": {
     "id": "tb2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      227.5,
      414.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "F1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      155.1,
      286.0,
      55.0,
      22.0
     ],
     "text": "int 1"
    }
   },
   {
    "box": {
     "id": "F2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      613.4,
      542.0,
      55.0,
      22.0
     ],
     "text": "int 1"
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      161.6,
      30.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "dl0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      214.4,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 1500"
    }
   },
   {
    "box": {
     "id": "dl1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      214.4,
      158.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "dl2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      214.4,
      222.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "dl3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      298.1,
      286.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "dl4",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      444.9,
      350.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "dl5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      444.9,
      414.0,
      81.4,
      22.0
     ],
     "text": "delay 400"
    }
   },
   {
    "box": {
     "id": "c1eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      155.1,
      350.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c1tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      155.1,
      414.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c1as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      155.1,
      478.0,
      602.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.receive/other_models/never_outputs_a_value_of_another_model"
    }
   },
   {
    "box": {
     "id": "c2eq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      613.4,
      606.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c2tg",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      613.4,
      670.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "c2as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      613.4,
      734.0,
      602.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.receive/other_models/deleting_another_model_outputs_nothing"
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
      845.9,
      478.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "dl0",
      0
     ],
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl1",
      0
     ],
     "source": [
      "dl0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl2",
      0
     ],
     "source": [
      "dl1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl3",
      0
     ],
     "source": [
      "dl2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl4",
      0
     ],
     "source": [
      "dl3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dl5",
      0
     ],
     "source": [
      "dl4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1eq",
      0
     ],
     "source": [
      "F1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1tg",
      0
     ],
     "source": [
      "c1eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c1as",
      0
     ],
     "source": [
      "c1tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2eq",
      0
     ],
     "source": [
      "F2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2tg",
      0
     ],
     "source": [
      "c2eq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "c2as",
      0
     ],
     "source": [
      "c2tg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt",
      0
     ],
     "source": [
      "b",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt2",
      0
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt2",
      0
     ],
     "source": [
      "rt",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "zero1",
      0
     ],
     "source": [
      "rt2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F1",
      1
     ],
     "source": [
      "zero1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "gt",
      1
     ],
     "source": [
      "b",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tb2",
      0
     ],
     "source": [
      "gt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "zero2",
      0
     ],
     "source": [
      "tb2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F2",
      1
     ],
     "source": [
      "zero2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F1",
      0
     ],
     "source": [
      "dl1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "open",
      0
     ],
     "source": [
      "dl2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "gt",
      0
     ],
     "source": [
      "open",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "del",
      0
     ],
     "source": [
      "dl3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "del",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "F2",
      0
     ],
     "source": [
      "dl4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "term",
      0
     ],
     "source": [
      "dl5",
      0
     ]
    }
   }
  ],
  "autosave": 0,
  "dependency_cache": []
 }
}
