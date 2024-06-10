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

enum AzurebladeSpells
{
    // Azureblade
    SPELL_ARCANE_CLEAVE = 372222,
    SPELL_ARCANE_CLEAVE_VISUAL = 372218,
    SPELL_ANCIENT_ORB = 385578,
    SPELL_ANCIENT_ORB_VISUAL = 385781,
    SPELL_ANCIENT_ORB_FRAGMENT = 390461,
    SPELL_SUMMON_DRACONIC_IMAGE = 384223,
    SPELL_OVERWHELMING_ENERGY = 384132,
    SPELL_SUMMON_ILLUSION_DRACONIC_RITUAL = 378742,
    SPELL_ARCANE_MANA = 389248,
    SPELL_ARCANE_MANA_2 = 389252, 
    SPELL_AZUREBLADE_CHECK = 397148,

    // Draconic Image
    SPELL_UNSTABLE_MAGIC = 389792,
    SPELL_ILLUSIONARY_BOLT = 373932,

    // Draconic Illusion
    SPELL_SEAL_EMPOWERMENT = 379256,

    SPELL_AZUREBLADE_CONVERSATION_INTRO = 389382
};

enum AzurebladeEvents
{
    EVENT_ARCANE_CLEAVE = 1,
    EVENT_ANCIENT_ORB,
    EVENT_SUMMON_DRACONIC_IMAGE,
    EVENT_OVERWHELMING_ENERGY,
    EVENT_CHECK_OVERHWHELMING,
    EVENT_MOVE_TO_CENTER,

    EVENT_ILLUSIONARY_BOLT
};

enum AzurebladeSays
{
    SAY_AGGRO,
    SAY_ARCANE_CLEAVE,
    SAY_ANCIENT_ORB,
    SAY_SUMMON_DRACONIC_IMAGE,
    SAY_OVERWHELMING_ENERGY,
    SAY_OVERWHELMING_ENERGY_2,
    SAY_DEATH
};

enum AzurebladePoints
{
    POINT_ROOM_CENTER = 1,
};

enum AzurebladeActions
{
    ACTION_OVERWHELMING_ENERGY,
    ACTION_SINDRAGOSA_AFTER_AZUREBLADE = 7
};

const Position SindragosaOutroPosition = { -5275.743f, 740.857f, 432.051f, 1.43736f };
const Position AzurebladeCenterPosition = { -5337.01f, 791.774f, 427.97284f, 1.5624f };

// 186739 - Azureblade
struct boss_azureblade : public BossAI
{
    boss_azureblade(Creature* creature) : BossAI(creature, DATA_AZUREBLADE) { }

    void JustAppeared() override
    {
        me->SetPower(me->GetPowerType(), 50);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
        Talk(SAY_DEATH);

        TempSummon* sindragosa = me->SummonCreature(NPC_SINDRAGOSA, SindragosaOutroPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_AFTER_AZUREBLADE);
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);

        summons.DespawnAll();
        _EnterEvadeMode();
        _DespawnAtEvade();
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_ARCANE_CLEAVE, 5s);
        events.ScheduleEvent(EVENT_ANCIENT_ORB, 10s);
        events.ScheduleEvent(EVENT_SUMMON_DRACONIC_IMAGE, 3500ms);
        events.ScheduleEvent(EVENT_OVERWHELMING_ENERGY, 500ms);
        instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, me, 1);

        DoCastSelf(SPELL_ARCANE_MANA);

        Talk(SAY_AGGRO);
    }

    void OnSpellCast(SpellInfo const* spellInfo) override
    {
        if (!spellInfo)
            return;

        switch (spellInfo->Id)
        {
        case SPELL_ARCANE_CLEAVE:
            Talk(SAY_ARCANE_CLEAVE);
            break;
        case SPELL_OVERWHELMING_ENERGY:
            events.ScheduleEvent(EVENT_CHECK_OVERHWHELMING, 4s);
            break;
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        if (id == POINT_ROOM_CENTER)
        {
            Talk(SAY_OVERWHELMING_ENERGY);
            DoCastSelf(SPELL_OVERWHELMING_ENERGY);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING) && me->GetChannelSpellId() != SPELL_OVERWHELMING_ENERGY)
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_ARCANE_CLEAVE:
                DoCastSelf(SPELL_ARCANE_CLEAVE_VISUAL);
                DoCastSelf(SPELL_ARCANE_CLEAVE);
                events.ScheduleEvent(EVENT_ARCANE_CLEAVE, 13s);
                break;
            case EVENT_ANCIENT_ORB:
                Talk(SAY_ANCIENT_ORB);
                DoCastVictim(SPELL_ANCIENT_ORB);
                DoCastVictim(SPELL_ANCIENT_ORB_VISUAL);
                events.ScheduleEvent(EVENT_ANCIENT_ORB, 15s);
                events.RescheduleEvent(EVENT_ARCANE_CLEAVE, events.GetTimeUntilEvent(EVENT_ARCANE_CLEAVE) + 500ms);
                break;
            case EVENT_SUMMON_DRACONIC_IMAGE:
                Talk(SAY_SUMMON_DRACONIC_IMAGE);
                DoCastAOE(SPELL_SUMMON_DRACONIC_IMAGE);
                events.ScheduleEvent(EVENT_SUMMON_DRACONIC_IMAGE, 14s);
                events.RescheduleEvent(EVENT_ARCANE_CLEAVE, events.GetTimeUntilEvent(EVENT_ARCANE_CLEAVE) + 500ms);
                break;
            case EVENT_OVERWHELMING_ENERGY:
                if (me->GetPower(POWER_ENERGY) <= 0)
                {
                    me->SetReactState(REACT_PASSIVE);
                    events.CancelEvent(EVENT_ARCANE_CLEAVE);
                    events.CancelEvent(EVENT_ANCIENT_ORB);
                    events.CancelEvent(EVENT_SUMMON_DRACONIC_IMAGE);
                    me->GetMotionMaster()->MovePoint(POINT_ROOM_CENTER, AzurebladeCenterPosition);
                }
                else
                    events.ScheduleEvent(EVENT_OVERWHELMING_ENERGY, 500ms);
                break;
            case EVENT_CHECK_OVERHWHELMING:
                if (!me->HasAura(SPELL_SEAL_EMPOWERMENT))
                {
                    me->RemoveAurasDueToSpell(SPELL_OVERWHELMING_ENERGY);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetPower(POWER_ENERGY, me->GetMaxPower(POWER_ENERGY));
                    events.ScheduleEvent(EVENT_ARCANE_CLEAVE, 5s);
                    events.ScheduleEvent(EVENT_ANCIENT_ORB, 10s);
                    events.ScheduleEvent(EVENT_SUMMON_DRACONIC_IMAGE, 3500ms);
                    events.ScheduleEvent(EVENT_OVERWHELMING_ENERGY, 500ms);
                }
                break;
            default:
                break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }
    }
};

// 190187 - Draconic Image
struct npc_draconic_image : public ScriptedAI
{
    npc_draconic_image(Creature* creature) : ScriptedAI(creature) { }

    void JustSummoned(Creature* summon) override
    {
        Creature* azureblade = me->GetInstanceScript()->GetCreature(DATA_AZUREBLADE);
        if (!azureblade)
            return;

        if (!azureblade->IsAIEnabled())
            return;

        azureblade->AI()->JustSummoned(summon);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (IsMythic() || IsMythicPlus())
            DoCastAOE(SPELL_UNSTABLE_MAGIC, true);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EVENT_ILLUSIONARY_BOLT, 100ms);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        _events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ILLUSIONARY_BOLT:
                    DoCastAOE(SPELL_ILLUSIONARY_BOLT);
                    _events.ScheduleEvent(EVENT_ILLUSIONARY_BOLT, 500ms);
                    break;
                default:
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }
    }
private:
    EventMap _events;
};

// 192955 - Draconic Illusion
struct npc_draconic_illusion : public ScriptedAI
{
    npc_draconic_illusion(Creature* creature) : ScriptedAI(creature) { }

    void JustSummoned(Creature* summon) override
    {
        Creature* azureblade = me->GetInstanceScript()->GetCreature(DATA_AZUREBLADE);
        if (!azureblade)
            return;

        if (!azureblade->IsAIEnabled())
            return;

        azureblade->AI()->JustSummoned(summon);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (IsMythic() || IsMythicPlus())
            DoCastAOE(SPELL_UNSTABLE_MAGIC, true);
    }

    void JustAppeared() override
    {
        me->SetReactState(REACT_PASSIVE);
        Creature* azureblade = me->GetInstanceScript()->GetCreature(DATA_AZUREBLADE);
        if (!azureblade)
            return;

        me->SetFacingToObject(azureblade);
        DoCast(azureblade, SPELL_SEAL_EMPOWERMENT);
    }
};

// 389792 - Unstable Magic
class spell_azureblade_unstable_magic : public SpellScript
{
    void HandleHitTarget(SpellEffIndex effIndex)
    {
        GetCaster()->CastSpell(GetHitUnit(), GetEffectInfo(effIndex).TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_azureblade_unstable_magic::HandleHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 389248 - Arcane Mana
class spell_azureblade_arcane_mana : public AuraScript
{
    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        target->SetPower(target->GetPowerType(), target->GetPower(POWER_ENERGY) - 2);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_azureblade_arcane_mana::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

constexpr uint8 MaxIllusionRitualPositions{4};
const Position IllusionRitualPositions[MaxIllusionRitualPositions] = {
    { -5327.18f, 803.722f, 427.996f },
    { -5346.86f, 779.741f, 427.996f },
    { -5327.04f, 779.644f, 427.996f },
    { -5346.89f, 803.51f, 427.996f }
};

// 379757 - Summon Illusion Ritual
class spell_azureblade_summon_illusion_ritual : public AuraScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_SUMMON_ILLUSION_DRACONIC_RITUAL
        });
    }

    void HandlePeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTickNumber() - 1 >= MaxIllusionRitualPositions)
            return;

        const Position pos = IllusionRitualPositions[aurEff->GetTickNumber() - 1];
        GetCaster()->CastSpell(pos, SPELL_SUMMON_ILLUSION_DRACONIC_RITUAL);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_azureblade_summon_illusion_ritual::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 390384 - Ancient Orb Fragment
class spell_azureblade_ancient_orb_fragment : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_ANCIENT_ORB_FRAGMENT
        });
    }

    void HandleHitTarget(SpellEffIndex /*effIndex*/)
    {
        const Position casterPosition = GetCaster()->GetPosition();
        float orientation = (2.0f * float(M_PI)) / 5.0f;
        const float randomInitialOrientation = frand(0.0f, orientation);
        orientation += randomInitialOrientation;

        for (uint8 i = 0; i < 5; i++)
        {
            Position finalPos = Position{casterPosition.m_positionX, casterPosition.m_positionY, casterPosition.m_positionZ, orientation * static_cast<float>(i)};
            finalPos.RelocateOffset({0.5f, 0.5f});
            GetCaster()->CastSpell(finalPos, SPELL_ANCIENT_ORB_FRAGMENT);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_azureblade_ancient_orb_fragment::HandleHitTarget, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 385578 - Ancient Orb CreatePropertiesId: 26351
// 390461 - Ancient Orb Fragment CreatePropertiesId: 26773
struct at_azureblade_ancient_orb : AreaTriggerAI
{
    at_azureblade_ancient_orb(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnInitialize() override
    {
        Unit* caster = at->GetCaster();
        if (!caster)
            return;

        Position destPos = caster->GetPosition();
        at->MovePositionToFirstCollision(destPos, 100.0f, 0.0f);

        std::vector<G3D::Vector3> splinePoints;
        splinePoints.push_back(PositionToVector3(at));
        splinePoints.push_back(PositionToVector3(destPos));

        at->InitSplines(std::move(splinePoints), at->GetCreateProperties()->TimeToTarget);
    }
};

// XX - Azure Vault - Trigger Conversation with Azureblade
struct at_azureblade_before_conversation : AreaTriggerAI
{
    at_azureblade_before_conversation(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_AZUREBLADE_INTRO_DONE))
            return;

        if (!unit->IsPlayer())
            return;
            
        Creature* azureblade = at->GetInstanceScript()->GetCreature(DATA_AZUREBLADE);
        if (!azureblade)
            return;

        if (!azureblade->IsAIEnabled())
            return;

        azureblade->CastSpell(azureblade, SPELL_AZUREBLADE_CONVERSATION_INTRO);
    }
};

void AddSC_boss_azureblade()
{
    // Creatures
    RegisterAzureVaultCreatureAI(boss_azureblade);
    RegisterAzureVaultCreatureAI(npc_draconic_image);
    RegisterAzureVaultCreatureAI(npc_draconic_illusion);

    // Spells
    RegisterSpellScript(spell_azureblade_unstable_magic);
    RegisterSpellScript(spell_azureblade_arcane_mana);
    RegisterSpellScript(spell_azureblade_ancient_orb_fragment);
    RegisterSpellScript(spell_azureblade_summon_illusion_ritual);

    // Areatriggers
    RegisterAreaTriggerAI(at_azureblade_ancient_orb);
    RegisterAreaTriggerAI(at_azureblade_before_conversation);
}
