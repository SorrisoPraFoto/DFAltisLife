/*
    Author: RobérioJR
	//https://community.bistudio.com/wiki/Arma_3_Animals:_Override_Default_Animal_Behaviour_Via_Script
*/

dog = createAgent ["Fin_random_F", getPos player, [], 5, "CAN_COLLIDE"];
dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
RJ_DogOcupado = false;
RJ_DogAtacando = false;
JogadorTemUmCachorro = true;
RJ_FomeDog = 100;

  /* Movimentação Do Dog */
[] spawn {
	while {alive dog} do {	
	    WaitUntil {!RJ_DogOcupado};
		WaitUntil {!RJ_DogAtacando};
		WaitUntil {dog distance player > 3.1};
		dog moveTo getPos player;
		sleep 1.2;
	};
 };
 
 /* Quando O Dog Morrer */
 [] spawn {
    WaitUntil {!Alive dog};
	RJ_DogOcupado = false;
	RJ_DogAtacando = false;
	JogadorTemUmCachorro = false;
	RJ_FomeDog = 100;
	[dog,"dogYelp",75,1] remoteExecCall ["life_fnc_say3D",0];
	SystemChat Format['%1, Seu Cachorro Morreu!',Name Player]; 
 };
 
  /* IA De Correr E Andar */
[] spawn {
    while {alive dog} do {
	    WaitUntil {!RJ_DogOcupado};
		WaitUntil {!RJ_DogAtacando};
		if (dog Distance player > 400) then { 
		    dog setPos [((getPos player) select 0) + 7, ((getPos player) select 1) + 7, 0];  
		};
		if (dog distance player < 3) then {
		    dog playMove "Dog_Sit";
			SystemChat 'Cao Muito Perto, Sentado';
		};
        if (dog distance player < 10) then {
		    WaitUntil {dog distance player > 3.1};
		    dog playMove "Dog_Walk";
			SystemChat 'Cao Perto, Andando';
		} else { 
		    dog playMove "Dog_Sprint"; 
		    SystemChat 'Cao Longe, Correndo'; 
		};
	    sleep 3;
	};	
 };
 
  /* Emitir Sons */
[] spawn {
    Private ['_K','_S'];
    while {alive dog} do {
		sleep 2.5;
        _K = [1,2,3,4,5,6] call bis_fnc_selectRandom;
        if (_K IsEqualTo 2) then { 
			_S = ['pantdois','pantum','dogLat'] call bis_fnc_selectRandom;
			[dog,_S,60,1] remoteExecCall ["life_fnc_say3D",0]; 
	    };
	};
 };

 [] spawn {
    WaitUntil {!Alive Player};
	dog SetDamage 1;
	deleteVehicle dog;
 };
 
	/* Fome Do Dog */
 [] spawn {
    [] execVM 'RJM\Scripts\Dog\DogAction.sqf';
    While {Alive Dog} do {
        Sleep 35;
	    RJ_FomeDog = RJ_FomeDog - 1;
		if (RJ_FomeDog < 36) then { SystemChat Format['%1, Seu Cão Está Ficando Com Fome!',Name Player]; };
	    if (RJ_FomeDog < 1) then { dog SetDamage 1; }
    };
 };