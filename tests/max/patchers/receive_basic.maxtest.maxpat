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
        "rect": [ 134.0, 168.0, 1135.0, 467.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 30.0, 88.0, 22.0 ],
                    "text": "j.model rb"
                }
            },
            {
                "box": {
                    "id": "a",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 900.0, 232.0, 200.2, 22.0 ],
                    "text": "j.parameter a @type integer"
                }
            },
            {
                "box": {
                    "id": "r",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 142.0, 30.0, 94.6, 22.0 ],
                    "text": "j.receive a"
                }
            },
            {
                "box": {
                    "id": "g",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 142.0, 94.0, 88.0, 22.0 ],
                    "text": "zl group 2"
                }
            },
            {
                "box": {
                    "id": "u",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 142.0, 158.0, 88.0, 22.0 ],
                    "text": "unpack 0 0"
                }
            },
            {
                "box": {
                    "id": "e",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 142.0, 222.0, 121.0, 22.0 ],
                    "text": "expr $i1*10+$i2"
                }
            },
            {
                "box": {
                    "id": "q",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 142.0, 286.0, 48.4, 22.0 ],
                    "text": "== 5"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 142.0, 414.0, 257.0, 22.0 ],
                    "text": "test.assert JamomaMax3/receive_basic/values"
                }
            },
            {
                "box": {
                    "id": "ar",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 450.0, 89.0, 94.6, 22.0 ],
                    "text": "route /rb/a"
                }
            },
            {
                "box": {
                    "id": "one",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 450.0, 144.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "aa",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 450.0, 414.0, 265.0, 22.0 ],
                    "text": "test.assert JamomaMax3/receive_basic/address"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 694.0, 40.0, 74.8, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "ji",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 900.0, 40.0, 61.6, 22.0 ],
                    "text": "j.init"
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 900.0, 104.0, 81.4, 22.0 ],
                    "text": "delay 100"
                }
            },
            {
                "box": {
                    "id": "set",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 900.0, 168.0, 40.0, 22.0 ],
                    "text": "5"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 694.0, 104.0, 88.0, 22.0 ],
                    "text": "delay 3000"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 694.0, 168.0, 114.4, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "tg_as",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 142.0, 350.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_aa",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 450.0, 350.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "one", 0 ],
                    "source": [ "ar", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "set", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q", 0 ],
                    "source": [ "e", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u", 0 ],
                    "source": [ "g", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_aa", 0 ],
                    "source": [ "one", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as", 0 ],
                    "source": [ "q", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ar", 0 ],
                    "source": [ "r", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "r", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a", 0 ],
                    "source": [ "set", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "aa", 0 ],
                    "source": [ "tg_aa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "as", 0 ],
                    "source": [ "tg_as", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e", 1 ],
                    "source": [ "u", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e", 0 ],
                    "source": [ "u", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}