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
   464.6,
   240.0
  ],
  "boxes": [
   {
    "box": {
     "id": "i",
     "maxclass": "newobj",
     "text": "r vu_model_in",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ],
     "patching_rect": [
      30.0,
      30.0,
      107.8,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "m",
     "maxclass": "newobj",
     "text": "j.model",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      30.0,
      94.0,
      68.2,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "p",
     "maxclass": "newobj",
     "text": "j.parameter a @type integer @default 1",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      161.8,
      30.0,
      272.8,
      22.0
     ]
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
      "m",
      0
     ]
    }
   }
  ]
 }
}
