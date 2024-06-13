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

#include "MythicPlusPackets.h"
#include "Util.h"

WorldPacket const* WorldPackets::MythicPlus::MythicPlusSeasonData::Write()
{
    _worldPacket.WriteBit(IsMythicPlusActive);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::MythicPlusCurrentAffixes::Write()
{
    _worldPacket << Count;
    for (uint32 i = 0; i < Count; i++)
    {
        _worldPacket << Affixes[i].KeystoneAffixId;
        _worldPacket << Affixes[i].RequiredSeason;
    }

    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::MythicPlusNewWeekRecord::Write()
{
    _worldPacket << MapChallengeModeID;
    _worldPacket << CompletionTime;
    _worldPacket << KeystoneLevel;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::MythicPlusAllMapStats::Write()
{
    _worldPacket << RunCount;
    _worldPacket << RewardCount;
    _worldPacket << Season;
    _worldPacket << Subseason;

    for (uint32 i = 0; i < RunCount; i++)
        _worldPacket << Runs[i];

    for (uint32 i = 0; i < RewardCount; i++)
        _worldPacket << Rewards[i];

    return &_worldPacket;
}

void WorldPackets::MythicPlus::MythicPlusRequestMapStats::Read()
{
    _worldPacket >> BnetAccountGUID;
    _worldPacket >> GUID;
}
