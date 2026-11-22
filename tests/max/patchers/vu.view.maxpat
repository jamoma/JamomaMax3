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
   400.0,
   240.0
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
      40.0,
      22.0
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
      94.0,
      30.0,
      61.6,
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
      30.0,
      94.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "o",
     "maxclass": "outlet",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      30.0,
      158.0,
      40.0,
      22.0
     ],
     "index": 1,
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
      "u",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "u",
      0
     ],
     "destination": [
      "o",
      0
     ]
    }
   }
  ]
 }
}
