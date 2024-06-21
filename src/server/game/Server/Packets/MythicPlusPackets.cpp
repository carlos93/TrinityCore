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
    _worldPacket << Affixes.size();
    for (uint32 i = 0; i < Affixes.size(); i++)
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
    _worldPacket << Runs.size();
    _worldPacket << Rewards.size();
    _worldPacket << Season;
    _worldPacket << Subseason;

    for (uint32 i = 0; i < Runs.size(); i++)
        _worldPacket << Runs[i];

    for (uint32 i = 0; i < Rewards.size(); i++)
        _worldPacket << Rewards[i];

    return &_worldPacket;
}

void WorldPackets::MythicPlus::MythicPlusRequestMapStats::Read()
{
    _worldPacket >> BnetAccountGUID;
    _worldPacket >> GUID;
}

void WorldPackets::MythicPlus::StartChallengeMode::Read()
{
    _worldPacket >> Bag;
    _worldPacket >> Slot;
    _worldPacket >> GameobjectGuid;
}

WorldPacket const* WorldPackets::MythicPlus::ChallengeModeStart::Write()
{
    _worldPacket << MapId;
    _worldPacket << ChallengeId;
    _worldPacket << ChallengeLevel;

    for (uint32 i = 0; i < Affixes.size(); i++)
        _worldPacket << Affixes[i];

    _worldPacket << DeathCount;
    _worldPacket << 0; // player, NYI

    _worldPacket.WriteBit(WasActiveKeystoneCharged);
    _worldPacket.FlushBits();

    /*
    for (Player player : players)
        _worldPacket << player;
    */

    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::ChallengeModeReset::Write()
{
    _worldPacket << MapId;

    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::ChallengeModeUpdateDeathCount::Write()
{
    _worldPacket << NewDeathCount;
    
    return &_worldPacket;
}

WorldPacket const* WorldPackets::MythicPlus::ChallengeModeComplete::Write()
{
    _worldPacket << Run;
    _worldPacket << NewDungeonScore;
    _worldPacket << Members.size();

    _worldPacket.WriteBit(IsPracticeRun);
    _worldPacket.WriteBit(IsAffixRecorded);
    _worldPacket.WriteBit(IsMapRecord);
    _worldPacket.FlushBits();

    for (MythicPlusCompletedRunMember const& Member : Members)
    {
        _worldPacket << Member.PlayerGuid;
        _worldPacket.WriteBits(Member.PlayerName.size(), 7);
        _worldPacket.WriteBit(Member.IsElegibleForScore);
        _worldPacket.WriteString(Member.PlayerName);
    }

    return &_worldPacket;
}
