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
   2559.5,
   722.0
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
          103.2,
          22.0
         ],
         "text": "j.model vs_one"
        }
       },
       {
        "box": {
         "id": "p",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          157.2,
          30.0,
          201.8,
          22.0
         ],
         "text": "j.parameter level @type decimal"
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
          103.2,
          22.0
         ],
         "text": "j.model vs_two"
        }
       },
       {
        "box": {
         "id": "p",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          157.2,
          30.0,
          201.8,
          22.0
         ],
         "text": "j.parameter level @type decimal"
        }
       }
      ],
      "lines": []
     }
    }
   },
   {
    "box": {
     "id": "v",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      291.0,
      94.0,
      103.2,
      22.0
     ],
     "text": "j.view /vs_one"
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      418.2,
      94.0,
      45.2,
      22.0
     ],
     "text": "j.ui"
    }
   },
   {
    "box": {
     "id": "rc",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      158.0,
      30.0,
      109.0,
      22.0
     ],
     "text": "j.receive level"
    }
   },
   {
    "box": {
     "id": "r_to_v",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      291.0,
      30.0,
      56.8,
      22.0
     ],
     "text": "r to_v"
    }
   },
   {
    "box": {
     "id": "r_to_u",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      371.8,
      30.0,
      56.8,
      22.0
     ],
     "text": "r to_u"
    }
   },
   {
    "box": {
     "id": "sd",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      487.4,
      94.0,
      138.0,
      22.0
     ],
     "text": "j.send /vs_two/level"
    }
   },
   {
    "box": {
     "id": "r_to_two",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      452.6,
      30.0,
      68.4,
      22.0
     ],
     "text": "r to_two"
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
      291.0,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:address"
    }
   },
   {
    "box": {
     "id": "a_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      291.0,
      222.0,
      97.4,
      22.0
     ],
     "text": "route /vs_two"
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
      291.0,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
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
      603.4,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:address"
    }
   },
   {
    "box": {
     "id": "b_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      603.4,
      222.0,
      97.4,
      22.0
     ],
     "text": "route /vs_two"
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
      603.4,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "d_r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      447.2,
      158.0,
      132.2,
      22.0
     ],
     "text": "route model:waiting"
    }
   },
   {
    "box": {
     "id": "d_one",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      447.2,
      222.0,
      40.0,
      22.0
     ],
     "text": "t 1"
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
      545.0,
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
      649.4,
      94.0,
      74.2,
      22.0
     ],
     "text": "delay 800"
    }
   },
   {
    "box": {
     "id": "set",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      857.8,
      222.0,
      143.8,
      22.0
     ],
     "text": "model:address /vs_two"
    }
   },
   {
    "box": {
     "id": "sv",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      857.8,
      286.0,
      56.8,
      22.0
     ],
     "text": "s to_v"
    }
   },
   {
    "box": {
     "id": "settle",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      759.6,
      222.0,
      74.2,
      22.0
     ],
     "text": "delay 500"
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
      759.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "deferlow"
    }
   },
   {
    "box": {
     "id": "order",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      759.6,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "top",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      759.6,
      350.0,
      85.8,
      22.0
     ],
     "text": "t b b b b b"
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
      759.6,
      414.0,
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
      1135.0,
      414.0,
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
      1311.1,
      478.0,
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
      1322.7,
      542.0,
      56.8,
      22.0
     ],
     "text": "s to_v"
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
      742.0,
      478.0,
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
      742.0,
      542.0,
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
      1632.1,
      670.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/set_address/the_view_is_bound_to_the_new_model"
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
      1060.0,
      414.0,
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
      1241.9,
      478.0,
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
      1241.9,
      542.0,
      56.8,
      22.0
     ],
     "text": "s to_u"
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
      831.7,
      478.0,
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
      831.7,
      542.0,
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
      2142.1,
      670.0,
      387.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/set_address/the_panel_follows"
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
      973.4,
      414.0,
      62.6,
      22.0
     ],
     "text": "t b 0.5"
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
      1149.5,
      478.0,
      68.4,
      22.0
     ],
     "text": "s to_two"
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
      565.7,
      478.0,
      68.4,
      22.0
     ],
     "text": "float 0."
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
      565.7,
      542.0,
      56.8,
      22.0
     ],
     "text": "== 0.5"
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
      565.7,
      670.0,
      439.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/set_address/a_relative_receive_follows"
    }
   },
   {
    "box": {
     "id": "d_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      886.8,
      414.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "d_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      975.9,
      478.0,
      149.6,
      22.0
     ],
     "text": "model:address /vs_none"
    }
   },
   {
    "box": {
     "id": "d_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      987.5,
      542.0,
      56.8,
      22.0
     ],
     "text": "s to_v"
    }
   },
   {
    "box": {
     "id": "d_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      906.7,
      478.0,
      45.2,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "d_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      906.7,
      542.0,
      56.8,
      22.0
     ],
     "text": "s to_v"
    }
   },
   {
    "box": {
     "id": "d_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      667.0,
      478.0,
      51.0,
      22.0
     ],
     "text": "int 0"
    }
   },
   {
    "box": {
     "id": "d_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      667.0,
      542.0,
      45.2,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "id": "d_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1029.3,
      670.0,
      578.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.view/set_address/an_address_without_a_model_leaves_the_view_waiting"
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
      1632.1,
      606.0,
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
      2142.1,
      606.0,
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
      565.7,
      606.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_d_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1029.3,
      606.0,
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
      "r_to_v",
      0
     ],
     "destination": [
      "v",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_u",
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
      "r_to_two",
      0
     ],
     "destination": [
      "sd",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v",
      1
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
      "a_s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_s",
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
      "u",
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
      "b_s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_s",
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
      "v",
      1
     ],
     "destination": [
      "d_r",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_r",
      0
     ],
     "destination": [
      "d_one",
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
      "order",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "order",
      1
     ],
     "destination": [
      "set",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "set",
      0
     ],
     "destination": [
      "sv",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "order",
      0
     ],
     "destination": [
      "settle",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "settle",
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
      4
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
      3
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
      2
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
      "rc",
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
      "top",
      1
     ],
     "destination": [
      "d_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_t",
      2
     ],
     "destination": [
      "d_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_m0",
      0
     ],
     "destination": [
      "d_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_t",
      1
     ],
     "destination": [
      "d_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_m1",
      0
     ],
     "destination": [
      "d_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_t",
      0
     ],
     "destination": [
      "d_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_one",
      0
     ],
     "destination": [
      "d_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_h",
      0
     ],
     "destination": [
      "d_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d_c",
      0
     ],
     "destination": [
      "tg_d_a",
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
   },
   {
    "patchline": {
     "source": [
      "tg_d_a",
      0
     ],
     "destination": [
      "d_a",
      0
     ]
    }
   }
  ]
 }
}
