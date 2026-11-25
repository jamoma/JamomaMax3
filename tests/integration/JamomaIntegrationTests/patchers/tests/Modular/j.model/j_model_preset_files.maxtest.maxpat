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
   1551.6,
   1554.0
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
      498.4,
      1182.0,
      88.0,
      22.0
     ],
     "text": "j.model pm"
    }
   },
   {
    "box": {
     "id": "pa",
     "linecount": 3,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      326.8,
      670.0,
      272.8,
      22.0
     ],
     "text": "j.parameter a @type integer @default 1"
    }
   },
   {
    "box": {
     "id": "pb",
     "linecount": 3,
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
      272.8,
      22.0
     ],
     "text": "j.parameter b @type integer @default 2"
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
      326.8,
      30.0,
      61.6,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "term",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      1162.8,
      1310.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "s0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      94.0,
      114.4,
      22.0
     ],
     "text": "preset:new one"
    }
   },
   {
    "box": {
     "id": "d0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      326.8,
      158.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      222.0,
      279.4,
      22.0
     ],
     "text": "preset:write /tmp/jamoma_m3_presets.txt"
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      326.8,
      286.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      350.0,
      101.2,
      22.0
     ],
     "text": "preset:clear"
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      326.8,
      414.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s3",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      478.0,
      272.8,
      22.0
     ],
     "text": "preset:read /tmp/jamoma_m3_presets.txt"
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      326.8,
      542.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      326.8,
      606.0,
      40.0,
      22.0
     ],
     "text": "11"
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      623.6,
      670.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s5",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      734.0,
      88.0,
      22.0
     ],
     "text": "preset one"
    }
   },
   {
    "box": {
     "id": "d5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      623.6,
      798.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s6",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      862.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "d6",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      623.6,
      926.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s7",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      990.0,
      305.8,
      22.0
     ],
     "text": "preset:read /tmp/jamoma_m3_missing_file.txt"
    }
   },
   {
    "box": {
     "id": "d7",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      623.6,
      1054.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "s8",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      623.6,
      1118.0,
      101.2,
      22.0
     ],
     "text": "preset:names"
    }
   },
   {
    "box": {
     "id": "d8",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      623.6,
      1182.0,
      74.8,
      22.0
     ],
     "text": "delay 60"
    }
   },
   {
    "box": {
     "id": "ia0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      524.6,
      990.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "ib0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      376.2,
      990.0,
      41.8,
      22.0
     ],
     "text": "int"
    }
   },
   {
    "box": {
     "id": "t0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "patching_rect": [
      722.4,
      926.0,
      55.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "ex0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450.4,
      1054.0,
      121.0,
      22.0
     ],
     "text": "expr $i1*10+$i2"
    }
   },
   {
    "box": {
     "id": "eq0",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      450.4,
      1118.0,
      55.0,
      22.0
     ],
     "text": "== 12"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "x0",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      450.4,
      1246.0,
      523.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/preset_files/read_brings_the_presets_back"
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      998.0,
      1246.0,
      140.8,
      22.0
     ],
     "text": "route preset:names"
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
      998.0,
      1310.0,
      61.6,
      22.0
     ],
     "text": "zl len"
    }
   },
   {
    "box": {
     "id": "e2",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      998.0,
      1374.0,
      48.4,
      22.0
     ],
     "text": "== 1"
    }
   },
   {
    "box": {
     "color": [
      0.7,
      0.4,
      0.3,
      1.0
     ],
     "id": "asn",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      998.0,
      1502.0,
      523.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.model/preset_files/missing_file_changes_nothing"
    }
   },
   {
    "box": {
     "id": "dend",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      1162.8,
      1246.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "tg_x0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      450.4,
      1182.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_asn",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      998.0,
      1438.0,
      24.0,
      24.0
     ]
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "s1",
      0
     ],
     "source": [
      "d0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s2",
      0
     ],
     "source": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s3",
      0
     ],
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s4",
      0
     ],
     "source": [
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s5",
      0
     ],
     "source": [
      "d4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s6",
      0
     ],
     "source": [
      "d5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s7",
      0
     ],
     "source": [
      "d6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s8",
      0
     ],
     "source": [
      "d7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "dend",
      0
     ],
     "source": [
      "d8",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "term",
      0
     ],
     "source": [
      "dend",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_asn",
      0
     ],
     "source": [
      "e2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_x0",
      0
     ],
     "source": [
      "eq0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "eq0",
      0
     ],
     "source": [
      "ex0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ex0",
      0
     ],
     "source": [
      "ia0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ex0",
      1
     ],
     "source": [
      "ib0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "s0",
      0
     ],
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rt",
      0
     ],
     "source": [
      "m",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ia0",
      1
     ],
     "source": [
      "pa",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ib0",
      1
     ],
     "source": [
      "pb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "zn",
      0
     ],
     "source": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d0",
      0
     ],
     "order": 1,
     "source": [
      "s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      329.5,
      89.2265625,
      976.5,
      89.2265625
     ],
     "order": 0,
     "source": [
      "s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d1",
      0
     ],
     "order": 1,
     "source": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      329.5,
      161.8828125,
      976.5,
      161.8828125
     ],
     "order": 0,
     "source": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d2",
      0
     ],
     "order": 1,
     "source": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      329.5,
      230.92578125,
      976.5,
      230.92578125
     ],
     "order": 0,
     "source": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d3",
      0
     ],
     "order": 1,
     "source": [
      "s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      329.5,
      299.23828125,
      976.5,
      299.23828125
     ],
     "order": 0,
     "source": [
      "s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d4",
      0
     ],
     "order": 0,
     "source": [
      "s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "pa",
      0
     ],
     "order": 1,
     "source": [
      "s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d5",
      0
     ],
     "order": 1,
     "source": [
      "s5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      626.5,
      455.62109375,
      976.5,
      455.62109375
     ],
     "order": 0,
     "source": [
      "s5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d6",
      0
     ],
     "order": 1,
     "source": [
      "s6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t0",
      0
     ],
     "order": 0,
     "source": [
      "s6",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d7",
      0
     ],
     "order": 1,
     "source": [
      "s7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      626.5,
      649.921875,
      976.5,
      649.921875
     ],
     "order": 0,
     "source": [
      "s7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d8",
      0
     ],
     "order": 1,
     "source": [
      "s8",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "m",
      0
     ],
     "midpoints": [
      626.5,
      723.03125,
      976.5,
      723.03125
     ],
     "order": 0,
     "source": [
      "s8",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ia0",
      0
     ],
     "source": [
      "t0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ib0",
      0
     ],
     "source": [
      "t0",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "asn",
      0
     ],
     "source": [
      "tg_asn",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "x0",
      0
     ],
     "source": [
      "tg_x0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "e2",
      0
     ],
     "source": [
      "zn",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
