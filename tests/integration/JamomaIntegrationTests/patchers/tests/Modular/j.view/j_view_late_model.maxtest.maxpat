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
   1139.6,
   850.0
  ],
  "boxes": [
   {
    "box": {
     "id": "vw",
     "maxclass": "newobj",
     "text": "vb.view",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      599.4,
      478.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "text": "thispatcher",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      402.6,
      414.0,
      94.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rv",
     "maxclass": "newobj",
     "text": "j.receive /vb/a",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "text": "loadbang",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      175.0,
      30.0,
      74.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d1",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      175.0,
      94.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "mk",
     "maxclass": "message",
     "text": "script newdefault m1 30 500 vb.model",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      175.0,
      158.0,
      259.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d2",
     "maxclass": "newobj",
     "text": "delay 400",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      458.6,
      158.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "go",
     "maxclass": "message",
     "text": "a 7",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      458.6,
      222.0,
      41.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d3",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      524.4,
      222.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump1",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      557.8,
      286.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d4",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      630.2,
      286.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rm",
     "maxclass": "message",
     "text": "script delete m1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      630.2,
      350.0,
      127.6,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d5",
     "maxclass": "newobj",
     "text": "delay 200",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      350.0,
      81.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "dump2",
     "maxclass": "message",
     "text": "dump",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      781.8,
      414.0,
      48.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "d6",
     "maxclass": "newobj",
     "text": "delay 300",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      854.2,
      414.0,
      81.4,
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
      854.2,
      478.0,
      114.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "s",
     "maxclass": "newobj",
     "text": "sel 7",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      55.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      158.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as1",
     "maxclass": "newobj",
     "text": "test.assert Jamoma/Modular/j.view/late_model/binds_when_the_model_appears",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      286.0,
      503.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "rt",
     "maxclass": "newobj",
     "text": "route model:address model:waiting",
     "numinlets": 3,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      599.4,
      542.0,
      239.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "sa",
     "maxclass": "newobj",
     "text": "sel /vb",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      599.4,
      606.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "one2",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      599.4,
      670.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as2",
     "maxclass": "newobj",
     "text": "test.assert Jamoma/Modular/j.view/late_model/reports_its_model",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      599.4,
      798.0,
      431.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "text": "1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      691.6,
      606.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "as3",
     "maxclass": "newobj",
     "text": "test.assert Jamoma/Modular/j.view/late_model/reports_waiting",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      691.6,
      734.0,
      418.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as1",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      30.0,
      222.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as2",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      599.4,
      734.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_as3",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      691.6,
      670.0,
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
      "lb",
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
      "mk",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "mk",
      0
     ],
     "destination": [
      "tp",
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
      "go",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "go",
      0
     ],
     "destination": [
      "vw",
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
      "d3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3",
      0
     ],
     "destination": [
      "dump1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump1",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d3",
      0
     ],
     "destination": [
      "d4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d4",
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
      "rm",
      0
     ],
     "destination": [
      "tp",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d4",
      0
     ],
     "destination": [
      "d5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d5",
      0
     ],
     "destination": [
      "dump2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "dump2",
      0
     ],
     "destination": [
      "vw",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d5",
      0
     ],
     "destination": [
      "d6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "d6",
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
      "rv",
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
      "s",
      0
     ],
     "destination": [
      "one",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one",
      0
     ],
     "destination": [
      "tg_as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "vw",
      1
     ],
     "destination": [
      "rt",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      0
     ],
     "destination": [
      "sa",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "sa",
      0
     ],
     "destination": [
      "one2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "one2",
      0
     ],
     "destination": [
      "tg_as2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "rt",
      1
     ],
     "destination": [
      "bg",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "bg",
      0
     ],
     "destination": [
      "tg_as3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as1",
      0
     ],
     "destination": [
      "as1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as2",
      0
     ],
     "destination": [
      "as2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "tg_as3",
      0
     ],
     "destination": [
      "as3",
      0
     ]
    }
   }
  ]
 }
}
