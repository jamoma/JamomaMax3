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
   1302.0,
   698.0
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
      503.4,
      20.0
     ],
     "text": "An attribute name sent without a value answers `<name> <value>` on the dump outlet."
    }
   },
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
      977.4,
      94.0,
      294.6,
      22.0
     ],
     "text": "j.unit @dataspace gain @input dB @output linear"
    }
   },
   {
    "box": {
     "id": "o_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      977.4,
      30.0,
      68.4,
      22.0
     ],
     "text": "r q11_in"
    }
   },
   {
    "box": {
     "id": "o_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      977.4,
      158.0,
      80.0,
      22.0
     ],
     "text": "s q11_dump"
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
      466.2,
      22.0
     ],
     "text": "p ask0",
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
       570.6,
       690.0
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
          304.8,
          350.0,
          80.0,
          22.0
         ],
         "text": "r q11_dump"
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
          304.8,
          390.0,
          109.0,
          22.0
         ],
         "text": "route dataspace"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          304.8,
          430.0,
          109.0,
          22.0
         ],
         "text": "zl.compare gain"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          304.8,
          470.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          304.8,
          510.0,
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
          304.8,
          550.0,
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
          425.8,
          470.0,
          114.8,
          22.0
         ],
         "text": "r q11_ask0_begin"
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
          425.8,
          510.0,
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
          630.0,
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
          304.8,
          630.0,
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
         "text": "s q11_ask0_begin"
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
          310.0,
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
          390.0,
          68.4,
          22.0
         ],
         "text": "s q11_in"
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
          350.0,
          74.2,
          22.0
         ],
         "text": "dataspace"
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
          "o0_0_3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_3",
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
          "h0_0",
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
      477.2,
      194.0,
      422.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/attribute_queries/dataspace_answers"
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
      443.0,
      22.0
     ],
     "text": "p ask1",
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
       643.4,
       450.0
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
          389.2,
          110.0,
          80.0,
          22.0
         ],
         "text": "r q11_dump"
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
          389.2,
          150.0,
          85.8,
          22.0
         ],
         "text": "route input"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          389.2,
          190.0,
          97.4,
          22.0
         ],
         "text": "zl.compare dB"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          389.2,
          230.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          389.2,
          270.0,
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
          389.2,
          310.0,
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
          498.6,
          230.0,
          114.8,
          22.0
         ],
         "text": "r q11_ask1_begin"
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
          498.6,
          270.0,
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
          390.0,
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
          389.2,
          390.0,
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
          234.4,
          110.0,
          114.8,
          22.0
         ],
         "text": "s q11_ask1_begin"
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
          68.4,
          22.0
         ],
         "text": "s q11_in"
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
          51.0,
          22.0
         ],
         "text": "input"
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
          270.0,
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
          "o0_0_3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_3",
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
      454.0,
      314.0,
      399.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/attribute_queries/input_answers"
    }
   },
   {
    "box": {
     "id": "step2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      364.0,
      448.8,
      22.0
     ],
     "text": "p ask2",
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
       666.6,
       450.0
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
          389.2,
          110.0,
          80.0,
          22.0
         ],
         "text": "r q11_dump"
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
          389.2,
          150.0,
          91.6,
          22.0
         ],
         "text": "route output"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          389.2,
          190.0,
          120.6,
          22.0
         ],
         "text": "zl.compare linear"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          389.2,
          230.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          389.2,
          270.0,
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
          389.2,
          310.0,
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
          521.8,
          230.0,
          114.8,
          22.0
         ],
         "text": "r q11_ask2_begin"
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
          521.8,
          270.0,
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
          390.0,
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
          389.2,
          390.0,
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
          234.4,
          110.0,
          114.8,
          22.0
         ],
         "text": "s q11_ask2_begin"
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
          68.4,
          22.0
         ],
         "text": "s q11_in"
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
          56.8,
          22.0
         ],
         "text": "output"
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
          270.0,
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
          "o0_0_3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_3",
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
     "id": "step2_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      459.8,
      434.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/attribute_queries/output_answers"
    }
   },
   {
    "box": {
     "id": "step3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      484.0,
      454.6,
      22.0
     ],
     "text": "p get",
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
       666.6,
       450.0
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
          406.6,
          110.0,
          80.0,
          22.0
         ],
         "text": "r q11_dump"
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
          406.6,
          150.0,
          109.0,
          22.0
         ],
         "text": "route dataspace"
        }
       },
       {
        "box": {
         "id": "o0_0_1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          406.6,
          190.0,
          109.0,
          22.0
         ],
         "text": "zl.compare gain"
        }
       },
       {
        "box": {
         "id": "o0_0_2",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          406.6,
          230.0,
          51.0,
          22.0
         ],
         "text": "sel 1"
        }
       },
       {
        "box": {
         "id": "o0_0_3",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          406.6,
          270.0,
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
          406.6,
          310.0,
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
          527.6,
          230.0,
          109.0,
          22.0
         ],
         "text": "r q11_get_begin"
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
          527.6,
          270.0,
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
          390.0,
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
          406.6,
          390.0,
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
          257.6,
          110.0,
          109.0,
          22.0
         ],
         "text": "s q11_get_begin"
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
          68.4,
          22.0
         ],
         "text": "s q11_in"
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
          91.6,
          22.0
         ],
         "text": "getdataspace"
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
          270.0,
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
          "o0_0_3",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "o0_0_3",
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
     "id": "step3_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      465.6,
      554.0,
      410.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.unit/attribute_queries/get_answers_too"
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
      604.0,
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
      477.2,
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
      454.0,
      280.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step2_a0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      459.8,
      400.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_step3_a0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      465.6,
      520.0,
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
      "o_r0",
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
      "o_s1",
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
      "step2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step2",
      1
     ],
     "destination": [
      "tg_step2_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step2",
      0
     ],
     "destination": [
      "step3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step3",
      1
     ],
     "destination": [
      "tg_step3_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "step3",
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
   },
   {
    "patchline": {
     "source": [
      "tg_step2_a0",
      0
     ],
     "destination": [
      "step2_a0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_step3_a0",
      0
     ],
     "destination": [
      "step3_a0",
      0
     ]
    }
   }
  ]
 }
}
