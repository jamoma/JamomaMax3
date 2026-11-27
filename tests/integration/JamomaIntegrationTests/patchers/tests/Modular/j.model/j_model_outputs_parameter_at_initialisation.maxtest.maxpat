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
   7473.0,
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
      433.8,
      20.0
     ],
     "text": "At initialisation the model outputs the parameters that have a default."
    }
   },
   {
    "box": {
     "id": "obj-1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5144.8,
      30.0,
      62.6,
      22.0
     ],
     "text": "j.model"
    }
   },
   {
    "box": {
     "id": "obj-1_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      5144.8,
      94.0,
      138.0,
      22.0
     ],
     "text": "s mod_ini_from_model"
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5231.4,
      30.0,
      271.4,
      22.0
     ],
     "text": "j.parameter aaa @type decimal @default 3.14"
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5526.8,
      30.0,
      259.8,
      22.0
     ],
     "text": "j.parameter bbb @type integer @default 54"
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      5810.6,
      30.0,
      271.4,
      22.0
     ],
     "text": "j.parameter ccc @type string @default hello"
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      6106.0,
      30.0,
      254.0,
      22.0
     ],
     "text": "j.parameter ddd @type boolean @default 1"
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      6384.0,
      30.0,
      300.4,
      22.0
     ],
     "text": "j.parameter eee @type array @default 1.1 2.2 3.3"
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      6708.4,
      30.0,
      306.2,
      22.0
     ],
     "text": "j.parameter fff @type generic @default 5.67 foo 2"
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      7038.6,
      30.0,
      190.2,
      22.0
     ],
     "text": "j.parameter ggg @type decimal"
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      7252.8,
      30.0,
      190.2,
      22.0
     ],
     "text": "j.parameter hhh @type integer"
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
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
     "numoutlets": 9,
     "outlettype": [
      "",
      "",
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
      124.0,
      4517.6,
      22.0
     ],
     "text": "p after_initialisation",
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
       1521.6,
       330.0
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
          202.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
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
          202.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route aaa"
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
          202.2,
          150.0,
          74.2,
          22.0
         ],
         "text": "float -1."
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
          202.2,
          190.0,
          62.6,
          22.0
         ],
         "text": "== 3.14"
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
          364.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
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
          364.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route bbb"
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
          364.2,
          150.0,
          56.8,
          22.0
         ],
         "text": "int -1"
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
          364.2,
          190.0,
          51.0,
          22.0
         ],
         "text": "== 54"
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
          526.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
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
          526.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ccc"
        }
       },
       {
        "box": {
         "id": "h2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          526.2,
          150.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c2_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          526.2,
          190.0,
          114.8,
          22.0
         ],
         "text": "zl compare hello"
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
          688.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
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
          688.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ddd"
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
          688.2,
          150.0,
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
          688.2,
          190.0,
          45.2,
          22.0
         ],
         "text": "== 1"
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
          850.2,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
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
          850.2,
          110.0,
          74.2,
          22.0
         ],
         "text": "route eee"
        }
       },
       {
        "box": {
         "id": "h4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          850.2,
          150.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c4_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          850.2,
          190.0,
          149.6,
          22.0
         ],
         "text": "zl compare 1.1 2.2 3.3"
        }
       },
       {
        "box": {
         "id": "r5_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1023.8,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
        }
       },
       {
        "box": {
         "id": "o5_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1023.8,
          110.0,
          74.2,
          22.0
         ],
         "text": "route fff"
        }
       },
       {
        "box": {
         "id": "h5_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1023.8,
          150.0,
          85.8,
          22.0
         ],
         "text": "zl reg none"
        }
       },
       {
        "box": {
         "id": "c5_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1023.8,
          190.0,
          143.8,
          22.0
         ],
         "text": "zl compare 5.67 foo 2"
        }
       },
       {
        "box": {
         "id": "r6_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1191.6,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
        }
       },
       {
        "box": {
         "id": "o6_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1191.6,
          110.0,
          74.2,
          22.0
         ],
         "text": "route ggg"
        }
       },
       {
        "box": {
         "id": "h6_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1191.6,
          150.0,
          74.2,
          22.0
         ],
         "text": "float -1."
        }
       },
       {
        "box": {
         "id": "c6_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1191.6,
          190.0,
          51.0,
          22.0
         ],
         "text": "== 0."
        }
       },
       {
        "box": {
         "id": "r7_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1353.6,
          70.0,
          138.0,
          22.0
         ],
         "text": "r mod_ini_from_model"
        }
       },
       {
        "box": {
         "id": "o7_0_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          1353.6,
          110.0,
          74.2,
          22.0
         ],
         "text": "route hhh"
        }
       },
       {
        "box": {
         "id": "h7_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1353.6,
          150.0,
          56.8,
          22.0
         ],
         "text": "int -1"
        }
       },
       {
        "box": {
         "id": "c7_0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          1353.6,
          190.0,
          45.2,
          22.0
         ],
         "text": "== 0"
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
          270.0,
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
          202.2,
          270.0,
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
          364.2,
          270.0,
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
          526.2,
          270.0,
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
          688.2,
          270.0,
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
          850.2,
          270.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out5",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          1023.8,
          270.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out6",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          1191.6,
          270.0,
          30.0,
          30.0
         ]
        }
       },
       {
        "box": {
         "id": "out7",
         "maxclass": "outlet",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          1353.6,
          270.0,
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
         "numoutlets": 9,
         "outlettype": [
          "",
          "",
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
          110.0,
          132.2,
          22.0
         ],
         "text": "t b b b b b b b b b"
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
          "h2_0",
          1
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
          "c2_0",
          0
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
          "r5_0",
          0
         ],
         "destination": [
          "o5_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o5_0_0",
          0
         ],
         "destination": [
          "h5_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h5_0",
          0
         ],
         "destination": [
          "c5_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r6_0",
          0
         ],
         "destination": [
          "o6_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o6_0_0",
          0
         ],
         "destination": [
          "h6_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h6_0",
          0
         ],
         "destination": [
          "c6_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "r7_0",
          0
         ],
         "destination": [
          "o7_0_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o7_0_0",
          0
         ],
         "destination": [
          "h7_0",
          1
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "h7_0",
          0
         ],
         "destination": [
          "c7_0",
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
          "c2_0",
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
          "c5_0",
          0
         ],
         "destination": [
          "out5",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c6_0",
          0
         ],
         "destination": [
          "out6",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "c7_0",
          0
         ],
         "destination": [
          "out7",
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
          8
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
          "t0",
          7
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
          "t0",
          6
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
          "t0",
          5
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
          "t0",
          4
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
          "t0",
          3
         ],
         "destination": [
          "h5_0",
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
          "h6_0",
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
          "h7_0",
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
      592.3,
      194.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/decimal_with_value"
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
      1154.6,
      194.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/integer_with_value"
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
      1717.0,
      194.0,
      468.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/string_with_value"
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
      2279.3,
      194.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/boolean_with_value"
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
      2841.6,
      194.0,
      462.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/array_with_value"
    }
   },
   {
    "box": {
     "id": "step0_a5",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3403.9,
      194.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/generic_with_value"
    }
   },
   {
    "box": {
     "id": "step0_a6",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3966.3,
      194.0,
      538.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/decimal_without_default_value"
    }
   },
   {
    "box": {
     "id": "step0_a7",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      4528.6,
      194.0,
      538.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/outputs_parameter_change/integer_without_default_value"
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
      592.3,
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
      1154.6,
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
      1717.0,
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
      2279.3,
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
      2841.6,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a5",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3403.9,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a6",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      3966.3,
      160.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step0_a7",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      4528.6,
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
      "obj-1",
      0
     ],
     "destination": [
      "obj-1_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
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
      6
     ],
     "destination": [
      "tg_step0_a5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      7
     ],
     "destination": [
      "tg_step0_a6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step0",
      8
     ],
     "destination": [
      "tg_step0_a7",
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
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a5",
      0
     ],
     "destination": [
      "step0_a5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a6",
      0
     ],
     "destination": [
      "step0_a6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step0_a7",
      0
     ],
     "destination": [
      "step0_a7",
      0
     ]
    }
   }
  ]
 }
}
