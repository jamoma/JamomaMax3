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
        "rect": [ 134.0, 168.0, 821.0, 530.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 30.0, 88.0, 22.0 ],
                    "text": "j.model fb"
                }
            },
            {
                "box": {
                    "id": "a",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 438.5, 222.0, 264.0, 22.0 ],
                    "text": "j.parameter a @type integer @repetitions/filter 1"
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
                    "id": "s",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 142.0, 94.0, 74.8, 22.0 ],
                    "text": "j.send a"
                }
            },
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 260.6, 30.0, 74.8, 22.0 ],
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
                    "patching_rect": [ 359.4, 30.0, 61.6, 22.0 ],
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
                    "patching_rect": [ 438.5, 94.0, 81.4, 22.0 ],
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
                    "patching_rect": [ 438.5, 158.0, 40.0, 22.0 ],
                    "text": "7"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 543.5, 94.0, 81.4, 22.0 ],
                    "text": "delay 900"
                }
            },
            {
                "box": {
                    "id": "ask",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 543.5, 158.0, 55.0, 22.0 ],
                    "text": "value"
                }
            },
            {
                "box": {
                    "id": "rt",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 438.5, 286.0, 94.6, 22.0 ],
                    "text": "route value"
                }
            },
            {
                "box": {
                    "id": "q",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 438.5, 350.0, 48.4, 22.0 ],
                    "text": "== 7"
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
                    "patching_rect": [ 438.5, 478.0, 299.0, 22.0 ],
                    "text": "test.assert JamomaMax3/receive_feedback/terminates"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 260.6, 94.0, 88.0, 22.0 ],
                    "text": "delay 4000"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 260.6, 158.0, 114.4, 22.0 ],
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
                    "patching_rect": [ 438.5, 414.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "rt", 0 ],
                    "source": [ "a", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "a", 0 ],
                    "source": [ "ask", 0 ]
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
                    "destination": [ "ask", 0 ],
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
                    "destination": [ "s", 0 ],
                    "source": [ "r", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "q", 0 ],
                    "source": [ "rt", 0 ]
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
                    "destination": [ "as", 0 ],
                    "source": [ "tg_as", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}