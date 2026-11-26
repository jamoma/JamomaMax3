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
   3673.2,
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
      2938.0,
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
      3134.4,
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
      3400.8,
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
      3042.0,
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
      3042.0,
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
      3134.4,
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
      3215.2,
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
     "id": "rr",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      3042.0,
      286.0,
      85.8,
      22.0
     ],
     "text": "route error"
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
      3042.0,
      414.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "tb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      3042.0,
      350.0,
      40.0,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "top",
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
      30.0,
      94.0,
      85.8,
      22.0
     ],
     "text": "t b b b b b"
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
     "id": "text_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 9,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      1855.8,
      158.0,
      132.2,
      22.0
     ],
     "text": "t b b 8 b b b b 3 b"
    }
   },
   {
    "box": {
     "id": "text_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2705.6,
      222.0,
      184.4,
      22.0
     ],
     "text": "namespace/select /pm/a /pm/b"
    }
   },
   {
    "box": {
     "id": "text_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2705.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2624.8,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "text_m2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2538.2,
      222.0,
      62.6,
      22.0
     ],
     "text": "new one"
    }
   },
   {
    "box": {
     "id": "text_s2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2538.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_m3",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2324.0,
      222.0,
      190.2,
      22.0
     ],
     "text": "write /tmp/jamoma_m4_cues.txt"
    }
   },
   {
    "box": {
     "id": "text_s3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2341.4,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_m4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2249.0,
      222.0,
      51.0,
      22.0
     ],
     "text": "clear"
    }
   },
   {
    "box": {
     "id": "text_s4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2249.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_m5",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      2040.6,
      222.0,
      184.4,
      22.0
     ],
     "text": "read /tmp/jamoma_m4_cues.txt"
    }
   },
   {
    "box": {
     "id": "text_s5",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      2040.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_s6",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1959.8,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "text_m7",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1855.8,
      222.0,
      80.0,
      22.0
     ],
     "text": "recall one"
    }
   },
   {
    "box": {
     "id": "text_s7",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1855.8,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "text_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1855.8,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "text_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1855.8,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 3."
    }
   },
   {
    "box": {
     "id": "text_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1855.8,
      542.0,
      433.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/files/a_written_text_file_is_read_back"
    }
   },
   {
    "box": {
     "id": "xml_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 8,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ],
     "patching_rect": [
      982.0,
      158.0,
      120.6,
      22.0
     ],
     "text": "t b b 8 b b b b 4"
    }
   },
   {
    "box": {
     "id": "xml_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1751.0,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "xml_m1",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1664.4,
      222.0,
      62.6,
      22.0
     ],
     "text": "new two"
    }
   },
   {
    "box": {
     "id": "xml_s1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1664.4,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "xml_m2",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1450.2,
      222.0,
      190.2,
      22.0
     ],
     "text": "write /tmp/jamoma_m4_cues.xml"
    }
   },
   {
    "box": {
     "id": "xml_s2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1467.6,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "xml_m3",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1375.2,
      222.0,
      51.0,
      22.0
     ],
     "text": "clear"
    }
   },
   {
    "box": {
     "id": "xml_s3",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1375.2,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "xml_m4",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1166.8,
      222.0,
      184.4,
      22.0
     ],
     "text": "read /tmp/jamoma_m4_cues.xml"
    }
   },
   {
    "box": {
     "id": "xml_s4",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1166.8,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "xml_s5",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      1086.0,
      222.0,
      56.8,
      22.0
     ],
     "text": "s to_a"
    }
   },
   {
    "box": {
     "id": "xml_m6",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      982.0,
      222.0,
      80.0,
      22.0
     ],
     "text": "recall two"
    }
   },
   {
    "box": {
     "id": "xml_s6",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      982.0,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "xml_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      982.0,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "xml_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      982.0,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 4."
    }
   },
   {
    "box": {
     "id": "xml_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      982.0,
      542.0,
      428.0,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/files/a_written_xml_file_is_read_back"
    }
   },
   {
    "box": {
     "id": "missing_t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      424.8,
      158.0,
      51.0,
      22.0
     ],
     "text": "t b b"
    }
   },
   {
    "box": {
     "id": "missing_m0",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      424.8,
      222.0,
      230.8,
      22.0
     ],
     "text": "read /tmp/jamoma_m4_no_such_cues.txt"
    }
   },
   {
    "box": {
     "id": "missing_s0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      424.8,
      286.0,
      68.4,
      22.0
     ],
     "text": "s to_cue"
    }
   },
   {
    "box": {
     "id": "missing_h",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      424.8,
      350.0,
      68.4,
      22.0
     ],
     "text": "float 0."
    }
   },
   {
    "box": {
     "id": "missing_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      424.8,
      414.0,
      51.0,
      22.0
     ],
     "text": "== 1."
    }
   },
   {
    "box": {
     "id": "missing_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      424.8,
      542.0,
      509.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/files/a_missing_file_is_reported_on_the_dump_outlet"
    }
   },
   {
    "box": {
     "id": "kept_t",
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
     "text": "t b b 8"
    }
   },
   {
    "box": {
     "id": "kept_s0",
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
     "id": "kept_m1",
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
     "text": "recall two"
    }
   },
   {
    "box": {
     "id": "kept_s1",
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
     "id": "kept_h",
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
     "id": "kept_c",
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
     "text": "== 4."
    }
   },
   {
    "box": {
     "id": "kept_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      542.0,
      346.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.cue/files/and_the_cues_stay"
    }
   },
   {
    "box": {
     "id": "tg_text_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1855.8,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_xml_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      982.0,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_missing_a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      424.8,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_kept_a",
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
      1
     ],
     "destination": [
      "rr",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rr",
      0
     ],
     "destination": [
      "tb",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tb",
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
      4
     ],
     "destination": [
      "text_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      8
     ],
     "destination": [
      "text_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m0",
      0
     ],
     "destination": [
      "text_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      7
     ],
     "destination": [
      "text_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      6
     ],
     "destination": [
      "text_m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m2",
      0
     ],
     "destination": [
      "text_s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      5
     ],
     "destination": [
      "text_m3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m3",
      0
     ],
     "destination": [
      "text_s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      4
     ],
     "destination": [
      "text_m4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m4",
      0
     ],
     "destination": [
      "text_s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      3
     ],
     "destination": [
      "text_m5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m5",
      0
     ],
     "destination": [
      "text_s5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      2
     ],
     "destination": [
      "text_s6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      1
     ],
     "destination": [
      "text_m7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_m7",
      0
     ],
     "destination": [
      "text_s7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_t",
      0
     ],
     "destination": [
      "text_h",
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
      "text_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_h",
      0
     ],
     "destination": [
      "text_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "text_c",
      0
     ],
     "destination": [
      "tg_text_a",
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
      "xml_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      7
     ],
     "destination": [
      "xml_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      6
     ],
     "destination": [
      "xml_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_m1",
      0
     ],
     "destination": [
      "xml_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      5
     ],
     "destination": [
      "xml_m2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_m2",
      0
     ],
     "destination": [
      "xml_s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      4
     ],
     "destination": [
      "xml_m3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_m3",
      0
     ],
     "destination": [
      "xml_s3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      3
     ],
     "destination": [
      "xml_m4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_m4",
      0
     ],
     "destination": [
      "xml_s4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      2
     ],
     "destination": [
      "xml_s5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      1
     ],
     "destination": [
      "xml_m6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_m6",
      0
     ],
     "destination": [
      "xml_s6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_t",
      0
     ],
     "destination": [
      "xml_h",
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
      "xml_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_h",
      0
     ],
     "destination": [
      "xml_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "xml_c",
      0
     ],
     "destination": [
      "tg_xml_a",
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
      "missing_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "missing_t",
      1
     ],
     "destination": [
      "missing_m0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "missing_m0",
      0
     ],
     "destination": [
      "missing_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "missing_t",
      0
     ],
     "destination": [
      "missing_h",
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
      "missing_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "missing_h",
      0
     ],
     "destination": [
      "missing_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "missing_c",
      0
     ],
     "destination": [
      "tg_missing_a",
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
      "kept_t",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_t",
      2
     ],
     "destination": [
      "kept_s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_t",
      1
     ],
     "destination": [
      "kept_m1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_m1",
      0
     ],
     "destination": [
      "kept_s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_t",
      0
     ],
     "destination": [
      "kept_h",
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
      "kept_h",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_h",
      0
     ],
     "destination": [
      "kept_c",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "kept_c",
      0
     ],
     "destination": [
      "tg_kept_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_text_a",
      0
     ],
     "destination": [
      "text_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_xml_a",
      0
     ],
     "destination": [
      "xml_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_missing_a",
      0
     ],
     "destination": [
      "missing_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_kept_a",
      0
     ],
     "destination": [
      "kept_a",
      0
     ]
    }
   }
  ]
 }
}
