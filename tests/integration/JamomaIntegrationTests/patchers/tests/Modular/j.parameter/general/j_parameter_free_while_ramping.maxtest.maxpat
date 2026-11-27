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
   1614.4,
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
      370.0,
      20.0
     ],
     "text": "Deleting a parameter in the middle of a ramp does not crash."
    }
   },
   {
    "box": {
     "id": "rp",
     "maxclass": "newobj",
     "text": "j.parameter rp @type decimal @ramp/drive max",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1035.4,
      94.0,
      277.2,
      22.0
     ],
     "varname": "rp"
    }
   },
   {
    "box": {
     "id": "rp_r0",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1035.4,
      30.0,
      109.0,
      22.0
     ],
     "text": "r par_fre_to_rp"
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
      1336.6,
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
      1168.4,
      30.0,
      138.0,
      22.0
     ],
     "text": "r par_fre_to_patcher"
    }
   },
   {
    "box": {
     "id": "alive",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1446.4,
      94.0,
      40.0,
      22.0
     ],
     "text": "t 1"
    }
   },
   {
    "box": {
     "id": "alive_r",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1330.4,
      30.0,
      126.4,
      22.0
     ],
     "text": "r par_fre_to_alive"
    }
   },
   {
    "box": {
     "id": "alive_s",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1446.4,
      158.0,
      138.0,
      22.0
     ],
     "text": "s par_fre_from_alive"
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
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      124.0,
      495.2,
      22.0
     ],
     "text": "p delete_while_ramping",
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
       690.4,
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
          138.0,
          22.0
         ],
         "text": "r par_fre_from_alive"
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
          244.4,
          414.0,
          51.0,
          22.0
         ],
         "text": "int 0"
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
         "text": "t b b 0"
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
          128.2,
          222.0,
          109.0,
          22.0
         ],
         "text": "s par_fre_to_rp"
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
          128.2,
          158.0,
          126.4,
          22.0
         ],
         "text": "0., 100. ramp 5000"
        }
       },
       {
        "box": {
         "id": "w0",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          158.0,
          74.2,
          22.0
         ],
         "text": "delay 100"
        }
       },
       {
        "box": {
         "id": "w0_why",
         "maxclass": "comment",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          256.0,
          30.0,
          161.2,
          20.0
         ],
         "text": "the ramp must be running"
        }
       },
       {
        "box": {
         "id": "t1",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 2,
         "outlettype": [
          "",
          ""
         ],
         "patching_rect": [
          30.0,
          222.0,
          51.0,
          22.0
         ],
         "text": "t b b"
        }
       },
       {
        "box": {
         "id": "s1_0",
         "maxclass": "newobj",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          128.2,
          350.0,
          138.0,
          22.0
         ],
         "text": "s par_fre_to_patcher"
        }
       },
       {
        "box": {
         "id": "m1_0",
         "maxclass": "message",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          128.2,
          286.0,
          114.8,
          22.0
         ],
         "text": "script delete rp"
        }
       },
       {
        "box": {
         "id": "w1",
         "maxclass": "newobj",
         "numinlets": 2,
         "numoutlets": 1,
         "outlettype": [
          ""
         ],
         "patching_rect": [
          30.0,
          286.0,
          74.2,
          22.0
         ],
         "text": "delay 700"
        }
       },
       {
        "box": {
         "id": "w1_why",
         "maxclass": "comment",
         "numinlets": 1,
         "numoutlets": 0,
         "outlettype": [],
         "patching_rect": [
          441.2,
          30.0,
          219.2,
          20.0
         ],
         "text": "ticks of the ramp would arrive now"
        }
       },
       {
        "box": {
         "id": "t2",
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
          350.0,
          62.6,
          22.0
         ],
         "text": "t b b b"
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
          414.0,
          126.4,
          22.0
         ],
         "text": "s par_fre_to_alive"
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
          "h0_0",
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
          "t1",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t1",
          1
         ],
         "destination": [
          "m1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "m1_0",
          0
         ],
         "destination": [
          "s1_0",
          0
         ]
        }
       },
       {
        "patchline": {
         "source": [
          "t1",
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
          2
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
     "id": "step0_a0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      506.2,
      194.0,
      451.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.parameter/general/free_while_ramping/survived"
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
      506.2,
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
      "rp_r0",
      0
     ],
     "destination": [
      "rp",
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
      "alive_r",
      0
     ],
     "destination": [
      "alive",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "alive",
      0
     ],
     "destination": [
      "alive_s",
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
   }
  ]
 }
}
