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
   1746.2,
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
      1011.0,
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
      1207.4,
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
      1473.8,
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
      1115.0,
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
      1115.0,
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
      1207.4,
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
      1288.2,
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
      670.0,
      103.2,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "edit_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      529.2,
      158.0,
      62.6,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "edit_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      621.6,
      222.0,
      190.2,
      22.0
     ],
     "text": "edit/apply \"CUE x\\\\n/pm/a 42\""
    }
   },
   {
    "box": {
     "id": "edit_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      621.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "edit_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      529.2,
      222.0,
      68.4,
      22.0
     ],
     "text": "recall x"
    }
   },
   {
    "box": {
     "id": "edit_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      529.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "edit_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      529.2,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "edit_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      529.2,
      414.0,
      56.8,
      22.0
     ],
     "text": "== 42."
    }
   },
   {
    "box": {
     "id": "edit_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      529.2,
      542.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/edit/the_edited_text_replaces_the_cues"
    }
   },
   {
    "box": {
     "id": "bad_t",
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
      158.0,
      74.2,
      22.0
     ],
     "text": "t b b 8 b"
    }
   },
   {
    "box": {
     "id": "bad_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      203.2,
      222.0,
      219.2,
      22.0
     ],
     "text": "edit/apply \"nothing that is a cue\""
    }
   },
   {
    "box": {
     "id": "bad_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      203.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "bad_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      122.4,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "bad_m2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      222.0,
      68.4,
      22.0
     ],
     "text": "recall x"
    }
   },
   {
    "box": {
     "id": "bad_s2",
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
     "id": "bad_h",
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
     "id": "bad_c",
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
     "text": "== 42."
    }
   },
   {
    "box": {
     "id": "bad_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      451.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/edit/a_text_without_a_cue_changes_nothing"
    }
   },
   {
    "box": {
     "id": "tg_edit_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      529.2,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_bad_a",
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
      2
     ],
     "destination": [
      "edit_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_t",
      2
     ],
     "destination": [
      "edit_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_m0",
      0
     ],
     "destination": [
      "edit_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_t",
      1
     ],
     "destination": [
      "edit_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_m1",
      0
     ],
     "destination": [
      "edit_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_t",
      0
     ],
     "destination": [
      "edit_h",
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
      "edit_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_h",
      0
     ],
     "destination": [
      "edit_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "edit_c",
      0
     ],
     "destination": [
      "tg_edit_a",
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
      "bad_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_t",
      3
     ],
     "destination": [
      "bad_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_m0",
      0
     ],
     "destination": [
      "bad_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_t",
      2
     ],
     "destination": [
      "bad_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_t",
      1
     ],
     "destination": [
      "bad_m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_m2",
      0
     ],
     "destination": [
      "bad_s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_t",
      0
     ],
     "destination": [
      "bad_h",
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
      "bad_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_h",
      0
     ],
     "destination": [
      "bad_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bad_c",
      0
     ],
     "destination": [
      "tg_bad_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_edit_a",
      0
     ],
     "destination": [
      "edit_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_bad_a",
      0
     ],
     "destination": [
      "bad_a",
      0
     ]
    }
   }
  ]
 }
}
