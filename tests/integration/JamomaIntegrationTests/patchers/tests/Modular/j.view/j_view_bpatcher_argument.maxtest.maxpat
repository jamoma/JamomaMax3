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
   2264.1,
   594.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m1",
     "maxclass": "bpatcher",
     "numinlets": 0,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      40.0,
      22.0
     ],
     "embed": 1,
     "args": [
      "bp_named"
     ],
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
       400.0,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "o",
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
          62.6,
          22.0
         ],
         "text": "j.model"
        }
       }
      ],
      "lines": []
     }
    }
   },
   {
    "box": {
     "id": "m2",
     "maxclass": "bpatcher",
     "numinlets": 0,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      94.0,
      30.0,
      40.0,
      22.0
     ],
     "embed": 1,
     "args": [
      "bp_other"
     ],
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
       400.0,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "o",
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
          114.8,
          22.0
         ],
         "text": "j.model bp_given"
        }
       }
      ],
      "lines": []
     }
    }
   },
   {
    "box": {
     "id": "v1",
     "maxclass": "bpatcher",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      158.0,
      94.0,
      40.0,
      22.0
     ],
     "embed": 1,
     "args": [],
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
       400.0,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "o",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          114.8,
          22.0
         ],
         "text": "j.view /bp_named"
        }
       },
       {
        "box": {
         "id": "in",
         "maxclass": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       },
       {
        "box": {
         "id": "out",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          158.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "in",
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
          1
         ],
         "destination": [
          "out",
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
     "id": "v2",
     "maxclass": "bpatcher",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      244.6,
      94.0,
      40.0,
      22.0
     ],
     "embed": 1,
     "args": [
      "/bp_given"
     ],
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
       400.0,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "o",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          56.8,
          22.0
         ],
         "text": "j.view"
        }
       },
       {
        "box": {
         "id": "in",
         "maxclass": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       },
       {
        "box": {
         "id": "out",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          158.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "in",
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
          1
         ],
         "destination": [
          "out",
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
     "id": "v3",
     "maxclass": "bpatcher",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      331.2,
      94.0,
      40.0,
      22.0
     ],
     "embed": 1,
     "args": [
      "/bp_nothing"
     ],
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
       400.0,
       240.0
      ],
      "boxes": [
       {
        "box": {
         "id": "o",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          114.8,
          22.0
         ],
         "text": "j.view /bp_given"
        }
       },
       {
        "box": {
         "id": "in",
         "maxclass": "inlet",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          30.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       },
       {
        "box": {
         "id": "out",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          158.0,
          40.0,
          22.0
         ],
         "index": 1,
         "comment": ""
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "in",
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
          1
         ],
         "destination": [
          "out",
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
     "id": "a_r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      158.0,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:address"
    }
   },
   {
    "box": {
     "id": "a_sel",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      158.0,
      222.0,
      109.0,
      22.0
     ],
     "text": "route /bp_named"
    }
   },
   {
    "box": {
     "id": "a_one",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      158.0,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "r_to_v1",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      158.0,
      30.0,
      62.6,
      22.0
     ],
     "text": "r to_v1"
    }
   },
   {
    "box": {
     "id": "b_r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      314.2,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:address"
    }
   },
   {
    "box": {
     "id": "b_sel",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      314.2,
      222.0,
      109.0,
      22.0
     ],
     "text": "route /bp_given"
    }
   },
   {
    "box": {
     "id": "b_one",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      314.2,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "r_to_v2",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      244.6,
      30.0,
      62.6,
      22.0
     ],
     "text": "r to_v2"
    }
   },
   {
    "box": {
     "id": "c_r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      470.4,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:address"
    }
   },
   {
    "box": {
     "id": "c_sel",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      470.4,
      222.0,
      109.0,
      22.0
     ],
     "text": "route /bp_given"
    }
   },
   {
    "box": {
     "id": "c_one",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      470.4,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "r_to_v3",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      331.2,
      30.0,
      62.6,
      22.0
     ],
     "text": "r to_v3"
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
      417.8,
      30.0,
      68.4,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "wait",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      417.8,
      94.0,
      74.2,
      22.0
     ],
     "text": "delay 800"
    }
   },
   {
    "box": {
     "id": "low",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      626.6,
      158.0,
      68.4,
      22.0
     ],
     "text": "deferlow"
    }
   },
   {
    "box": {
     "id": "top",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      626.6,
      222.0,
      74.2,
      22.0
     ],
     "text": "t b b b b"
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
      626.6,
      286.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "a_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      903.8,
      286.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "a_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      903.8,
      350.0,
      45.2,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "a_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      929.1,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_v1"
    }
   },
   {
    "box": {
     "id": "a_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      530.9,
      350.0,
      51.0,
      22.0
     ],
     "text": "int 0"
    }
   },
   {
    "box": {
     "id": "a_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      530.9,
      414.0,
      45.2,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "a_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      530.9,
      542.0,
      549.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/bpatcher_argument/model_is_named_by_the_bpatcher_argument"
    }
   },
   {
    "box": {
     "id": "b_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      828.8,
      286.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "b_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      828.8,
      350.0,
      45.2,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "b_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      842.5,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_v2"
    }
   },
   {
    "box": {
     "id": "b_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      605.9,
      350.0,
      51.0,
      22.0
     ],
     "text": "int 0"
    }
   },
   {
    "box": {
     "id": "b_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      605.9,
      414.0,
      45.2,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "b_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1104.7,
      542.0,
      526.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/bpatcher_argument/view_binds_by_the_bpatcher_argument"
    }
   },
   {
    "box": {
     "id": "c_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      753.8,
      286.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "c_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      755.9,
      350.0,
      45.2,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "c_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      755.9,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_v3"
    }
   },
   {
    "box": {
     "id": "c_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      680.9,
      350.0,
      51.0,
      22.0
     ],
     "text": "int 0"
    }
   },
   {
    "box": {
     "id": "c_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      680.9,
      414.0,
      45.2,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "c_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1655.3,
      542.0,
      578.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/bpatcher_argument/own_argument_wins_over_the_bpatcher_argument"
    }
   },
   {
    "box": {
     "id": "tg_a_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      530.9,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_b_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1104.7,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_c_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1655.3,
      478.0,
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
      "v1",
      0
     ],
     "destination": [
      "a_r",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_r",
      0
     ],
     "destination": [
      "a_sel",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_sel",
      0
     ],
     "destination": [
      "a_one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_v1",
      0
     ],
     "destination": [
      "v1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v2",
      0
     ],
     "destination": [
      "b_r",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_r",
      0
     ],
     "destination": [
      "b_sel",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_sel",
      0
     ],
     "destination": [
      "b_one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_v2",
      0
     ],
     "destination": [
      "v2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v3",
      0
     ],
     "destination": [
      "c_r",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_r",
      0
     ],
     "destination": [
      "c_sel",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_sel",
      0
     ],
     "destination": [
      "c_one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_v3",
      0
     ],
     "destination": [
      "v3",
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
      "wait",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "wait",
      0
     ],
     "destination": [
      "low",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "low",
      0
     ],
     "destination": [
      "top",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
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
      "top",
      3
     ],
     "destination": [
      "a_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_t",
      1
     ],
     "destination": [
      "a_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_m0",
      0
     ],
     "destination": [
      "a_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_t",
      0
     ],
     "destination": [
      "a_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_one",
      0
     ],
     "destination": [
      "a_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_h",
      0
     ],
     "destination": [
      "a_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_c",
      0
     ],
     "destination": [
      "tg_a_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
      2
     ],
     "destination": [
      "b_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_t",
      1
     ],
     "destination": [
      "b_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_m0",
      0
     ],
     "destination": [
      "b_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_t",
      0
     ],
     "destination": [
      "b_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_one",
      0
     ],
     "destination": [
      "b_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_h",
      0
     ],
     "destination": [
      "b_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_c",
      0
     ],
     "destination": [
      "tg_b_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
      1
     ],
     "destination": [
      "c_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_t",
      1
     ],
     "destination": [
      "c_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_m0",
      0
     ],
     "destination": [
      "c_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_t",
      0
     ],
     "destination": [
      "c_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_one",
      0
     ],
     "destination": [
      "c_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_h",
      0
     ],
     "destination": [
      "c_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_c",
      0
     ],
     "destination": [
      "tg_c_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_a_a",
      0
     ],
     "destination": [
      "a_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_b_a",
      0
     ],
     "destination": [
      "b_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_c_a",
      0
     ],
     "destination": [
      "c_a",
      0
     ]
    }
   }
  ]
 }
}
