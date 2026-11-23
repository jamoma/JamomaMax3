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
   1002.0,
   428.0
  ],
  "boxes": [
   {
    "box": {
     "bubble": 1,
     "id": "obj-2",
     "linecount": 3,
     "maxclass": "comment",
     "numinlets": 1,
     "numoutlets": 0,
     "patching_rect": [
      579.0,
      129.0,
      284.0,
      51.0
     ],
     "text": "When opened, this patch contains a j.parameter object (rp) that is deleted while it ramps. That is the reason the message box seems to be hanging. Do not save the patch after it has run: the deleted object would be lost."
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
      217.0,
      15.0,
      74.8,
      22.0
     ],
     "text": "loadbang"
    }
   },
   {
    "box": {
     "id": "t",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "bang",
      "bang"
     ],
     "patching_rect": [
      217.0,
      79.0,
      68.2,
      22.0
     ],
     "text": "t b b b"
    }
   },
   {
    "box": {
     "id": "go",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      428.0,
      143.0,
      140.8,
      22.0
     ],
     "text": "0., 100. ramp 5000"
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
      322.0,
      143.0,
      81.4,
      22.0
     ],
     "text": "delay 100"
    }
   },
   {
    "box": {
     "id": "del",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      419.0,
      207.0,
      127.6,
      22.0
     ],
     "text": "script delete rp"
    }
   },
   {
    "box": {
     "id": "tp",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      419.0,
      271.0,
      94.6,
      22.0
     ],
     "save": [
      "#N",
      "thispatcher",
      ";",
      "#Q",
      "end",
      ";"
     ],
     "text": "thispatcher"
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
      217.0,
      143.0,
      81.4,
      22.0
     ],
     "text": "delay 800"
    }
   },
   {
    "box": {
     "id": "one",
     "maxclass": "message",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      217.0,
      207.0,
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
     "id": "as",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      217.0,
      335.0,
      352.0,
      22.0
     ],
     "text": "test.assert JamomaMax3/free_while_ramping/survived"
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
      90.0,
      207.0,
      114.4,
      22.0
     ],
     "text": "test.terminate"
    }
   },
   {
    "box": {
     "id": "tg_as",
     "maxclass": "toggle",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ],
     "parameter_enable": 0,
     "patching_rect": [
      217.0,
      271.0,
      24.0,
      24.0
     ]
    }
   },
   {
    "box": {
     "id": "rp",
     "maxclass": "newobj",
     "text": "j.parameter rp @type decimal @ramp/drive max",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      620.0,
      207.0,
      312.4,
      22.0
     ],
     "varname": "rp"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "destination": [
      "del",
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
      "one",
      0
     ],
     "order": 0,
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
     "order": 1,
     "source": [
      "d2",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "tp",
      0
     ],
     "source": [
      "del",
      0
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "t",
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
      "tg_as",
      0
     ],
     "source": [
      "one",
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
     "source": [
      "t",
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
     "source": [
      "t",
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
      "t",
      2
     ]
    }
   },
   {
    "patchline": {
     "destination": [
      "as",
      0
     ],
     "source": [
      "tg_as",
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
      "rp",
      0
     ]
    }
   }
  ],
  "autosave": 0
 }
}