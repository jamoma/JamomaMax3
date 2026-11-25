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
   1566.2,
   530.0
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
      30.0,
      30.0,
      88.0,
      22.0
     ],
     "text": "j.model io"
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
      142.0,
      30.0,
      61.6,
      22.0
     ],
     "text": "j.init"
    }
   },
   {
    "box": {
     "id": "o",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      333.0,
      222.0,
      68.2,
      22.0
     ],
     "text": "j.out 1"
    }
   },
   {
    "box": {
     "id": "i",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      247.4,
      222.0,
      61.6,
      22.0
     ],
     "text": "j.in 1"
    }
   },
   {
    "box": {
     "id": "r",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      227.6,
      30.0,
      154.0,
      22.0
     ],
     "text": "j.receive data/out.1"
    }
   },
   {
    "box": {
     "id": "five",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      142.0,
      158.0,
      40.0,
      22.0
     ],
     "text": "5"
    }
   },
   {
    "box": {
     "id": "seven",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      247.4,
      158.0,
      40.0,
      22.0
     ],
     "text": "7"
    }
   },
   {
    "box": {
     "id": "mute",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      352.8,
      158.0,
      61.6,
      22.0
     ],
     "text": "mute 1"
    }
   },
   {
    "box": {
     "id": "six",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      464.8,
      158.0,
      40.0,
      22.0
     ],
     "text": "6"
    }
   },
   {
    "box": {
     "id": "q5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      333.0,
      286.0,
      48.4,
      22.0
     ],
     "text": "== 5"
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
     "id": "a5",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      676.2,
      414.0,
      411.4,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.in_out/basic/out_passes_values"
    }
   },
   {
    "box": {
     "id": "zr",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      454.9,
      286.0,
      61.6,
      22.0
     ],
     "text": "zl reg"
    }
   },
   {
    "box": {
     "id": "bg",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      576.8,
      158.0,
      48.4,
      22.0
     ],
     "text": "bang"
    }
   },
   {
    "box": {
     "id": "e5",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      454.9,
      350.0,
      48.4,
      22.0
     ],
     "text": "== 5"
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
     "id": "ah",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1111.6,
      478.0,
      424.6,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.in_out/basic/muted_out_is_silent"
    }
   },
   {
    "box": {
     "id": "rq",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      688.8,
      94.0,
      48.4,
      22.0
     ],
     "text": "== 5"
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
     "id": "ar",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      688.8,
      222.0,
      470.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.in_out/basic/node_is_visible_to_receive"
    }
   },
   {
    "box": {
     "id": "q7",
     "maxclass": "newobj",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "patching_rect": [
      247.4,
      286.0,
      48.4,
      22.0
     ],
     "text": "== 7"
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
     "id": "a7",
     "linecount": 2,
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      247.4,
      414.0,
      404.8,
      22.0
     ],
     "text": "test.assert Jamoma/Modular/j.in_out/basic/in_passes_values"
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
      142.0,
      94.0,
      81.4,
      22.0
     ],
     "text": "delay 100"
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
      247.4,
      94.0,
      81.4,
      22.0
     ],
     "text": "delay 600"
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
      352.8,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 1200"
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
      464.8,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 2000"
    }
   },
   {
    "box": {
     "id": "lb",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ],
     "patching_rect": [
      405.6,
      30.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
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
      576.8,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 3000"
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
      761.2,
      94.0,
      88.0,
      22.0
     ],
     "text": "delay 4500"
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
      761.2,
      158.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_a5",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      676.2,
      350.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_ah",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      1111.6,
      414.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_ar",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      688.8,
      158.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "tg_a7",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      247.4,
      350.0,
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
      "zr",
      0
     ],
     "source": [
      "bg",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "five",
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
      "seven",
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
      "mute",
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
      "six",
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
      "bg",
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
      "term",
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
      "tg_ah",
      0
     ],
     "source": [
      "e5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "o",
      0
     ],
     "source": [
      "five",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "q7",
      0
     ],
     "source": [
      "i",
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
     "order": 4,
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d2",
      0
     ],
     "order": 3,
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d3",
      0
     ],
     "order": 2,
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d4",
      0
     ],
     "order": 1,
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d5",
      0
     ],
     "order": 0,
     "source": [
      "ji",
      1
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "d6",
      0
     ],
     "source": [
      "lb",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "o",
      0
     ],
     "source": [
      "mute",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "q5",
      0
     ],
     "order": 1,
     "source": [
      "o",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "zr",
      1
     ],
     "order": 0,
     "source": [
      "o",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a5",
      0
     ],
     "source": [
      "q5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_a7",
      0
     ],
     "source": [
      "q7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "rq",
      0
     ],
     "source": [
      "r",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tg_ar",
      0
     ],
     "source": [
      "rq",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "i",
      0
     ],
     "source": [
      "seven",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "o",
      0
     ],
     "source": [
      "six",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a5",
      0
     ],
     "source": [
      "tg_a5",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "a7",
      0
     ],
     "source": [
      "tg_a7",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ah",
      0
     ],
     "source": [
      "tg_ah",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "ar",
      0
     ],
     "source": [
      "tg_ar",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "e5",
      0
     ],
     "source": [
      "zr",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}
