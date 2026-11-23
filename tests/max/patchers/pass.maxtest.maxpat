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
        "rect": [ 134.0, 168.0, 1230.0, 530.0 ],
        "boxes": [
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 30.0, 74.8, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "t",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "bang", "bang" ],
                    "patching_rect": [ 30.0, 94.0, 68.2, 22.0 ],
                    "text": "t b b b"
                }
            },
            {
                "box": {
                    "id": "m1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 273.6, 158.0, 48.4, 22.0 ],
                    "text": "/a 5"
                }
            },
            {
                "box": {
                    "id": "m2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 201.2, 158.0, 48.4, 22.0 ],
                    "text": "zz 7"
                }
            },
            {
                "box": {
                    "id": "m3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 158.0, 41.8, 22.0 ],
                    "text": "b 3"
                }
            },
            {
                "box": {
                    "id": "p",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 234.2, 222.0, 88.0, 22.0 ],
                    "text": "j.pass a b"
                }
            },
            {
                "box": {
                    "id": "r1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 234.2, 286.0, 68.2, 22.0 ],
                    "text": "route a"
                }
            },
            {
                "box": {
                    "id": "r2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 940.0, 286.0, 74.8, 22.0 ],
                    "text": "route zz"
                }
            },
            {
                "box": {
                    "id": "r3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 623.4, 286.0, 68.2, 22.0 ],
                    "text": "route b"
                }
            },
            {
                "box": {
                    "id": "e1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 234.2, 350.0, 48.4, 22.0 ],
                    "text": "== 5"
                }
            },
            {
                "box": {
                    "id": "e2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 940.0, 350.0, 48.4, 22.0 ],
                    "text": "== 7"
                }
            },
            {
                "box": {
                    "id": "e3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 623.4, 350.0, 48.4, 22.0 ],
                    "text": "== 3"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 234.2, 478.0, 317.0, 22.0 ],
                    "text": "test.assert JamomaMax3/pass/strips_slash_and_matches"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 940.0, 478.0, 219.0, 22.0 ],
                    "text": "test.assert JamomaMax3/pass/overflow"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "a3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 623.4, 478.0, 249.0, 22.0 ],
                    "text": "test.assert JamomaMax3/pass/second_outlet"
                }
            },
            {
                "box": {
                    "id": "dl",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 95.8, 158.0, 81.4, 22.0 ],
                    "text": "delay 300"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 95.8, 222.0, 114.4, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "tg_a1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 234.2, 414.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_a2",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 940.0, 414.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_a3",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 623.4, 414.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "dl", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a1", 0 ],
                    "source": [ "e1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a2", 0 ],
                    "source": [ "e2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a3", 0 ],
                    "source": [ "e3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "t", 0 ],
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "p", 0 ],
                    "source": [ "m1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "p", 0 ],
                    "source": [ "m2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "p", 0 ],
                    "source": [ "m3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "r1", 0 ],
                    "source": [ "p", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "r2", 0 ],
                    "source": [ "p", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "r3", 0 ],
                    "source": [ "p", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e1", 0 ],
                    "source": [ "r1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e2", 0 ],
                    "source": [ "r2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e3", 0 ],
                    "source": [ "r3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dl", 0 ],
                    "order": 0,
                    "source": [ "t", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m1", 0 ],
                    "source": [ "t", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m2", 0 ],
                    "source": [ "t", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m3", 0 ],
                    "order": 1,
                    "source": [ "t", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a1", 0 ],
                    "source": [ "tg_a1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a2", 0 ],
                    "source": [ "tg_a2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a3", 0 ],
                    "source": [ "tg_a3", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}