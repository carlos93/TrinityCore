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

#include "WorldSession.h"
#include "MythicPlusPackets.h"

void WorldSession::HandleRequestMythicPlusSeasonData(WorldPackets::MythicPlus::RequestMythicPlusSeasonData& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusSeasonData response;
    response.IsMythicPlusActive = true;
    SendPacket(response.Write());
}

void WorldSession::HandleRequestMythicPlusAffixes(WorldPackets::MythicPlus::RequestMythicPlusAffixes& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusCurrentAffixes response;
    std::vector<WorldPackets::MythicPlus::MythicPlusAffix> affixes;
    response.Count = affixes.size();
    for (const auto affix : affixes)
    {
        response.Affixes.push_back({affix.KeystoneAffixId, affix.RequiredSeason});
    }

    SendPacket(response.Write());
}

void WorldSession::HandleMythicPlusRequestMapStats(WorldPackets::MythicPlus::MythicPlusRequestMapStats& /*packet*/)
{
    WorldPackets::MythicPlus::MythicPlusAllMapStats response;
    response.Season = 12;
    response.Subseason = 94;
    response.RunCount = 0;
    response.RewardCount = 0;
    SendPacket(response.Write());
}
