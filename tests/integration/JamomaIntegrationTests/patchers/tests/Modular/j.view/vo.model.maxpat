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
   730.4,
   240.0
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
      62.6,
      22.0
     ],
     "text": "j.model"
    }
   },
   {
    "box": {
     "id": "in",
     "maxclass": "inlet",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      116.6,
      30.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "r",
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
      116.6,
      94.0,
      85.8,
      22.0
     ],
     "text": "route a b c"
    }
   },
   {
    "box": {
     "id": "p_a",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      116.6,
      158.0,
      178.6,
      22.0
     ],
     "text": "j.parameter a @type integer"
    }
   },
   {
    "box": {
     "id": "p_b",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      319.2,
      158.0,
      178.6,
      22.0
     ],
     "text": "j.parameter b @type integer"
    }
   },
   {
    "box": {
     "id": "p_c",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      521.8,
      158.0,
      178.6,
      22.0
     ],
     "text": "j.parameter c @type integer"
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "in",
      0
     ],
     "destination": [
      "r",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      0
     ],
     "destination": [
      "p_a",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      1
     ],
     "destination": [
      "p_b",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r",
      2
     ],
     "destination": [
      "p_c",
      0
     ]
    }
   }
  ]
 }
}
