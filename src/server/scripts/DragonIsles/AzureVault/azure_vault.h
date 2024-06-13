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

#ifndef DEF_AZURE_VAULT_H_
#define DEF_AZURE_VAULT_H_

#include "CreatureAIImpl.h"

#define DataHeader "AzureVault"
#define AVScriptName "instance_azure_vault"

uint32 const EncounterCount = 4;

enum AVDataTypes
{
    // Encounters
    DATA_LEYMOR             = 0,
    DATA_AZUREBLADE,
    DATA_TELASH_GREYWING,
    DATA_UMBRELSKUL,

    DATA_LEYMOR_INTRO_DONE,
    DATA_SINDRAGOSA_INTRO_DONE,
    DATA_SINDRAGOSA_SUNDERED_FLAME_DONE,
    DATA_SINDRAGOSA_BEFORE_LEYMOR_DONE,
    DATA_SINDRAGOSA_WILD_MAGIC_DONE,
    DATA_SINDRAGOSA_BOOKS_DONE,
    DATA_SINDRAGOSA_BEFORE_TELASH_DONE,
    DATA_AZUREBLADE_INTRO_DONE,
    DATA_UMBRELSKUL_INTRO_DONE
};

enum AVSindragosaStatus
{
    SINDRAGOSA_INTRO = 0,
    SINDRAGOSA_MISC_1,
    SINDRAGOSA_BEFORE_LEYMORE,
    SINDRAGOSA_AFTER_LEYMORE,
    SINDRAGOSA_MISC_2,
    SINDRAGOSA_EXPLAIN_BOOKS,
    SINDRAGOSA_AFTER_AZUREBLADE,
    SINDRAGOSA_TELASH_RP,
    SINDRAGOSA_BEFORE_TELASH,
    SINDRAGOSA_BEFORE_UMBRELSKUL,
};

enum AVCreatureIds
{
    // Bosses
    BOSS_LEYMOR             = 186644,
    BOSS_AZUREBLADE         = 186739,
    BOSS_TELASH_GREYWING    = 199614,
    BOSS_UMBRELSKUL         = 186738,

    // Leymor
    NPC_ARCANE_TENDER       = 191164,
    NPC_SINDRAGOSA          = 187482,
    NPC_SINDRAGOSA_ENTRANCE = 197081,
};

enum AVGameObjectIds
{
    GO_ARCANE_VAULTS_DOOR_LEYMOR_ENTRANCE       = 380536,
    GO_ARCANE_VAULTS_DOOR_LEYMOR_EXIT           = 377951,
    GO_AZUREBLADE_ENTER                         = 377952,
    GO_AZUREBLADE_EXIT                          = 380537,
};

template <class AI, class T>
inline AI* GetAzureVaultAI(T* obj)
{
    return GetInstanceAI<AI>(obj, AVScriptName);
}

#define RegisterAzureVaultCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetAzureVaultAI)

#endif
