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
        "rect": [ 134.0, 168.0, 1507.0, 658.0 ],
        "boxes": [
            {
                "box": {
                    "id": "lb",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 30.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "d0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 94.0, 61.0, 22.0 ],
                    "text": "delay 500"
                }
            },
            {
                "box": {
                    "id": "t",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "bang", "bang", "bang" ],
                    "patching_rect": [ 30.0, 174.0, 1041.0, 22.0 ],
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
                    "patching_rect": [ 1052.0, 222.0, 29.5, 22.0 ],
                    "text": "-6."
                }
            },
            {
                "box": {
                    "id": "u1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1052.0, 286.0, 271.0, 22.0 ],
                    "text": "j.unit @dataspace gain @input db @output linear"
                }
            },
            {
                "box": {
                    "id": "c1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1052.0, 350.0, 332.0, 22.0 ],
                    "text": "expr ($f1-0.501187)<0.000001 && ($f1-0.501187)>-0.000001"
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
                    "patching_rect": [ 1052.0, 606.0, 299.0, 22.0 ],
                    "text": "test.assert JamomaMax3/unit_basic/gain_db_to_linear"
                }
            },
            {
                "box": {
                    "id": "m2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 541.0, 222.0, 32.0, 22.0 ],
                    "text": "100."
                }
            },
            {
                "box": {
                    "id": "u2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 541.0, 286.0, 147.0, 22.0 ],
                    "text": "j.unit @input C @output F"
                }
            },
            {
                "box": {
                    "id": "c2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 541.0, 350.0, 280.0, 22.0 ],
                    "text": "expr ($f1-212.)<0.000001 && ($f1-212.)>-0.000001"
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
                    "patching_rect": [ 541.0, 606.0, 388.0, 22.0 ],
                    "text": "test.assert JamomaMax3/unit_basic/default_dataspace_is_temperature"
                }
            },
            {
                "box": {
                    "id": "m3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 222.0, 59.0, 22.0 ],
                    "text": "45. 10. 2."
                }
            },
            {
                "box": {
                    "id": "u3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 286.0, 285.0, 22.0 ],
                    "text": "j.unit @dataspace position @input aed @output xyz"
                }
            },
            {
                "box": {
                    "id": "u4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 30.0, 350.0, 285.0, 22.0 ],
                    "text": "j.unit @dataspace position @input xyz @output aed"
                }
            },
            {
                "box": {
                    "id": "p",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "float", "float", "float" ],
                    "patching_rect": [ 30.0, 414.0, 87.0, 22.0 ],
                    "text": "unpack 0. 0. 0."
                }
            },
            {
                "box": {
                    "id": "c3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 478.0, 481.0, 22.0 ],
                    "text": "expr ($f1-45.)<0.00001 && ($f1-45.)>-0.00001 && ($f2-2.)<0.00001 && ($f2-2.)>-0.00001"
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
                    "patching_rect": [ 30.0, 606.0, 305.0, 22.0 ],
                    "text": "test.assert JamomaMax3/unit_basic/position_round_trip"
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 135.4, 94.0, 67.0, 22.0 ],
                    "text": "delay 1500"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "term",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.4, 132.0, 81.0, 22.0 ],
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
                    "patching_rect": [ 1052.0, 542.0, 24.0, 24.0 ]
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
                    "patching_rect": [ 541.0, 542.0, 24.0, 24.0 ]
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
                    "patching_rect": [ 30.0, 542.0, 24.0, 24.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "tg_a1", 0 ],
                    "source": [ "c1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a2", 0 ],
                    "source": [ "c2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_a3", 0 ],
                    "source": [ "c3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "t", 0 ],
                    "source": [ "d0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "term", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d0", 0 ],
                    "order": 1,
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "order": 0,
                    "source": [ "lb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u1", 0 ],
                    "source": [ "m1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u2", 0 ],
                    "source": [ "m2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u3", 0 ],
                    "source": [ "m3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "c3", 1 ],
                    "source": [ "p", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "c3", 0 ],
                    "source": [ "p", 0 ]
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
            },
            {
                "patchline": {
                    "destination": [ "c1", 0 ],
                    "source": [ "u1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "c2", 0 ],
                    "source": [ "u2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "u4", 0 ],
                    "source": [ "u3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "p", 0 ],
                    "source": [ "u4", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}