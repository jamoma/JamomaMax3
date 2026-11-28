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
   4097.0,
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
      689.0,
      20.0
     ],
     "text": "A bang sent to j.remote brings the current value out of it, of the parameter and of every other object on the node."
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      743.0,
      30.0,
      62.6,
      22.0
     ],
     "text": "j.model"
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
      829.6,
      30.0,
      283.0,
      22.0
     ],
     "text": "j.parameter banged @type integer @range 0 100"
    }
   },
   {
    "box": {
     "id": "p_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      829.6,
      94.0,
      91.6,
      22.0
     ],
     "text": "s rmbp_param"
    }
   },
   {
    "box": {
     "id": "a",
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
      1136.6,
      94.0,
      109.0,
      22.0
     ],
     "text": "j.remote banged"
    }
   },
   {
    "box": {
     "id": "a_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1136.6,
      30.0,
      68.4,
      22.0
     ],
     "text": "r rmbp_a"
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
      1136.6,
      158.0,
      91.6,
      22.0
     ],
     "text": "s rmbp_a_set"
    }
   },
   {
    "box": {
     "id": "a_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1252.2,
      158.0,
      103.2,
      22.0
     ],
     "text": "s rmbp_a_value"
    }
   },
   {
    "box": {
     "id": "b",
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
      1229.0,
      30.0,
      109.0,
      22.0
     ],
     "text": "j.remote banged"
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
      1269.6,
      94.0,
      103.2,
      22.0
     ],
     "text": "s rmbp_b_value"
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1362.0,
      30.0,
      114.8,
      22.0
     ],
     "text": "j.receive banged"
    }
   },
   {
    "box": {
     "id": "r_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1396.8,
      94.0,
      109.0,
      22.0
     ],
     "text": "s rmbp_received"
    }
   },
   {
    "box": {
     "id": "j.init",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1500.8,
      30.0,
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
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1529.8,
      94.0,
      74.2,
      22.0
     ],
     "text": "p a_value",
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
       530.0
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
         "id": "done",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          30.0,
          478.0,
          40.0,
          22.0
         ]
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
          94.0,
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
          158.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w2",
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
         "id": "t3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          286.0,
          51.0,
          22.0
         ],
         "text": "t b 7"
        }
       },
       {
        "box": {
         "id": "s3_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          122.4,
          350.0,
          68.4,
          22.0
         ],
         "text": "s rmbp_a"
        }
       },
       {
        "box": {
         "id": "w3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          350.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w4",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          414.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
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
          "w2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w2",
          0
         ],
         "destination": [
          "t3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t3",
          1
         ],
         "destination": [
          "s3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t3",
          0
         ],
         "destination": [
          "w3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w3",
          0
         ],
         "destination": [
          "w4",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w4",
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
     "id": "step1",
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
      1529.8,
      158.0,
      56.8,
      22.0
     ],
     "text": "p bang",
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
       1441.6,
       530.0
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
          103.2,
          22.0
         ],
         "text": "r rmbp_a_value"
        }
       },
       {
        "box": {
         "id": "o0_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          116.6,
          94.0,
          51.0,
          22.0
         ],
         "text": "sel 7"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          359.4,
          158.0,
          40.0,
          22.0
         ],
         "text": "t 1"
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
          203.5,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "zr0_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          221.2,
          30.0,
          120.6,
          22.0
         ],
         "text": "r rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "zv0_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          221.2,
          94.0,
          40.0,
          22.0
         ],
         "text": "0"
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
          365.8,
          30.0,
          91.6,
          22.0
         ],
         "text": "r rmbp_a_set"
        }
       },
       {
        "box": {
         "id": "o1_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          365.8,
          94.0,
          74.2,
          22.0
         ],
         "text": "route set"
        }
       },
       {
        "box": {
         "id": "o1_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          423.4,
          158.0,
          51.0,
          22.0
         ],
         "text": "sel 7"
        }
       },
       {
        "box": {
         "id": "o1_0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          423.4,
          222.0,
          40.0,
          22.0
         ],
         "text": "t 1"
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
          311.6,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "zr1_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          481.4,
          30.0,
          120.6,
          22.0
         ],
         "text": "r rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "zv1_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          481.4,
          94.0,
          40.0,
          22.0
         ],
         "text": "0"
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
          626.0,
          30.0,
          91.6,
          22.0
         ],
         "text": "r rmbp_param"
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
          626.0,
          94.0,
          51.0,
          22.0
         ],
         "text": "sel 7"
        }
       },
       {
        "box": {
         "id": "o2_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          626.0,
          158.0,
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
          465.9,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "zr2_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          741.6,
          30.0,
          120.6,
          22.0
         ],
         "text": "r rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "zv2_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          741.6,
          94.0,
          40.0,
          22.0
         ],
         "text": "0"
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
          886.2,
          30.0,
          103.2,
          22.0
         ],
         "text": "r rmbp_b_value"
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
          886.2,
          94.0,
          51.0,
          22.0
         ],
         "text": "sel 7"
        }
       },
       {
        "box": {
         "id": "o3_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          886.2,
          158.0,
          40.0,
          22.0
         ],
         "text": "t 1"
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
          643.2,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "zr3_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1013.4,
          30.0,
          120.6,
          22.0
         ],
         "text": "r rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "zv3_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1013.4,
          94.0,
          40.0,
          22.0
         ],
         "text": "0"
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
          1158.0,
          30.0,
          109.0,
          22.0
         ],
         "text": "r rmbp_received"
        }
       },
       {
        "box": {
         "id": "o4_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1158.0,
          94.0,
          51.0,
          22.0
         ],
         "text": "sel 7"
        }
       },
       {
        "box": {
         "id": "o4_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1158.0,
          158.0,
          40.0,
          22.0
         ],
         "text": "t 1"
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
          826.3,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
        }
       },
       {
        "box": {
         "id": "zr4_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1291.0,
          30.0,
          120.6,
          22.0
         ],
         "text": "r rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "zv4_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1291.0,
          94.0,
          40.0,
          22.0
         ],
         "text": "0"
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
          414.0,
          40.0,
          22.0
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
          203.5,
          478.0,
          40.0,
          22.0
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
          311.6,
          478.0,
          40.0,
          22.0
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
          465.9,
          478.0,
          40.0,
          22.0
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
          643.2,
          478.0,
          40.0,
          22.0
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
          826.3,
          478.0,
          40.0,
          22.0
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
          62.6,
          22.0
         ],
         "text": "t b b b"
        }
       },
       {
        "box": {
         "id": "s0_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          214.8,
          158.0,
          120.6,
          22.0
         ],
         "text": "s rmbp_bang_begin"
        }
       },
       {
        "box": {
         "id": "s0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          122.4,
          158.0,
          68.4,
          22.0
         ],
         "text": "s rmbp_a"
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
         "id": "w2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          286.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t3",
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
          350.0,
          97.4,
          22.0
         ],
         "text": "t b b b b b b"
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
          "o0_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_0",
          0
         ],
         "destination": [
          "o0_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_1",
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
          "zr0_0",
          0
         ],
         "destination": [
          "zv0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv0_0",
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
          "r1_0",
          0
         ],
         "destination": [
          "o1_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o1_0_0",
          0
         ],
         "destination": [
          "o1_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o1_0_1",
          0
         ],
         "destination": [
          "o1_0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o1_0_2",
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
          "zr1_0",
          0
         ],
         "destination": [
          "zv1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv1_0",
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
          "h2_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zr2_0",
          0
         ],
         "destination": [
          "zv2_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv2_0",
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
          "o3_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o3_0_1",
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
          "zr3_0",
          0
         ],
         "destination": [
          "zv3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv3_0",
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
          "r4_0",
          0
         ],
         "destination": [
          "o4_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o4_0_0",
          0
         ],
         "destination": [
          "o4_0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o4_0_1",
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
          "zr4_0",
          0
         ],
         "destination": [
          "zv4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "zv4_0",
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
          "h0_0",
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
          "h1_0",
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
          "h3_0",
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
          "h4_0",
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
          "s0_0",
          0
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
          "s0_1",
          0
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
          "w2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w2",
          0
         ],
         "destination": [
          "t3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t3",
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
          "t3",
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
          "t3",
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
          "t3",
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
          "t3",
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
          "t3",
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
     "id": "step1_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1657.0,
      286.0,
      468.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/bang_to_remote/it_comes_out_of_the_remote"
    }
   },
   {
    "box": {
     "id": "step1_a1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2149.6,
      286.0,
      491.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/bang_to_remote/it_comes_out_of_the_set_outlet"
    }
   },
   {
    "box": {
     "id": "step1_a2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2665.4,
      286.0,
      457.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/bang_to_remote/the_parameter_outputs_it"
    }
   },
   {
    "box": {
     "id": "step1_a3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3146.4,
      286.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/bang_to_remote/the_other_remote_outputs_it"
    }
   },
   {
    "box": {
     "id": "step1_a4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3644.8,
      286.0,
      422.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/bang_to_remote/a_receiver_gets_it"
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
      1529.8,
      222.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_step1_a0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1657.0,
      222.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step1_a1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2149.6,
      222.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step1_a2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2665.4,
      222.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step1_a3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3146.4,
      222.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step1_a4",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3644.8,
      222.0,
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
      "p",
      0
     ],
     "destination": [
      "p_s0",
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
      "a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "a",
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
      "a",
      1
     ],
     "destination": [
      "a_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "b",
      1
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
      "r",
      0
     ],
     "destination": [
      "r_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "j.init",
      0
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
      0
     ],
     "destination": [
      "step1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
      1
     ],
     "destination": [
      "tg_step1_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
      2
     ],
     "destination": [
      "tg_step1_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
      3
     ],
     "destination": [
      "tg_step1_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
      4
     ],
     "destination": [
      "tg_step1_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
      5
     ],
     "destination": [
      "tg_step1_a4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step1",
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
      "tg_step1_a0",
      0
     ],
     "destination": [
      "step1_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step1_a1",
      0
     ],
     "destination": [
      "step1_a1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step1_a2",
      0
     ],
     "destination": [
      "step1_a2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step1_a3",
      0
     ],
     "destination": [
      "step1_a3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step1_a4",
      0
     ],
     "destination": [
      "step1_a4",
      0
     ]
    }
   }
  ]
 }
}
