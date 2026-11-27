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
   1530.8,
   722.0
  ],
  "boxes": [
   {
    "box": {
     "id": "model",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      685.8,
      158.0,
      80.0,
      22.0
     ],
     "text": "j.model pm"
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
      882.2,
      222.0,
      242.4,
      22.0
     ],
     "text": "j.parameter a @type integer @default 1",
     "varname": "boxa"
    }
   },
   {
    "box": {
     "id": "b",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1148.6,
      222.0,
      242.4,
      22.0
     ],
     "text": "j.parameter b @type integer @default 2",
     "varname": "boxb"
    }
   },
   {
    "box": {
     "id": "cue",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      789.8,
      222.0,
      51.0,
      22.0
     ],
     "text": "j.cue"
    }
   },
   {
    "box": {
     "id": "r_to_cue",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      789.8,
      158.0,
      68.4,
      22.0
     ],
     "text": "r to_cue"
    }
   },
   {
    "box": {
     "id": "r_to_a",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      882.2,
      158.0,
      56.8,
      22.0
     ],
     "text": "r to_a"
    }
   },
   {
    "box": {
     "id": "r_to_b",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      963.0,
      158.0,
      56.8,
      22.0
     ],
     "text": "r to_b"
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
      30.0,
      56.8,
      22.0
     ],
     "text": "j.init"
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
      1415.0,
      222.0,
      85.8,
      22.0
     ],
     "text": "thispatcher"
    }
   },
   {
    "box": {
     "id": "r_to_patcher",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1043.8,
      158.0,
      91.6,
      22.0
     ],
     "text": "r to_patcher"
    }
   },
   {
    "box": {
     "id": "top",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      51.0,
      22.0
     ],
     "text": "t b b"
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
      670.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "gone_t",
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
      158.0,
      97.4,
      22.0
     ],
     "text": "t b b 9 b b b"
    }
   },
   {
    "box": {
     "id": "gone_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      451.8,
      222.0,
      184.4,
      22.0
     ],
     "text": "namespace/select /pm/a /pm/b"
    }
   },
   {
    "box": {
     "id": "gone_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      457.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "gone_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      365.2,
      222.0,
      62.6,
      22.0
     ],
     "text": "new one"
    }
   },
   {
    "box": {
     "id": "gone_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      365.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "gone_m2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      214.8,
      222.0,
      126.4,
      22.0
     ],
     "text": "script delete boxb"
    }
   },
   {
    "box": {
     "id": "gone_s2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      214.8,
      286.0,
      91.6,
      22.0
     ],
     "text": "s to_patcher"
    }
   },
   {
    "box": {
     "id": "gone_s3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      134.0,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "gone_m4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      80.0,
      22.0
     ],
     "text": "recall one"
    }
   },
   {
    "box": {
     "id": "gone_s4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "gone_h",
     "maxclass": "newobj",
     "numinlets": 2,
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
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "gone_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 1."
    }
   },
   {
    "box": {
     "id": "gone_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      607.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/missing_models/recall_sends_the_other_lines_when_a_parameter_is_gone"
    }
   },
   {
    "box": {
     "id": "tg_gone_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
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
      "r_to_cue",
      0
     ],
     "destination": [
      "cue",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_a",
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
      "r_to_b",
      0
     ],
     "destination": [
      "b",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_patcher",
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
      "ji",
      1
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
      1
     ],
     "destination": [
      "gone_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      5
     ],
     "destination": [
      "gone_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_m0",
      0
     ],
     "destination": [
      "gone_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      4
     ],
     "destination": [
      "gone_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_m1",
      0
     ],
     "destination": [
      "gone_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      3
     ],
     "destination": [
      "gone_m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_m2",
      0
     ],
     "destination": [
      "gone_s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      2
     ],
     "destination": [
      "gone_s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      1
     ],
     "destination": [
      "gone_m4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_m4",
      0
     ],
     "destination": [
      "gone_s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_t",
      0
     ],
     "destination": [
      "gone_h",
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
      "gone_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_h",
      0
     ],
     "destination": [
      "gone_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "gone_c",
      0
     ],
     "destination": [
      "tg_gone_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_gone_a",
      0
     ],
     "destination": [
      "gone_a",
      0
     ]
    }
   }
  ]
 }
}
