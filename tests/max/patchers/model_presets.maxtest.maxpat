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
        "rect": [ 34.0, 96.0, 1260.0, 987.0 ],
        "boxes": [
            {
                "box": {
                    "id": "m",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 513.0, 774.0, 67.0, 22.0 ],
                    "text": "j.model pm"
                }
            },
            {
                "box": {
                    "id": "pa",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 23.0, 290.0, 91.0, 49.0 ],
                    "text": "j.parameter a @type integer @default 1"
                }
            },
            {
                "box": {
                    "id": "pb",
                    "linecount": 3,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 320.0, 290.0, 91.0, 49.0 ],
                    "text": "j.parameter b @type integer @default 2"
                }
            },
            {
                "box": {
                    "id": "ji",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 23.0, 54.0, 30.0, 22.0 ],
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
                    "patching_rect": [ 1070.0, 942.0, 81.0, 22.0 ],
                    "text": "test.terminate"
                }
            },
            {
                "box": {
                    "id": "s0",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 23.0, 87.0, 91.0, 22.0 ],
                    "text": "preset:new one"
                }
            },
            {
                "box": {
                    "id": "d0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 23.0, 123.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s1",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 23.0, 162.0, 29.5, 22.0 ],
                    "text": "11"
                }
            },
            {
                "box": {
                    "id": "d1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 320.0, 206.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s2",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 320.0, 244.0, 29.5, 22.0 ],
                    "text": "22"
                }
            },
            {
                "box": {
                    "id": "d2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 558.0, 290.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s3",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 558.0, 320.0, 89.0, 22.0 ],
                    "text": "preset:new two"
                }
            },
            {
                "box": {
                    "id": "d3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 558.0, 352.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 558.0, 384.0, 65.0, 22.0 ],
                    "text": "preset one"
                }
            },
            {
                "box": {
                    "id": "d4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 558.0, 424.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s5",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 558.0, 454.0, 35.0, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "d5",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 558.0, 493.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s6",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 558.0, 529.0, 167.0, 22.0 ],
                    "text": "preset:interpolate one two 0.5"
                }
            },
            {
                "box": {
                    "id": "d6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 558.0, 561.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s7",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 558.0, 598.0, 35.0, 22.0 ],
                    "text": "bang"
                }
            },
            {
                "box": {
                    "id": "d7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1070.0, 666.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "s8",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1070.0, 704.0, 81.0, 22.0 ],
                    "text": "preset:names"
                }
            },
            {
                "box": {
                    "id": "d8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1070.0, 840.0, 54.0, 22.0 ],
                    "text": "delay 60"
                }
            },
            {
                "box": {
                    "id": "ia0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 192.0, 809.0, 29.5, 22.0 ],
                    "text": "int"
                }
            },
            {
                "box": {
                    "id": "ib0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 265.0, 809.0, 29.5, 22.0 ],
                    "text": "int"
                }
            },
            {
                "box": {
                    "id": "ex0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 192.0, 840.0, 92.0, 22.0 ],
                    "text": "expr $i1*10+$i2"
                }
            },
            {
                "box": {
                    "id": "eq0",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 192.0, 879.0, 39.0, 22.0 ],
                    "text": "== 12"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "x0",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 192.0, 942.0, 300.0, 35.0 ],
                    "text": "test.assert JamomaMax3/model_presets/recall_restores_values"
                }
            },
            {
                "box": {
                    "id": "ia1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 19.0, 704.0, 29.5, 22.0 ],
                    "text": "int"
                }
            },
            {
                "box": {
                    "id": "ib1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 848.0, 704.0, 29.5, 22.0 ],
                    "text": "int"
                }
            },
            {
                "box": {
                    "id": "t1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "bang" ],
                    "patching_rect": [ 558.0, 642.0, 32.0, 22.0 ],
                    "text": "t b b"
                }
            },
            {
                "box": {
                    "id": "ex1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 776.0, 774.0, 92.0, 22.0 ],
                    "text": "expr $i1*10+$i2"
                }
            },
            {
                "box": {
                    "id": "eq1",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 776.0, 809.0, 39.0, 22.0 ],
                    "text": "== 72"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "x1",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 776.0, 942.0, 276.0, 35.0 ],
                    "text": "test.assert JamomaMax3/model_presets/interpolate_halfway"
                }
            },
            {
                "box": {
                    "id": "rt",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 513.0, 809.0, 112.0, 22.0 ],
                    "text": "route preset:names"
                }
            },
            {
                "box": {
                    "id": "zn",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 513.0, 840.0, 37.0, 22.0 ],
                    "text": "zl len"
                }
            },
            {
                "box": {
                    "id": "e2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 513.0, 879.0, 33.0, 22.0 ],
                    "text": "== 2"
                }
            },
            {
                "box": {
                    "color": [ 0.7, 0.4, 0.3, 1.0 ],
                    "id": "asn",
                    "linecount": 2,
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 513.0, 942.0, 244.0, 35.0 ],
                    "text": "test.assert JamomaMax3/model_presets/names_listed"
                }
            },
            {
                "box": {
                    "id": "dend",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1070.0, 879.0, 61.0, 22.0 ],
                    "text": "delay 300"
                }
            },
            {
                "box": {
                    "id": "tg_x0",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 192.0, 909.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_x1",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 776.0, 909.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "tg_asn",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 513.0, 909.0, 24.0, 24.0 ]
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
                    "destination": [ "s2", 0 ],
                    "source": [ "d1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s3", 0 ],
                    "source": [ "d2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s4", 0 ],
                    "source": [ "d3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s5", 0 ],
                    "source": [ "d4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s6", 0 ],
                    "source": [ "d5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s7", 0 ],
                    "source": [ "d6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "s8", 0 ],
                    "source": [ "d7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "dend", 0 ],
                    "source": [ "d8", 0 ]
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
                    "destination": [ "tg_asn", 0 ],
                    "source": [ "e2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_x0", 0 ],
                    "source": [ "eq0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "tg_x1", 0 ],
                    "source": [ "eq1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "eq0", 0 ],
                    "source": [ "ex0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "eq1", 0 ],
                    "source": [ "ex1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ex0", 0 ],
                    "source": [ "ia0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ex1", 0 ],
                    "source": [ "ia1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ex0", 1 ],
                    "source": [ "ib0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ex1", 1 ],
                    "source": [ "ib1", 0 ]
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
                    "destination": [ "rt", 0 ],
                    "source": [ "m", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ia0", 1 ],
                    "order": 0,
                    "source": [ "pa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ia1", 1 ],
                    "order": 1,
                    "source": [ "pa", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ib0", 1 ],
                    "order": 1,
                    "source": [ "pb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ib1", 1 ],
                    "order": 0,
                    "source": [ "pb", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "zn", 0 ],
                    "source": [ "rt", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d0", 0 ],
                    "order": 1,
                    "source": [ "s0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "order": 0,
                    "source": [ "s0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d1", 0 ],
                    "midpoints": [ 32.5, 190.38671875, 329.5, 190.38671875 ],
                    "order": 0,
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "pa", 0 ],
                    "order": 1,
                    "source": [ "s1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d2", 0 ],
                    "midpoints": [ 329.5, 278.51171875, 567.5, 278.51171875 ],
                    "order": 0,
                    "source": [ "s2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "pb", 0 ],
                    "order": 1,
                    "source": [ "s2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d3", 0 ],
                    "order": 0,
                    "source": [ "s3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "midpoints": [ 567.5, 348.6644580696203, 522.5, 348.6644580696203 ],
                    "order": 1,
                    "source": [ "s3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d4", 0 ],
                    "order": 0,
                    "source": [ "s4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "midpoints": [ 567.5, 416.9273140822785, 522.5, 416.9273140822785 ],
                    "order": 1,
                    "source": [ "s4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d5", 0 ],
                    "order": 0,
                    "source": [ "s5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ia0", 0 ],
                    "order": 2,
                    "source": [ "s5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ib0", 0 ],
                    "order": 1,
                    "source": [ "s5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d6", 0 ],
                    "order": 0,
                    "source": [ "s6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "midpoints": [ 567.5, 557.2217167721519, 522.5, 557.2217167721519 ],
                    "order": 1,
                    "source": [ "s6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d7", 0 ],
                    "order": 0,
                    "source": [ "s7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "t1", 0 ],
                    "order": 1,
                    "source": [ "s7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "d8", 0 ],
                    "order": 0,
                    "source": [ "s8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "m", 0 ],
                    "order": 1,
                    "source": [ "s8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ia1", 0 ],
                    "source": [ "t1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "ib1", 0 ],
                    "source": [ "t1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "asn", 0 ],
                    "source": [ "tg_asn", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "x0", 0 ],
                    "source": [ "tg_x0", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "x1", 0 ],
                    "source": [ "tg_x1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "e2", 0 ],
                    "source": [ "zn", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}