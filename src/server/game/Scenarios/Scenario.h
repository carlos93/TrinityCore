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

#ifndef Scenario_h__
#define Scenario_h__

#include "Item.h"
#include "GameTime.h"
#include "CriteriaHandler.h"
#include <optional>
#include <map>
#include <unordered_set>

class Map;
struct ScenarioData;
struct ScenarioEntry;
struct ScenarioStepEntry;

namespace WorldPackets
{
    namespace Achievement
    {
        struct CriteriaProgress;
    }

    namespace Scenario
    {
        struct BonusObjectiveData;
        class ScenarioState;
    }
}

enum ScenarioStepState
{
    SCENARIO_STEP_INVALID       = 0,
    SCENARIO_STEP_NOT_STARTED   = 1,
    SCENARIO_STEP_IN_PROGRESS   = 2,
    SCENARIO_STEP_DONE          = 3
};

#define SECONDS_LOST_PER_DEATH 5
#define WAIT_SECONDS_UNTIL_CHALLENGE_START 10

class TC_GAME_API Scenario : public CriteriaHandler
{
    public:
        Scenario(Map* map, ScenarioData const* scenarioData, Optional<KeystoneItemData> const keystoneItemData);
        ~Scenario();

        void Reset() override;
        void SetStep(ScenarioStepEntry const* step);

        virtual void CompleteStep(ScenarioStepEntry const* step);
        virtual void CompleteScenario();

        virtual void OnPlayerEnter(Player* player);
        virtual void OnPlayerExit(Player* player);
        virtual void OnPlayerDeath(Player* /*player*/);
        virtual void Update(uint32 diff);

        bool IsComplete() const;
        bool IsCompletedStep(ScenarioStepEntry const* step);
        void SetStepState(ScenarioStepEntry const* step, ScenarioStepState state) { _stepStates[step] = state; }
        ScenarioEntry const* GetEntry() const;
        ScenarioStepState GetStepState(ScenarioStepEntry const* step) const;
        ScenarioStepEntry const* GetStep() const { return _currentstep; }
        ScenarioStepEntry const* GetFirstStep() const;
        ScenarioStepEntry const* GetLastStep() const;

        void SendScenarioState(Player const* player) const;
        void SendBootPlayer(Player const* player) const;
        void SendChallengeModeStart(Player const* player) const;
        void SendElapsedTimer(Player const* player, uint32 timeElapsed) const;

    protected:
        Map const* _map;
        GuidUnorderedSet _players;

        void SendCriteriaUpdate(Criteria const* criteria, CriteriaProgress const* progress, Seconds timeElapsed, bool timedCompleted) const override;
        void SendCriteriaProgressRemoved(uint32 /*criteriaId*/) override { }

        bool CanUpdateCriteriaTree(Criteria const* criteria, CriteriaTree const* tree, Player* referencePlayer) const override;
        bool CanCompleteCriteriaTree(CriteriaTree const* tree) override;
        void CompletedCriteriaTree(CriteriaTree const* tree, Player* referencePlayer) override;
        void AfterCriteriaTreeUpdate(CriteriaTree const* /*tree*/, Player* /*referencePlayer*/) override { }

        void DoForAllPlayers(std::function<void(Player*)> const& worker) const;
        void SendPacket(WorldPacket const* data) const override;

        void SendAllData(Player const* /*receiver*/) const override { }

        void BuildScenarioStateFor(Player const* player, WorldPackets::Scenario::ScenarioState* scenarioState) const;

        std::vector<WorldPackets::Scenario::BonusObjectiveData> GetBonusObjectivesData() const;
        std::vector<WorldPackets::Achievement::CriteriaProgress> GetCriteriasProgressFor(Player const* player) const;

        CriteriaList const& GetCriteriaByType(CriteriaType type, uint32 asset) const override;
        ScenarioData const* _data;

        Optional<KeystoneItemData> GetKeystoneItemData() const { return _keystoneItemData; }

        uint32 GetChallengeTimeElapsed() const { return GetSecondsSinceChallengeStart() + (_deathCount * SECONDS_LOST_PER_DEATH) - WAIT_SECONDS_UNTIL_CHALLENGE_START; }
        uint32 GetSecondsSinceChallengeStart() const { return uint32(std::max(0LL, std::chrono::duration_cast<Seconds>(GameTime::GetSystemTime() - _challengeStartTime.value()).count())); }

    private:
        ObjectGuid const _guid;
        ScenarioStepEntry const* _currentstep;
        std::map<ScenarioStepEntry const*, ScenarioStepState> _stepStates;
        Optional<KeystoneItemData> _keystoneItemData;
        Optional<int32> _timerStartChallenge;
        uint32 _deathCount;
        Optional<SystemTimePoint> _challengeStartTime;
        bool _timerSent;
};

#endif // Scenario_h__
