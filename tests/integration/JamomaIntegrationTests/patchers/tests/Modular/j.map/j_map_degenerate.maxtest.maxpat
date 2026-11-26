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
   2368.0,
   722.0
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
      1771.2,
      222.0,
      364.2,
      22.0
     ],
     "text": "j.map @input/min 5 @input/max 5 @output/min 2 @output/max 8"
    }
   },
   {
    "box": {
     "id": "mm",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      2159.4,
      222.0,
      178.6,
      22.0
     ],
     "text": "j.map @function exponential"
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
      1771.2,
      158.0,
      68.4,
      22.0
     ],
     "text": "r to_map"
    }
   },
   {
    "box": {
     "id": "r_to_exp",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1863.6,
      158.0,
      68.4,
      22.0
     ],
     "text": "r to_exp"
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
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      74.2,
      22.0
     ],
     "text": "t b b b b"
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
     "id": "eq_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1248.8,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b 5.5"
    }
   },
   {
    "box": {
     "id": "eq_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1248.8,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "eq_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1248.8,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "eq_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1248.8,
      414.0,
      184.4,
      22.0
     ],
     "text": "expr abs($f1 - 5.) < 0.00001"
    }
   },
   {
    "box": {
     "id": "eq_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1248.8,
      542.0,
      474.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/degenerate/equal_limits_do_not_divide_by_zero"
    }
   },
   {
    "box": {
     "id": "eqclip_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      627.8,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b 9 b"
    }
   },
   {
    "box": {
     "id": "eqclip_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      720.2,
      222.0,
      97.4,
      22.0
     ],
     "text": "clipmode both"
    }
   },
   {
    "box": {
     "id": "eqclip_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      720.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "eqclip_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      627.8,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "eqclip_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      627.8,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "eqclip_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      627.8,
      414.0,
      184.4,
      22.0
     ],
     "text": "expr abs($f1 - 2.) < 0.00001"
    }
   },
   {
    "box": {
     "id": "eqclip_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      627.8,
      542.0,
      573.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/degenerate/equal_limits_clipped_give_the_low_end_of_the_output"
    }
   },
   {
    "box": {
     "id": "hostile_t",
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
      158.0,
      74.2,
      22.0
     ],
     "text": "t b 0.5 b"
    }
   },
   {
    "box": {
     "id": "hostile_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      122.4,
      222.0,
      62.6,
      22.0
     ],
     "text": "base -5"
    }
   },
   {
    "box": {
     "id": "hostile_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      122.4,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_exp"
    }
   },
   {
    "box": {
     "id": "hostile_s1",
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
     "text": "s to_exp"
    }
   },
   {
    "box": {
     "id": "hostile_h",
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
     "id": "hostile_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      213.4,
      22.0
     ],
     "text": "expr abs($f1 - 0.999001) < 0.0001"
    }
   },
   {
    "box": {
     "id": "hostile_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      549.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/degenerate/a_hostile_parameter_still_gives_a_finite_number"
    }
   },
   {
    "box": {
     "id": "tg_eq_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1248.8,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_eqclip_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      627.8,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_hostile_a",
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
      "r_to_exp",
      0
     ],
     "destination": [
      "mm",
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
      3
     ],
     "destination": [
      "eq_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq_t",
      1
     ],
     "destination": [
      "eq_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq_t",
      0
     ],
     "destination": [
      "eq_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m",
      0
     ],
     "destination": [
      "eq_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq_h",
      0
     ],
     "destination": [
      "eq_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eq_c",
      0
     ],
     "destination": [
      "tg_eq_a",
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
      "eqclip_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_t",
      2
     ],
     "destination": [
      "eqclip_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_m0",
      0
     ],
     "destination": [
      "eqclip_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_t",
      1
     ],
     "destination": [
      "eqclip_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_t",
      0
     ],
     "destination": [
      "eqclip_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "m",
      0
     ],
     "destination": [
      "eqclip_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_h",
      0
     ],
     "destination": [
      "eqclip_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "eqclip_c",
      0
     ],
     "destination": [
      "tg_eqclip_a",
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
      "hostile_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_t",
      2
     ],
     "destination": [
      "hostile_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_m0",
      0
     ],
     "destination": [
      "hostile_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_t",
      1
     ],
     "destination": [
      "hostile_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_t",
      0
     ],
     "destination": [
      "hostile_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mm",
      0
     ],
     "destination": [
      "hostile_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_h",
      0
     ],
     "destination": [
      "hostile_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "hostile_c",
      0
     ],
     "destination": [
      "tg_hostile_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_eq_a",
      0
     ],
     "destination": [
      "eq_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_eqclip_a",
      0
     ],
     "destination": [
      "eqclip_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_hostile_a",
      0
     ],
     "destination": [
      "hostile_a",
      0
     ]
    }
   }
  ]
 }
}
