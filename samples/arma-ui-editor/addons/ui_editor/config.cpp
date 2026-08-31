class CfgPatches {
    class DB_UIEditor {
        name = "DB UI Editor Sample";
        author = "DarkBall";
        requiredVersion = 2.22;
        requiredAddons[] = {"A3_UI_F"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions {
    class DB {
        class UIEditor {
            file = "\z\db\addons\ui_editor\functions";

            class openUIEditor {};
            class uiEditorAdd {};
            class uiEditorApply {};
            class uiEditorBuild {};
            class uiEditorCreateControl {};
            class uiEditorDrawGrid {};
            class uiEditorExport {};
            class uiEditorGroup {};
            class uiEditorOverlay {};
            class uiEditorParent {};
            class uiEditorPointerDown {};
            class uiEditorPointerMove {};
            class uiEditorPointerUp {};
            class uiEditorPosition {};
            class uiEditorRefresh {};
            class uiEditorSelect {};
        };
    };
};

class CfgUserActions {
    class DB_UIEditor_Open {
        displayName = "Open UI Editor";
        tooltip = "Open the DB UI control playground";
        onActivate = "[] call DB_fnc_openUIEditor";
    };
};

class CfgDefaultKeysPresets {
    class Arma2 {
        class Mappings {
            DB_UIEditor_Open[] = {0x41};
        };
    };
};

class UserActionGroups {
    class DB_Samples {
        name = "DB Samples";
        isAddon = 1;
        group[] = {"DB_UIEditor_Open"};
    };
};
