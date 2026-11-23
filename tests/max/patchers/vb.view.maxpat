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
   800.0,
   600.0
  ],
  "boxes": [
   {
    "box": {
     "id": "i",
     "maxclass": "inlet",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      30.0,
      30.0
     ],
     "index": 1,
     "comment": ""
    }
   },
   {
    "box": {
     "id": "v",
     "maxclass": "newobj",
     "text": "j.view",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      100.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "o1",
     "maxclass": "outlet",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      30.0,
      30.0
     ],
     "index": 1,
     "comment": ""
    }
   },
   {
    "box": {
     "id": "o2",
     "maxclass": "outlet",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      30.0,
      30.0,
      30.0
     ],
     "index": 2,
     "comment": ""
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "i",
      0
     ],
     "destination": [
      "v",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v",
      0
     ],
     "destination": [
      "o1",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "v",
      1
     ],
     "destination": [
      "o2",
      0
     ]
    }
   }
  ]
 }
}