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
   2401.2,
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
      329.4,
      20.0
     ],
     "text": "hi loads with its 256 returns and takes its settings."
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1232.2,
      30.0,
      91.6,
      22.0
     ],
     "text": "hi.model thi"
    }
   },
   {
    "box": {
     "id": "r1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1347.8,
      30.0,
      143.8,
      22.0
     ],
     "text": "j.receive /thi/hi.256"
    }
   },
   {
    "box": {
     "id": "r1_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1347.8,
      94.0,
      74.2,
      22.0
     ],
     "text": "s hi_last"
    }
   },
   {
    "box": {
     "id": "r2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1515.6,
      30.0,
      132.2,
      22.0
     ],
     "text": "j.receive /thi/hi.1"
    }
   },
   {
    "box": {
     "id": "r2_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1515.6,
      94.0,
      80.0,
      22.0
     ],
     "text": "s hi_first"
    }
   },
   {
    "box": {
     "id": "r3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1671.8,
      30.0,
      201.8,
      22.0
     ],
     "text": "j.receive /thi/polling_interval"
    }
   },
   {
    "box": {
     "id": "r3_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1671.8,
      94.0,
      74.2,
      22.0
     ],
     "text": "s hi_poll"
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1897.6,
      94.0,
      126.4,
      22.0
     ],
     "text": "j.send /thi/hi.256"
    }
   },
   {
    "box": {
     "id": "s1_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1897.6,
      30.0,
      91.6,
      22.0
     ],
     "text": "r hi_to_last"
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2048.0,
      94.0,
      114.8,
      22.0
     ],
     "text": "j.send /thi/hi.1"
    }
   },
   {
    "box": {
     "id": "s2_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2013.2,
      30.0,
      97.4,
      22.0
     ],
     "text": "r hi_to_first"
    }
   },
   {
    "box": {
     "id": "s3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2186.8,
      94.0,
      184.4,
      22.0
     ],
     "text": "j.send /thi/polling_interval"
    }
   },
   {
    "box": {
     "id": "s3_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2134.6,
      30.0,
      91.6,
      22.0
     ],
     "text": "r hi_to_poll"
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
      784.8,
      22.0
     ],
     "text": "p nodes",
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
       856.8,
       570.0
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
          395.0,
          310.0,
          74.2,
          22.0
         ],
         "text": "r hi_last"
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
          395.0,
          350.0,
          62.6,
          22.0
         ],
         "text": "sel 200"
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
          395.0,
          390.0,
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
          395.0,
          430.0,
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
          481.2,
          350.0,
          114.8,
          22.0
         ],
         "text": "r hi_nodes_begin"
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
          481.2,
          390.0,
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
          620.0,
          310.0,
          80.0,
          22.0
         ],
         "text": "r hi_first"
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
          620.0,
          350.0,
          51.0,
          22.0
         ],
         "text": "sel 3"
        }
       },
       {
        "box": {
         "id": "o1_0_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          620.0,
          390.0,
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
          620.0,
          430.0,
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
          712.0,
          350.0,
          114.8,
          22.0
         ],
         "text": "r hi_nodes_begin"
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
          712.0,
          390.0,
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
          510.0,
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
          395.0,
          510.0,
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
          620.0,
          510.0,
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
          114.8,
          22.0
         ],
         "text": "s hi_nodes_begin"
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
          310.0,
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
          350.0,
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
         "numoutlets": 5,
         "outlettype": [
          "",
          "",
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          390.0,
          97.4,
          22.0
         ],
         "text": "t b b b 3 200"
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
          263.4,
          430.0,
          91.6,
          22.0
         ],
         "text": "s hi_to_last"
        }
       },
       {
        "box": {
         "id": "s6_1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          430.0,
          97.4,
          22.0
         ],
         "text": "s hi_to_first"
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
          4
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
          3
         ],
         "destination": [
          "s6_1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t6",
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
          "t6",
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
          "t6",
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
      412.9,
      194.0,
      352.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/hi/load/the_last_return_exists"
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
      795.8,
      194.0,
      358.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/hi/load/the_first_return_exists"
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
      425.6,
      22.0
     ],
     "text": "p settings",
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
       678.2,
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
         "id": "r0_0",
         "maxclass": "newobj",
         "numinlets": 0,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          429.8,
          150.0,
          74.2,
          22.0
         ],
         "text": "r hi_poll"
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
          429.8,
          190.0,
          56.8,
          22.0
         ],
         "text": "sel 25"
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
          429.8,
          230.0,
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
          429.8,
          270.0,
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
          516.0,
          190.0,
          132.2,
          22.0
         ],
         "text": "r hi_settings_begin"
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
          516.0,
          230.0,
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
          350.0,
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
          429.8,
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
         "numoutlets": 3,
         "outlettype": [
          "",
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          70.0,
          68.4,
          22.0
         ],
         "text": "t b 25 b"
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
          257.6,
          110.0,
          132.2,
          22.0
         ],
         "text": "s hi_settings_begin"
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
          110.0,
          91.6,
          22.0
         ],
         "text": "s hi_to_poll"
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
         "id": "t2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          230.0,
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
          "t2",
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
          "h0_0",
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
     "id": "step1_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      436.6,
      314.0,
      381.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/hi/load/the_polling_interval_is_set"
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
      412.9,
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
      795.8,
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
      436.6,
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
      "r1",
      0
     ],
     "destination": [
      "r1_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r2",
      0
     ],
     "destination": [
      "r2_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r3",
      0
     ],
     "destination": [
      "r3_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1_r0",
      0
     ],
     "destination": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2_r0",
      0
     ],
     "destination": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s3_r0",
      0
     ],
     "destination": [
      "s3",
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
