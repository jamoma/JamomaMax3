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
        "rect": [ 100.0, 100.0, 1077.0, 681.0 ],
        "gridsize": [ 5.0, 5.0 ],
        "toolbars_unpinned_last_save": 15,
        "showrootpatcherontab": 0,
        "showontab": 0,
        "boxes": [
            {
                "box": {
                    "annotation": "none",
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1077.0, 655.0 ],
                        "gridsize": [ 10.0, 10.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-9",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 549.5, 134.0, 385.0, 20.0 ],
                                    "text": "Open the Clue Window from the Window menu to see the annotations."
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-7",
                                    "linecount": 9,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 788.0, 427.5, 214.0, 131.0 ],
                                    "text": "If other objects need to be inserted between j.remote and the GUI widget, the third outlet of j.remote can be connected to the widget.\n\nIt will ensure that the parameter description is automatically added to the @annotation of the GUI object"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-6",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 685.0, 260.5, 192.0, 51.0 ],
                                    "text": "The parameter description is automatically added to the @annotation of the GUI object"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-31",
                                    "linecount": 3,
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 558.0, 468.5, 68.0, 49.0 ],
                                    "text": "substitute set setsymbol"
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-30",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 40.0, 218.0, 82.0, 22.0 ],
                                    "text": "none"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "This parameter description will be used as annotation for GUI widgets in the views.",
                                    "id": "obj-3",
                                    "maxclass": "live.tab",
                                    "multiline": 0,
                                    "num_lines_patching": 1,
                                    "num_lines_presentation": 0,
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 558.0, 537.5, 216.0, 20.0 ],
                                    "pictures": [ "lowcut.svg", "lowshelf.svg", "bell.svg", "notch.svg", "highshelf.svg", "highcut.svg" ],
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_enum": [ "lowcut", "lowself", "bell", "notch", "highshelf", "highcut" ],
                                            "parameter_initial": [ 0.0 ],
                                            "parameter_longname": "live.tab[14]",
                                            "parameter_mmax": 5,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "live.tab[1]",
                                            "parameter_speedlim": 0.0,
                                            "parameter_type": 2,
                                            "parameter_unitstyle": 9
                                        }
                                    },
                                    "spacing_x": 6.26,
                                    "usepicture": 1,
                                    "varname": "live.tab[3]"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "This parameter description will be used as annotation for GUI widgets in the views.",
                                    "id": "obj-20",
                                    "items": [ "lowcut", ",", "lowself", ",", "bell", ",", "notch", ",", "highshelf", ",", "highcut" ],
                                    "maxclass": "umenu",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "", "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 558.0, 275.0, 100.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 558.0, 440.5, 155.0, 22.0 ],
                                    "text": "j.remote filter_type"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 558.0, 242.0, 109.0, 22.0 ],
                                    "text": "j.remote filter_type"
                                }
                            },
                            {
                                "box": {
                                    "border": 0,
                                    "filename": "helpname.js",
                                    "id": "obj-2",
                                    "ignoreclick": 1,
                                    "jsarguments": [ "j.remote" ],
                                    "maxclass": "jsui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 10.0, 10.0, 178.49600219726562, 57.599853515625 ]
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-4",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 103.0, 525.0, 215.0, 51.0 ],
                                    "text": "Makes this subpatch a model, so that j.remote objects can subscribe to j.parameter objects."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 38.0, 539.5, 49.0, 22.0 ],
                                    "text": "j.model"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-22",
                                    "linecount": 4,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 40.0, 134.0, 218.0, 62.0 ],
                                    "style": "default",
                                    "text": "j.parameter filter_type @type string @description \"This parameter description will be used as annotation for GUI widgets in the views.\"",
                                    "varname": "my_float[1]"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-16",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 272.5, 146.5, 107.0, 37.0 ],
                                    "style": "default",
                                    "text": "A documented parameter"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 658.1666666666666, 528.5, 567.5, 528.5 ],
                                    "source": [ "obj-18", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-31", 0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "midpoints": [ 608.0, 307.0, 544.5, 307.0, 544.5, 231.0, 567.5, 231.0 ],
                                    "source": [ "obj-20", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 1 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "midpoints": [ 666.0, 567.5, 544.75, 567.5, 544.75, 429.5, 567.5, 429.5 ],
                                    "source": [ "obj-3", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-31", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 316.0, 400.0, 83.0, 22.0 ],
                    "style": "default",
                    "text": "p Annotations"
                }
            },
            {
                "box": {
                    "annotation": "none",
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1077.0, 655.0 ],
                        "gridsize": [ 10.0, 10.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-28",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 743.0, 537.5, 178.0, 37.0 ],
                                    "style": "default",
                                    "text": "Accessed using an alternative unit (MIDI cents)."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-27",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 612.0, 538.5, 111.0, 35.0 ],
                                    "style": "default",
                                    "text": "j.remote frequency @unit cents"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "none",
                                    "id": "obj-26",
                                    "maxclass": "live.numbox",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 612.0, 503.0, 83.0, 15.0 ],
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_longname": "live.numbox[2]",
                                            "parameter_mmax": 12700.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "live.numbox[2]",
                                            "parameter_steps": 12700,
                                            "parameter_type": 0,
                                            "parameter_units": "%ld Cents",
                                            "parameter_unitstyle": 9
                                        }
                                    },
                                    "varname": "live.numbox[1]"
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-15",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 75.0, 210.0, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-8",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 743.0, 164.5, 134.0, 37.0 ],
                                    "text": "Accessed using the default unit (Hz)."
                                }
                            },
                            {
                                "box": {
                                    "border": 0,
                                    "filename": "helpname.js",
                                    "id": "obj-2",
                                    "ignoreclick": 1,
                                    "jsarguments": [ "j.remote" ],
                                    "maxclass": "jsui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 10.0, 10.0, 178.49600219726562, 57.599853515625 ]
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-4",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 140.0, 530.5, 215.0, 51.0 ],
                                    "text": "Makes this subpatch a model, so that j.remote objects can subscribe to j.parameter objects."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 75.0, 545.0, 49.0, 22.0 ],
                                    "text": "j.model"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-34",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 743.0, 367.5, 165.0, 37.0 ],
                                    "style": "default",
                                    "text": "Accessed using an alternative unit (midinote)."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-32",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 612.0, 172.0, 110.0, 22.0 ],
                                    "style": "default",
                                    "text": "j.remote frequency"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "none",
                                    "id": "obj-31",
                                    "maxclass": "live.numbox",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "float" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 612.0, 139.0, 86.0, 15.0 ],
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_longname": "live.numbox",
                                            "parameter_mmax": 1000.0,
                                            "parameter_mmin": 65.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "live.numbox",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 3
                                        }
                                    },
                                    "varname": "live.numbox"
                                }
                            },
                            {
                                "box": {
                                    "channels": 1,
                                    "id": "obj-14",
                                    "lastchannelcount": 0,
                                    "maxclass": "live.gain~",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "signal", "", "float", "list" ],
                                    "parameter_enable": 1,
                                    "patching_rect": [ 75.0, 277.0, 27.0, 76.0 ],
                                    "saved_attribute_attributes": {
                                        "valueof": {
                                            "parameter_initial": [ -15 ],
                                            "parameter_initial_enable": 1,
                                            "parameter_longname": "live.gain~",
                                            "parameter_mmax": 6.0,
                                            "parameter_mmin": -70.0,
                                            "parameter_modmode": 0,
                                            "parameter_shortname": "gain",
                                            "parameter_type": 0,
                                            "parameter_unitstyle": 4
                                        }
                                    },
                                    "varname": "live.gain~"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "none",
                                    "id": "obj-6",
                                    "maxclass": "kslider",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "int", "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 612.0, 287.0, 336.0, 53.0 ],
                                    "style": "default"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 612.0, 368.5, 111.0, 35.0 ],
                                    "style": "default",
                                    "text": "j.remote frequency @unit midinote"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 75.0, 242.5, 46.0, 22.0 ],
                                    "style": "default",
                                    "text": "cycle~"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-22",
                                    "linecount": 4,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 75.0, 139.0, 129.0, 62.0 ],
                                    "style": "default",
                                    "text": "j.parameter frequency @type decimal @dataspace time @unit hz",
                                    "varname": "my_float[1]"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-21",
                                    "local": 1,
                                    "maxclass": "ezdac~",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "patching_rect": [ 75.0, 367.5, 45.0, 45.0 ],
                                    "style": "default"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-16",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 214.5, 151.5, 138.5, 37.0 ],
                                    "style": "default",
                                    "text": "The parameter uses the time dataspace. "
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 1 ],
                                    "order": 0,
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "order": 1,
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "midpoints": [ 621.5, 583.5, 599.5, 583.5, 599.5, 492.0, 621.5, 492.0 ],
                                    "source": [ "obj-27", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 621.5, 413.5, 600.5, 413.5, 600.5, 276.0, 621.5, 276.0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "source": [ "obj-31", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-31", 0 ],
                                    "midpoints": [ 621.5, 204.0, 601.5, 204.0, 601.5, 128.0, 621.5, 128.0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 289.0, 361.0, 78.0, 22.0 ],
                    "style": "default",
                    "text": "p Dataspace"
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1077.0, 655.0 ],
                        "gridsize": [ 10.0, 10.0 ],
                        "showontab": 1,
                        "boxes": [],
                        "lines": []
                    },
                    "patching_rect": [ 387.5, 458.0, 27.0, 22.0 ],
                    "style": "default",
                    "text": "p ?"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 0.0, 26.0, 1077.0, 655.0 ],
                        "gridsize": [ 10.0, 10.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "border": 0,
                                    "filename": "helpname.js",
                                    "id": "obj-6",
                                    "ignoreclick": 1,
                                    "jsarguments": [ "j.remote" ],
                                    "maxclass": "jsui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 10.0, 10.0, 178.49600219726562, 57.599853515625 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-18",
                                    "linecount": 6,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 108.0, 487.0, 105.0, 87.0 ],
                                    "text": "bird\n\ndemo_model\n\n\n/demo_model/bird",
                                    "textjustification": 2
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-13",
                                    "linecount": 8,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 219.0, 487.0, 578.0, 127.0 ],
                                    "text": "j.model sets up a local namespace within the model, so that \"bird\" is sufficient to name the parameter.\n\nWhen the view subscribes to a model, it attach itself to this local namespace. This way it is sufficient to access the parameter as bird within the view.\n\nThe address of the model instance (here demo_model) helps establishing a global name for the parameter: /demo_model/bird. This way the parameter can also be accesed outside of models and views.\n\n"
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-10",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 80.0, 405.0, 76.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "hidden": 1,
                                    "id": "obj-5",
                                    "linecount": 5,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 526.0, 23.0, 425.0, 74.0 ],
                                    "text": "Note to Jamoma-developers:\n\nThe bpacthers are embedded in the help patch itself. In order to edit the content of the bpatchers, select the bpacther object, and from the contextual menu choose \"Object > New View of Embedded Patcher\"."
                                }
                            },
                            {
                                "box": {
                                    "fontsize": 14.0,
                                    "id": "obj-2",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 108.0, 452.0, 215.0, 22.0 ],
                                    "text": "Relative and absolute addresses"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "none",
                                    "args": [ "demo_model" ],
                                    "bgmode": 0,
                                    "border": 1,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-9",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [ 0.0, 0.0 ],
                                    "outlettype": [ "" ],
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
                                        "rect": [ 524.0, 136.0, 429.0, 283.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 319.0, 51.0, 80.0, 20.0 ],
                                                    "text": "demo_model"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-7",
                                                    "linecount": 2,
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 30.0, 51.0, 392.0, 33.0 ],
                                                    "text": "This is a view, embedded in a bpatcher. It binds to the demo_model model, as specified by the argument to the bpatcher."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontsize": 16.0,
                                                    "id": "obj-8",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 30.0, 19.0, 191.0, 24.0 ],
                                                    "text": "A view"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "annotation": "none",
                                                    "format": 6,
                                                    "id": "obj-6",
                                                    "maxclass": "flonum",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 167.0, 134.0, 50.0, 22.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 4,
                                                    "outlettype": [ "", "", "", "" ],
                                                    "patching_rect": [ 167.0, 168.0, 77.0, 22.0 ],
                                                    "text": "j.remote bird"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-3",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 58.0, 204.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-2",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 58.0, 101.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-1",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 58.0, 157.0, 41.0, 22.0 ],
                                                    "text": "j.view"
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-3", 0 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-1", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-6", 0 ],
                                                    "midpoints": [ 176.5, 200.0, 153.5, 200.0, 153.5, 123.0, 176.5, 123.0 ],
                                                    "source": [ "obj-4", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-4", 0 ],
                                                    "source": [ "obj-6", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 524.0, 109.5, 429.0, 283.0 ],
                                    "viewvisibility": 1
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-8",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 867.0, 500.0, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-4",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 867.0, 533.0, 112.0, 35.0 ],
                                    "text": "j.remote /demo_model/bird"
                                }
                            },
                            {
                                "box": {
                                    "annotation": "none",
                                    "args": [ "demo_model" ],
                                    "bgmode": 0,
                                    "border": 1,
                                    "clickthrough": 0,
                                    "embed": 1,
                                    "enablehscroll": 0,
                                    "enablevscroll": 0,
                                    "id": "obj-7",
                                    "lockeddragscroll": 0,
                                    "lockedsize": 0,
                                    "maxclass": "bpatcher",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "offset": [ 0.0, 0.0 ],
                                    "outlettype": [ "" ],
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
                                        "rect": [ 80.0, 136.0, 429.0, 283.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-4",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 42.0, 64.0, 80.0, 20.0 ],
                                                    "text": "demo_model"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-6",
                                                    "linecount": 2,
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 30.0, 51.0, 345.0, 33.0 ],
                                                    "text": "The model instance, provided as an argument to this bpatcher, is demo_model."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "fontsize": 16.0,
                                                    "id": "obj-3",
                                                    "maxclass": "comment",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 30.0, 19.0, 191.0, 24.0 ],
                                                    "text": "A model."
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-12",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 80.0, 208.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-11",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 80.0, 102.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-10",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 80.0, 151.0, 49.0, 22.0 ],
                                                    "text": "j.model"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "format": 6,
                                                    "id": "obj-9",
                                                    "maxclass": "flonum",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 230.0, 181.0, 50.0, 22.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "format": 6,
                                                    "id": "obj-7",
                                                    "maxclass": "flonum",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "bang" ],
                                                    "parameter_enable": 0,
                                                    "patching_rect": [ 230.0, 110.0, 50.0, 22.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-5",
                                                    "linecount": 2,
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 230.0, 138.0, 101.0, 35.0 ],
                                                    "text": "j.parameter bird @type decimal"
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "source": [ "obj-10", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 0 ],
                                                    "source": [ "obj-11", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-9", 0 ],
                                                    "source": [ "obj-5", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-5", 0 ],
                                                    "source": [ "obj-7", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 80.0, 109.5, 429.0, 283.0 ],
                                    "viewvisibility": 1
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "midpoints": [ 876.5, 578.0, 855.5, 578.0, 855.5, 489.0, 876.5, 489.0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 1 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-8", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 214.5, 314.0, 144.0, 22.0 ],
                    "style": "default",
                    "text": "p \"Views and Addresses\""
                }
            },
            {
                "box": {
                    "border": 0,
                    "filename": "helpdetails.js",
                    "id": "obj-3",
                    "ignoreclick": 1,
                    "jsarguments": [ "j.remote" ],
                    "maxclass": "jsui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 0.0, 0.0, 411.0, 143.0 ]
                }
            },
            {
                "box": {
                    "annotation": "none",
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                        "rect": [ 100.0, 126.0, 1077.0, 655.0 ],
                        "gridsize": [ 10.0, 10.0 ],
                        "showontab": 1,
                        "boxes": [
                            {
                                "box": {
                                    "fontsize": 14.0,
                                    "id": "obj-4",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 703.0, 191.0, 30.0, 22.0 ],
                                    "text": "set"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-37",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 824.0, 639.5, 213.0, 51.0 ],
                                    "text": "Turns this patch into a model, and ensures communication between j.parameter and j.remote."
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-35",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 793.666687, 454.0, 70.0, 22.0 ],
                                    "text": "0."
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-34",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 771.0, 425.0, 70.0, 22.0 ],
                                    "text": "set 0."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-28",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 822.0, 360.0, 43.0, 22.0 ],
                                    "text": "set $1"
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-22",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 822.0, 333.0, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 822.0, 391.0, 87.0, 22.0 ],
                                    "text": "j.remote apple"
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-33",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 477.5, 221.0, 37.0 ],
                                    "text": "2nd outlet outputs new parameter value whenever it changes."
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-32",
                                    "linecount": 2,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 430.5, 221.0, 37.0 ],
                                    "text": "1st outlet updates GUI object while preventing a feedback loop."
                                }
                            },
                            {
                                "box": {
                                    "bubble": 1,
                                    "id": "obj-31",
                                    "linecount": 3,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 309.5, 221.0, 51.0 ],
                                    "text": "Binds remotely to the parameter.\nKeeps the value of j.parameter, and the GUI object syncronized."
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-26",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 218.0, 438.5, 70.0, 22.0 ],
                                    "text": "set 0."
                                }
                            },
                            {
                                "box": {
                                    "dontreplace": 1,
                                    "id": "obj-25",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 240.0, 484.5, 69.999992, 22.0 ],
                                    "text": "0."
                                }
                            },
                            {
                                "box": {
                                    "annotation": "Apples are green.",
                                    "format": 6,
                                    "id": "obj-23",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 269.0, 323.5, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [ "", "", "", "" ],
                                    "patching_rect": [ 269.0, 357.5, 87.0, 22.0 ],
                                    "text": "j.remote apple"
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-20",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 45.0, 425.5, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "format": 6,
                                    "id": "obj-18",
                                    "maxclass": "flonum",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "bang" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 45.0, 323.5, 50.0, 22.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-16",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 45.0, 353.5, 190.0, 35.0 ],
                                    "text": "j.parameter apple @type decimal @description \"Apples are green.\""
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 757.0, 654.0, 49.0, 22.0 ],
                                    "text": "j.model"
                                }
                            },
                            {
                                "box": {
                                    "bubbletextmargin": 10,
                                    "id": "obj-15",
                                    "linecount": 5,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 703.0, 220.0, 288.0, 74.0 ],
                                    "text": "The 'set' message updates the parameter value without producing output from this j.remote object.\n\nOther j.remote objects associated with the same parameter will however be updated."
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-5",
                                    "linecount": 4,
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 16.0, 191.0, 483.0, 60.0 ],
                                    "text": "j.remote binds to a parameter value. It is useful when designing user interfaces, as the model (the media processing algorithm) and the view (the interface) can be separated.\n\nSeveral instances of j.remote can bind to the same parameter."
                                }
                            },
                            {
                                "box": {
                                    "border": 0,
                                    "filename": "helpdetails.js",
                                    "id": "obj-3",
                                    "ignoreclick": 1,
                                    "jsarguments": [ "j.remote" ],
                                    "maxclass": "jsui",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 16.0, 13.0, 772.0, 141.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-34", 1 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-35", 1 ],
                                    "source": [ "obj-17", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "midpoints": [ 278.5, 390.0, 254.500015, 390.0, 254.500015, 313.0, 278.5, 313.0 ],
                                    "order": 1,
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 1 ],
                                    "source": [ "obj-21", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 1 ],
                                    "order": 0,
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "source": [ "obj-28", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 175.5, 269.0, 50.0, 22.0 ],
                    "style": "default",
                    "text": "p Basic"
                }
            }
        ],
        "lines": [],
        "parameters": {
            "obj-31::obj-14": [ "live.gain~", "gain", 0 ],
            "obj-31::obj-26": [ "live.numbox[2]", "live.numbox[2]", 0 ],
            "obj-31::obj-31": [ "live.numbox", "live.numbox", 0 ],
            "obj-5::obj-3": [ "live.tab[14]", "live.tab[1]", 0 ],
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