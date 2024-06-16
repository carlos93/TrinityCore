/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Group.h"
#include "InstanceScript.h"
#include "Item.h"
#include "MapManager.h"
#include "MiscPackets.h"
#include "MythicPlusPackets.h"
#include "WorldStatePackets.h"
#include "WorldSession.h"

void WorldSession::HandleRequestMythicPlusSeasonData(WorldPackets::MythicPlus::RequestMythicPlusSeasonData& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusSeasonData response;
    response.IsMythicPlusActive = true;
    SendPacket(response.Write());
}

void WorldSession::HandleRequestMythicPlusAffixes(WorldPackets::MythicPlus::RequestMythicPlusAffixes& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusCurrentAffixes response;

    // for (const auto mythicPlusSeasonTrackedAffix : sMythicPlusSeasonTrackedAffixStore)
    // {
    //     if (mythicPlusSeasonTrackedAffix->DisplaySeasonID == 23)
    //         response.Affixes.push_back({mythicPlusSeasonTrackedAffix->KeystoneAffixID, 0});
    // }

    // response.Count = response.Affixes.size();
    response.Count = 0;
    SendPacket(response.Write());
}

void WorldSession::HandleMythicPlusRequestMapStats(WorldPackets::MythicPlus::MythicPlusRequestMapStats& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusAllMapStats response;
    response.Season = 12;
    response.Subseason = 94;

    // std::vector<MapChallengeModeEntry*> instances;

    // for (const auto mythicPlusSeasonTrackedMap : sMythicPlusSeasonTrackedMapStore)
    // {
    //     if (mythicPlusSeasonTrackedMap->DisplaySeasonID == 23)
    //     {
    //         MapChallengeModeEntry const* mapChallenge = sMapChallengeModeStore.LookupEntry(mythicPlusSeasonTrackedMap->MapChallengeModeID);
    //         if (mapChallenge)
    //             instances.push_back(mapChallenge);
    //     }
    // }

    // response.RunCount = instances.size();

    // for (MapChallengeModeEntry* const instance : instances)
    // {
    //     WorldPackets::MythicPlus::MythicPlusRun run;

    //     run.MapChallengeModeID = instance->ID;
    //     run.Level = 1;
    //     run.Completed = true;
    //     run.Season = 12;
    //     run.RunScore = 200;

    //     response.Runs.push_back(run);
    // }

    response.RewardCount = 0;
    SendPacket(response.Write());
}

void WorldSession::HandleStartChallengeMode(WorldPackets::MythicPlus::StartChallengeMode& packet)
{
    Player* player = GetPlayer();
    if (!player)
        return;

    Item* keystone = player->GetItemByPos(packet.Bag, packet.Slot);
    if (!keystone)
        return;

    uint32 challengeLevel = keystone->GetModifier(ITEM_MODIFIER_CHALLENGE_KEYSTONE_LEVEL);
    uint32 mapChallengeId = keystone->GetModifier(ITEM_MODIFIER_CHALLENGE_MAP_CHALLENGE_MODE_ID);
    MapChallengeModeEntry const* mapChallengeModeEntry = sMapChallengeModeStore.LookupEntry(mapChallengeId);
    if (!mapChallengeModeEntry)
        return;

    WorldPackets::Misc::ChangePlayerDifficultyResult changeDiffResult;
    changeDiffResult.Result = DIFFICULTY_CHANGE_RESULT_LOADING_SCREEN_ENABLE;
    changeDiffResult.Cooldown = -1717869596;
    SendPacket(changeDiffResult.Write());

    player->SetDungeonDifficultyID(DIFFICULTY_MYTHIC_KEYSTONE);
    Map* map = sMapMgr->CreateMap(mapChallengeModeEntry->MapID, GetPlayer());

    bool result = false;
    WorldSafeLocsEntry const* instanceEntrance = sObjectMgr->GetWorldSafeLoc(mapChallengeModeEntry->MapID);
    if (instanceEntrance)
        result = player->TeleportTo(instanceEntrance->Loc);
    else
        result = player->TeleportTo({mapChallengeModeEntry->MapID, {player->GetPosition()}}, TELE_TO_NONE, map->GetInstanceId());


    WorldPackets::Misc::ChangePlayerDifficultyResult changeDiffResult2;
    changeDiffResult2.Result = result ? DIFFICULTY_CHANGE_RESULT_SUCCESS : DIFFICULTY_CHANGE_RESULT_PLAYER_ALREADY_LOCKED_TO_DIFFERENT_INSTANCE;
    changeDiffResult2.PlayerGUID = player->GetGUID();
    changeDiffResult2.MapId = mapChallengeModeEntry->MapID;
    changeDiffResult2.DifficultyId = DIFFICULTY_MYTHIC_KEYSTONE;
    SendPacket(changeDiffResult2.Write());

    if (!result)
        return;

    map->ToInstanceMap()->GetInstanceScript()->SendEncounterStart(1, 5, 600000, 600000);

    WorldPackets::MythicPlus::ChallengeModeReset reset;
    reset.MapId = mapChallengeModeEntry->MapID;
    SendPacket(reset.Write());

    WorldPackets::Misc::StartTimer timer;
    timer.TotalTime = 10s;
    timer.Type = CountdownTimerType::ChallengeMode;
    timer.TimeLeft = 10s;
    SendPacket(timer.Write());

    WorldPackets::MythicPlus::ChallengeModeStart start;

    for (uint8 i = 0; i < MAX_KEYSTONE_AFFIX; i++)
        start.Affixes[i] = keystone->GetModifier(static_cast<ItemModifier>(ITEM_MODIFIER_CHALLENGE_KEYSTONE_AFFIX_ID_1 + i));

    start.MapId = mapChallengeModeEntry->MapID;
    start.ChallengeId = mapChallengeModeEntry->ID;
    start.ChallengeLevel = challengeLevel;
    start.DeathCount = 0;
    start.WasActiveKeystoneCharged = true;
    SendPacket(start.Write());

    WorldPackets::Misc::StartElapsedTimer startElapsedTimer;
    WorldPackets::Misc::ElapsedTimer elapsedTimer;
    elapsedTimer.TimerId = 0;
    elapsedTimer.CurrentDuration = 0;
    elapsedTimer.Unk = 1;
    startElapsedTimer.Timer = elapsedTimer;
    SendPacket(startElapsedTimer.Write());

    WorldPackets::WorldState::UpdateWorldState updateWorldState;
    updateWorldState.VariableID = 13436;
    updateWorldState.Value = 219273919;
    updateWorldState.Hidden = false;
    updateWorldState.Write();
    
    WorldPackets::WorldState::UpdateWorldState updateWorldState2;
    updateWorldState2.VariableID = 13437;
    updateWorldState2.Value = 302710420;
    updateWorldState2.Hidden = false;
    updateWorldState2.Write();

    WorldPackets::WorldState::UpdateWorldState updateWorldState3;
    updateWorldState3.VariableID = 16712;
    updateWorldState3.Value = 299955408;
    updateWorldState3.Hidden = false;
    updateWorldState3.Write();
    
}
