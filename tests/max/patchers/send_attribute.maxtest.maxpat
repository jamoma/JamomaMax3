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
        "rect": [ 134.0, 168.0, 926.0, 466.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 30.0, 63.0, 22.0 ],
                    "text": "j.model sa"
                }
            },
            {
                "box": {
                    "id": "a",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 142.0, 30.0, 321.0, 22.0 ],
                    "text": "j.parameter a @type integer @range 0 10 @clipmode both"
                }
            },
            {
                "box": {
                    "id": "sr",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 682.8, 222.0, 85.0, 22.0 ],
                    "text": "j.send a:range"
                }
            },
            {
                "box": {
                    "id": "sv",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 821.2, 222.0, 51.0, 22.0 ],
                    "text": "j.send a"
                }
            },
            {
                "box": {
                    "id": "g",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 142.0, 94.0, 61.0, 22.0 ],
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
                    "patching_rect": [ 142.0, 158.0, 67.0, 22.0 ],
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
                    "patching_rect": [ 142.0, 222.0, 92.0, 22.0 ],
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
                    "patching_rect": [ 142.0, 286.0, 33.0, 22.0 ],
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
                    "patching_rect": [ 142.0, 414.0, 397.0, 22.0 ],
                    "text": "test.assert JamomaMax3/send_attribute/value_is_clipped_to_new_range"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 544.4, 30.0, 58.0, 22.0 ],
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
                    "patching_rect": [ 682.55, 30.0, 30.0, 22.0 ],
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
                    "patching_rect": [ 682.8, 94.0, 61.0, 22.0 ],
                    "text": "delay 100"
                }
            },
            {
                "box": {
                    "id": "rng",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 682.8, 158.0, 29.5, 22.0 ],
                    "text": "0 5"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 821.2, 94.0, 61.0, 22.0 ],
                    "text": "delay 500"
                }
            },
            {
                "box": {
                    "id": "big",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 821.2, 158.0, 29.5, 22.0 ],
                    "text": "20"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 544.4, 94.0, 67.0, 22.0 ],
                    "text": "delay 3500"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 544.4, 158.0, 81.0, 22.0 ],
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
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "g", 0 ],
                    "source": [ "a", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "sv", 0 ],
                    "source": [ "big", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rng", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "big", 0 ],
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d3", 0 ]
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
                    "order": 1,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 0,
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3", 0 ],
                    "source": [ "lb", 0 ]
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
                    "destination": [ "sr", 0 ],
                    "source": [ "rng", 0 ]
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