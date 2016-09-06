#include <amxmodx>
#include <reapi>

new HookChain:g_hookPlayerKilled;
new HookChain:g_hookCanPlayerSpawn_Post;

public plugin_init() {
	register_plugin("Block spawn after first death", "1.0", "PRoSToC0der");
	
	RegisterHookChain(RG_CSGameRules_RestartRound, "OnRoundStart");
	
	g_hookPlayerKilled = RegisterHookChain(RG_CBasePlayer_Killed, "OnPlayerKilled");
	DisableHookChain(g_hookPlayerKilled);
	
	g_hookCanPlayerSpawn_Post = RegisterHookChain(RG_CSGameRules_FPlayerCanRespawn, "OnCanPlayerSpawn_Post", true);
	DisableHookChain(g_hookCanPlayerSpawn_Post);
}

public OnRoundStart() {
	EnableHookChain(g_hookPlayerKilled);
	DisableHookChain(g_hookCanPlayerSpawn_Post);
}

public OnPlayerKilled(playerEntIndex, killerEntIndex, gibBehavior) {
	DisableHookChain(g_hookPlayerKilled);
	EnableHookChain(g_hookCanPlayerSpawn_Post);
}

public OnCanPlayerSpawn_Post(playerEntIndex) {
	SetHookChainReturn(ATYPE_INTEGER, _:false);
	return HC_OVERRIDE;
}