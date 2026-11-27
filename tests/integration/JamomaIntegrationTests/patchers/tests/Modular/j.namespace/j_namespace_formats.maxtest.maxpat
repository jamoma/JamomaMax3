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
   5652.6,
   338.0
  ],
  "boxes": [
   {
    "box": {
     "id": "about",
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      364.2,
      20.0
     ],
     "text": "The result in the formats of umenu, jit.cellblock and coll."
    }
   },
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
      2936.2,
      30.0,
      80.0,
      22.0
     ],
     "text": "j.model pm"
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3040.2,
      30.0,
      265.6,
      22.0
     ],
     "text": "j.parameter alpha @type integer @default 1"
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3329.8,
      30.0,
      259.8,
      22.0
     ],
     "text": "j.parameter beta @type integer @default 2"
    }
   },
   {
    "box": {
     "id": "um",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      3613.6,
      94.0,
      341.0,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format umenu"
    }
   },
   {
    "box": {
     "id": "um_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3613.6,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_to_formats"
    }
   },
   {
    "box": {
     "id": "um_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3613.6,
      158.0,
      132.2,
      22.0
     ],
     "text": "s ns_fmt_from_umenu"
    }
   },
   {
    "box": {
     "id": "up",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      3978.6,
      94.0,
      381.6,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format umenu_prefix"
    }
   },
   {
    "box": {
     "id": "up_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3769.8,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_to_formats"
    }
   },
   {
    "box": {
     "id": "up_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      3978.6,
      158.0,
      138.0,
      22.0
     ],
     "text": "s ns_fmt_from_prefix"
    }
   },
   {
    "box": {
     "id": "cb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      4384.2,
      94.0,
      387.4,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format jit.cellblock"
    }
   },
   {
    "box": {
     "id": "cb_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3926.0,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_to_formats"
    }
   },
   {
    "box": {
     "id": "cb_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      4384.2,
      158.0,
      132.2,
      22.0
     ],
     "text": "s ns_fmt_from_cells"
    }
   },
   {
    "box": {
     "id": "co",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      4795.6,
      94.0,
      335.2,
      22.0
     ],
     "text": "j.namespace @address /pm @output children @format coll"
    }
   },
   {
    "box": {
     "id": "co_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4082.2,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_to_formats"
    }
   },
   {
    "box": {
     "id": "co_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      4795.6,
      158.0,
      126.4,
      22.0
     ],
     "text": "s ns_fmt_from_coll"
    }
   },
   {
    "box": {
     "id": "append_r",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4238.4,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_from_umenu"
    }
   },
   {
    "box": {
     "id": "append_route",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5154.8,
      94.0,
      91.6,
      22.0
     ],
     "text": "route append"
    }
   },
   {
    "box": {
     "id": "append_count",
     "maxclass": "newobj",
     "numinlets": 5,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      5154.8,
      222.0,
      103.2,
      22.0
     ],
     "text": "counter 1 1000"
    }
   },
   {
    "box": {
     "id": "append_bang",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      5154.8,
      158.0,
      40.0,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "append_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      5154.8,
      286.0,
      143.8,
      22.0
     ],
     "text": "s ns_fmt_count_append"
    }
   },
   {
    "box": {
     "id": "clear_r",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4394.6,
      30.0,
      132.2,
      22.0
     ],
     "text": "r ns_fmt_from_umenu"
    }
   },
   {
    "box": {
     "id": "clear_route",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5270.4,
      94.0,
      85.8,
      22.0
     ],
     "text": "route clear"
    }
   },
   {
    "box": {
     "id": "clear_count",
     "maxclass": "newobj",
     "numinlets": 5,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      5282.0,
      222.0,
      103.2,
      22.0
     ],
     "text": "counter 1 1000"
    }
   },
   {
    "box": {
     "id": "clear_bang",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      5270.4,
      158.0,
      40.0,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "clear_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      5322.6,
      286.0,
      138.0,
      22.0
     ],
     "text": "s ns_fmt_count_clear"
    }
   },
   {
    "box": {
     "id": "store_r",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4550.8,
      30.0,
      126.4,
      22.0
     ],
     "text": "r ns_fmt_from_coll"
    }
   },
   {
    "box": {
     "id": "store_route",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5380.2,
      94.0,
      85.8,
      22.0
     ],
     "text": "route store"
    }
   },
   {
    "box": {
     "id": "store_count",
     "maxclass": "newobj",
     "numinlets": 5,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      5409.2,
      222.0,
      103.2,
      22.0
     ],
     "text": "counter 1 1000"
    }
   },
   {
    "box": {
     "id": "store_bang",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      5380.2,
      158.0,
      40.0,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "store_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      5484.6,
      286.0,
      138.0,
      22.0
     ],
     "text": "s ns_fmt_count_store"
    }
   },
   {
    "box": {
     "id": "ji",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      60.0,
      56.8,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "step0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 6,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      124.0,
      2425.0,
      22.0
     ],
     "text": "p output_every_format",
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
       910.0,
       538.0
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
         ]
        }
       },
       {
        "box": {
         "id": "r0_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          94.0,
          30.0,
          143.8,
          22.0
         ],
         "text": "r ns_fmt_count_append"
        }
       },
       {
        "box": {
         "id": "h0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          250.2,
          350.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "c0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          250.2,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 2"
        }
       },
       {
        "box": {
         "id": "r1_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          261.8,
          30.0,
          138.0,
          22.0
         ],
         "text": "r ns_fmt_count_clear"
        }
       },
       {
        "box": {
         "id": "h1_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          325.2,
          350.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "c1_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          325.2,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 1"
        }
       },
       {
        "box": {
         "id": "r2_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          423.8,
          30.0,
          138.0,
          22.0
         ],
         "text": "r ns_fmt_from_prefix"
        }
       },
       {
        "box": {
         "id": "o2_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          423.8,
          94.0,
          91.6,
          22.0
         ],
         "text": "route prefix"
        }
       },
       {
        "box": {
         "id": "o2_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          423.8,
          158.0,
          68.4,
          22.0
         ],
         "text": "sel /pm/"
        }
       },
       {
        "box": {
         "id": "o2_0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          423.8,
          222.0,
          40.0,
          22.0
         ],
         "text": "t 1"
        }
       },
       {
        "box": {
         "id": "h2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          400.2,
          350.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "r3_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          585.8,
          30.0,
          132.2,
          22.0
         ],
         "text": "r ns_fmt_from_cells"
        }
       },
       {
        "box": {
         "id": "o3_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          585.8,
          94.0,
          80.0,
          22.0
         ],
         "text": "route rows"
        }
       },
       {
        "box": {
         "id": "h3_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          475.2,
          350.0,
          56.8,
          22.0
         ],
         "text": "int -1"
        }
       },
       {
        "box": {
         "id": "c3_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          475.2,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 2"
        }
       },
       {
        "box": {
         "id": "r4_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          742.0,
          30.0,
          138.0,
          22.0
         ],
         "text": "r ns_fmt_count_store"
        }
       },
       {
        "box": {
         "id": "h4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          556.0,
          350.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "c4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          556.0,
          414.0,
          45.2,
          22.0
         ],
         "text": "== 2"
        }
       },
       {
        "box": {
         "id": "done",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out0",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          120.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out1",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          210.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out2",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          300.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out3",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          390.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out4",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          480.0,
          478.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "t0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 3,
         "outlettype": [
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          94.0,
          68.4,
          22.0
         ],
         "text": "t b -1 0"
        }
       },
       {
        "box": {
         "id": "w0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          158.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          222.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 7,
         "outlettype": [
          "",
          "",
          "",
          "",
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          286.0,
          109.0,
          22.0
         ],
         "text": "t b b b b b b b"
        }
       },
       {
        "box": {
         "id": "s2_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          94.0,
          350.0,
          132.2,
          22.0
         ],
         "text": "s ns_fmt_to_formats"
        }
       }
      ],
      "lines": [
       {
        "patchline": {
         "source": [
          "r0_0",
          0
         ],
         "destination": [
          "h0_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h0_0",
          0
         ],
         "destination": [
          "c0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r1_0",
          0
         ],
         "destination": [
          "h1_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h1_0",
          0
         ],
         "destination": [
          "c1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r2_0",
          0
         ],
         "destination": [
          "o2_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o2_0_0",
          0
         ],
         "destination": [
          "o2_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o2_0_1",
          0
         ],
         "destination": [
          "o2_0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o2_0_2",
          0
         ],
         "destination": [
          "h2_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r3_0",
          0
         ],
         "destination": [
          "o3_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o3_0_0",
          0
         ],
         "destination": [
          "h3_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h3_0",
          0
         ],
         "destination": [
          "c3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r4_0",
          0
         ],
         "destination": [
          "h4_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h4_0",
          0
         ],
         "destination": [
          "c4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c0_0",
          0
         ],
         "destination": [
          "out0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c1_0",
          0
         ],
         "destination": [
          "out1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h2_0",
          0
         ],
         "destination": [
          "out2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c3_0",
          0
         ],
         "destination": [
          "out3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c4_0",
          0
         ],
         "destination": [
          "out4",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "in",
          0
         ],
         "destination": [
          "t0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          2
         ],
         "destination": [
          "h2_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          1
         ],
         "destination": [
          "h3_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t0",
          0
         ],
         "destination": [
          "w0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w0",
          0
         ],
         "destination": [
          "w1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w1",
          0
         ],
         "destination": [
          "t2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          6
         ],
         "destination": [
          "s2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          5
         ],
         "destination": [
          "h0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          4
         ],
         "destination": [
          "h1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          3
         ],
         "destination": [
          "h2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          2
         ],
         "destination": [
          "h3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          1
         ],
         "destination": [
          "h4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t2",
          0
         ],
         "destination": [
          "done",
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
     "id": "step0_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      511.2,
      194.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_appends_every_item"
    }
   },
   {
    "box": {
     "id": "step0_a1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      992.4,
      194.0,
      393.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_clears_once"
    }
   },
   {
    "box": {
     "id": "step0_a2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1473.6,
      194.0,
      457.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/umenu_prefix_sets_the_prefix"
    }
   },
   {
    "box": {
     "id": "step0_a3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1954.8,
      194.0,
      451.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/jit_cellblock_sets_the_rows"
    }
   },
   {
    "box": {
     "id": "step0_a4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2436.0,
      194.0,
      422.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespace/formats/coll_stores_every_item"
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
      30.0,
      244.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_step0_a0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      511.2,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      992.4,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1473.6,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1954.8,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a4",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2436.0,
      160.0,
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
      "um_r0",
      0
     ],
     "destination": [
      "um",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "um",
      0
     ],
     "destination": [
      "um_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "up_r0",
      0
     ],
     "destination": [
      "up",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "up",
      0
     ],
     "destination": [
      "up_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cb_r0",
      0
     ],
     "destination": [
      "cb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cb",
      0
     ],
     "destination": [
      "cb_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co_r0",
      0
     ],
     "destination": [
      "co",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "co",
      0
     ],
     "destination": [
      "co_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "append_r",
      0
     ],
     "destination": [
      "append_route",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "append_route",
      0
     ],
     "destination": [
      "append_bang",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "append_bang",
      0
     ],
     "destination": [
      "append_count",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "append_count",
      0
     ],
     "destination": [
      "append_s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clear_r",
      0
     ],
     "destination": [
      "clear_route",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clear_route",
      0
     ],
     "destination": [
      "clear_bang",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clear_bang",
      0
     ],
     "destination": [
      "clear_count",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clear_count",
      0
     ],
     "destination": [
      "clear_s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "store_r",
      0
     ],
     "destination": [
      "store_route",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "store_route",
      0
     ],
     "destination": [
      "store_bang",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "store_bang",
      0
     ],
     "destination": [
      "store_count",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "store_count",
      0
     ],
     "destination": [
      "store_s",
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
      "step0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      1
     ],
     "destination": [
      "tg_step0_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      2
     ],
     "destination": [
      "tg_step0_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      3
     ],
     "destination": [
      "tg_step0_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      4
     ],
     "destination": [
      "tg_step0_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      5
     ],
     "destination": [
      "tg_step0_a4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
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
      "tg_step0_a0",
      0
     ],
     "destination": [
      "step0_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a1",
      0
     ],
     "destination": [
      "step0_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a2",
      0
     ],
     "destination": [
      "step0_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a3",
      0
     ],
     "destination": [
      "step0_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a4",
      0
     ],
     "destination": [
      "step0_a4",
      0
     ]
    }
   }
  ]
 }
}
