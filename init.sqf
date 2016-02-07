#include "Zen_FrameworkFunctions\Zen_InitHeader.sqf"

player createDiaryRecord ["Diary", ["Execution", "A inserção do grupo AEGIS já foi iniciada por meio de contatos locais. <br/>O grupo sairá da residência do empresário que contataria João Silva, em seguida deverá iniciar incurssão pelo centro da cidade até a mesquita. <br/><br/>De lá, deverão avançar até o aeroporto, onde um avião aguarda o VIP para extração."]];
player createDiaryRecord ["Diary", ["Missão", "O presidente d Anabel Engenharia contratou o <marker name='aegis'>AEGIS</marker> para fazer a <marker name='extracao'>extração</marker> de <marker name='vip'>João Silva</marker> até o aeroporto de Zargabad, aonde um <marker name='extracao'>CH-471 CHINOOK</marker> está esperando."]];
player createDiaryRecord ["Diary", ["Situação", " <marker name='vip'>João Silva</marker>, gerente de compras da Anabel Engenharia foi surpreendido por insurgentes do estado islâmico enquanto negociava máquinas pesadas para um empresário local.<br/><br/> João tem treinamento em segurança, mas não possui equipamentos nem suporte para sair da cidade."]];


titleText ["Boa Sorte!", "BLACK FADED", 0.2];

enableSaving [false, false];

if (!isServer) exitWith {};
sleep 1;


VIP = vip_01;


0 = [] Spawn{
	waituntil { sleep 2; !(alive vip_01) };
	["vip_kill",false,2] remoteExecCall ["BIS_fnc_endMission"];
};


waituntil {
	sleep 2;
	((VIP distance plane) < 10)
};

"end1" remoteExecCall ["BIS_fnc_endMission"];
