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
        "rect": [ 134.0, 168.0, 1296.0, 466.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 30.0, 114.4, 22.0 ],
                    "text": "j.model modelA"
                }
            },
            {
                "box": {
                    "id": "pa",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 356.4, 6.0, 281.0, 22.0 ],
                    "text": "j.parameter a @type integer @default 1 @priority 1"
                }
            },
            {
                "box": {
                    "id": "pb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 399.0, 40.0, 281.0, 22.0 ],
                    "text": "j.parameter b @type integer @default 2 @priority 0"
                }
            },
            {
                "box": {
                    "id": "ji",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 920.4, 30.0, 61.6, 22.0 ],
                    "text": "j.init"
                }
            },
            {
                "box": {
                    "id": "g",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 356.4, 94.0, 88.0, 22.0 ],
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
                    "patching_rect": [ 356.4, 158.0, 88.0, 22.0 ],
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
                    "patching_rect": [ 356.4, 222.0, 121.0, 22.0 ],
                    "text": "expr $i1*10+$i2"
                }
            },
            {
                "box": {
                    "id": "eq",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 356.4, 286.0, 55.0, 22.0 ],
                    "text": "== 21"
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
                    "patching_rect": [ 356.4, 414.0, 338.8, 22.0 ],
                    "text": "test.assert JamomaMax3/model_init/priority_order"
                }
            },
            {
                "box": {
                    "id": "st",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 920.4, 94.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "as2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 920.4, 222.0, 345.4, 22.0 ],
                    "text": "test.assert JamomaMax3/model_init/init_start_bang"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 984.4, 94.0, 114.4, 22.0 ],
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
                    "patching_rect": [ 356.4, 350.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_as2",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 920.4, 158.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "eq", 0 ],
                    "source": [ "e", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as", 0 ],
                    "source": [ "eq", 0 ]
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
                    "destination": [ "st", 0 ],
                    "source": [ "ji", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "pa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "pb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_as2", 0 ],
                    "source": [ "st", 0 ]
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
                    "destination": [ "as2", 0 ],
                    "source": [ "tg_as2", 0 ]
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