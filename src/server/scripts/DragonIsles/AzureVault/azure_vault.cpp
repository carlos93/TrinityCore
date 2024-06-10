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
#include "Conversation.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "TemporarySummon.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Unit.h"
#include "azure_vault.h"


enum AzureVaultConvoData
{
    CONVO_SINDRAGOSA = 84710,
    CONVO_SINDRAGOSA_LINE_0 = 46138,

    EVENT_SINDRAGOSA_SUMMON_WHELP = 1,
    EVENT_SINDRAGOSA_START_CONVERSATION = 2,
    EVENT_SINDRAGOSA_START_MOVING = 3,
    EVENT_TELASH_START_MOVING = 4,

    SPELL_SINDRAGOSA_CONVERSATION_INTRO = 370258,
    SPELL_SINDRAGOSA_CONVERSATION_SUNDERED_FLAME = 397106,
    SPELL_SINDRAGOSA_CONVERSATION_BEFORE_LEYMOR = 389330,
    SPELL_SINDRAGOSA_CONVERSATION_AFTER_LEYMOR = 389351,
    SPELL_SINDRAGOSA_CONVERSATION_WILD_MAGIC = 389374,
    SPELL_SINDRAGOSA_CONVERSATION_BOOKS = 389369,
    SPELL_SINDRAGOSA_CONVERSATION_AFTER_AZUREBLADE = 389365,
    SPELL_SINDRAGOSA_CONVERSATION_BEFORE_TELASH = 397107,
    SPELL_SINDRAGOSA_CONVERSATION_AFTER_TELASH = 389370,
    SPELL_SINDRAGOSA_CONVERSATION_AFTER_UMBRELSKUL = 389371,
    SPELL_SINDRAGOSA_APPEARS_COSMETIC = 370267,
    SPELL_SINDRAGOSA_SUMMON_WHELP = 370875,

    ACTION_SINDRAGOSA_INTRO = 1,
    ACTION_SINDRAGOSA_SUNDERED_FLAME = 2,
    ACTION_SINDRAGOSA_BEFORE_LEYMOR = 3,
    ACTION_SINDRAGOSA_AFTER_LEYMOR = 4,
    ACTION_SINDRAGOSA_WILD_MAGIC = 5,
    ACTION_SINDRAGOSA_BOOKS = 6,
    ACTION_SINDRAGOSA_AFTER_AZUREBLADE = 7,
    ACTION_SINDRAGOSA_BEFORE_TELASH = 8,
    ACTION_SINDRAGOSA_AFTER_TELASH = 9,
    ACTION_SINDRAGOSA_AFTER_UMBRESKUL = 10,

    POINT_WILD_MAGIC = 1,
    POINT_TELASH_RUN = 1,
    POINT_BOOK_TRANSLOCATION = 1,

    NPC_TELASH_RP = 199614,
    NPC_SINDRAGOSA_2 = 188046,
};

WaypointPath const SindragosaPath =
{
    POINT_WILD_MAGIC,
    {
        { 0, -5153.4375f, 1155.7291f, 532.648f },
        { 1, -5162.394f, 1159.5973f, 527.70654f },
        { 2, -5185.7866f, 1181.0399f, 510.9255f },
        { 3, -5188.5503f, 1183.783f, 510.5951f },
        { 4, -5192.2065f, 1181.5642f, 510.53488f }
    },
    WaypointMoveType::Walk,
    WaypointPathFlags::None
};

WaypointPath const TelashPath =
{
    POINT_TELASH_RUN,
    {
        { 0, -5289.6704f,  899.2299f, 388.94684f },
        { 1, -5324.9985f,  895.03644f, 378.95898f },
        { 2, -5357.5103f,  898.9427f, 363.51746f },
        { 3, -5351.0654f,  898.16833f, 366.71182f },
        { 4, -5357.5103f,  898.9427f, 363.51746f },
        { 5, -5357.688f,  898.9817f, 363.42285f },
        { 6, -5363.175f,  900.18646f, 360.09393f },
        { 7, -5363.4062f,  900.23724f, 360.07382f },
        { 8, -5363.6426f,  900.2892f, 359.82864f },
        { 9, -5364.3145f,  900.43665f, 359.4659f },
        { 10, -5372.8633f,  902.31384f, 354.98492f },
        { 11, -5376.889f,  903.1977f, 352.90338f },
        { 12, -5378.3115f,  903.5101f, 352.43637f },
        { 13, -5380.523f,  903.9956f, 351.38354f },
        { 14, -5380.666f,  904.02704f, 351.48557f },
        { 15, -5380.968f,  904.0933f, 351.33444f },
        { 16, -5383.8267f,  904.721f, 350.01437f },
        { 17, -5384.777f,  904.9297f, 349.78668f },
        { 18, -5393.411f,  906.8255f, 346.77597f },
        { 19, -5393.671f,  906.88257f, 346.7517f },
        { 20, -5394.248f,  907.0093f, 346.44012f },
        { 21, -5396.396f,  907.4809f, 345.6689f },
        { 22, -5412.5034f,  907.92017f, 343.33176f },
        { 23, -5435.8853f,  881.6406f, 343.33176f }
    },
    WaypointMoveType::Run,
    WaypointPathFlags::None
};

WaypointPath const BookBeforeTelash =
{
    POINT_BOOK_TRANSLOCATION,
    {
       {0, -5413.002f, 991.00696f, 346.43228f },
       {1, -5405.328f, 1008.5521f, 351.44327f },
       {2, -5383.4272f, 1032.1459f, 348.3228f },
       {3, -5366.299f, 1040.7935f, 339.7f },
    },
    WaypointMoveType::Run,
    WaypointPathFlags::FlyingPath
};

const Position SindragosaIntroPosition = {-5074.3057f, 1049.3317f, 594.7531f, 5.49160f};
const Position SindragosaSunderedFlamePosition = {-5091.191f, 1169.8055f, 594.269f, 4.48038f};
const Position SindragosaBeforeLeymorPosition = {-5083.512f, 1291.5798f, 555.61f, 1.2050f};
const Position SindragosaWildMagicPosition = {-5139.752f, 1153.8212f, 539.0215f, 6.00883f};
const Position SindragosaBooksPosition = {-5294.936f, 1190.2812f, 510.5488f, 1.3903f};
const Position SindragosaBeforeTelashPosition = {-5267.188f, 880.163f, 388.809f, 4.5922f};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_intro : AreaTriggerAI
{
    at_azure_vault_sindragosa_intro(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_INTRO_DONE))
            return;
            
        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaIntroPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_INTRO);

        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_INTRO_DONE, true);
    }
};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_sundered_flame : AreaTriggerAI
{
    at_azure_vault_sindragosa_sundered_flame(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_SUNDERED_FLAME_DONE))
            return;

        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaSunderedFlamePosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_SUNDERED_FLAME);
        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_SUNDERED_FLAME_DONE, true);
    }
};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_before_leymor : AreaTriggerAI
{
    at_azure_vault_sindragosa_before_leymor(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_BEFORE_LEYMOR_DONE))
            return;

        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaBeforeLeymorPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_BEFORE_LEYMOR);
        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_BEFORE_LEYMOR_DONE, true);
    }
};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_wild_magic : AreaTriggerAI
{
    at_azure_vault_sindragosa_wild_magic(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_WILD_MAGIC_DONE))
            return;

        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaWildMagicPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_WILD_MAGIC);
        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_WILD_MAGIC_DONE, true);
    }
};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_books : AreaTriggerAI
{
    at_azure_vault_sindragosa_books(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_BOOKS_DONE))
            return;

        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaBooksPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_BOOKS);
        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_BOOKS_DONE, true);
    }
};

// XX - Azure Vault - Trigger Conversation with Sindragosa
struct at_azure_vault_sindragosa_before_telash : AreaTriggerAI
{
    at_azure_vault_sindragosa_before_telash(AreaTrigger* areatrigger) : AreaTriggerAI(areatrigger) { }

    void OnUnitEnter(Unit* unit) override
    {
        if (!at->GetInstanceScript())
            return;

        if (at->GetInstanceScript()->GetData(DATA_SINDRAGOSA_BEFORE_TELASH_DONE))
            return;

        if (!unit->IsPlayer())
            return;

        TempSummon* sindragosa = at->SummonCreature(NPC_SINDRAGOSA, SindragosaBeforeTelashPosition, TEMPSUMMON_MANUAL_DESPAWN);
        if (!sindragosa || !sindragosa->GetAI())
            return;

        sindragosa->GetAI()->DoAction(ACTION_SINDRAGOSA_BEFORE_TELASH);
        at->GetInstanceScript()->SetData(DATA_SINDRAGOSA_BEFORE_TELASH_DONE, true);
    }
};

// 187482 - Sindragosa
struct npc_azure_vault_sindragosa : public ScriptedAI
{
public:
    npc_azure_vault_sindragosa(Creature* creature) : ScriptedAI(creature), _conversationSpell(0) { }

    void JustAppeared() override
    {
        DoCastSelf(SPELL_SINDRAGOSA_APPEARS_COSMETIC);
    }

    void WaypointReached(uint32 /*waypointId*/, uint32 pathId) override
    {
        if (pathId == POINT_WILD_MAGIC)
        {
            me->DespawnOrUnsummon(10s);
        }
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
        case ACTION_SINDRAGOSA_INTRO:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_INTRO;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_SUNDERED_FLAME:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_SUNDERED_FLAME;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_BEFORE_LEYMOR:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_BEFORE_LEYMOR;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_AFTER_LEYMOR:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_AFTER_LEYMOR;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_WILD_MAGIC:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_WILD_MAGIC;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_MOVING, 2s);
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_BOOKS:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_BOOKS;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_AFTER_AZUREBLADE:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_AFTER_AZUREBLADE;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_BEFORE_TELASH:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_BEFORE_TELASH;
            _events.ScheduleEvent(EVENT_TELASH_START_MOVING, 1s);
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_AFTER_TELASH:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_AFTER_TELASH;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        case ACTION_SINDRAGOSA_AFTER_UMBRESKUL:
            _conversationSpell = SPELL_SINDRAGOSA_CONVERSATION_AFTER_UMBRELSKUL;
            _events.ScheduleEvent(EVENT_SINDRAGOSA_START_CONVERSATION, 3s);
            break;
        default:
            break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_SINDRAGOSA_START_CONVERSATION:
                DoCastSelf(_conversationSpell);
                break;
            case EVENT_SINDRAGOSA_START_MOVING:
                me->GetMotionMaster()->MovePath(SindragosaPath, false);
                break;
            case EVENT_TELASH_START_MOVING:
            {
                Creature* telash = me->FindNearestCreature(NPC_TELASH_RP, 100.f);
                if (!telash)
                    break;

                telash->GetMotionMaster()->MovePath(TelashPath, false);
                telash->DespawnOrUnsummon(10s);
            }
                break;
            }
        }
    }
private:
    EventMap _events;
    uint32 _conversationSpell;
};

// 20393 - Sindragosa Sundered Flame
// 19960 - Sindragosa Before Leymor
// 19961 - Sindragosa After Leymor
// 19963 - Sindragosa Books of Translocation
// 19966 - Sindragosa And Telash
struct conversation_azure_vault_sindragosa : public ConversationScript
{
public:
    conversation_azure_vault_sindragosa(const char* scriptName, uint8 actorIdx) : ConversationScript(scriptName), _actorIdx(actorIdx) { }
    
    void OnConversationCreate(Conversation* conversation, Unit* creator) override
    {
        if (!creator)
            return;

        conversation->AddActor(CONVO_SINDRAGOSA, _actorIdx, creator->GetGUID());
        conversation->Start();
    }

    void OnConversationStart(Conversation* conversation) override
    {
        Creature* sindragosa = conversation->GetActorCreature(_actorIdx);
        if (!sindragosa)
            return;

        sindragosa->DespawnOrUnsummon(conversation->GetLastLineEndTime(DEFAULT_LOCALE) + 10s);
    }
private:
    uint8 _actorIdx;
};

// 19966 - Sindragosa Wild Magic
struct conversation_azure_vault_sindragosa_moving : public ConversationScript
{
public:
    conversation_azure_vault_sindragosa_moving() : ConversationScript("conversation_azure_vault_sindragosa_moving") { }
    
    void OnConversationCreate(Conversation* conversation, Unit* creator) override
    {
        if (!creator)
            return;

        conversation->AddActor(CONVO_SINDRAGOSA, 0, creator->GetGUID());
        conversation->Start();
    }
};

// 18117 - Sindragosa Intro
struct conversation_sindragosa_intro : public ConversationScript
{
public:
    conversation_sindragosa_intro() : ConversationScript("conversation_sindragosa_intro") { }

    void OnConversationCreate(Conversation* conversation, Unit* creator) override
    {
        if (!creator)
            return;

        conversation->AddActor(CONVO_SINDRAGOSA, 0, creator->GetGUID());
        conversation->Start();
    }

    void OnConversationStart(Conversation* conversation) override
    {
        Creature* sindragosa = conversation->GetActorCreature(0);
        if (!sindragosa)
            return;

        sindragosa->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);

        _events.ScheduleEvent(EVENT_SINDRAGOSA_SUMMON_WHELP, conversation->GetLineEndTime(DEFAULT_LOCALE, CONVO_SINDRAGOSA_LINE_0));
        sindragosa->DespawnOrUnsummon(conversation->GetLastLineEndTime(DEFAULT_LOCALE) + 10s);
    }

    void OnConversationUpdate(Conversation* conversation, uint32 diff) override
    {
        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
        case EVENT_SINDRAGOSA_SUMMON_WHELP:
            {
                Creature* sindragosa = conversation->GetActorCreature(0);
                if (!sindragosa)
                    break;
                
                sindragosa->CastSpell(nullptr, SPELL_SINDRAGOSA_SUMMON_WHELP);
            }
            break;
            default:
                break;
        }
    }

private:
    EventMap _events;
};

void AddSC_azure_vault()
{
    // Creatures
    RegisterAzureVaultCreatureAI(npc_azure_vault_sindragosa);

    // Areatrigger
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_intro);
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_sundered_flame);
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_before_leymor);
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_wild_magic);
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_books);
    RegisterAreaTriggerAI(at_azure_vault_sindragosa_before_telash);

    new conversation_azure_vault_sindragosa("conversation_azure_vault_sindragosa", 0);
    new conversation_azure_vault_sindragosa("conversation_azure_vault_sindragosa_and_telash", 1);
    new conversation_azure_vault_sindragosa_moving();
    new conversation_sindragosa_intro();
}
