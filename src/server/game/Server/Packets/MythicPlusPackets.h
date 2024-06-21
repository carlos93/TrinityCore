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

#ifndef MythicPlusPackets_h__
#define MythicPlusPackets_h__

#include "Packet.h"
#include "MythicPlusPacketsCommon.h"
#include "Optional.h"

namespace WorldPackets
{
    namespace MythicPlus
    {
        class RequestMythicPlusSeasonData final : public ClientPacket
        {
        public:
            RequestMythicPlusSeasonData(WorldPacket&& packet) : ClientPacket(CMSG_REQUEST_MYTHIC_PLUS_SEASON_DATA, std::move(packet)) { }

            void Read() override { }
        };

        class TC_GAME_API MythicPlusSeasonData final : public ServerPacket
        {
        public:
            MythicPlusSeasonData() : ServerPacket(SMSG_MYTHIC_PLUS_SEASON_DATA) { }

            WorldPacket const* Write() override;

            bool IsMythicPlusActive = false;
        };
        
        class RequestMythicPlusAffixes final : public ClientPacket
        {
        public:
            RequestMythicPlusAffixes(WorldPacket&& packet) : ClientPacket(CMSG_REQUEST_MYTHIC_PLUS_AFFIXES, std::move(packet)) { }

            void Read() override { }
        };

        struct MythicPlusAffix
        {
            int32 KeystoneAffixId;
            int32 RequiredSeason;
        };

        class TC_GAME_API MythicPlusCurrentAffixes final : public ServerPacket
        {
        public:
            MythicPlusCurrentAffixes() : ServerPacket(SMSG_MYTHIC_PLUS_CURRENT_AFFIXES) { }

            WorldPacket const* Write() override;

            std::vector<MythicPlusAffix> Affixes;
        };

        class TC_GAME_API MythicPlusNewWeekRecord final : public ServerPacket
        {
        public:
            MythicPlusNewWeekRecord() : ServerPacket(SMSG_MYTHIC_PLUS_NEW_WEEK_RECORD, 4+4+4) { }

            WorldPacket const* Write() override;

            int32 MapChallengeModeID = 0;
            int32 CompletionTime = 0;
            uint32 KeystoneLevel = 0;
        };

        class TC_GAME_API MythicPlusAllMapStats final : public ServerPacket
        {
        public:
            MythicPlusAllMapStats() : ServerPacket(SMSG_MYTHIC_PLUS_ALL_MAP_STATS) { }

            WorldPacket const* Write() override;

            int32 Season;
            int32 Subseason;

            std::vector<WorldPackets::MythicPlus::MythicPlusRun> Runs;
            std::vector<WorldPackets::MythicPlus::MythicPlusReward> Rewards;
        };

        class MythicPlusRequestMapStats final : public ClientPacket
        {
        public:
            MythicPlusRequestMapStats(WorldPacket&& packet) : ClientPacket(CMSG_MYTHIC_PLUS_REQUEST_MAP_STATS, std::move(packet)) { }

            void Read() override;

            ObjectGuid BnetAccountGUID;
            ObjectGuid GUID;
        };

        class StartChallengeMode final : public ClientPacket
        {
        public:
            StartChallengeMode(WorldPacket&& packet) : ClientPacket(CMSG_START_CHALLENGE_MODE, std::move(packet)) { }

            void Read() override;

            uint8 Bag;
            int32 Slot;
            ObjectGuid GameobjectGuid;
        };

        class TC_GAME_API ChallengeModeStart final : public ServerPacket
        {
        public:
            ChallengeModeStart() : ServerPacket(SMSG_CHALLENGE_MODE_START) { }

            WorldPacket const* Write() override;

            uint32 MapId;
            uint32 ChallengeId;
            int32 ChallengeLevel;
            uint32 DeathCount;

            bool WasActiveKeystoneCharged;
            
            std::array<uint32, 4> Affixes;
        };

        class TC_GAME_API ChallengeModeReset final : public ServerPacket
        {
        public:
            ChallengeModeReset() : ServerPacket(SMSG_CHALLENGE_MODE_RESET, 4) { }

            WorldPacket const* Write() override;

            uint32 MapId;
        };

        class TC_GAME_API ChallengeModeUpdateDeathCount final : public ServerPacket
        {
        public:
            ChallengeModeUpdateDeathCount() : ServerPacket(SMSG_CHALLENGE_MODE_UPDATE_DEATH_COUNT, 4) { }

            WorldPacket const* Write() override;

            int32 NewDeathCount;
        };

        class TC_GAME_API ChallengeModeComplete final : public ServerPacket
        {
        public:
            ChallengeModeComplete() : ServerPacket(SMSG_CHALLENGE_MODE_COMPLETE) { }

            WorldPacket const* Write() override;

            MythicPlusRun Run;
            float NewDungeonScore;
            std::vector<MythicPlusCompletedRunMember> Members;
            bool IsPracticeRun;
            bool IsAffixRecorded;
            bool IsMapRecord;
        };
    }
}

#endif // MythicPlusPackets_h__
