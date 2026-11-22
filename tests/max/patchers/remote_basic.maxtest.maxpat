{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 0,
   "revision": 0,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   60.0,
   60.0,
   1533.4,
   722.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model rb",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "px",
     "maxclass": "newobj",
     "text": "j.parameter x @type decimal @default 0.5",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      286.0,
      286.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm",
     "maxclass": "newobj",
     "text": "j.remote x",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      297.0,
      414.0,
      88.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "ji",
     "maxclass": "newobj",
     "text": "j.init",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      30.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "term",
     "maxclass": "newobj",
     "text": "test.terminate",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      718.6,
      542.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s0",
     "maxclass": "message",
     "text": "3.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      94.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d0",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      158.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s1",
     "maxclass": "message",
     "text": "7.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      222.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      452.0,
      286.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s2",
     "maxclass": "message",
     "text": "set 9.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      452.0,
      350.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 80",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      452.0,
      414.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dend",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      468.2,
      478.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p3s",
     "maxclass": "newobj",
     "text": "sel 3.",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      142.0,
      350.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p3o",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      414.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p3a",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/remote_basic/number_sets_the_parameter",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      542.0,
      424.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r7s",
     "maxclass": "newobj",
     "text": "sel 7.",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      297.0,
      478.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r7o",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      590.6,
      542.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r7a",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/remote_basic/parameter_change_reaches_the_ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      590.6,
      670.0,
      464.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r9s",
     "maxclass": "newobj",
     "text": "sel 9.",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      382.6,
      478.0,
      61.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r9o",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      654.6,
      542.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r9a",
     "maxclass": "newobj",
     "text": "test.assert JamomaMax3/remote_basic/set_shows_without_sending",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1078.8,
      670.0,
      424.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_p3a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      142.0,
      478.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_r7a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      590.6,
      606.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_r9a",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1078.8,
      606.0,
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
      "ji",
      1
     ],
     "destination": [
      "s0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "rm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s0",
      0
     ],
     "destination": [
      "d0",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d0",
      0
     ],
     "destination": [
      "s1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
      0
     ],
     "destination": [
      "px",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s1",
      0
     ],
     "destination": [
      "d1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d1",
      0
     ],
     "destination": [
      "s2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "rm",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "s2",
      0
     ],
     "destination": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d2",
      0
     ],
     "destination": [
      "dend",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dend",
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
      "px",
      0
     ],
     "destination": [
      "p3s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p3s",
      0
     ],
     "destination": [
      "p3o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "p3o",
      0
     ],
     "destination": [
      "tg_p3a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rm",
      0
     ],
     "destination": [
      "r7s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r7s",
      0
     ],
     "destination": [
      "r7o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r7o",
      0
     ],
     "destination": [
      "tg_r7a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rm",
      0
     ],
     "destination": [
      "r9s",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r9s",
      0
     ],
     "destination": [
      "r9o",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r9o",
      0
     ],
     "destination": [
      "tg_r9a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_p3a",
      0
     ],
     "destination": [
      "p3a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_r7a",
      0
     ],
     "destination": [
      "r7a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_r9a",
      0
     ],
     "destination": [
      "r9a",
      0
     ]
    }
   }
  ]
 }
}
