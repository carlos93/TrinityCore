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

    std::vector<int32> affixes {9, 136, 137 };
    for (const auto affix : affixes)
    {
        response.Affixes.push_back({affix, 0});
    }
    SendPacket(response.Write());
}

void WorldSession::HandleMythicPlusRequestMapStats(WorldPackets::MythicPlus::MythicPlusRequestMapStats& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusAllMapStats response;
    response.Season = 12;
    response.Subseason = 94;

    response.Runs = _player->GetMapStats();
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

    Optional<KeystoneItemData> keystoneItemData = keystone->GetKeystoneItemData();
    if (!keystoneItemData)
        return;

    MapChallengeModeEntry const* mapChallengeModeEntry = sMapChallengeModeStore.LookupEntry(keystoneItemData->ChallengeMapId->ID);
    if (!mapChallengeModeEntry)
        return;

    WorldPackets::Misc::ChangePlayerDifficultyResult changeDiffResult;
    changeDiffResult.Result = DIFFICULTY_CHANGE_RESULT_LOADING_SCREEN_ENABLE;
    changeDiffResult.Cooldown = 0;
    SendPacket(changeDiffResult.Write());

    player->SetDungeonDifficultyID(DIFFICULTY_MYTHIC_KEYSTONE);
    Map* map = sMapMgr->CreateMap(mapChallengeModeEntry->MapID, GetPlayer(), keystoneItemData);

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
    
    WorldPackets::MythicPlus::ChallengeModeReset reset;
    reset.MapId = mapChallengeModeEntry->MapID;
    SendPacket(reset.Write());
}
