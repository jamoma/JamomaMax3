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
   3951.8,
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
      3216.6,
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
      3413.0,
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
      3679.4,
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
      3320.6,
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
      3320.6,
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
      3413.0,
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
      3493.8,
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
     "id": "ra",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3320.6,
      286.0,
      85.8,
      22.0
     ],
     "text": "route /pm/a"
    }
   },
   {
    "box": {
     "id": "rn",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3430.4,
      286.0,
      85.8,
      22.0
     ],
     "text": "route names"
    }
   },
   {
    "box": {
     "id": "zn",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3430.4,
      350.0,
      56.8,
      22.0
     ],
     "text": "zl len"
    }
   },
   {
    "box": {
     "id": "rd",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3540.2,
      286.0,
      120.6,
      22.0
     ],
     "text": "route description"
    }
   },
   {
    "box": {
     "id": "nth",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3540.2,
      350.0,
      68.4,
      22.0
     ],
     "text": "zl nth 2"
    }
   },
   {
    "box": {
     "id": "sh",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3540.2,
      414.0,
      74.2,
      22.0
     ],
     "text": "sel hello"
    }
   },
   {
    "box": {
     "id": "yes",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3540.2,
      478.0,
      40.0,
      22.0
     ],
     "text": "1"
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
     "id": "names_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      2711.6,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "names_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2798.2,
      222.0,
      184.4,
      22.0
     ],
     "text": "namespace/select /pm/a /pm/b"
    }
   },
   {
    "box": {
     "id": "names_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2804.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "names_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2711.6,
      222.0,
      62.6,
      22.0
     ],
     "text": "new one"
    }
   },
   {
    "box": {
     "id": "names_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2711.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "names_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2711.6,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "names_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2711.6,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 1."
    }
   },
   {
    "box": {
     "id": "names_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2711.6,
      542.0,
      457.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/new_adds_the_cue_to_the_names"
    }
   },
   {
    "box": {
     "id": "recall_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      2224.0,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b b 7"
    }
   },
   {
    "box": {
     "id": "recall_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2328.0,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "recall_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2224.0,
      222.0,
      80.0,
      22.0
     ],
     "text": "recall one"
    }
   },
   {
    "box": {
     "id": "recall_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2224.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "recall_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2224.0,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "recall_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2224.0,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 1."
    }
   },
   {
    "box": {
     "id": "recall_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2224.0,
      542.0,
      439.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/recall_restores_the_values"
    }
   },
   {
    "box": {
     "id": "line_t",
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
      1626.2,
      158.0,
      85.8,
      22.0
     ],
     "text": "t b b 9 b 5"
    }
   },
   {
    "box": {
     "id": "line_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1897.6,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "line_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1811.0,
      222.0,
      62.6,
      22.0
     ],
     "text": "new two"
    }
   },
   {
    "box": {
     "id": "line_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1811.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "line_s2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1730.2,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "line_m3",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1626.2,
      222.0,
      80.0,
      22.0
     ],
     "text": "output two"
    }
   },
   {
    "box": {
     "id": "line_s3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1626.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "line_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1626.2,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "line_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1626.2,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 5."
    }
   },
   {
    "box": {
     "id": "line_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1626.2,
      542.0,
      549.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/output_sends_the_lines_out_of_the_left_outlet"
    }
   },
   {
    "box": {
     "id": "noapply_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1074.8,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "noapply_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1074.8,
      222.0,
      80.0,
      22.0
     ],
     "text": "output two"
    }
   },
   {
    "box": {
     "id": "noapply_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1074.8,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "noapply_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1074.8,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "noapply_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1074.8,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 9."
    }
   },
   {
    "box": {
     "id": "noapply_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1074.8,
      542.0,
      503.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/output_does_not_change_the_parameters"
    }
   },
   {
    "box": {
     "id": "next_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      523.4,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "next_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      633.2,
      222.0,
      80.0,
      22.0
     ],
     "text": "recall one"
    }
   },
   {
    "box": {
     "id": "next_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      633.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "next_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      523.4,
      222.0,
      85.8,
      22.0
     ],
     "text": "recall/next"
    }
   },
   {
    "box": {
     "id": "next_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      523.4,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "next_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      523.4,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "next_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      523.4,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 5."
    }
   },
   {
    "box": {
     "id": "next_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      523.4,
      542.0,
      503.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/recall_next_goes_to_the_following_cue"
    }
   },
   {
    "box": {
     "id": "desc_t",
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
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "desc_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      186.2,
      222.0,
      167.0,
      22.0
     ],
     "text": "set description one hello"
    }
   },
   {
    "box": {
     "id": "desc_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      186.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "desc_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      132.2,
      22.0
     ],
     "text": "get description one"
    }
   },
   {
    "box": {
     "id": "desc_s1",
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
     "id": "desc_h",
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
     "id": "desc_c",
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
     "id": "desc_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      445.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/store_recall/set_and_get_the_description"
    }
   },
   {
    "box": {
     "id": "tg_names_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2711.6,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_recall_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      2224.0,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_line_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1626.2,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_noapply_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1074.8,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_next_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      523.4,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_desc_a",
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
      "cue",
      0
     ],
     "destination": [
      "ra",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cue",
      1
     ],
     "destination": [
      "rn",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rn",
      0
     ],
     "destination": [
      "zn",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "cue",
      1
     ],
     "destination": [
      "rd",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rd",
      0
     ],
     "destination": [
      "nth",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "nth",
      0
     ],
     "destination": [
      "sh",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sh",
      0
     ],
     "destination": [
      "yes",
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
      6
     ],
     "destination": [
      "names_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_t",
      2
     ],
     "destination": [
      "names_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_m0",
      0
     ],
     "destination": [
      "names_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_t",
      1
     ],
     "destination": [
      "names_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_m1",
      0
     ],
     "destination": [
      "names_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_t",
      0
     ],
     "destination": [
      "names_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "zn",
      0
     ],
     "destination": [
      "names_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_h",
      0
     ],
     "destination": [
      "names_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "names_c",
      0
     ],
     "destination": [
      "tg_names_a",
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
      "recall_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_t",
      2
     ],
     "destination": [
      "recall_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_t",
      1
     ],
     "destination": [
      "recall_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_m1",
      0
     ],
     "destination": [
      "recall_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_t",
      0
     ],
     "destination": [
      "recall_h",
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
      "recall_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_h",
      0
     ],
     "destination": [
      "recall_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "recall_c",
      0
     ],
     "destination": [
      "tg_recall_a",
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
      "line_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_t",
      4
     ],
     "destination": [
      "line_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_t",
      3
     ],
     "destination": [
      "line_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_m1",
      0
     ],
     "destination": [
      "line_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_t",
      2
     ],
     "destination": [
      "line_s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_t",
      1
     ],
     "destination": [
      "line_m3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_m3",
      0
     ],
     "destination": [
      "line_s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_t",
      0
     ],
     "destination": [
      "line_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "ra",
      0
     ],
     "destination": [
      "line_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_h",
      0
     ],
     "destination": [
      "line_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "line_c",
      0
     ],
     "destination": [
      "tg_line_a",
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
      "noapply_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noapply_t",
      1
     ],
     "destination": [
      "noapply_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noapply_m0",
      0
     ],
     "destination": [
      "noapply_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noapply_t",
      0
     ],
     "destination": [
      "noapply_h",
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
      "noapply_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noapply_h",
      0
     ],
     "destination": [
      "noapply_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noapply_c",
      0
     ],
     "destination": [
      "tg_noapply_a",
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
      "next_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_t",
      2
     ],
     "destination": [
      "next_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_m0",
      0
     ],
     "destination": [
      "next_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_t",
      1
     ],
     "destination": [
      "next_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_m1",
      0
     ],
     "destination": [
      "next_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_t",
      0
     ],
     "destination": [
      "next_h",
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
      "next_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_h",
      0
     ],
     "destination": [
      "next_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "next_c",
      0
     ],
     "destination": [
      "tg_next_a",
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
      "desc_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_t",
      2
     ],
     "destination": [
      "desc_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_m0",
      0
     ],
     "destination": [
      "desc_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_t",
      1
     ],
     "destination": [
      "desc_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_m1",
      0
     ],
     "destination": [
      "desc_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_t",
      0
     ],
     "destination": [
      "desc_h",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "yes",
      0
     ],
     "destination": [
      "desc_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_h",
      0
     ],
     "destination": [
      "desc_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "desc_c",
      0
     ],
     "destination": [
      "tg_desc_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_names_a",
      0
     ],
     "destination": [
      "names_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_recall_a",
      0
     ],
     "destination": [
      "recall_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_line_a",
      0
     ],
     "destination": [
      "line_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_noapply_a",
      0
     ],
     "destination": [
      "noapply_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_next_a",
      0
     ],
     "destination": [
      "next_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_desc_a",
      0
     ],
     "destination": [
      "desc_a",
      0
     ]
    }
   }
  ]
 }
}
