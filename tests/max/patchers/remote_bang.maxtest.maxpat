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
   80.0,
   96.0,
   1452.0,
   338.0
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
      30.0,
      30.0,
      68.2,
      22.0
     ],
     "text": "j.model"
    }
   },
   {
    "box": {
     "id": "init",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ],
     "patching_rect": [
      122.2,
      30.0,
      61.6,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "ret",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      122.2,
      158.0,
      200.2,
      22.0
     ],
     "text": "j.return trigger @type none"
    }
   },
   {
    "box": {
     "id": "rem",
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
      207.8,
      30.0,
      127.6,
      22.0
     ],
     "text": "j.remote trigger"
    }
   },
   {
    "box": {
     "id": "rcv",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      359.4,
      30.0,
      134.2,
      22.0
     ],
     "text": "j.receive trigger"
    }
   },
   {
    "box": {
     "id": "fire",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      517.6,
      30.0,
      41.8,
      22.0
     ],
     "text": "t b"
    }
   },
   {
    "box": {
     "id": "go",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      122.2,
      94.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "dl",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      583.4,
      30.0,
      81.4,
      22.0
     ],
     "text": "delay 100"
    }
   },
   {
    "box": {
     "id": "rset",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      300.0,
      94.0,
      81.4,
      22.0
     ],
     "text": "route set"
    }
   },
   {
    "box": {
     "id": "one0",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      484.8,
      158.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "one1",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      405.4,
      94.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "one2",
     "maxclass": "message",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      469.4,
      94.0,
      40.0,
      22.0
     ],
     "text": "1"
    }
   },
   {
    "box": {
     "id": "tg0",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      484.8,
      222.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as0",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      484.8,
      286.0,
      484.0,
      22.0
     ],
     "text": "test.assert JamomaMax3/remote_bang/the_remote_shows_a_bang_as_set_bang"
    }
   },
   {
    "box": {
     "id": "tg1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      548.8,
      158.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      548.8,
      222.0,
      418.0,
      22.0
     ],
     "text": "test.assert JamomaMax3/remote_bang/the_remote_outputs_a_bang"
    }
   },
   {
    "box": {
     "id": "tg2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      990.8,
      158.0,
      24.0,
      24.0
     ],
     "parameter_enable": 0
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      990.8,
      222.0,
      431.2,
      22.0
     ],
     "text": "test.assert JamomaMax3/remote_bang/the_receiver_outputs_a_bang"
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
      194.6,
      94.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
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
      346.4,
      158.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "as0",
      0
     ],
     "source": [
      "tg0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as1",
      0
     ],
     "source": [
      "tg1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as2",
      0
     ],
     "source": [
      "tg2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "go",
      0
     ],
     "source": [
      "init",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ret",
      0
     ],
     "source": [
      "go",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rset",
      0
     ],
     "source": [
      "rem",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "one0",
      0
     ],
     "source": [
      "rset",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg0",
      0
     ],
     "source": [
      "one0",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "one1",
      0
     ],
     "source": [
      "rem",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg1",
      0
     ],
     "source": [
      "one1",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "one2",
      0
     ],
     "source": [
      "rcv",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg2",
      0
     ],
     "source": [
      "one2",
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
     "source": [
      "init",
      1
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
      "d2",
      0
     ]
    }
   }
  ],
  "autosave": 0,
  "dependency_cache": []
 }
}
