你能识别目录树吗？这是我现在的目录树，帮我看看合理吗，是否还有改进的地方？
scripts层级的📁Libraries是我引用外部导入的库的地方，这合理吗，我感觉可能会有点怪？
比如说📁PlayerSettings我觉得放在📁Player目录内可能不太合适，可能其他很多地方会调用他。

├─ 📁scripts
│  ├─ 📁Libraries
│  │  ├─ 📁Memory
│  │  │  └─ 📄MemoryUtils.j
│  │  ├─ 📁Utilities
│  │  │  ├─ 📄Alloc.j
│  │  │  ├─ 📄ErrorMessage.j
│  │  │  ├─ 📄GroupUtils.j
│  │  │  ├─ 📄Line Segment Enumeration.j
│  │  │  ├─ 📄Linkedlist.j
│  │  │  ├─ 📄PlayerChatUtils.j
│  │  │  ├─ 📄PlayerUtils.j
│  │  │  ├─ 📄PseudoRandomDistribution.j
│  │  │  ├─ 📄StringUtils.j
│  │  │  ├─ 📄Table.j
│  │  │  ├─ 📄TimerUtils.j
│  │  │  ├─ 📄UnitDex.j
│  │  │  └─ 📄WorldBonuds.j
│  │  ├─ 📄ShockWave.j
│  │  └─ 📄_include
│  ├─ 📁Map
│  │  ├─ 📁GamePlay
│  │  │  ├─ 📁Structures
│  │  │  │  ├─ 📄AntiBackdoor.j
│  │  │  │  ├─ 📄Merchants.j
│  │  │  │  ├─ 📄Raxs.j
│  │  │  │  ├─ 📄Structures.j
│  │  │  │  ├─ 📄Towers.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📄GameEnd.j
│  │  │  └─ 📄_include
│  │  ├─ 📁ObjectBehaviors
│  │  │  ├─ 📁Creeps
│  │  │  │  ├─ 📄Creeps.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁Heroes
│  │  │  │  ├─ 📁Agi
│  │  │  │  │  ├─ 📄AntiMage.j
│  │  │  │  │  ├─ 📄Bloodseeker.j
│  │  │  │  │  ├─ 📄Broodmother.j
│  │  │  │  │  ├─ 📄DrowRanger.j
│  │  │  │  │  ├─ 📄EmberSpirit.j
│  │  │  │  │  ├─ 📄FacelessVoid.j
│  │  │  │  │  ├─ 📄Gyrocopter.j
│  │  │  │  │  ├─ 📄Juggernaut.j
│  │  │  │  │  ├─ 📄Mirana.j
│  │  │  │  │  ├─ 📄Morphling.j
│  │  │  │  │  ├─ 📄NagaSiren.j
│  │  │  │  │  ├─ 📄PhantomLancer.j
│  │  │  │  │  ├─ 📄RiddenHippogryph.j
│  │  │  │  │  ├─ 📄ShadowFiend.j
│  │  │  │  │  ├─ 📄Slark.j
│  │  │  │  │  ├─ 📄Spectre.j
│  │  │  │  │  ├─ 📄Terrorblade.j
│  │  │  │  │  └─ 📄VengefulSpirit.j
│  │  │  │  ├─ 📁Int
│  │  │  │  │  ├─ 📄BaneElemental.j
│  │  │  │  │  ├─ 📄DeathProphet.j
│  │  │  │  │  ├─ 📄Enchantress.j
│  │  │  │  │  ├─ 📄Ezalor.j
│  │  │  │  │  ├─ 📄Invoker.j
│  │  │  │  │  ├─ 📄Lina.j
│  │  │  │  │  ├─ 📄Necrolyte.j
│  │  │  │  │  ├─ 📄ObsidianDestroyer.j
│  │  │  │  │  ├─ 📄OgreMagi.j
│  │  │  │  │  ├─ 📄Puck.j
│  │  │  │  │  ├─ 📄QueenOfPain.j
│  │  │  │  │  ├─ 📄ShadowDemon.j
│  │  │  │  │  ├─ 📄StormSpirit.j
│  │  │  │  │  ├─ 📄TwinHeadDragon.j
│  │  │  │  │  └─ 📄Visage.j
│  │  │  │  ├─ 📁Str
│  │  │  │  │  ├─ 📄Alchemist.j
│  │  │  │  │  ├─ 📄CentaurWarchief.j
│  │  │  │  │  ├─ 📄ChaosKnight.j
│  │  │  │  │  ├─ 📄ChaosKotoBeast.j
│  │  │  │  │  ├─ 📄Clockwerk.j
│  │  │  │  │  ├─ 📄DragonKnight.j
│  │  │  │  │  ├─ 📄Earthshaker.j
│  │  │  │  │  ├─ 📄GoblinShredder.j
│  │  │  │  │  ├─ 📄Kunkka.j
│  │  │  │  │  ├─ 📄Magnus.j
│  │  │  │  │  ├─ 📄Pudge.j
│  │  │  │  │  ├─ 📄Slardar.j
│  │  │  │  │  ├─ 📄TaurenChieftain.j
│  │  │  │  │  ├─ 📄Tidehunter.j
│  │  │  │  │  ├─ 📄Tiny.j
│  │  │  │  │  ├─ 📄TreantProtector.j
│  │  │  │  │  └─ 📄Tuskarr.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁Items
│  │  │  │  ├─ 📄AetherLens.j
│  │  │  │  ├─ 📄DragonLance.j
│  │  │  │  ├─ 📄ForceStaff.j
│  │  │  │  ├─ 📄HeartOfTarrasque.j
│  │  │  │  ├─ 📄HurricanePike.j
│  │  │  │  ├─ 📄KelenDagger.j
│  │  │  │  ├─ 📄OctarineCore.j
│  │  │  │  ├─ 📄TranquilBoots.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📄DamageSystem.j
│  │  │  └─ 📄_include
│  │  ├─ 📁ObjectDefinitions
│  │  │  ├─ 📄ItemDefinitions.j
│  │  │  ├─ 📄ScepterUpgradeDefinitions.j
│  │  │  ├─ 📄SkillDefinitions.j
│  │  │  └─ 📄_include
│  │  ├─ 📁Player
│  │  │  ├─ 📁PlayerSettings
│  │  │  │  ├─ 📁Behaviors
│  │  │  │  │  ├─ 📄DoubleClickSelfCast.j
│  │  │  │  │  └─ 📄_include
│  │  │  │  ├─ 📄PlayerSettings.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁PlayerSystem
│  │  │  │  ├─ 📄PlayerNetWorth.j
│  │  │  │  ├─ 📄PlayerStatus.j
│  │  │  │  ├─ 📄PlayerSystem.j
│  │  │  │  └─ 📄_include
│  │  │  └─ 📄_include
│  │  ├─ 📁UI
│  │  │  ├─ 📁Behaviors
│  │  │  │  ├─ 📄CallCommandButton.j
│  │  │  │  ├─ 📄CommandButtonHelper.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁CoreUI
│  │  │  ├─ 📁GameplayUI
│  │  │  ├─ 📄UIManager.j
│  │  │  └─ 📄_include
│  │  ├─ 📁_CoreSystems
│  │  │  ├─ 📁AbilitySystem
│  │  │  │  ├─ 📄AbilityCustomCastType.j
│  │  │  │  ├─ 📄AbilityCustomOrderId.j
│  │  │  │  ├─ 📄AbilityUtils.j
│  │  │  │  ├─ 📄BuffSystem.j
│  │  │  │  ├─ 📄BuffUtils.j
│  │  │  │  ├─ 📄SpecialPassiveAbility.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁InputSystem
│  │  │  │  ├─ 📄OSKeyConstant.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁ItemSystem
│  │  │  │  ├─ 📄ItemStatus.j
│  │  │  │  ├─ 📄ItemSystem.j
│  │  │  │  ├─ 📄ItemUtils.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁SkillSystem
│  │  │  │  ├─ 📄ScepterUpgrade.j
│  │  │  │  ├─ 📄SkillSystem.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁UISystem
│  │  │  │  ├─ 📄UISystem.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁UnitSystem
│  │  │  │  ├─ 📄UnitAbility.j
│  │  │  │  ├─ 📄UnitIllusion.j
│  │  │  │  ├─ 📄UnitLimitation.j
│  │  │  │  ├─ 📄UnitModel.j
│  │  │  │  ├─ 📄UnitMorph.j
│  │  │  │  ├─ 📄UnitMove.j
│  │  │  │  ├─ 📄UnitOrderConstant.j
│  │  │  │  ├─ 📄UnitRemove.j
│  │  │  │  ├─ 📄UnitStateBonus.j
│  │  │  │  ├─ 📄UnitStatus.j
│  │  │  │  ├─ 📄UnitUpdate.j
│  │  │  │  ├─ 📄UnitUtils.j
│  │  │  │  ├─ 📄UnitWeapon.j
│  │  │  │  ├─ 📄UnitWindWalk.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📁UtilitiesSystem
│  │  │  │  ├─ 📄GroupAlloc.j
│  │  │  │  ├─ 📄Team.j
│  │  │  │  ├─ 📄TriggerDestroyQueue.j
│  │  │  │  └─ 📄_include
│  │  │  ├─ 📄Base.j
│  │  │  ├─ 📄EventSystem.j
│  │  │  └─ 📄_include
│  │  └─ 📄_include 
