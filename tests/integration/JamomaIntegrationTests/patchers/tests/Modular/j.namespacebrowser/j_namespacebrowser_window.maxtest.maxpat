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
   2599.2,
   402.0
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
      909.4,
      20.0
     ],
     "text": "The window of the namespace browser is the model /namespacebrowser; opening it as the view does gives its parameters (clicking in it is checked by hand)."
    }
   },
   {
    "box": {
     "id": "w",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1609.2,
      94.0,
      68.4,
      22.0
     ],
     "text": "pcontrol"
    }
   },
   {
    "box": {
     "id": "w_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1609.2,
      30.0,
      80.0,
      22.0
     ],
     "text": "r nbw_open"
    }
   },
   {
    "box": {
     "id": "a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1713.2,
      30.0,
      225.0,
      22.0
     ],
     "text": "j.receive /namespacebrowser/address"
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
      1713.2,
      94.0,
      97.4,
      22.0
     ],
     "text": "s nbw_address"
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1962.2,
      94.0,
      207.6,
      22.0
     ],
     "text": "j.send /namespacebrowser/address"
    }
   },
   {
    "box": {
     "id": "s_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1962.2,
      30.0,
      91.6,
      22.0
     ],
     "text": "r nbw_choose"
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
      2077.8,
      30.0,
      265.6,
      22.0
     ],
     "text": "j.receive /namespacebrowser/filter:service"
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
      2193.8,
      94.0,
      97.4,
      22.0
     ],
     "text": "s nbw_service"
    }
   },
   {
    "box": {
     "id": "c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2367.4,
      94.0,
      201.8,
      22.0
     ],
     "text": "j.send /namespacebrowser/closed"
    }
   },
   {
    "box": {
     "id": "c_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2367.4,
      30.0,
      85.8,
      22.0
     ],
     "text": "r nbw_close"
    }
   },
   {
    "box": {
     "id": "loadbang",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      60.0,
      68.4,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "step0",
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
      124.0,
      1063.2,
      22.0
     ],
     "text": "p there",
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
       866.0,
       1130.0
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
          30.0,
          30.0
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
          420.8,
          870.0,
          97.4,
          22.0
         ],
         "text": "r nbw_service"
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
          420.8,
          910.0,
          85.8,
          22.0
         ],
         "text": "sel message"
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
          420.8,
          950.0,
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
          420.8,
          990.0,
          51.0,
          22.0
         ],
         "text": "int 0"
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
          542.2,
          830.0,
          97.4,
          22.0
         ],
         "text": "r nbw_address"
        }
       },
       {
        "box": {
         "id": "o1_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          542.2,
          870.0,
          161.2,
          22.0
         ],
         "text": "zl.compare /some/address"
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
          542.2,
          910.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
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
          542.2,
          950.0,
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
          542.2,
          990.0,
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
          715.4,
          910.0,
          120.6,
          22.0
         ],
         "text": "r nbw_there_begin"
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
          715.4,
          950.0,
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
          1070.0,
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
          420.8,
          1070.0,
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
          542.2,
          1070.0,
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
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          70.0,
          51.0,
          22.0
         ],
         "text": "t b b"
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
          150.0,
          110.0,
          120.6,
          22.0
         ],
         "text": "s nbw_there_begin"
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
          150.0,
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
          190.0,
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
          230.0,
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
          270.0,
          51.0,
          22.0
         ],
         "text": "t b b"
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
          150.0,
          350.0,
          80.0,
          22.0
         ],
         "text": "s nbw_open"
        }
       },
       {
        "box": {
         "id": "m3_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          310.0,
          230.8,
          22.0
         ],
         "text": "loadunique j.namespacebrowser.maxpat"
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
          390.0,
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
          430.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w5",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          470.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w6",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          510.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w7",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          550.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w8",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          590.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w9",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          630.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w10",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          670.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t11",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          710.0,
          51.0,
          22.0
         ],
         "text": "t b b"
        }
       },
       {
        "box": {
         "id": "s11_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          790.0,
          91.6,
          22.0
         ],
         "text": "s nbw_choose"
        }
       },
       {
        "box": {
         "id": "m11_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          750.0,
          97.4,
          22.0
         ],
         "text": "/some/address"
        }
       },
       {
        "box": {
         "id": "w11",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          830.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w12",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          870.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "w13",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          910.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t14",
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
          950.0,
          62.6,
          22.0
         ],
         "text": "t b b b"
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
          1
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
          "m3_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m3_0",
          0
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
          "w5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w5",
          0
         ],
         "destination": [
          "w6",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w6",
          0
         ],
         "destination": [
          "w7",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w7",
          0
         ],
         "destination": [
          "w8",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w8",
          0
         ],
         "destination": [
          "w9",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w9",
          0
         ],
         "destination": [
          "w10",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w10",
          0
         ],
         "destination": [
          "t11",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t11",
          1
         ],
         "destination": [
          "m11_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m11_0",
          0
         ],
         "destination": [
          "s11_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t11",
          0
         ],
         "destination": [
          "w11",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w11",
          0
         ],
         "destination": [
          "w12",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w12",
          0
         ],
         "destination": [
          "w13",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "w13",
          0
         ],
         "destination": [
          "t14",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t14",
          2
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
          "t14",
          1
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
          "t14",
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
      552.1,
      194.0,
      497.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespacebrowser/window/its_model_is_namespacebrowser"
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
      1074.2,
      194.0,
      457.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.namespacebrowser/window/its_address_can_be_set"
    }
   },
   {
    "box": {
     "id": "step1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      244.0,
      62.6,
      22.0
     ],
     "text": "p close",
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
       410.0
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
          30.0,
          30.0
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
          350.0,
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
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          70.0,
          51.0,
          22.0
         ],
         "text": "t b b"
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
          150.0,
          110.0,
          85.8,
          22.0
         ],
         "text": "s nbw_close"
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
          150.0,
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
          190.0,
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
          230.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
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
          270.0,
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
          "t0",
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
          "s0_0",
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
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      308.0,
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
      552.1,
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
      1074.2,
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
      "w_r0",
      0
     ],
     "destination": [
      "w",
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
      "s_r0",
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
      "c_r0",
      0
     ],
     "destination": [
      "c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "loadbang",
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
   }
  ]
 }
}
