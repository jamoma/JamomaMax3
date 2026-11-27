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
   2194.4,
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
      375.8,
      20.0
     ],
     "text": "Dataspace and unit work whatever the order of the attributes."
    }
   },
   {
    "box": {
     "id": "pa",
     "maxclass": "newobj",
     "text": "j.parameter a @dataspace gain @unit db @type decimal",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1493.2,
      94.0,
      323.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pa_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1493.2,
      30.0,
      103.2,
      22.0
     ],
     "text": "r par_ord_to_a"
    }
   },
   {
    "box": {
     "id": "pa_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1493.2,
      158.0,
      114.8,
      22.0
     ],
     "text": "s par_ord_from_a"
    }
   },
   {
    "box": {
     "id": "pb",
     "maxclass": "newobj",
     "text": "j.parameter b @type decimal @dataspace gain @unit db",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1840.8,
      94.0,
      323.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "pb_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1620.4,
      30.0,
      103.2,
      22.0
     ],
     "text": "r par_ord_to_b"
    }
   },
   {
    "box": {
     "id": "pb_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1840.8,
      158.0,
      114.8,
      22.0
     ],
     "text": "s par_ord_from_b"
    }
   },
   {
    "box": {
     "id": "start",
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
      958.8,
      22.0
     ],
     "text": "p set_both",
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
       1219.6,
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
          589.6,
          110.0,
          114.8,
          22.0
         ],
         "text": "r par_ord_from_a"
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
          589.6,
          150.0,
          91.6,
          22.0
         ],
         "text": "float -1000."
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
          716.4,
          70.0,
          161.2,
          22.0
         ],
         "text": "r par_ord_set_both_begin"
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
          716.4,
          110.0,
          56.8,
          22.0
         ],
         "text": "-1000."
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
          589.6,
          190.0,
          51.0,
          22.0
         ],
         "text": "== 0."
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
          901.6,
          110.0,
          114.8,
          22.0
         ],
         "text": "r par_ord_from_b"
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
          901.6,
          150.0,
          91.6,
          22.0
         ],
         "text": "float -1000."
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
          1028.4,
          70.0,
          161.2,
          22.0
         ],
         "text": "r par_ord_set_both_begin"
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
          1028.4,
          110.0,
          56.8,
          22.0
         ],
         "text": "-1000."
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
          901.6,
          190.0,
          51.0,
          22.0
         ],
         "text": "== 0."
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
          589.6,
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
          901.6,
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
          110.0,
          97.4,
          22.0
         ],
         "text": "t b b b b b b"
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
          388.4,
          150.0,
          161.2,
          22.0
         ],
         "text": "s par_ord_set_both_begin"
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
          269.2,
          190.0,
          103.2,
          22.0
         ],
         "text": "s par_ord_to_a"
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
          269.2,
          150.0,
          74.2,
          22.0
         ],
         "text": "1. linear"
        }
       },
       {
        "box": {
         "id": "s0_2",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          150.0,
          190.0,
          103.2,
          22.0
         ],
         "text": "s par_ord_to_b"
        }
       },
       {
        "box": {
         "id": "m0_2",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          150.0,
          150.0,
          74.2,
          22.0
         ],
         "text": "1. linear"
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
          5
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
          4
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
          3
         ],
         "destination": [
          "m0_2",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m0_2",
          0
         ],
         "destination": [
          "s0_2",
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
          "h0_0",
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
          "h1_0",
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
      499.9,
      194.0,
      445.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/attribute_order/unit_first"
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
      969.8,
      194.0,
      445.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/attribute_order/type_first"
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
      499.9,
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
      969.8,
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
      "pa_r0",
      0
     ],
     "destination": [
      "pa",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pa",
      0
     ],
     "destination": [
      "pa_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pb_r0",
      0
     ],
     "destination": [
      "pb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "pb",
      0
     ],
     "destination": [
      "pb_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "start",
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
