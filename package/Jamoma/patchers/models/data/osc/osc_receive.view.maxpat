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
        "rect": [ 387.0, 448.0, 431.0, 248.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 4.75, 46.0, 32.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.75, 45.0, 34.0, 20.0 ],
                    "text": "print"
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 331.0, 25.0, 41.0, 22.0 ],
                    "text": "j.view"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 24.0, 154.0, 97.0, 22.0 ],
                    "text": "j.remote print"
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 294.0, 154.0, 78.0, 22.0 ],
                    "text": "j.remote port"
                }
            },
            {
                "box": {
                    "automation": "PRINT-OFF",
                    "automationon": "PRINT-ON",
                    "id": "obj-47",
                    "maxclass": "live.text",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 24.0, 124.0, 91.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 48.5, 45.0, 61.0, 22.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "PRINT-OFF", "PRINT-ON" ],
                            "parameter_longname": "monitor",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "monitor",
                            "parameter_type": 2
                        }
                    },
                    "text": "OFF",
                    "texton": "ON",
                    "varname": "printreceiv[1]"
                }
            },
            {
                "box": {
                    "fontsize": 14.0,
                    "id": "obj-54",
                    "maxclass": "live.numbox",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 294.0, 124.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 48.5, 22.0, 61.0, 20.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "live.numbox",
                            "parameter_mmax": 65536.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "live.numbox",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "port[1]"
                }
            },
            {
                "box": {
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 310.5, 97.0, 31.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 13.75, 22.0, 31.0, 20.0 ],
                    "text": "port"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "j.ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 0.0, 1.0, 300.0, 70.0 ],
                    "presentation": 1,
                    "presentation_rect": [ -0.25, 0.0, 150.0, 70.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-47", 0 ],
                    "midpoints": [ 33.5, 172.0, 11.0, 172.0, 11.0, 121.0, 33.5, 121.0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "midpoints": [ 303.5, 187.0, 281.0, 187.0, 281.0, 113.0, 303.5, 113.0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "midpoints": [ 33.5, 145.0, 33.5, 145.0 ],
                    "source": [ "obj-47", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 303.5, 148.0, 303.5, 148.0 ],
                    "source": [ "obj-54", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-47": [ "monitor", "monitor", 0 ],
            "obj-54": [ "live.numbox", "live.numbox", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}