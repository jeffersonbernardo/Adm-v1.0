#include <a_samp>
#include <zcmd>
#include <DOF2>
#include <sscanf>

#if defined FILTERSCRIPT
#endif

#define Cor_Erro 0xFF0000AA
#define Dialog_Admincmd 666
enum pInfo
{
    Admins,
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new Trabalhando[MAX_PLAYERS];
public OnGameModeInit()
{
    CreateObject(18769, 277.67221, 1915.82837, 601.19281,  0.00000, 0.00000, 0.00000);
    CreateObject(18769, 277.64740, 1906.36548, 611.23279,  90.00000, 0.00000, 0.00000);
    CreateObject(18769, 277.59738, 1925.93042, 611.23279,  90.00000, 0.00000, 0.00000);
    CreateObject(18769, 287.66284, 1915.88208, 611.23279,  90.00000, 0.00000, -90.17996);
    CreateObject(18769, 268.52026, 1916.28540, 611.23279,  90.00000, 0.00000, -90.17996);
    CreateObject(18769, 277.67221, 1915.84839, 620.27283,  0.00000, 0.00000, 0.00000);
    CreateObject(2302, 285.38251, 1921.56213, 601.81171,  0.00000, 0.00000, 0.00000);
    CreateObject(2302, 285.40094, 1918.87830, 601.81171,  0.00000, 0.00000, 0.00000);
    CreateObject(2302, 282.24103, 1921.43140, 601.81171,  0.00000, 0.00000, 0.00000);
    CreateObject(2302, 282.20499, 1918.65491, 601.81171,  0.00000, 0.00000, 0.00000);
    CreateObject(14604, 282.50769, 1919.08386, 602.66278,  0.00000, 0.00000, 0.00000);
    CreateObject(14604, 286.02692, 1919.00623, 602.66278,  0.00000, 0.00000, 0.00000);
    return 1;
}

public OnGameModeExit()
{
    DOF2_Exit();
return 1;
}
public OnPlayerConnect(playerid)
{
    CaregaPlayer(playerid);
return 1;
}
stock CaregaPlayer(playerid){
    new File[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(File, sizeof(File), "Admins/%s.ini", sendername);
    if(DOF2_FileExists(File))
    {
        PlayerInfo[playerid][Admins] = DOF2_GetInt(File, "Admins");
    }
    else
    {
        DOF2_CreateFile(File);
        DOF2_SetInt(File, "Admins", 0);
        DOF2_SaveFile();
        OnPlayerConnect(playerid);
    }
    return 1;
}
public OnPlayerSpawn(playerid){
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    SalvaAdmin(playerid);
return 1;
}
public OnPlayerUpdate(playerid)
{
    SalvaAdmin(playerid);
return 1;
}
CMD:setadmin(playerid,params[]){
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Logado Na Rcon");
    new Id,Nivel,Str[222];
    if(sscanf(params, "dd",Id,Nivel)) return SendClientMessage(playerid, Cor_Erro, "[ERRO]Use: /setadmin[Id][Nivel]!");
    if(!IsPlayerConnected(Id)) return SendClientMessage(playerid, Cor_Erro, "[ERRO]Player Off");
    if( Nivel > 2 || Nivel < 0 ) return SendClientMessage(playerid, Cor_Erro, "[ERRO]:{E85A5A}Use Somente leveis de 1 a 2!." );
    PlayerInfo[Id][Admins] = Nivel;
    format(Str, sizeof(Str), "{0080FF}[Servidor]Temos Um Novo Admin Nome: %s{FFFFFF}(%d){0080FF} Nivel: %d",GetPlayerNameEx(Id),Id,Nivel);
    SendClientMessageToAll(-1,Str);
    return 1;
}
CMD:ajudaadmin(playerid){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    new Str[1000];
    strcat(Str, "{FFFF00}Comandos Admin Nivel 1\n");
    strcat(Str, "{FF8000}1»\t{FFFF00}/tv\n");
    strcat(Str, "{FF8000}2»\t{FFFF00}/limparchat\n");
    strcat(Str, "{FF8000}3»\t{FFFF00}/colete\n");
    strcat(Str, "{FF8000}4»\t{FFFF00}/vida\n");
    strcat(Str, "{FF8000}5»\t{FFFF00}/trabalhar\n");
    strcat(Str, "{FF8000}6»\t{FFFF00}/dararma\n");
    strcat(Str, "{FF8000}7»\t{FFFF00}/tirararmas\n");
    strcat(Str, "{FF8000}8»\t{FFFF00}/cv\n");
    strcat(Str, "{FF8000}9»\t{FFFF00}/avisa\n");
    strcat(Str, "{FF8000}10»\t{FFFF00}/imortal\n");
    strcat(Str, "{FF8000}11»\t{FFFF00}/sairimortal\n");
    strcat(Str, "{FF8000}12»\t{FFFF00}/vcm\n");
    strcat(Str, "{FF8000}13»\t{FFFF00}/prender\n");
    strcat(Str, "{FF8000}14»\t{FFFF00}/soltar\n");
    strcat(Str, "{FF8000}15»\t{FFFF00}/Banir\n");
    strcat(Str, "{FF8000}16»\t{FFFF00}/kick\n");
    strcat(Str, "{FF8000}17»\t{FFFF00}/trazer\n");
    strcat(Str, "{FF8000}18»\t{FFFF00}/ir\n");
    strcat(Str, "{FF8000}19»\t{FFFF00}/dargrana\n");
    strcat(Str, "{FF8000}20»\t{FFFF00}/tirargrana");
    ShowPlayerDialog(playerid, Dialog_Admincmd, DIALOG_STYLE_MSGBOX, "{FFFFFF}*----------Comandos_Admin-----------*", Str, "Fechar", #);
    return 1;
}
CMD:vcm(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new texto[100], String[128];
    if(sscanf(params, "s", texto)) return SendClientMessage(playerid, Cor_Erro, "Use: /vcm [Texto]");
    format(String, sizeof(String), "{0080FF}***Admin %s{FFFFFF}(%d){0080FF}Falou %s",GetPlayerNameEx(playerid),playerid,texto);
    SendClientMessageToAll(-1, String);
    return 1;
}
CMD:imortal(playerid)
{
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    {
      new String[300];
      SetPlayerHealth(playerid,99999999);
      format(String,sizeof(String),"Voce Esta No Modo Imortal");
      SendClientMessage(playerid,-1,String);
    }
    return 1;
}
CMD:sairimortal(playerid)
{
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    {
      new String[300];
      SetPlayerHealth(playerid,100);
      format(String,sizeof(String),"Voce Saiu Do Modo Imortal");
      SendClientMessage(playerid,-1,String);
    }
    return 1;
}
CMD:avisa(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,Motivo[100],Str[5000];
    if(sscanf(params, "ds",id,Motivo)) return SendClientMessage(playerid, Cor_Erro, "[ERRO]Use: /avisa[Id][Motivo]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    format(Str, sizeof(Str), "{0080FF}O Admin {FFFFFF}%s {0080FF}Deu Um Aviso Para O Player {FFFFFF}%s Motivo: %s",GetPlayerNameEx(playerid),GetPlayerNameEx(id),Motivo);
    SendClientMessageToAll(-1,Str);
    SendClientMessage(id, -1,"Voce Tem Um Aviso Na Sua Conta");
    return 1;
}
CMD:soltar(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,Str[500];
    if(sscanf(params, "d",id)) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Use: /soltar[id]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    SetPlayerPos(playerid,1155.3208,-1769.3306,16.5938);
    format(Str, sizeof(Str), "{0080FF}O Admin {FFFFFF}%s {0080FF}Tirou Voce Da Cadeia ",GetPlayerNameEx(playerid));
    SendClientMessage(id,-1,Str);
    SendClientMessage(playerid, 0x00FF80AA, "Comando Efetuado Com Sucesso!");
    KillTimer(TempoPreso(playerid));
    return 1;
}
CMD:prender(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,tempo,Str[500];
    if(sscanf(params, "dd",id,tempo)) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Use: /prender[id][tempo em minuto]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    //----------------------Cordernada Da Cadeia------------------//
    SetPlayerPos(id,283.22250, 1921.20215, 601.83167);
    SetTimerEx("TempoPreso", tempo*60000, false, "i", playerid);
    format(Str, sizeof(Str), "{0080FF}O Admin {FFFFFF}%s {0080FF}Prendeu Voce Na Cadeia Tempo %d Minutos!",GetPlayerNameEx(playerid),tempo);
    SendClientMessage(id,-1,Str);
    SendClientMessage(playerid, 0x00FF80AA, "Comando Efetuado Com Sucesso!");
    return 1;
}
forward TempoPreso(playerid);
public TempoPreso(playerid){
    SetPlayerPos(playerid,1155.3208,-1769.3306,16.5938);
    SendClientMessage(playerid, -1, "Voce Esta Solto!");
    KillTimer(TempoPreso(playerid));
    return 1;
}
CMD:cv(playerid, params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new idveiculo, cor1, cor2, Float:Pos[4];
    if(sscanf(params, "ddd", idveiculo, cor1, cor2)) return SendClientMessage(playerid, -1, "Use: /cv [id do veiculo] [cor 1] [cor 2]");
    GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
    GetPlayerFacingAngle(playerid, Pos[3]);
    CreateVehicle(idveiculo, Pos[0], Pos[1], Pos[2], Pos[3], cor1, cor2, -1);
    SendClientMessage(playerid, 0x00FF80AA, "Veiculo Criado com Sucesso!");
    return 1;
}
CMD:dararma(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,arma,municao,Str[500];
    if(sscanf(params, "ddd",id,arma,municao)) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Use: /dararma[id][id da arma][Muniçao]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    GivePlayerWeapon(id,arma,municao);
    format(Str, sizeof(Str), "{0080FF}O Admin {FFFFFF}%s {0080FF}Deu Umas armas Para Voce!",GetPlayerNameEx(playerid));
    SendClientMessage(id,-1,Str);
    SendClientMessage(id,-1,"Comando Efetuado Com Sucesso!");
    return 1;
}
CMD:tirararmas(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,Str[500];
    if(sscanf(params,"i",id))return SendClientMessage(playerid,-1,"Use /tirararma [ID]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    ResetPlayerWeapons(id);
    format(Str, sizeof(Str), "{0080FF}O Admin {FFFFFF}%s {0080FF}Tirou Suas Armas!",GetPlayerNameEx(playerid));
    SendClientMessage(id,-1,Str);
    SendClientMessage(id,-1,"Comando Efetuado Com Sucesso!");
    if(id == playerid)return 1;
    return 1;
}
CMD:trabalhar(playerid){
    new Str[500];
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] > 0) return  SendClientMessage(playerid, Cor_Erro, "[ERRO]Voce Ja Esta Trabalhando");
    Trabalhando[playerid] =1;
    SetPlayerSkin(playerid, 217);
    format(Str, sizeof(Str), "{0080FF}*** O Admin {FFFFFF}%s {0080FF}Esta Trabalhando!",GetPlayerNameEx(playerid));
    SendClientMessageToAll(-1,Str);
    SendClientMessage(playerid, -1, "Para Para de Trabalhar /paratrabalho");
    return 1;
}
CMD:paratrabalho(playerid){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new Str[222];
    SetPlayerSkin(playerid, 26);
    format(Str, sizeof(Str), "{0080FF}***O Admin {FFFFFF}%s {0080FF}Nao Esta Mais Trabalhando!",GetPlayerNameEx(playerid));
    SendClientMessageToAll(-1, Str);
    Trabalhando[playerid] =0;
    return 1;
}
CMD:dargrana(playerid,params[])
{
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,grana,String[222];
    if(sscanf(params,"ii",id,grana))return SendClientMessage(playerid,-1,"Use /dargrana [ID] [QUANTIA]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    GivePlayerMoney(id,grana);
    format(String,sizeof(String),"O %s  te deu %d de dinheiro.",GetPlayerNameEx(playerid),grana);
    SendClientMessage(id,-1,String);
    return 1;
}
CMD:tirargrana(playerid,params[])
{
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,grana,String[222];
    if(sscanf(params,"ii",id,grana))return SendClientMessage(playerid,-1,"Use /tirargrana [ID] [QUANTIA]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    GivePlayerMoney(id, -grana);
    format(String,sizeof(String),"O %s  removeu %d do seu dinheiro.",GetPlayerNameEx(playerid),grana);
    SendClientMessage(id,-1,String);
    return 1;
}
CMD:skin(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,idskin,String[222];
    if(sscanf(params,"ii",id,idskin))return SendClientMessage(playerid,-1,"Use /skin [ID] [ID DA SKIN]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    SetPlayerSkin(id,idskin);
    format(String,sizeof(String),"O %s  mudou sua skin para %d",GetPlayerNameEx(playerid),idskin);
    SendClientMessage(id,-1,String);
    return 1;
}
CMD:vida(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,vida,String[222];
    if(sscanf(params,"ii",id,vida))return SendClientMessage(playerid,-1,"Use /vida [ID] [vida]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    SetPlayerHealth(id,vida);
    format(String,sizeof(String),"O %s  te deu %d de vida.",GetPlayerNameEx(playerid),vida);
    SendClientMessage(id,-1,String);
    return 1;
}
CMD:colete(playerid,params[])
{
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,colete,String[222];
    if(sscanf(params,"ii",id,colete))return SendClientMessage(playerid,-1,"Use /colete [ID] [colete]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    SetPlayerArmour(id,colete);
    format(String,sizeof(String),"O %s  te deu %d de colete.",GetPlayerNameEx(playerid),colete);
    SendClientMessage(id,-1,String);
    return 1;
}
CMD:limparchat(playerid){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
  //if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
  //new String[222];
    for(new a = 0; a < 100; a++)
    {
      SendClientMessageToAll(0xFFFFFFFF, " ");
    }
  //format(String,sizeof(String),"~r~%s ~w~limpou o chat",GetPlayerNameEx(playerid));
  //GameTextForAll(String,2000,1);
    return 1;
}
CMD:tv(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id;
    if(sscanf(params,"i",id)) return SendClientMessage(playerid, Cor_Erro, "Use /tv [ID]");
    if(id == playerid) return SendClientMessage(playerid, Cor_Erro, "Você nao se assistir!");
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, Cor_Erro, "JOGADOR OFFLINE");
    SendClientMessage(playerid, Cor_Erro, "Para parar de assistir use /tvoff");
    TogglePlayerSpectating(playerid, 1);
    PlayerSpectatePlayer(playerid, id);
    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
    return 1;
}
CMD:tvoff(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 1) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    TogglePlayerSpectating(playerid, 0);
    PlayerSpectatePlayer(playerid, playerid);
    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerid));
    return 1;
}
CMD:ir(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao E Um(a)  Admin");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new Float:x,Float:y,Float:z,id,String[444];
    if(sscanf(params,"i",id))return SendClientMessage(playerid,-1,"Use /ir [ID]");
    if(!IsPlayerConnected(id)){
    GetPlayerPos(id,x,y,z);
    SetPlayerInterior(playerid,GetPlayerInterior(id));
    SetPlayerPos(playerid,x,y,z);
    format(String,sizeof(String),"O %s %s veio ate voce",GetPlayerNameEx(PlayerInfo[playerid][Admins]),GetPlayerNameEx(playerid));
    SendClientMessage(id,-1,String);
    }
    else return SendClientMessage(playerid,-1,"Esse player nao esta online");
    return 1;
}
CMD:trazer(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao E Um(a)  Admin");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new Float:x,Float:y,Float:z,id,String[444];
    if(sscanf(params,"i",id))return SendClientMessage(playerid,-1,"Use /trazer [ID]");
    if(!IsPlayerConnected(id)){
    GetPlayerPos(playerid,x,y,z);
    SetPlayerInterior(id,GetPlayerInterior(playerid));
    SetPlayerPos(id,x,y,z);
    format(String,sizeof(String),"O %s veio ate voce",GetPlayerNameEx(id));
    SendClientMessage(playerid,-1,String);
    }
    else return SendClientMessage(playerid,-1,"Esse player nao esta online");
    return 1;
}
CMD:banir(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,motivo[22],Mensagem[222];
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    if(sscanf(params, "dd",id,motivo)) return SendClientMessage(playerid, Cor_Erro, "[ERRO]Use: /banir[Id][Motivo]");
    format(Mensagem, sizeof(Mensagem), "[Ban] O Admin %s Baniu O Player %s! Motivo: %s!. ",GetPlayerNameEx(playerid), GetPlayerNameEx(id), motivo  );
    SendClientMessageToAll(0x008040FF, Mensagem);
    Ban(id);
    return 1;
}
CMD:kick(playerid,params[]){
    if(PlayerInfo[playerid][Admins] < 2) return SendClientMessage(playerid, Cor_Erro, "Voce Nao Tem Permisao De Usar Este Comando");
    if(Trabalhando[playerid] < 1) return SendClientMessage(playerid, Cor_Erro,"[ERRO]Voce Nao Esta Trabalhando!");
    new id,motivo[22],Mensagem[222];
    if(sscanf(params, "dd",id,motivo)) return SendClientMessage(playerid, Cor_Erro, "[ERRO]Use: /Kick[Id][Motivo]");
    if(!IsPlayerConnected(id))return SendClientMessage(playerid, Cor_Erro, "[ERRO]Id Invalido");
    format(Mensagem, sizeof(Mensagem), "[Kick] O Admin %s Deu Kick No Player %s! Motivo: %s!. ",GetPlayerNameEx(playerid), GetPlayerNameEx(id), motivo  );
    SendClientMessageToAll(0x008040FF, Mensagem);
    Kick(id);
    return 1;
}
CMD:admins(playerid, params[])
{
new IsAdmin,String[222];
SendClientMessage(playerid, -1, "Admin Online:");
for(new i = 0; i < MAX_PLAYERS; i++)
{
    if(IsPlayerConnected(i)) {
    if(PlayerInfo[i][Admins] > 0)
    {
        format(String, sizeof(String), "Nome: %s Nivel: %d",GetPlayerNameEx(i), PlayerInfo[i][Admins]);
        SendClientMessage(playerid, -1, String);
        IsAdmin ++;
}
}
}
if(IsAdmin == 0)
{
    SendClientMessage(playerid, -1, "Nenhum Admin Online!");
}
IsAdmin = 0;
return 1;
}
stock SalvaAdmin(playerid){
    new File[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(File, sizeof(File), "Admins/%s.ini", sendername);
    DOF2_SetInt(File, "Admins", PlayerInfo[playerid][Admins]);
601.81171,  0.00000, 0.00000, 0.00000);
    Cr
    DOF2_SaveFile();
    return 1;
}
stock GetPlayerNameEx(playerid){
new Nome[MAX_PLAYER_NAME];
GetPlayerName(playerid, Nome, sizeof(Nome));
return Nome;
}
