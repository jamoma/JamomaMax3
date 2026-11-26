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
   1742.0,
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
      1330.4,
      222.0,
      381.6,
      22.0
     ],
     "text": "j.map @input/min 0 @input/max 10 @output/min 0 @output/max 100"
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
      1330.4,
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
     "id": "lin_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      883.4,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b 5"
    }
   },
   {
    "box": {
     "id": "lin_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      883.4,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "lin_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      883.4,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "lin_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      883.4,
      414.0,
      56.8,
      22.0
     ],
     "text": "== 50."
    }
   },
   {
    "box": {
     "id": "lin_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      883.4,
      542.0,
      399.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/linear/scales_between_the_ranges"
    }
   },
   {
    "box": {
     "id": "noclip_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      442.2,
      158.0,
      56.8,
      22.0
     ],
     "text": "t b 20"
    }
   },
   {
    "box": {
     "id": "noclip_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      442.2,
      222.0,
      68.4,
      22.0
     ],
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "noclip_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      442.2,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "noclip_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      442.2,
      414.0,
      62.6,
      22.0
     ],
     "text": "== 200."
    }
   },
   {
    "box": {
     "id": "noclip_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      442.2,
      542.0,
      393.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/linear/does_not_clip_by_default"
    }
   },
   {
    "box": {
     "id": "clip_t",
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
     "text": "t b 20 b"
    }
   },
   {
    "box": {
     "id": "clip_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      122.4,
      222.0,
      97.4,
      22.0
     ],
     "text": "clipmode both"
    }
   },
   {
    "box": {
     "id": "clip_s0",
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
     "text": "s to_map"
    }
   },
   {
    "box": {
     "id": "clip_s1",
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
     "id": "clip_h",
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
     "id": "clip_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      414.0,
      62.6,
      22.0
     ],
     "text": "== 100."
    }
   },
   {
    "box": {
     "id": "clip_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      364.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.map/linear/clipmode_both_clips"
    }
   },
   {
    "box": {
     "id": "tg_lin_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      883.4,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_noclip_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      442.2,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_clip_a",
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
      "lin_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lin_t",
      1
     ],
     "destination": [
      "lin_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lin_t",
      0
     ],
     "destination": [
      "lin_h",
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
      "lin_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lin_h",
      0
     ],
     "destination": [
      "lin_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "lin_c",
      0
     ],
     "destination": [
      "tg_lin_a",
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
      "noclip_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noclip_t",
      1
     ],
     "destination": [
      "noclip_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noclip_t",
      0
     ],
     "destination": [
      "noclip_h",
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
      "noclip_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noclip_h",
      0
     ],
     "destination": [
      "noclip_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "noclip_c",
      0
     ],
     "destination": [
      "tg_noclip_a",
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
      "clip_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_t",
      2
     ],
     "destination": [
      "clip_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_m0",
      0
     ],
     "destination": [
      "clip_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_t",
      1
     ],
     "destination": [
      "clip_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_t",
      0
     ],
     "destination": [
      "clip_h",
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
      "clip_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_h",
      0
     ],
     "destination": [
      "clip_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "clip_c",
      0
     ],
     "destination": [
      "tg_clip_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_lin_a",
      0
     ],
     "destination": [
      "lin_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_noclip_a",
      0
     ],
     "destination": [
      "noclip_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_clip_a",
      0
     ],
     "destination": [
      "clip_a",
      0
     ]
    }
   }
  ]
 }
}
