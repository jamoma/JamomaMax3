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
   2474.6,
   594.0
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
      80.0,
      22.0
     ],
     "text": "j.model sw"
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
      238.0,
      94.0,
      45.2,
      22.0
     ],
     "text": "j.ui"
    }
   },
   {
    "box": {
     "id": "u2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      307.2,
      94.0,
      45.2,
      22.0
     ],
     "text": "j.ui"
    }
   },
   {
    "box": {
     "id": "sp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      238.0,
      158.0,
      62.6,
      22.0
     ],
     "text": "p panel",
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
         "id": "s",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          94.0,
          68.4,
          22.0
         ],
         "text": "s sw_got"
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
          "s",
          0
         ]
        }
       }
      ]
     },
     "varname": "sp"
    }
   },
   {
    "box": {
     "id": "got",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      134.0,
      30.0,
      68.4,
      22.0
     ],
     "text": "r sw_got"
    }
   },
   {
    "box": {
     "id": "js",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      393.8,
      94.0,
      184.4,
      22.0
     ],
     "text": "js subwindow_state.js sp /sw"
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
      226.4,
      30.0,
      56.8,
      22.0
     ],
     "text": "r to_u"
    }
   },
   {
    "box": {
     "id": "r_to_u2",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      307.2,
      30.0,
      62.6,
      22.0
     ],
     "text": "r to_u2"
    }
   },
   {
    "box": {
     "id": "r_to_js",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      393.8,
      30.0,
      62.6,
      22.0
     ],
     "text": "r to_js"
    }
   },
   {
    "box": {
     "id": "a_r0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      324.6,
      158.0,
      85.8,
      22.0
     ],
     "text": "route panel"
    }
   },
   {
    "box": {
     "id": "a_r1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      324.6,
      222.0,
      62.6,
      22.0
     ],
     "text": "route 1"
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
      324.6,
      286.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "b_r0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      434.4,
      158.0,
      85.8,
      22.0
     ],
     "text": "route panel"
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
      434.4,
      222.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "c_r0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      134.0,
      94.0,
      80.0,
      22.0
     ],
     "text": "route bang"
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
      134.0,
      158.0,
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
      480.4,
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
      602.2,
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
      602.2,
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
     "numoutlets": 5,
     "outlettype": [
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      602.2,
      222.0,
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
      602.2,
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
      966.0,
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
      1083.7,
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
      1135.9,
      414.0,
      56.8,
      22.0
     ],
     "text": "s to_u"
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
      645.3,
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
      645.3,
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
      1477.6,
      542.0,
      509.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.ui/subwindow/has_a_panel_when_a_subpatcher_is_connected"
    }
   },
   {
    "box": {
     "id": "b_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      879.4,
      286.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
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
      1008.7,
      350.0,
      51.0,
      22.0
     ],
     "text": "panel"
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
      1049.3,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_u2"
    }
   },
   {
    "box": {
     "id": "b_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      939.5,
      350.0,
      45.2,
      22.0
     ],
     "text": "dump"
    }
   },
   {
    "box": {
     "id": "b_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      962.7,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_u2"
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
      720.3,
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
      720.3,
      414.0,
      45.2,
      22.0
     ],
     "text": "== 0"
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
      2010.8,
      542.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.ui/subwindow/has_none_without_a_subpatcher"
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
      804.4,
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
      864.5,
      350.0,
      51.0,
      22.0
     ],
     "text": "panel"
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
      881.9,
      414.0,
      56.8,
      22.0
     ],
     "text": "s to_u"
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
      469.2,
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
      469.2,
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
      469.2,
      542.0,
      381.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.ui/subwindow/a_click_sends_a_bang"
    }
   },
   {
    "box": {
     "id": "d_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      729.4,
      286.0,
      51.0,
      22.0
     ],
     "text": "t b b"
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
      795.3,
      350.0,
      45.2,
      22.0
     ],
     "text": "bang"
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
      795.3,
      414.0,
      62.6,
      22.0
     ],
     "text": "s to_js"
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
      561.6,
      350.0,
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
      561.6,
      414.0,
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
      874.8,
      542.0,
      578.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.ui/subwindow/a_click_shows_the_subpatcher_with_the_address_as_title"
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
      1477.6,
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
      2010.8,
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
      469.2,
      478.0,
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
      874.8,
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
      "u",
      0
     ],
     "destination": [
      "sp",
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
      "r_to_u2",
      0
     ],
     "destination": [
      "u2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_js",
      0
     ],
     "destination": [
      "js",
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
      "a_r0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_r0",
      0
     ],
     "destination": [
      "a_r1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a_r1",
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
      "u2",
      0
     ],
     "destination": [
      "b_r0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_r0",
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
      "got",
      0
     ],
     "destination": [
      "c_r0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "c_r0",
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
      2
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
      1
     ],
     "destination": [
      "b_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b_m1",
      0
     ],
     "destination": [
      "b_s1",
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
      1
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
      "js",
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
