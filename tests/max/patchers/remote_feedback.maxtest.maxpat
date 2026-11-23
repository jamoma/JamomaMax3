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
        "rect": [ 134.0, 168.0, 936.0, 786.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 30.0, 88.0, 22.0 ],
                    "text": "j.model rf"
                }
            },
            {
                "box": {
                    "id": "px",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 142.0, 158.0, 411.4, 22.0 ],
                    "text": "j.parameter x @type decimal @default 0.5 @ramp/drive system"
                }
            },
            {
                "box": {
                    "id": "rm",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 577.4, 350.0, 88.0, 22.0 ],
                    "text": "j.remote x"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "ui",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 577.4, 286.0, 40.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "ji",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 142.0, 30.0, 61.6, 22.0 ],
                    "text": "j.init"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 788.2, 542.0, 114.4, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "fl",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 106.0, 478.0, 55.0, 22.0 ],
                    "text": "float"
                }
            },
            {
                "box": {
                    "id": "t",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 227.6, 30.0, 55.0, 22.0 ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "bg",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 306.6, 30.0, 48.4, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "s0",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 142.0, 94.0, 107.8, 22.0 ],
                    "text": "100. ramp 600"
                }
            },
            {
                "box": {
                    "id": "d0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 577.4, 158.0, 74.8, 22.0 ],
                    "text": "delay 80"
                }
            },
            {
                "box": {
                    "id": "s1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 577.4, 222.0, 40.0, 22.0 ],
                    "text": "7."
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 641.4, 286.0, 74.8, 22.0 ],
                    "text": "delay 80"
                }
            },
            {
                "box": {
                    "id": "s2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 689.4, 414.0, 48.4, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 689.4, 478.0, 74.8, 22.0 ],
                    "text": "delay 80"
                }
            },
            {
                "box": {
                    "id": "dwait",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 689.4, 350.0, 81.4, 22.0 ],
                    "text": "delay 900"
                }
            },
            {
                "box": {
                    "id": "dend",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 788.2, 478.0, 81.4, 22.0 ],
                    "text": "delay 200"
                }
            },
            {
                "box": {
                    "id": "f7s",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 106.0, 542.0, 61.6, 22.0 ],
                    "text": "sel 7."
                }
            },
            {
                "box": {
                    "id": "f7o",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 106.0, 606.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "f7a",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 106.0, 734.0, 439.0, 22.0 ],
                    "text": "test.assert JamomaMax3/remote_feedback/dragged_value_wins_over_the_ramp"
                }
            },
            {
                "box": {
                    "id": "tg_f7a",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 106.0, 670.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "s1", 0 ],
                    "source": [ "d0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dwait", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "dend", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s2", 0 ],
                    "source": [ "dwait", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_f7a", 0 ],
                    "source": [ "f7o", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "f7o", 0 ],
                    "source": [ "f7s", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "f7s", 0 ],
                    "source": [ "fl", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s0", 0 ],
                    "source": [ "ji", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fl", 1 ],
                    "source": [ "px", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "source": [ "rm", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d0", 0 ],
                    "order": 0,
                    "source": [ "s0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "px", 0 ],
                    "order": 1,
                    "source": [ "s0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "order": 0,
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ui", 0 ],
                    "order": 1,
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "order": 1,
                    "source": [ "s2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dend", 0 ],
                    "order": 0,
                    "source": [ "s2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "fl", 0 ],
                    "order": 2,
                    "source": [ "s2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "f7a", 0 ],
                    "source": [ "tg_f7a", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "rm", 0 ],
                    "source": [ "ui", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}