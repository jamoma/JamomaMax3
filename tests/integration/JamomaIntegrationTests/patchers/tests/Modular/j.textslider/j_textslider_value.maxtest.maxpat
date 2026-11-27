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
   3251.2,
   722.0
  ],
  "boxes": [
   {
    "box": {
     "id": "s",
     "maxclass": "j.textslider",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3129.6,
      222.0,
      91.6,
      22.0
     ],
     "text": "j.textslider"
    }
   },
   {
    "box": {
     "id": "r_to_slider",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3129.6,
      158.0,
      85.8,
      22.0
     ],
     "text": "r to_slider"
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
     "numoutlets": 7,
     "outlettype": [
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
      94.0,
      109.0,
      22.0
     ],
     "text": "t b b b b b b b"
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
     "id": "flt_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      2688.4,
      158.0,
      68.4,
      22.0
     ],
     "text": "t b 0.25"
    }
   },
   {
    "box": {
     "id": "flt_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2688.4,
      222.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "flt_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2688.4,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "flt_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2688.4,
      414.0,
      62.6,
      22.0
     ],
     "text": "== 0.25"
    }
   },
   {
    "box": {
     "id": "flt_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2688.4,
      542.0,
      393.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/a_number_is_output"
    }
   },
   {
    "box": {
     "id": "above_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      2102.2,
      158.0,
      56.8,
      22.0
     ],
     "text": "t b 20"
    }
   },
   {
    "box": {
     "id": "above_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2102.2,
      222.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "above_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2102.2,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "above_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2102.2,
      414.0,
      56.8,
      22.0
     ],
     "text": "== 20."
    }
   },
   {
    "box": {
     "id": "above_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2102.2,
      542.0,
      538.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/a_number_above_the_range_is_output_as_it_is"
    }
   },
   {
    "box": {
     "id": "bng_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      1527.6,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "bng_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1596.8,
      222.0,
      51.0,
      22.0
     ],
     "text": "set 7"
    }
   },
   {
    "box": {
     "id": "bng_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1637.4,
      286.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "bng_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1527.6,
      222.0,
      45.2,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "bng_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1527.6,
      286.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "bng_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1527.6,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "bng_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1527.6,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 7."
    }
   },
   {
    "box": {
     "id": "bng_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1527.6,
      542.0,
      526.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/bang_outputs_the_value_set_without_output"
    }
   },
   {
    "box": {
     "id": "silent_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1115.4,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "silent_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1115.4,
      222.0,
      51.0,
      22.0
     ],
     "text": "set 3"
    }
   },
   {
    "box": {
     "id": "silent_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1115.4,
      286.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "silent_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1115.4,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "silent_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1115.4,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 7."
    }
   },
   {
    "box": {
     "id": "silent_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1115.4,
      542.0,
      364.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/set_is_silent"
    }
   },
   {
    "box": {
     "id": "equal_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      581.4,
      158.0,
      74.2,
      22.0
     ],
     "text": "t b 100 b"
    }
   },
   {
    "box": {
     "id": "equal_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      691.2,
      222.0,
      74.2,
      22.0
     ],
     "text": "range 3 3"
    }
   },
   {
    "box": {
     "id": "equal_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      691.2,
      286.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "equal_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      581.4,
      222.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "equal_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "equal_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      414.0,
      62.6,
      22.0
     ],
     "text": "== 100."
    }
   },
   {
    "box": {
     "id": "equal_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      581.4,
      542.0,
      486.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/equal_range_ends_still_pass_values"
    }
   },
   {
    "box": {
     "id": "swap_t",
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
      68.4,
      22.0
     ],
     "text": "t b -4 b"
    }
   },
   {
    "box": {
     "id": "swap_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      139.8,
      222.0,
      80.0,
      22.0
     ],
     "text": "range 10 0"
    }
   },
   {
    "box": {
     "id": "swap_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      139.8,
      286.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "swap_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      222.0,
      85.8,
      22.0
     ],
     "text": "s to_slider"
    }
   },
   {
    "box": {
     "id": "swap_h",
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
     "id": "swap_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      56.8,
      22.0
     ],
     "text": "== -4."
    }
   },
   {
    "box": {
     "id": "swap_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      503.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.textslider/value/reversed_range_ends_still_pass_values"
    }
   },
   {
    "box": {
     "id": "tg_flt_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2688.4,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_above_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2102.2,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_bng_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1527.6,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_silent_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1115.4,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_equal_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      581.4,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_swap_a",
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
      "r_to_slider",
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
      6
     ],
     "destination": [
      "flt_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "flt_t",
      1
     ],
     "destination": [
      "flt_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "flt_t",
      0
     ],
     "destination": [
      "flt_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "flt_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "flt_h",
      0
     ],
     "destination": [
      "flt_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "flt_c",
      0
     ],
     "destination": [
      "tg_flt_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
      5
     ],
     "destination": [
      "above_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "above_t",
      1
     ],
     "destination": [
      "above_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "above_t",
      0
     ],
     "destination": [
      "above_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "above_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "above_h",
      0
     ],
     "destination": [
      "above_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "above_c",
      0
     ],
     "destination": [
      "tg_above_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "top",
      4
     ],
     "destination": [
      "bng_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_t",
      2
     ],
     "destination": [
      "bng_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_m0",
      0
     ],
     "destination": [
      "bng_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_t",
      1
     ],
     "destination": [
      "bng_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_m1",
      0
     ],
     "destination": [
      "bng_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_t",
      0
     ],
     "destination": [
      "bng_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "bng_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_h",
      0
     ],
     "destination": [
      "bng_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bng_c",
      0
     ],
     "destination": [
      "tg_bng_a",
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
      "silent_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "silent_t",
      1
     ],
     "destination": [
      "silent_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "silent_m0",
      0
     ],
     "destination": [
      "silent_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "silent_t",
      0
     ],
     "destination": [
      "silent_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "silent_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "silent_h",
      0
     ],
     "destination": [
      "silent_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "silent_c",
      0
     ],
     "destination": [
      "tg_silent_a",
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
      "equal_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_t",
      2
     ],
     "destination": [
      "equal_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_m0",
      0
     ],
     "destination": [
      "equal_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_t",
      1
     ],
     "destination": [
      "equal_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_t",
      0
     ],
     "destination": [
      "equal_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "equal_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_h",
      0
     ],
     "destination": [
      "equal_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "equal_c",
      0
     ],
     "destination": [
      "tg_equal_a",
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
      "swap_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_t",
      2
     ],
     "destination": [
      "swap_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_m0",
      0
     ],
     "destination": [
      "swap_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_t",
      1
     ],
     "destination": [
      "swap_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_t",
      0
     ],
     "destination": [
      "swap_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s",
      0
     ],
     "destination": [
      "swap_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_h",
      0
     ],
     "destination": [
      "swap_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "swap_c",
      0
     ],
     "destination": [
      "tg_swap_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_flt_a",
      0
     ],
     "destination": [
      "flt_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_above_a",
      0
     ],
     "destination": [
      "above_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_bng_a",
      0
     ],
     "destination": [
      "bng_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_silent_a",
      0
     ],
     "destination": [
      "silent_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_equal_a",
      0
     ],
     "destination": [
      "equal_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_swap_a",
      0
     ],
     "destination": [
      "swap_a",
      0
     ]
    }
   }
  ]
 }
}
