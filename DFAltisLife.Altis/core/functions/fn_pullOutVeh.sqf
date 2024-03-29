/*
    File: fn_pullOutVeh.sqf
    Author: Bryan "Tonic" Boardwine

    Description:

*/
if((speed vehicle player) >= 10) exitWith {};
if(vehicle player == player) exitWith {};
if (player getVariable "restrained" || player getVariable "ziptied") then {
    detach player;
    player setVariable ["Escorting",false,true];
    player setVariable ["transporting",false,true];
    life_disable_getOut = false;
    player action ["Eject", vehicle player];
    titleText[localize "STR_NOTF_PulledOut","PLAIN"];
    titleFadeOut 4;
    life_disable_getIn = true;
} else {
    player action ["Eject", vehicle player];
    titleText[localize "STR_NOTF_PulledOut","PLAIN"];
    titleFadeOut 4;
};
