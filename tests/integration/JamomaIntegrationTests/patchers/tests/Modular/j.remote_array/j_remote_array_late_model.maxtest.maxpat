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
   1429.2,
   458.0
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
      515.0,
      20.0
     ],
     "text": "A remote array that comes before its model and its parameters binds when they appear."
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      1128.2,
      94.0,
      161.2,
      22.0
     ],
     "text": "j.remote_array rml_n.[2]"
    }
   },
   {
    "box": {
     "id": "r_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1128.2,
      30.0,
      68.4,
      22.0
     ],
     "text": "r rml_in"
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
      1313.4,
      94.0,
      85.8,
      22.0
     ],
     "text": "thispatcher"
    }
   },
   {
    "box": {
     "id": "tp_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1220.6,
      30.0,
      97.4,
      22.0
     ],
     "text": "r rml_patcher"
    }
   },
   {
    "box": {
     "id": "rml_shown_pack",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1128.2,
      158.0,
      68.4,
      22.0
     ],
     "text": "pack 0 0"
    }
   },
   {
    "box": {
     "id": "rml_shown_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1128.2,
      222.0,
      85.8,
      22.0
     ],
     "text": "s rml_shown"
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
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      124.0,
      501.0,
      22.0
     ],
     "text": "p they_appear",
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
       994.0,
       1210.0
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
          693.4,
          910.0,
          85.8,
          22.0
         ],
         "text": "r rml_shown"
        }
       },
       {
        "box": {
         "id": "o0_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          693.4,
          950.0,
          103.2,
          22.0
         ],
         "text": "zl.compare 4 2"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          693.4,
          990.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          693.4,
          1030.0,
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
          693.4,
          1070.0,
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
          808.6,
          990.0,
          155.4,
          22.0
         ],
         "text": "r rml_they_appear_begin"
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
          808.6,
          1030.0,
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
          1150.0,
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
          693.4,
          1150.0,
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
          155.4,
          22.0
         ],
         "text": "s rml_they_appear_begin"
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
          97.4,
          22.0
         ],
         "text": "s rml_patcher"
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
          265.6,
          22.0
         ],
         "text": "script newdefault m1 600 500 j.model rml_m"
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
         "id": "t6",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          510.0,
          51.0,
          22.0
         ],
         "text": "t b b"
        }
       },
       {
        "box": {
         "id": "s6_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          590.0,
          97.4,
          22.0
         ],
         "text": "s rml_patcher"
        }
       },
       {
        "box": {
         "id": "m6_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          550.0,
          503.4,
          22.0
         ],
         "text": "script newdefault p1 600 540 j.parameter_array rml_n.[2] @type integer @range 0 100"
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
          630.0,
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
          670.0,
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
          710.0,
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
          750.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t10",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          790.0,
          51.0,
          22.0
         ],
         "text": "t b b"
        }
       },
       {
        "box": {
         "id": "s10_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          870.0,
          68.4,
          22.0
         ],
         "text": "s rml_in"
        }
       },
       {
        "box": {
         "id": "m10_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          830.0,
          74.2,
          22.0
         ],
         "text": "array 3 4"
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
          910.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
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
          950.0,
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
          990.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t13",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          1030.0,
          51.0,
          22.0
         ],
         "text": "t b b"
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
          "o0_0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_2",
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
          "t6",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t6",
          1
         ],
         "destination": [
          "m6_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m6_0",
          0
         ],
         "destination": [
          "s6_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t6",
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
          "t10",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t10",
          1
         ],
         "destination": [
          "m10_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m10_0",
          0
         ],
         "destination": [
          "s10_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t10",
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
          "t13",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t13",
          1
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
          "t13",
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
      512.0,
      194.0,
      457.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote_array/late_model/binds_when_they_appear"
    }
   },
   {
    "box": {
     "id": "step1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      244.0,
      541.6,
      22.0
     ],
     "text": "p the_model_goes",
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
       811.6,
       770.0
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
          493.6,
          470.0,
          85.8,
          22.0
         ],
         "text": "r rml_shown"
        }
       },
       {
        "box": {
         "id": "o0_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          493.6,
          510.0,
          103.2,
          22.0
         ],
         "text": "zl.compare 6 2"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          493.6,
          550.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          493.6,
          590.0,
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
          493.6,
          630.0,
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
          608.8,
          550.0,
          172.8,
          22.0
         ],
         "text": "r rml_the_model_goes_begin"
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
          608.8,
          590.0,
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
          710.0,
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
          493.6,
          710.0,
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
          70.0,
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
          280.8,
          110.0,
          172.8,
          22.0
         ],
         "text": "s rml_the_model_goes_begin"
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
          150.0,
          150.0,
          97.4,
          22.0
         ],
         "text": "s rml_patcher"
        }
       },
       {
        "box": {
         "id": "m0_1",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          110.0,
          114.8,
          22.0
         ],
         "text": "script delete m1"
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
          190.0,
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
          230.0,
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
          270.0,
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
          310.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t4",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          350.0,
          51.0,
          22.0
         ],
         "text": "t b b"
        }
       },
       {
        "box": {
         "id": "s4_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          430.0,
          68.4,
          22.0
         ],
         "text": "s rml_in"
        }
       },
       {
        "box": {
         "id": "m4_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          390.0,
          74.2,
          22.0
         ],
         "text": "array 5 6"
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
          470.0,
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
          510.0,
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
          550.0,
          68.4,
          22.0
         ],
         "text": "deferlow"
        }
       },
       {
        "box": {
         "id": "t7",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          590.0,
          51.0,
          22.0
         ],
         "text": "t b b"
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
          "o0_0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_2",
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
          "m0_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m0_1",
          0
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
          "t4",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t4",
          1
         ],
         "destination": [
          "m4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m4_0",
          0
         ],
         "destination": [
          "s4_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t4",
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
          "t7",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t7",
          1
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
          "t7",
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
      552.6,
      314.0,
      497.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote_array/late_model/follows_the_nodes_to_the_root"
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
      364.0,
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
      512.0,
      160.0,
      24.0,
      24.0
     ]
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
      552.6,
      280.0,
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
      "r_r0",
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
      "tp_r0",
      0
     ],
     "destination": [
      "tp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      2
     ],
     "destination": [
      "rml_shown_pack",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      1
     ],
     "destination": [
      "rml_shown_pack",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rml_shown_pack",
      0
     ],
     "destination": [
      "rml_shown_s",
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
      "tg_step1_a0",
      0
     ],
     "destination": [
      "step1_a0",
      0
     ]
    }
   }
  ]
 }
}
