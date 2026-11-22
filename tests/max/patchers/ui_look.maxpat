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
   1379.2,
   240.0
  ],
  "boxes": [
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model look",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "a",
     "maxclass": "newobj",
     "text": "j.parameter gain @type decimal @default 0.5 @range 0 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      155.2,
      30.0,
      378.4,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "b",
     "maxclass": "newobj",
     "text": "j.parameter freq @type integer @default 440",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      557.6,
      30.0,
      305.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "c",
     "maxclass": "newobj",
     "text": "j.message reset",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      887.4,
      30.0,
      121.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "v",
     "maxclass": "newobj",
     "text": "j.view /look",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      1032.4,
      30.0,
      101.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "u",
     "maxclass": "j.ui",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1157.6,
      30.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "n",
     "maxclass": "message",
     "text": "preset:new first",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      1221.6,
      30.0,
      127.6,
      22.0
     ]
    }
   }
  ],
  "lines": []
 }
}
