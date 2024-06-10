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

#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "Containers.h"
#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuras.h"
#include "SharedDefines.h"
#include "TemporarySummon.h"
#include "G3DPosition.hpp"
#include "azure_vault.h"

enum UmbrelskulSpells
{
    SPELL_UMBRELSKUL_SAY_AGGRO = 388840,
    SPELL_UMBRELSKUL_SAY_BRITTLE = 388834,
    SPELL_UMBRELSKUL_SAY_CRYSTALLINE_ROAR = 388836,
    SPELL_UMBRELSKUL_SAY_ARCANE_ERUPTION = 388837,
    SPELL_UMBRELSKUL_SAY_UNLEASHED_DESTRUCTION = 388826,

    SPELL_UMBRELSKUL_DRAGON_STRIKE = 384978,
    SPELL_UMBRELSKUL_CLEAR_DRAGON_STRIKE_DEBUFF = 397492,

    SPELL_UMBRELSKUL_UNLEASHED_DESTRUCTION = 388804,

    SPELL_UMBRELSKUL_BRITTLE = 386746,
    SPELL_UMBRELSKUL_BRITTLE_DETONATING_CRYSTAL_SUMMON = 386749,
    SPELL_UMBRELSKUL_BRITTLE_HARDENED_CRYSTAL_SUMMON = 396379,
    
    SPELL_UMBRELSKUL_CRACKLING_VORTEX_VISUAL = 385159,
    SPELL_UMBRELSKUL_CRACKLING_VORTEX_SUMMON_DUMMY = 385077,
    SPELL_UMBRELSKUL_CRACKLING_VORTEX_SOUND = 385153,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION_DAMAGE = 385078,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION_SUMMON_DUMMY = 385041,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION_VISUAL = 385079,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION = 385075,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION_DUMMY = 385037,
    SPELL_UMBRELSKUL_ARCANE_ERUPTION_MISSILE = 385076,

    SPELL_UMBRELSKUL_CRYSTALLINE_ROAR_DUMMY = 384696,
    SPELL_UMBRELSKUL_CRYSTALLINE_ROAR_SUMMON = 384697,
    SPELL_UMBRELSKUL_CRYSTALLINE_ROAR = 384699,

    SPELL_UMBRELSKUL_ENERGIZE = 394082,

    SPELL_UMBRELSKUL_DRAGON_SLEEPS = 385656,
};

enum UmbrelskulNpcs
{
    NPC_CRYSTALLINE_ROAR_TRIGGER = 194826,
    NPC_ARCANE_ERUPTION_TRIGGER = 194978,
};

enum UmbrelskulEvents
{
    EVENT_DRAGON_STRIKE = 1,
    EVENT_UNLEASHED_DESTRUCTION,
    EVENT_CRYSTALLINE_ROAR,
    EVENT_CHECK_HP,
    EVENT_CHECK_ENERGY,
    EVENT_CRACKLING_VORTEX_INIT
};

enum UmbrelskulActions
{
    ACTION_SINDRAGOSA_AFTER_UMBRESKUL = 10,
};

const Position SindragosaAfterUmbrelskulPosition = {-5305.152f, 1025.9412f, 158.74663f, 0.0f};

// 186738 - Umbrelskul
struct boss_umbrelskul : public BossAI
{
    boss_umbrelskul(Creature* creature) : BossAI(creature, DATA_UMBRELSKUL), _lastHpPct(100.0f) { }

    void JustAppeared() override
    {
        if (!instance->GetData(DATA_UMBRELSKUL_INTRO_DONE))
            DoCastSelf(SPELL_UMBRELSKUL_DRAGON_SLEEPS);

        me->SetPower(me->GetPowerType(), 50);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 1);

        DoCastSelf(SPELL_UMBRELSKUL_SAY_AGGRO);
        DoCastSelf(SPELL_UMBRELSKUL_ENERGIZE);

        me->RemoveAurasDueToSpell(SPELL_UMBRELSKUL_DRAGON_SLEEPS);
        instance->SetData(DATA_UMBRELSKUL_INTRO_DONE, true);

        events.ScheduleEvent(EVENT_DRAGON_STRIKE, 7s);
        events.ScheduleEvent(EVENT_CRYSTALLINE_ROAR, 15s);
        events.ScheduleEvent(EVENT_UNLEASHED_DESTRUCTION, 30s);
        events.ScheduleEvent(EVENT_CHECK_ENERGY, 500ms);
        events.ScheduleEvent(EVENT_CHECK_HP, 500ms);

        _lastHpPct = 100.0f;
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        summons.DespawnAll();
        _EnterEvadeMode();
        _DespawnAtEvade();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();

        TempSummon* sindragosa = me->SummonCreature(NPC_SINDRAGOSA, SindragosaAfterUmbrelskulPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (sindragosa && sindragosa->GetAI())
        {
            sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_AFTER_UMBRESKUL);
            sindragosa->SetFacingToObject(me);
        }

        DoCastSelf(SPELL_UMBRELSKUL_CLEAR_DRAGON_STRIKE_DEBUFF);
    }
    
    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!instance->GetData(DATA_UMBRELSKUL_INTRO_DONE) && instance->GetBossState(DATA_TELASH_GREYWING) == DONE)
        {
            std::vector<Player*> players;
            me->GetPlayerListInGrid(players, 70.0f);
            if (players.size() > 0)
            {
                me->RemoveAurasDueToSpell(SPELL_UMBRELSKUL_DRAGON_SLEEPS);
                instance->SetData(DATA_UMBRELSKUL_INTRO_DONE, true);
            }
        }

        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_DRAGON_STRIKE:
                DoCastVictim(SPELL_UMBRELSKUL_DRAGON_STRIKE);
                events.ScheduleEvent(EVENT_DRAGON_STRIKE, 15s);
                break;
            case EVENT_CRYSTALLINE_ROAR:
                DoCastSelf(SPELL_UMBRELSKUL_SAY_CRYSTALLINE_ROAR);
                DoCastSelf(SPELL_UMBRELSKUL_CRYSTALLINE_ROAR_DUMMY);
                DoCastSelf(SPELL_UMBRELSKUL_CRYSTALLINE_ROAR);
                events.ScheduleEvent(EVENT_CRYSTALLINE_ROAR, 60s);
                break;
            case EVENT_UNLEASHED_DESTRUCTION:
                DoCastSelf(SPELL_UMBRELSKUL_SAY_UNLEASHED_DESTRUCTION);
                DoCastSelf(SPELL_UMBRELSKUL_UNLEASHED_DESTRUCTION);
                events.ScheduleEvent(EVENT_UNLEASHED_DESTRUCTION, 60s);
                break;
            case EVENT_CHECK_ENERGY:
                if (me->GetPower(me->GetPowerType()) >= 100)
                {
                    DoCastSelf(SPELL_UMBRELSKUL_SAY_ARCANE_ERUPTION);
                    DoCastSelf(SPELL_UMBRELSKUL_ARCANE_ERUPTION_DUMMY);
                    me->SetPower(me->GetPowerType(), 0);
                }
                events.ScheduleEvent(EVENT_CHECK_ENERGY, 500ms);
                break;
            case EVENT_CHECK_HP:
                if ((_lastHpPct >= 75.0f && me->GetHealthPct() < 75.0f) ||
                    (_lastHpPct >= 50.0f && me->GetHealthPct() < 50.0f) ||
                    (_lastHpPct >= 25.0f && me->GetHealthPct() < 25.0f))
                {
                    DoCastSelf(SPELL_UMBRELSKUL_SAY_BRITTLE);
                    DoCastSelf(SPELL_UMBRELSKUL_BRITTLE);
                }
                events.ScheduleEvent(EVENT_CHECK_HP, 500ms);
                _lastHpPct = me->GetHealthPct();
                break;
            default:
                break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }
    }
private:
    float _lastHpPct;
};

// 194806 - Crackling Vortex
struct npc_crackling_vortex : public ScriptedAI
{
    npc_crackling_vortex(Creature* creature) : ScriptedAI(creature) { }

    void JustSummoned(Creature* summon) override
    {
        Creature* umbrelskul = me->GetInstanceScript()->GetCreature(DATA_UMBRELSKUL);
        if (!umbrelskul)
            return;

        if (!umbrelskul->IsAIEnabled())
            return;

        umbrelskul->AI()->JustSummoned(summon);
    }

    void JustAppeared() override
    {
        me->SetReactState(REACT_PASSIVE);
        _events.ScheduleEvent(EVENT_CRACKLING_VORTEX_INIT, 2s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_CRACKLING_VORTEX_INIT:
                    me->GetMotionMaster()->MoveRandom(20.f);
                    DoCastSelf(SPELL_UMBRELSKUL_CRACKLING_VORTEX_VISUAL);
                    break;
                default:
                    break;
            }
        }
    }
private:
    EventMap _events;
};

// 394082 - Energize
class spell_umbrelskul_energize : public AuraScript
{
    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        if (!target)
            return;
            
        int32 power = std::min(target->GetMaxPower(target->GetPowerType()), target->GetPower(target->GetPowerType()) + 2);
        target->SetPower(target->GetPowerType(), power);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_umbrelskul_energize::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

// 385037 - Arcane Eruption
class spell_umbrelskul_arcane_eruption_dummy : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_UMBRELSKUL_ARCANE_ERUPTION_SUMMON_DUMMY
        });
    }

    void HandleHitTarget(SpellEffIndex /*effIndex*/)
    {
        for (uint8 i = 0; i < 4; i++)
            GetCaster()->CastSpell(GetHitUnit()->GetRandomNearPosition(40.f), SPELL_UMBRELSKUL_ARCANE_ERUPTION_SUMMON_DUMMY);

        GetCaster()->CastSpell(GetCaster(), SPELL_UMBRELSKUL_ARCANE_ERUPTION);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_umbrelskul_arcane_eruption_dummy::HandleHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 385075 - Arcane Eruption
class spell_umbrelskul_arcane_eruption : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_UMBRELSKUL_ARCANE_ERUPTION_MISSILE
        });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.remove_if([](WorldObject* target) -> bool
        {
            return !target->IsCreature() || target->ToCreature()->GetEntry() != NPC_ARCANE_ERUPTION_TRIGGER;
        });
    }

    void HandleHitTarget(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_UMBRELSKUL_ARCANE_ERUPTION_MISSILE, TRIGGERED_IGNORE_CAST_IN_PROGRESS);
        if (Creature* target = GetHitCreature())
            target->DespawnOrUnsummon(1s);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_umbrelskul_arcane_eruption::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_umbrelskul_arcane_eruption::HandleHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 385077 - Arcane Eruption
class spell_umbrelskul_arcane_eruption_summon : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_UMBRELSKUL_ARCANE_ERUPTION_DAMAGE
        });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.remove_if([](WorldObject* target) -> bool
        {
            return !target->IsCreature() || target->ToCreature()->GetEntry() != NPC_ARCANE_ERUPTION_TRIGGER;
        });
    }

    void HandleHitTarget(SpellEffIndex /*effIndex*/)
    {
        GetOriginalCaster()->CastSpell(GetHitUnit(), SPELL_UMBRELSKUL_ARCANE_ERUPTION_DAMAGE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_umbrelskul_arcane_eruption_summon::HandleHitTarget, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// 384696 - Crystalline Roar
class spell_umbrelskul_crystalline_roar_dummy : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_UMBRELSKUL_CRYSTALLINE_ROAR_SUMMON
        });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.remove_if([](WorldObject* target) -> bool
        {
            return !target->IsPlayer();
        });

        Trinity::Containers::RandomResize(targets, 1);
    }

    void HandleCast(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_UMBRELSKUL_CRYSTALLINE_ROAR_SUMMON);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_umbrelskul_crystalline_roar_dummy::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_umbrelskul_crystalline_roar_dummy::HandleCast, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 384699 - Crystalline Roar
class spell_umbrelskul_crystalline_roar : public SpellScript
{
    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.remove_if([](WorldObject* target) -> bool
        {
            return !target->IsCreature() || target->ToCreature()->GetEntry() != NPC_CRYSTALLINE_ROAR_TRIGGER;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_umbrelskul_crystalline_roar::FilterTargets, EFFECT_0, TARGET_UNIT_TARGET_ANY);
    }
};

// 388804 - Unleashed Destruction
struct at_umbrelskul_unleashed_destruction : AreaTriggerAI
{
    at_umbrelskul_unleashed_destruction(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!unit->IsPlayer())
            return;

        unit->ApplyMovementForce(at->GetGUID(), at->GetPosition(), -20.0f, MovementForceType::Gravity);
    }

    void OnUnitExit(Unit* unit) override
    {
        if (!unit->IsPlayer())
            return;

        unit->RemoveMovementForce(at->GetGUID());
    }
};

void AddSC_boss_umbrelskul()
{
    // Creatures
    RegisterAzureVaultCreatureAI(boss_umbrelskul);
    RegisterAzureVaultCreatureAI(npc_crackling_vortex);

    // Spells
    RegisterSpellScript(spell_umbrelskul_energize);
    RegisterSpellScript(spell_umbrelskul_crystalline_roar);
    RegisterSpellScript(spell_umbrelskul_crystalline_roar_dummy);
    RegisterSpellScript(spell_umbrelskul_arcane_eruption);
    RegisterSpellScript(spell_umbrelskul_arcane_eruption_dummy);
    RegisterSpellScript(spell_umbrelskul_arcane_eruption_summon);

    // AreaTrigger
    RegisterAreaTriggerAI(at_umbrelskul_unleashed_destruction);
}
