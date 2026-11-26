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
   1312.4,
   658.0
  ],
  "boxes": [
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
      1132.8,
      222.0,
      51.0,
      22.0
     ],
     "text": "j.map"
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1132.8,
      286.0,
      149.6,
      22.0
     ],
     "text": "route input/going/down"
    }
   },
   {
    "box": {
     "id": "r_to_map",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1132.8,
      158.0,
      68.4,
      22.0
     ],
     "text": "r to_map"
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      68.4,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "top",
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
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      606.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "down_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      581.4,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b 0"
    }
   },
   {
    "box": {
     "id": "down_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      581.4,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "down_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      286.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "down_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      350.0,
      51.0,
      22.0
     ],
     "text": "== 1."
    }
   },
   {
    "box": {
     "id": "down_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      478.0,
      503.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/thresholds/going_down_is_told_at_the_low_threshold"
    }
   },
   {
    "box": {
     "id": "leave_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b 0.5"
    }
   },
   {
    "box": {
     "id": "leave_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "leave_h",
     "maxclass": "newobj",
     "numinlets": 2,
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
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "leave_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      350.0,
      51.0,
      22.0
     ],
     "text": "== 0."
    }
   },
   {
    "box": {
     "id": "leave_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      478.0,
      503.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/thresholds/and_told_again_when_the_input_leaves_it"
    }
   },
   {
    "box": {
     "id": "tg_down_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      581.4,
      414.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_leave_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
      414.0,
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
      "m",
      1
     ],
     "destination": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_to_map",
      0
     ],
     "destination": [
      "m",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lb",
      0
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
      2
     ],
     "destination": [
      "down_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "down_t",
      1
     ],
     "destination": [
      "down_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "down_t",
      0
     ],
     "destination": [
      "down_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      0
     ],
     "destination": [
      "down_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "down_h",
      0
     ],
     "destination": [
      "down_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "down_c",
      0
     ],
     "destination": [
      "tg_down_a",
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
      "leave_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "leave_t",
      1
     ],
     "destination": [
      "leave_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "leave_t",
      0
     ],
     "destination": [
      "leave_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      0
     ],
     "destination": [
      "leave_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "leave_h",
      0
     ],
     "destination": [
      "leave_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "leave_c",
      0
     ],
     "destination": [
      "tg_leave_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_down_a",
      0
     ],
     "destination": [
      "down_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_leave_a",
      0
     ],
     "destination": [
      "leave_a",
      0
     ]
    }
   }
  ]
 }
}
