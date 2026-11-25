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
   134.0,
   168.0,
   1628.2,
   722.0
  ],
  "boxes": [
   {
    "box": {
     "id": "obj-11",
     "maxclass": "number",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
      30.0,
      40.0,
      22.0
     ]
    }
   },
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
      94.0,
      30.0,
      88.0,
      22.0
     ],
     "text": "j.model rb"
    }
   },
   {
    "box": {
     "id": "px",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      118.0,
      286.0,
      286.0,
      22.0
     ],
     "text": "j.parameter x @type decimal @default 0.5"
    }
   },
   {
    "box": {
     "id": "rm",
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
      317.0,
      414.0,
      88.0,
      22.0
     ],
     "text": "j.remote x"
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
      206.0,
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
      734.2,
      542.0,
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
      206.0,
      94.0,
      40.0,
      22.0
     ],
     "text": "3."
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
      206.0,
      158.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
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
      206.0,
      222.0,
      40.0,
      22.0
     ],
     "text": "7."
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
      428.0,
      286.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
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
      428.0,
      350.0,
      61.6,
      22.0
     ],
     "text": "set 9."
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
      429.0,
      414.0,
      74.8,
      22.0
     ],
     "text": "delay 80"
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
      488.2,
      478.0,
      81.4,
      22.0
     ],
     "text": "delay 300"
    }
   },
   {
    "box": {
     "id": "p3s",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      118.0,
      350.0,
      61.6,
      22.0
     ],
     "text": "sel 3."
    }
   },
   {
    "box": {
     "id": "p3o",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      118.0,
      414.0,
      40.0,
      22.0
     ],
     "text": "1"
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
     "id": "p3a",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      118.0,
      542.0,
      464.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/basic/number_sets_the_parameter"
    }
   },
   {
    "box": {
     "id": "r7s",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      317.0,
      478.0,
      61.6,
      22.0
     ],
     "text": "sel 7."
    }
   },
   {
    "box": {
     "id": "r7o",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      606.2,
      542.0,
      40.0,
      22.0
     ],
     "text": "1"
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
     "id": "r7a",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      606.2,
      670.0,
      503.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/basic/parameter_change_reaches_the_ui"
    }
   },
   {
    "box": {
     "id": "r9s",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ],
     "patching_rect": [
      402.6,
      478.0,
      61.6,
      22.0
     ],
     "text": "sel 9."
    }
   },
   {
    "box": {
     "id": "r9o",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      670.2,
      542.0,
      40.0,
      22.0
     ],
     "text": "1"
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
     "id": "r9a",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1134.0,
      670.0,
      464.2,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.remote/basic/set_shows_without_sending"
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
      118.0,
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
      606.2,
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
      1134.0,
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
      "dend",
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
      "px",
      0
     ],
     "source": [
      "obj-11",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_p3a",
      0
     ],
     "source": [
      "p3o",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "p3o",
      0
     ],
     "source": [
      "p3s",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "p3s",
      0
     ],
     "source": [
      "px",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_r7a",
      0
     ],
     "source": [
      "r7o",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r7o",
      0
     ],
     "source": [
      "r7s",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_r9a",
      0
     ],
     "source": [
      "r9o",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r9o",
      0
     ],
     "source": [
      "r9s",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r7s",
      0
     ],
     "order": 1,
     "source": [
      "rm",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r9s",
      0
     ],
     "order": 0,
     "source": [
      "rm",
      1
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
      "rm",
      0
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
      "px",
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
      "d2",
      0
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
      "rm",
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
      "p3a",
      0
     ],
     "source": [
      "tg_p3a",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r7a",
      0
     ],
     "source": [
      "tg_r7a",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "r9a",
      0
     ],
     "source": [
      "tg_r9a",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
