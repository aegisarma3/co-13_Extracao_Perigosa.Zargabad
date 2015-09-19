// This file is part of Zenophon's ArmA 3 Co-op Mission Framework
// This file is released under Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)
// See Legal.txt

#include "Zen_FrameworkLibrary.sqf"
#include "Zen_StandardLibrary.sqf"

_Zen_stack_Trace = ["Zen_ExecuteEvent", _this] call Zen_StackAdd;
private ["_controlID", "_controlData", "_controlBlocks", "_index", "_function"];

if !([_this, [["STRING"]], [], 0] call Zen_CheckArguments) exitWith {
    call Zen_StackRemove;
};

_controlID = _this select 0;
_controlData = [_controlID] call Zen_GetControlData;
_controlBlocks = _controlData select 2;

_index = [_controlBlocks, "Function", 0] call Zen_ArrayGetNestedIndex;
if (count _index == 0) exitWith {};
_index = _index select 0;
_function = (_controlBlocks select _index) select 1;

_index = [_controlBlocks, "Data", 0] call Zen_ArrayGetNestedIndex;
_linkedArgs = [];
if (count _index > 0) then {
    _index = _index select 0;
    _linkedArgs pushBack ((_controlBlocks select _index) select 1);
};

_index = [_controlBlocks, "LinksTo", 0] call Zen_ArrayGetNestedIndex;
if (count _index > 0) then {
    disableSerialization;
    _Zen_Dialog_Object_Local = uiNamespace getVariable  "Zen_Dialog_Object_Local";

    _linkedControls = (_controlBlocks select (_index select 0)) select 1;
    _dialogControls = [(_Zen_Dialog_Object_Local select 0)] call Zen_GetDialogControls;
    {
        _controlData = [_x] call Zen_GetControlData;
        _type = _controlData select 1;
        if ((toUpper _type) in ["LIST"]) then {
                _indexLinkedControlLocal = [_Zen_Dialog_Object_Local select 1, _x, 0] call Zen_ArrayGetNestedIndex;
                if (count _indexLinkedControlLocal > 0) then {
                    _indexLinkedControlLocal = _indexLinkedControlLocal select 0;
                    _linkedControl = ((_Zen_Dialog_Object_Local select 1) select _indexLinkedControlLocal) select 1;
                    _listDataIndex = lbCurSel _linkedControl;

                    _indexLinkControlBlock = [(_controlData select 2), "ListData", 0] call Zen_ArrayGetNestedIndex;
                    if (count _indexLinkControlBlock > 0) then {
                        _indexLinkControlBlock = _indexLinkControlBlock select 0;
                        _linkedArgs pushBack ((((_controlData select 2) select _indexLinkControlBlock) select 1) select _listDataIndex);
                    };
                };
        } else {
            _indexLinkControlBlock = [(_controlData select 2), "Data", 0] call Zen_ArrayGetNestedIndex;
            if (count _indexLinkControlBlock > 0) then {
                _indexLinkControlBlock = _indexLinkControlBlock select 0;
                _linkedArgs pushBack (((_controlData select 2) select _indexLinkControlBlock) select 1);
            };
        };
    } forEach (_linkedControls arrayIntersect _dialogControls);
};

0 = _linkedArgs spawn (missionNamespace getVariable _function);

call Zen_StackRemove;
if (true) exitWith {};
