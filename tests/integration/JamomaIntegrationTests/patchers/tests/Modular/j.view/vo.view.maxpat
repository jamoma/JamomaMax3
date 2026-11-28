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
   585.4,
   240.0
  ],
  "boxes": [
   {
    "box": {
     "id": "v",
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
      56.8,
      22.0
     ],
     "text": "j.view"
    }
   },
   {
    "box": {
     "id": "out",
     "maxclass": "outlet",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": [],
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
     "id": "named",
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
      429.0,
      158.0,
      126.4,
      22.0
     ],
     "text": "j.remote a named_a"
    }
   },
   {
    "box": {
     "id": "plain",
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
      110.8,
      30.0,
      80.0,
      22.0
     ],
     "text": "j.remote b"
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
      214.8,
      30.0,
      40.0,
      22.0
     ]
    }
   },
   {
    "box": {
     "id": "own",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "patching_rect": [
      214.8,
      158.0,
      190.2,
      22.0
     ],
     "text": "j.parameter own @type integer"
    }
   },
   {
    "box": {
     "id": "r_in",
     "maxclass": "newobj",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "patching_rect": [
      214.8,
      94.0,
      109.0,
      22.0
     ],
     "text": "route own named"
    }
   },
   {
    "box": {
     "id": "sub",
     "maxclass": "newobj",
     "numinlets": 0,
     "numoutlets": 0,
     "outlettype": [],
     "patching_rect": [
      278.8,
      30.0,
      62.6,
      22.0
     ],
     "text": "p inner",
     "patcher": {
      "fileversion": 1,
      "classnamespace": "box",
      "rect": [
       50.0,
       50.0,
       400.0,
       240.0
      ],
      "boxes": [
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
          30.0,
          30.0,
          126.4,
          22.0
         ],
         "text": "j.remote c named_c"
        }
       }
      ],
      "lines": []
     }
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "v",
      0
     ],
     "destination": [
      "out",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "in",
      0
     ],
     "destination": [
      "r_in",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_in",
      0
     ],
     "destination": [
      "own",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "r_in",
      1
     ],
     "destination": [
      "named",
      0
     ]
    }
   }
  ]
 }
}
