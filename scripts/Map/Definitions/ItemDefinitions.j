
// 需求黑市的卷轴合成物品 卷轴是BTNSnazzyScroll 即不能双击快速合成
// 不需求黑市的卷轴合成物品 卷轴是BTNSnazzyScrollPurple
library ItemDefine requires ItemSystem

    function ItemDefine_Init takes nothing returns nothing
        local string s = ""
        call RegisterItem('I0FF', 'I0FG', 0, 0)

        // 魔龙枪
        // Item_DragonLance
        set Item_DragonLance = RegisterItem('I0UB', 'I0UC', 0, 'I0UD')
        set Recipe_HurricanePike = RegisterItem('I0VX', 'I0VY', 'n138', 'I0VZ')
        set Item_HurricanePike = RegisterItem('I0W0', 'I0W1', 0, 'I0W2')
        call ResgiterAbilityMethodSimple('A3SH', "DragonReachOnAdd", "DragonReachOnRemove")
        
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'n12V', 0), Item_DragonLance)

        set Item_Bloodthorn = RegisterItem('I0VJ', 'I0VK', 0, 'I0VL')
        set Recipe_Bloodthorn = RegisterItem('I0VG', 'I0VH', 'h0EU', 'I0VI')

        set it_hyzr = RegisterItem('I0VM', 'I0VN', 0, 'I0VO')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'n134', 0), it_hyzr)
        // it_jys
        set it_jys = RegisterItem('I0RC', 'I0RD', 'n139', 0)
        set it_fj = RegisterItem('IZPS', 'IZPD', 0, 'IZPE')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'n125', 0), it_fj)//否决一键购买
    
        set Recipe_AetherLens = RegisterItem('I0V3', 'I0V4', 'n12W', 'I0V5')
        set Item_AetherLens   = RegisterItem('I0UE', 'I0UF',     0, 'I0UG')
        call RegisterItemMethodSimple(Item_AetherLens, "ItemAetherLensOnPickup", "ItemAetherLensOnDrop")
        
        set XMV = RegisterItem('I02Q', 'I02O', 'h011', 'I00A')
        set XPV = RegisterItem('I02S', 'I02P', 'h012', 'I0CA')
        set XQV = RegisterItem('I02N', 'I02R', 'h013', 'I0CS')
        set XSV = RegisterItem('I02X', 'I02Y', 'h015', 'I0D4')
        set XTV = RegisterItem('I02Z', 'I043', 'h016', 'I0CV')
        set XUV = RegisterItem('I030', 'I044', 'h017', 'I0D2')
        set XWV = RegisterItem('I031', 'I045', 'h018', 'I0D5')
        set XYV = RegisterItem('I032', 'I046', 'h019', 'I0CZ')
        set XZV = RegisterItem('I033', 'I047', 'h01A', 'I0D7')
        set X_V = RegisterItem('I034', 'I048', 'h01B', 'I0CX')
        set X0V = RegisterItem('I035', 'I049', 'h01C', 'I0CI')
        set X1V = RegisterItem('I036', 'I04A', 'h01D', 'I0CH')
        set X2V = RegisterItem('I037', 'I04B', 'h01E', 'I0CR')
        set X3V = RegisterItem('I038', 'I04C', 'h01F', 'I0CJ')

        // 宝石
        set ITem_GemOfTrueSight = RegisterItem('I039', 'I04D', 'h01G', 'I0DG')
        set ITem_GemOfTrueSight_CourierEdition = RegisterItem('I0MS', 'I0MR', 0, 'I0MT')

        set X6V = RegisterItem('I03B', 'I04E', 'h01H', 'I0DA')
        set X7V = RegisterItem('I03C', 'I04F', 'h01I', 'I0CQ')
        set Item_IronwoodBranch = RegisterItem('I03D', 'I04G', 'h01J', 'I0CU')

        // 跳刀
        set Item_KelenDagger = RegisterItem('I03E', 'I04H', 'h01K', 'I0C7')
        set Item_DisabledKelenDagger = RegisterItem('I03E', 'I04I', 'h01K', 'I0DH')
        call RegisterItemMethodSimple(Item_KelenDagger, "ItemKelenDaggerOnPickup", "ItemKelenDaggerOnDrop")
        call RegisterItemMethodSimple(Item_DisabledKelenDagger, "ItemKelenDaggerOnPickup", "ItemKelenDaggerOnDrop")

        set OEV = RegisterItem('I03F', 'I04J', 'h01L', 'I0CM')
        set OXV = RegisterItem('I03G', 'I04K', 'h01M', 'I0CD')
        set OOV = RegisterItem('I03H', 'I04L', 'h01N', 'I0CG')
        set ORV = RegisterItem('I03I', 'I04M', 'h01O', 'I0D0')
        set OIV = RegisterItem('I03J', 'I04N', 'h01P', 'I0CN')
        set OAV = RegisterItem('I03K', 'I04O', 'h01Q', 'I0D8')
        set ONV = RegisterItem('I03L', 'I04P', 'h01R', 'I0CE')
        set OBV = RegisterItem('I03M', 'I04Q', 'h01S', 'I0DB')
        set OCV = RegisterItem('I03N', 'I04R', 'h01T', 'I0CL')
        set ODV = RegisterItem('I03P', 'I04S', 'h01U', 'I0CY')
        set OFV = RegisterItem('I03Q', 'I04T', 'h01V', 'I0DI')
        set OGV = RegisterItem('I03R', 'I04U', 'h01W', 'I0CW')
        set OHV = RegisterItem('I03S', 'I04V', 'h01X', 'I0DJ')
        set OJV = RegisterItem('I03T', 'I04W', 'h01Y', 'I0CP')
        set OKV = RegisterItem('I03U', 'I04X', 'h01Z', 'I0CC')
        set OLV = RegisterItem('I03V', 'I04Y', 'h020', 'I0C5')
        set OMV = RegisterItem('I03W', 'I04Z', 'h021', 'I0DK')
        set OPV = RegisterItem('I03X', 'I050', 'h022', 'I0D1')
        set OQV = RegisterItem('I03A', 'I051', 'h023', 'I0D9')
        set OSV = RegisterItem('I0KB', 'I0KA', 0, 'I0KC')
        set OTV = RegisterItem('I03Y', 'I052', 'h024', 'I0C9')
        set OUV = RegisterItem('I03Z', 'I053', 'h025', 'I0CK')
        set OWV = RegisterItem('I040', 'I054', 'h026', 'I0DL')
        set OYV = RegisterItem('I041', 'I055', 'h027', 'I0D6')
        set OZV = RegisterItem('I00L', 'I0AV', 'h02B', 0)
        set O_V = RegisterItem('I05E', 'I0AM', 0, 'I0DN')
        set O0V = RegisterItem('I0AU', 'I0AN', 0, 'I0DO')
        set O1V = RegisterItem('I0AS', 'I0AO', 0, 'I0DP')
        set O2V = RegisterItem('I0AT', 'I0AP', 0, 'I0DQ')
        set O7V = RegisterItem('I0GW', 'I0GY', 0, 'I0H3')
        set O6V = RegisterItem('I0H2', 'I0GX', 0, 'I0DR')
        set O5V = RegisterItem('I0GV', 'I0H1', 0, 'I0H4')
        set O8V = RegisterItem('I0Q8', 'I0Q7', 0, 'I0Q9')
        set O4V = RegisterItem('I0AR', 'I0H0', 0, 'I0H6')
        set O3V = RegisterItem('I0AQ', 'I0GZ', 0, 'I0H5')
        set Item_MagicStick = RegisterItem('I0GD', 'I0GC', 'h074', 'I0GE')
        set Item_MagicWand = RegisterItem('I0HC', 'I0HB', 0, 'I0HA')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h07S', 0), Item_MagicWand)
        set RVV = RegisterItem('I0HT', 'I0HR', 'h07W', 'I0HV')
        set REV = RegisterItem('I0HU', 'I0HP', 0, 'I0HW')
        set RXV = RegisterItem('I0J7', 'I0J6', 'h083', 'I0J8')
        set NTV = RegisterItem('I0JJ', 'I0JI', 'h087', 'I0JK')
        set XKV = RegisterItem('I0MA', 'I0M9', 'h0CM', 'I0MB')
        set XLV = RegisterItem('I0MD', 'I0ME', 0, 'I0MC')
        set Item_AncientTangoOfEssifation = RegisterItem('I057', 'I05C', 'h02A', 'ITGB')
        set XHV = RegisterItem('I0QI', 'I0QH', 0, 'I0QJ')
        set XJV = RegisterItem('I0QL', 'I0QK', 'ho02', 'I0QM')
        set R1V = RegisterItem('INTD', 'INTG', 0, 0)
        set RYV = RegisterItem('I042', 'I05D', 'h028', 'INCP')
        set RZV = RegisterItem('I0HO', 'I0HN', 'h07V', 0)
        set R_V = RegisterItem('I056', 'I05F', 'h029', 'INHS')
        set R2V = RegisterItem('I058', 'I05G', 'h02C', 0)
        set Item_SentryWard = RegisterItem('I059', 'I05H', 'h02D', 0)
        set R4V = RegisterItem('I05A', 'I05I', 'h02E', 0)
        set R5V = RegisterItem('I05B', 'I05J', 'h02F', 0)
        set R6V = RegisterItem('I0B0', 'I0B1', 0, 0)
        set R7V = RegisterItem('I0TC', 'I0TD', 0, 0)
        set Item_DustOfAppearance = RegisterItem('I0GI', 'I0GH', 'h076', 0)
        set R9V = RegisterItem('I0KT', 'I0KS', 'h0B9', 0)
        set IVV = RegisterItem('I0NF', 'I0NG', 'h0D3', 0)
        set IEV = RegisterItem('I061', 'I062', 0, 'I01J')
        set IXV = RegisterItem('I064', 'I063', 0, 'I01K')
        set IOV = RegisterItem('I065', 'I066', 0, 'I01L')
        set IRV = RegisterItem('I068', 'I067', 0, 'I01M')
        set IIV = RegisterItem('I069', 'I06A', 0, 'I0C6')
        set IAV = RegisterItem('I06C', 'I06B', 0, 'I01P')
        set IBV = RegisterItem('I03O', 'I02T', 0, 'I01R')
        set ICV = RegisterItem('I02U', 'I05Y', 0, 'I01Q')
        set IDV = RegisterItem('I060', 'I05Z', 0, 'I01S')
        set IFV = RegisterItem('I06E', 'I06D', 0, 'I01T')
        set IGV = RegisterItem('I0NO', 'I0NN', 0, 'I0NP')
        set IHV = RegisterItem('I06G', 'I06F', 0, 'I01U')
        set IJV = RegisterItem('I06I', 'I06H', 0, 'I01V')
        set IKV = RegisterItem('I06K', 'I06J', 0, 'I01W')
        set ILV = RegisterItem('I06M', 'I06L', 0, 'I01X')
        set IMV = RegisterItem('I08F', 'I08G', 0, 'I01Y')
        set IPV = RegisterItem('I08I', 'I08H', 0, 'I01Z')
        set IQV = RegisterItem('I08J', 'I08K', 0, 'I020')
        set ISV = RegisterItem('I08N', 'I08O', 0, 'I021')
        set ITV = RegisterItem('I08Q', 'I08P', 0, 'I022')
        set IUV = RegisterItem('I08S', 'I08R', 0, 'I023')
        set IWV = RegisterItem('I0JB', 'I0J9', 0, 'I0JD')
        set IYV = RegisterItem('I0EW', 'I0EV', 0, 'I0EX')
        set IZV = RegisterItem('I0JC', 'I0JA', 0, 'I0JE')
        set I_V = RegisterItem('I08U', 'I08T', 0, 'I024')
        set I0V = RegisterItem('I08W', 'I08V', 0, 'I0CO')
        set I1V = RegisterItem('I08X', 'I08Y', 0, 'I025')
        set Item_EulScepterOfDivinity = RegisterItem('I090', 'I08Z', 0, 'I026')
        set I3V = RegisterItem('I092', 'I091', 0, 'I027')
        set I4V = RegisterItem('I094', 'I093', 0, 'I028')
        set I5V = RegisterItem('I096', 'I095', 0, 'I029')
        set I6V = RegisterItem('I098', 'I097', 0, 'I02A')
        set I7V = RegisterItem('I09A', 'I099', 0, 'I02B')
        set I8V = RegisterItem('I09B', 'I09C', 0, 'I02C')
        // BKB 6 种
        set I9V = RegisterItem('I0G2', 'I0FZ', 0, 'I0G8') // 10
        set AVV = RegisterItem('I0G6', 'I0G0', 0, 'I0G9') // 9
        set AEV = RegisterItem('I09E', 'I0FY', 0, 'I0G7') // 8
        set AXV = RegisterItem('I0G5', 'I0FS', 0, 'I02D') // 7
        set AOV = RegisterItem('I0G3', 'I09D', 0, 'I0GB') // 6
        set ARV = RegisterItem('I0G4', 'I0G1', 0, 'I0GA') // 5
        set AIV = RegisterItem('I0AX', 'I0AW', 0, 0)
        set AAV = RegisterItem('I0TE', 'I0TF', 0, 0)
        set ANV = RegisterItem('I09G', 'I09F', 0, 'I02E')	// 近战分身斧
        set ABV = RegisterItem('I0MV', 'I0MU', 0, 'I0MW')	// 远程分身斧
        set ACV = RegisterItem('I09I', 'I09H', 0, 'I02F')
        set ADV = RegisterItem('I09K', 'I09M', 0, 'I01G') // 1
        set AFV = RegisterItem('I09J', 'I09P', 0, 'I02G') // 2
        set AGV = RegisterItem('I09Q', 'I09N', 0, 'I0DC') // 3
        set AHV = RegisterItem('I09S', 'I09O', 0, 'I0DD') // 4
        set AJV = RegisterItem('I09R', 'I09L', 0, 'I0D3') // 5级大根
        set AKV = RegisterItem('I09U', 'I09T', 0, 'I02H')
        set ALV = RegisterItem('I09V', 'I09X', 0, 'I02I')
        set AMV = RegisterItem('I09W', 'I09Y', 0, 'I02J')
        set Item_LinkenSphere = RegisterItem('I0A0', 'I09Z', 0, 'I0BO')
        set AQV = RegisterItem('I0HK', 'I0HJ', 0, 'I0HL')

        // 自己的圣剑 Item_DivineRapier
        set ASV = RegisterItem('I0A2', 'I0A1', 0, 'I0BP')
        // 被人捡过的圣剑
        set ATV = RegisterItem('I0LI', 'I0LJ', 0, 'I0LK')

        set AUV = RegisterItem('I0A4', 'I0A3', 0, 'I0BQ')
        set AWV = RegisterItem('I0A6', 'I0A5', 0, 'I0BR')
        set AYV = RegisterItem('I0K8', 'I0K7', 0, 'I0K9')
        set AZV = RegisterItem('I0A7', 'I0A8', 0, 'I0BS')
        set A_V = RegisterItem('I0KQ', 'I0KP', 0, 'I0KR')

        // 龙心
        set Item_HeartOfTarrasque = RegisterItem('I0AA', 'I0A9', 0, 'I0BT')
        set Item_DisabledHeartOfTarrasque = RegisterItem('I0AA', 'I0KL', 0, 'I0KM')
        call RegisterItemMethodSimple(Item_HeartOfTarrasque, "ItemHeartOfTarrasqueOnPickup", "ItemHeartOfTarrasqueOnDrop")
        call RegisterItemMethodSimple(Item_DisabledHeartOfTarrasque, "ItemHeartOfTarrasqueOnPickup", "ItemHeartOfTarrasqueOnDrop")
        
        set A2V = RegisterItem('I0AC', 'I0AB', 0, 'I0BU')
        set A3V = RegisterItem('I0AD', 'I0AE', 0, 'I0BV')
        set A4V = RegisterItem('I0AG', 'I0AF', 0, 'I0CT')
        set Item_TheButterfly = RegisterItem('I0AH', 'I0AI', 0, 'I0BW')
        
        // 基础 Item_AghanimScepterBasic
        set Item_AghanimScepterBasic = RegisterItem('I0B8', 'I0AY', 0, 'I00B')
        // 通用的 Item_AghanimScepter
        set Item_AghanimScepter = RegisterItem('I0QT', 'I0QS', 0, 'I0QU')
        call RegisterItemMethodSimple(Item_AghanimScepter, "ItemAghanimScepterOnPickup", "ItemAghanimScepterOnDrop")
        // 炼金的 Item_AghanimScepterGiftable
        set Item_AghanimScepterGiftable = RegisterItem('I0QT', 'I0TB', 0, 'I0QU')

        // FastCombine_AghanimScepterBasic
        set FastCombine_AghanimScepterBasic = RegisterItem(0, 0, 'h03K', 0)
        call SaveInteger(HY, 'ITDB', FastCombine_AghanimScepterBasic, Item_AghanimScepterBasic)
        
        //  set Recipe_AetherLens = RegisterItem('I0V3', 'I0V4', 'n12W', 'I0V5')

        // Recipe_AghanimBlessing
        set Recipe_AghanimBlessing = RegisterItem('I0VD', 'I0VE', 'h0EQ', 'I0VF')
        // 阿哈利姆 Item_AghanimBlessing
        set Item_AghanimBlessing   = RegisterItem('I0V6', 'I0V7', 0, 'I0V8')
        call RegisterItemPuckupMethodByIndex(Item_AghanimBlessing, "ItemAghanimBlessingOnPickup")
  
        set A6V = RegisterItem('I0AK', 'I0AJ', 0, 'I0BX')
        set A7V = RegisterItem('I07K', 'I0AL', 0, 'I0BY')
        set A8V = RegisterItem('I0BB', 'I0BA', 0, 'I0BZ')
        set A9V = RegisterItem('I0LE', 'I0LC', 0, 'I0LD')
        set NVV = RegisterItem('I0BC', 'I0BD', 0, 'I00C')
        set NEV = RegisterItem('I0BF', 'I0BE', 0, 'I0C0')
        set NXV = RegisterItem('I014', 'I01D', 0, 0)
        set NOV = RegisterItem('I0BH', 'I0BG', 0, 'I0C1')
        set NRV = RegisterItem('I0BI', 'I0BJ', 0, 'I0C2')
        set NIV = RegisterItem('I0BL', 'I0BK', 0, 'I0C3')
        set NNV = RegisterItem('I0BN', 'I0BM', 0, 'I0C4')
        set NBV = RegisterItem('I00S', 'I00M', 0, 'I01C')
        set NCV = RegisterItem('I00T', 'I00Q', 0, 'I01E')
        set NDV = RegisterItem('I00V', 'I00N', 0, 'I01F')
        set NFV = RegisterItem('I00W', 'I00R', 0, 'I0DE')
        set NGV = RegisterItem('I00X', 'I00Z', 0, 'I0CF')
        set NHV = RegisterItem('I00Y', 'I010', 0, 'I0DF')
        set NJV = RegisterItem('I013', 'I012', 0, 'I0CB')
        set NKV = RegisterItem('I0GK', 'I0GJ', 0, 'I0GL')
        set NMV = RegisterItem('I0HG', 'I0HI', 0, 'I0HH')
        set NPV = RegisterItem('I0I0', 'I0K6', 0, 'I0I2')
        set NQV = RegisterItem('I0JG', 'I0JF', 0, 'I0JH')
        set NSV = RegisterItem('I0KD', 'I0KF', 0, 'I0KE')
        set NUV = RegisterItem('I0KX', 'I0KY', 0, 'I0KZ')
        set NWV = RegisterItem('I0LG', 'I0LF', 0, 'I0LH')
        set NYV = RegisterItem('I0LP', 'I0LL', 0, 'I0LQ')
        set ROV = RegisterItem('I0LR', 'I0LT', 0, 'I0LS')
        set NZV = RegisterItem('I0MJ', 'I0MI', 0, 'I0MK')
        set N_V = RegisterItem('I0N1', 'I0N0', 0, 'I0N2')
        set RRV = RegisterItem('I0ND', 'I0NE', 0, 'I0NC')
        set RIV = RegisterItem('I0NL', 'I0NK', 0, 'I0NM')
        set N0V = RegisterItem('I0O2', 'I0O3', 0, 'I0O4')
        set RAV = RegisterItem('I0OC', 'I0OE', 0, 'I0OD')

        // 绿鞋
        set Item_TranquilBoots = RegisterItem('I0OF', 'I0OG', 0, 'I0OH')
        set Item_DisabledTranquilBoots = RegisterItem('I0OJ', 'I0OI', 0, 'I0OK')
        call RegisterItemMethodSimple(Item_TranquilBoots, "ItemTranquilBootsOnPickup", "ItemTranquilBootsOnDrop")
        call RegisterItemMethodSimple(Item_DisabledTranquilBoots, "ItemTranquilBootsOnPickup", "ItemTranquilBootsOnDrop")

        set RCV = RegisterItem('I0OM', 'I0OL', 0, 'I0ON')
        set Item_MoonShard = RegisterItem('I0SI', 'I0SJ', 0, 'I0SK')
        set Item_OctarineCore = RegisterItem('I0SU', 'I0SV', 0, 'I0SW')
        call RegisterItemMethodSimple(Item_OctarineCore, "ItemOctarineCoreOnPickup", "ItemOctarineCoreOnDrop")
        
        set RLV = RegisterItem('I0SL', 'I0SM', 0, 'I0SN')
        set RJV = RegisterItem('I0SR', 'I0SS', 0, 'I0ST')
        set RGV = RegisterItem('I0T5', 'I0T6', 0, 'I0T7')
        set RPV = RegisterItem('I0S6', 'I0S7', 'n12A', 'I0S8')
        set RTV = RegisterItem('I0SC', 'I0SD', 0, 'I0SE')
        set RQV = RegisterItem('I0S9', 'I0SA', 0, 'I0SB')
        set INV = RegisterItem('I0SZ', 'I0T0', 0, 'I0T1')
        set XGV = RegisterItem('I0P9', 'I0PB', 'h0EI', 'I0PA')
        set N1V = RegisterItem('I0OU', 'I0OV', 0, 'I0OW')
        set N2V = RegisterItem('I0OY', 'I0OX', 0, 'I0OZ')
        set RUV = RegisterItem('I0P0', 'I0P1', 0, 'I0P2')
        set RWV = RegisterItem('I0P3', 'I0P4', 0, 'I0P5')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02G', 0), IEV)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h086', 0), NQV)
        set s = "ReplaceableTextures\\CommandButtons\\BTNSnazzyScroll.blp"
        set RKV = RegisterItem(0, 0, 'h0DY', 0)
        set RHV = RegisterItem('I0T2', 'I0T3', 'n12H', 'I0T4')
        set RMV = RegisterItem('I0SO', 'I0SP', 'n12D', 'I0SQ')
        set RSV = RegisterItem('I0SF', 'I0SG', 'n12C', 'I0SH')
        set N3V = RegisterItem('I05L', 'I05R', 'h02H', 'I0DS')
        set N4V = RegisterItem('I05M', 'I05S', 'h02I', 'I0DT')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02J', 0), IIV)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h014', 0), IBV)
        set N5V = RegisterItem('I05O', 'I05T', 'h02K', 'I0DU')
        set N6V = RegisterItem('I05P', 'I05U', 'h02L', 'I0DW')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02M', 0), IHV)
        set N7V = RegisterItem('I05K', 'I05V', 'h02N', 'I0DX')
        set N8V = RegisterItem('I05N', 'I05W', 'h02O', 'I0DY')
        set N9V = RegisterItem('I05Q', 'I05X', 'h02P', 'I0DZ')
        set BVV = RegisterItem('I06N', 'I06O', 'h02Q', 'I0E0')
        set BEV = RegisterItem('I06Q', 'I06P', 'h02R', 'I0E1')
        set BXV = RegisterItem('I06R', 'I06S', 'h02S', 'I0E2')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02T', 0), ISV)
        set BOV = RegisterItem('I06W', 'I06V', 'h02U', 'I0E4')
        set BRV = RegisterItem('I06X', 'I06Y', 'h02V', 'I0E5')
        //	set BIV = RegisterItem('I070', 'I06Z', 'h02X', 'I0E6')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02W', 0), I_V)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h02X', 0), I1V) //疯脸
        set BAV = RegisterItem('I071', 'I072', 'h02Y', 'I0E7')
        call RegisterItem(0, 0, 'h02Z', 0)
        set BNV = RegisterItem('I074', 'I073', 'h030', 'I0E8')
        set BBV = RegisterItem(0, 0, 'h031', 0)
        call SaveInteger(HY, 'ITDB', BBV, I5V)
        set BCV = RegisterItem('I076', 'I07V', 'h032', 'I0EA')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h033', 0), I7V)
    
    
        set BDV = RegisterItem('I077', 'I07W', 'h034', 'I0EB')
        // 黑皇杖
        set BFV = RegisterItem('I078', 'I07X', 'h035', 'I0EC')
        
        set BGV = RegisterItem('I079', 'I07Y', 'h036', 'I0ED')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h037', 0), ACV)
        set BHV = RegisterItem('I07B', 'I080', 'h038', 'I0EF')
        set BJV = RegisterItem('I07C', 'I081', 'h039', 'I0EG')
        set BKV = RegisterItem('I07D', 'I082', 'h03A', 'I0EH')
        call RegisterItem(0, 0, 'h03C', 0)
        set BLV = RegisterItem('I07E', 'I083', 'h03D', 'I0EI')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h03E', 0), AWV)
        set BMV = RegisterItem('I07G', 'I07F', 'h03F', 'I0EJ')
        set BPV = RegisterItem('I07H', 'I084', 'h03G', 'I0EK')
        set BQV = RegisterItem('I07O', 'I085', 'h03H', 'I0EL')
        set BSV = RegisterItem('I07J', 'I088', 'h03L', 'I0EO')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h03M', 0), A7V)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h03N', 0), A8V)
        set BTV = RegisterItem('I07M', 'I089', 'h03O', 'I0EP')
        set BUV = RegisterItem('I07P', 'I08A', 'h03Q', 'I0EQ')
        set BWV = RegisterItem('I07Q', 'I08B', 'h03R', 'I0ER')
        set BYV = RegisterItem('I07R', 'I08C', 'h03S', 'I0ES')
        set NAV = RegisterItem('I0QQ', 'I0QN', 'h03T', 'I0QR')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h03U', 0), NNV)
        set BZV = RegisterItem('I07S', 'I08D', 'h03V', 'I0ET')
        set B_V = RegisterItem('I07T', 'I08E', 'h03W', 'I0EU')
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h079', 0), NKV)
        set B0V = RegisterItem('I0HD', 'I0HF', 'h07T', 'I0HE')
        set B1V = RegisterItem('I0HX', 'I0HZ', 'h07X', 'I0HY')
        set B3V = RegisterItem('I07L', 'I0KN', 'h03P', 'I0KO')
        set B4V = RegisterItem('I0KW', 'I0KV', 'h0BA', 'I0KU')
        set B5V = RegisterItem('I0LM', 'I0LN', 'h0BQ', 'I0LO')
        set B6V = RegisterItem('I0N9', 'I0NA', 'h0D1', 'I0NB')
        set B7V = RegisterItem('I0NH', 'I0NI', 'h0CY', 'I0NJ')
        set B8V = RegisterItem('I0O5', 'I0O6', 'h0DD', 'I0O7')
        set B9V = RegisterItem('I0OB', 'I0OA', 'h03X', 'I0O9')
        // 快速合成的展示物品?
        set CVV = RegisterItem(0, 0, 'h0DU', 0)
        call SaveInteger(HY, 'ITDB', CVV, Item_TranquilBoots)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h0E9', 0), N1V)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h0DV', 0), RCV)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h0EN', 0), RQV)
        // 依赖黑市?
        call RegisterItem(0, 0, 'h0EA', 0)
        call SaveInteger(HY, 'ITDB', RegisterItem(0, 0, 'h0EC', 0), RWV)

        // 边路野店卖的版本
        set ItemSideLaneShopId[RegisterItem('I03A', 'I051', 'h08K', 'I0D9')] = OQV
        set ItemSideLaneShopId[RegisterItem('I03Y', 'I052', 'h08X', 'I0C9')] = OTV
        set ItemSideLaneShopId[RegisterItem('I02S', 'I02P', 'h08S', 'I0CA')] = XPV
        set ItemSideLaneShopId[RegisterItem('I02N', 'I02R', 'h08P', 'I0CS')] = XQV
        set ItemSideLaneShopId[RegisterItem('I02Z', 'I043', 'h08Q', 'I0CV')] = XTV
        set ItemSideLaneShopId[RegisterItem('I031', 'I045', 'h08T', 'I0D5')] = XWV
        set ItemSideLaneShopId[RegisterItem('I03B', 'I04E', 'h08N', 'I0DA')] = X6V
        set ItemSideLaneShopId[RegisterItem('I03E', 'I04H', 'h08W', 'I0C7')] = Item_KelenDagger
        set ItemSideLaneShopId[RegisterItem('I03G', 'I04K', 'h08O', 'I0CD')] = OXV
        set ItemSideLaneShopId[RegisterItem('I03P', 'I04S', 'h08U', 'I0CY')] = ODV
        set ItemSideLaneShopId[RegisterItem('I03Q', 'I04T', 'h08G', 'I0DI')] = OFV
        set ItemSideLaneShopId[RegisterItem('I03S', 'I04V', 'h08L', 'I0DJ')] = OHV
        set ItemSideLaneShopId[RegisterItem('I03T', 'I04W', 'h08R', 'I0CP')] = OJV
        set ItemSideLaneShopId[RegisterItem('I03V', 'I04Y', 'h08E', 'I0C5')] = OLV
        set ItemSideLaneShopId[RegisterItem('I03W', 'I04Z', 'h08J', 'I0DK')] = OMV
        set ItemSideLaneShopId[RegisterItem('I0GD', 'I0GC', 'h08I', 'I0GE')] = Item_MagicStick
        set ItemSideLaneShopId[RegisterItem('I0HT', 'I0HR', 'h08F', 'I0HW')] = RVV
        set ItemSideLaneShopId[RegisterItem('I0J7', 'I0J6', 'h08V', 'I0J8')] = RXV
        set ItemSideLaneShopId[RegisterItem('I040', 'I054', 'h08M', 'I0DL')] = OWV
        set ItemSideLaneShopId[RegisterItem('I05A', 'I05I', 'h08H', 0)]    = R4V
        set ItemSideLaneShopId[RegisterItem('I037', 'I04B', 'h093', 'I0CR')] = X2V
        set ItemSideLaneShopId[RegisterItem('I02Q', 'I02O', 'h0BO', 'I00A')] = XMV
        set ItemSideLaneShopId[RegisterItem('I0MA', 'I0M9', 'h0CN', 'I0MB')] = XKV
        set ItemSideLaneShopId[RegisterItem('I033', 'I047', 'h0D0', 'I0D7')] = XZV
        set ItemSideLaneShopId[RegisterItem('I032', 'I046', 'u025', 'I0CZ')] = XYV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OFV
        set CombineIndex2[CombineMaxIndex] = OWV
        set CombinedIndex[CombineMaxIndex] = IEV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IEV
        set CombineIndex2[CombineMaxIndex] = XZV
        set CombineIndex3[CombineMaxIndex] = RHV
        set CombineIndex4[CombineMaxIndex] = XZV
        set CombinedIndex[CombineMaxIndex] = RGV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X7V
        set CombineIndex2[CombineMaxIndex] = X7V
        set CombinedIndex[CombineMaxIndex] = Item_MoonShard
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ONV
        set CombineIndex2[CombineMaxIndex] = XGV
        set CombinedIndex[CombineMaxIndex] = RQV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = N_V
        set CombineIndex2[CombineMaxIndex] = RXV
        set CombinedIndex[CombineMaxIndex] = RJV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OHV
        set CombineIndex2[CombineMaxIndex] = Item_IronwoodBranch
        set CombineIndex3[CombineMaxIndex] = N3V
        set CombinedIndex[CombineMaxIndex] = IXV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XZV
        set CombineIndex2[CombineMaxIndex] = Item_IronwoodBranch
        set CombineIndex3[CombineMaxIndex] = N4V
        set CombinedIndex[CombineMaxIndex] = IOV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OGV
        set CombineIndex2[CombineMaxIndex] = OMV
        set CombinedIndex[CombineMaxIndex] = IIV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = N5V
        set CombinedIndex[CombineMaxIndex] = IAV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IAV
        set CombineIndex2[CombineMaxIndex] = N5V
        set CombinedIndex[CombineMaxIndex] = INV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = I3V
        set CombineIndex2[CombineMaxIndex] = OIV
        set CombinedIndex[CombineMaxIndex] = Item_OctarineCore
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = XQV
        set CombineIndex3[CombineMaxIndex] = XPV
        set CombinedIndex[CombineMaxIndex] = IBV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = XTV
        set CombineIndex3[CombineMaxIndex] = XPV
        set CombinedIndex[CombineMaxIndex] = ICV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = OJV
        set CombineIndex3[CombineMaxIndex] = XPV
        set CombinedIndex[CombineMaxIndex] = IDV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XPV
        set CombineIndex2[CombineMaxIndex] = N6V
        set CombinedIndex[CombineMaxIndex] = IFV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ODV
        set CombineIndex2[CombineMaxIndex] = OJV
        set CombineIndex3[CombineMaxIndex] = OMV
        set CombinedIndex[CombineMaxIndex] = IHV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XSV
        set CombineIndex2[CombineMaxIndex] = X3V
        set CombineIndex3[CombineMaxIndex] = N7V
        set CombinedIndex[CombineMaxIndex] = IJV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XSV
        set CombineIndex2[CombineMaxIndex] = OLV
        set CombineIndex3[CombineMaxIndex] = N8V
        set CombinedIndex[CombineMaxIndex] = IKV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XSV
        set CombineIndex2[CombineMaxIndex] = OEV
        set CombineIndex3[CombineMaxIndex] = N9V
        set CombinedIndex[CombineMaxIndex] = ILV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XUV
        set CombineIndex2[CombineMaxIndex] = XQV
        set CombineIndex3[CombineMaxIndex] = BVV
        set CombinedIndex[CombineMaxIndex] = IMV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OAV
        set CombineIndex2[CombineMaxIndex] = XTV
        set CombineIndex3[CombineMaxIndex] = BEV
        set CombinedIndex[CombineMaxIndex] = IPV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OYV
        set CombineIndex2[CombineMaxIndex] = XTV
        set CombineIndex3[CombineMaxIndex] = BXV
        set CombinedIndex[CombineMaxIndex] = IQV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ACV	//大隐刀
        set CombineIndex2[CombineMaxIndex] = IPV
        set CombineIndex3[CombineMaxIndex] = RMV
        set CombinedIndex[CombineMaxIndex] = RLV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = I4V
        set CombineIndex2[CombineMaxIndex] = NZV
        set CombineIndex3[CombineMaxIndex] = RSV
        set CombinedIndex[CombineMaxIndex] = RTV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XYV
        set CombineIndex2[CombineMaxIndex] = XZV
        set CombineIndex3[CombineMaxIndex] = OJV
        set CombinedIndex[CombineMaxIndex] = ISV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ORV
        set CombineIndex2[CombineMaxIndex] = XPV
        set CombineIndex3[CombineMaxIndex] = BOV
        set CombinedIndex[CombineMaxIndex] = ITV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XUV
        set CombineIndex2[CombineMaxIndex] = XUV
        set CombineIndex3[CombineMaxIndex] = OJV
        set CombineIndex4[CombineMaxIndex] = BRV
        set CombinedIndex[CombineMaxIndex] = IUV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IUV
        set CombineIndex2[CombineMaxIndex] = BRV
        set CombinedIndex[CombineMaxIndex] = IWV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IYV
        set CombineIndex2[CombineMaxIndex] = BRV
        set CombinedIndex[CombineMaxIndex] = IWV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X6V
        set CombineIndex2[CombineMaxIndex] = OXV
        set CombinedIndex[CombineMaxIndex] = I_V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OXV
        set CombineIndex2[CombineMaxIndex] = ODV
        set CombinedIndex[CombineMaxIndex] = I1V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OMV
        set CombineIndex2[CombineMaxIndex] = OPV
        set CombineIndex3[CombineMaxIndex] = OWV
        set CombineIndex4[CombineMaxIndex] = BAV
        set CombinedIndex[CombineMaxIndex] = Item_EulScepterOfDivinity
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OCV
        set CombineIndex2[CombineMaxIndex] = X2V
        set CombineIndex3[CombineMaxIndex] = OUV
        set CombinedIndex[CombineMaxIndex] = I3V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IXV
        set CombineIndex2[CombineMaxIndex] = IOV
        set CombineIndex3[CombineMaxIndex] = BNV
        set CombinedIndex[CombineMaxIndex] = I4V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IPV
        set CombineIndex2[CombineMaxIndex] = IMV
        set CombinedIndex[CombineMaxIndex] = I5V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ORV
        set CombineIndex2[CombineMaxIndex] = ORV
        set CombineIndex3[CombineMaxIndex] = BCV
        set CombinedIndex[CombineMaxIndex] = I6V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IEV
        set CombineIndex2[CombineMaxIndex] = XYV
        set CombineIndex3[CombineMaxIndex] = X_V
        set CombineIndex4[CombineMaxIndex] = RVV
        set CombinedIndex[CombineMaxIndex] = I7V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IEV
        set CombineIndex2[CombineMaxIndex] = XYV
        set CombineIndex3[CombineMaxIndex] = X_V
        set CombineIndex4[CombineMaxIndex] = REV
        set CombinedIndex[CombineMaxIndex] = I7V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XWV
        set CombineIndex2[CombineMaxIndex] = XYV
        set CombineIndex3[CombineMaxIndex] = BDV
        set CombinedIndex[CombineMaxIndex] = I8V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ORV
        set CombineIndex2[CombineMaxIndex] = OAV
        set CombineIndex3[CombineMaxIndex] = BFV
        set CombinedIndex[CombineMaxIndex] = I9V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IMV
        set CombineIndex2[CombineMaxIndex] = OTV
        set CombineIndex3[CombineMaxIndex] = BGV
        set CombinedIndex[CombineMaxIndex] = ABV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XGV
        set CombineIndex2[CombineMaxIndex] = X_V
        set CombinedIndex[CombineMaxIndex] = ACV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OPV
        set CombineIndex2[CombineMaxIndex] = ILV
        set CombineIndex3[CombineMaxIndex] = BHV
        set CombinedIndex[CombineMaxIndex] = ADV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ADV
        set CombineIndex2[CombineMaxIndex] = BHV
        set CombinedIndex[CombineMaxIndex] = AFV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = AFV
        set CombineIndex2[CombineMaxIndex] = BHV
        set CombinedIndex[CombineMaxIndex] = AGV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = AGV
        set CombineIndex2[CombineMaxIndex] = BHV
        set CombinedIndex[CombineMaxIndex] = AHV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = AHV
        set CombineIndex2[CombineMaxIndex] = BHV
        set CombinedIndex[CombineMaxIndex] = AJV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OPV
        set CombineIndex2[CombineMaxIndex] = XTV
        set CombineIndex3[CombineMaxIndex] = BJV
        set CombinedIndex[CombineMaxIndex] = AKV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = AKV
        set CombineIndex2[CombineMaxIndex] = BJV
        set CombinedIndex[CombineMaxIndex] = ALV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = ALV
        set CombineIndex2[CombineMaxIndex] = BJV
        set CombinedIndex[CombineMaxIndex] = AMV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OTV
        set CombineIndex2[CombineMaxIndex] = IEV
        set CombineIndex3[CombineMaxIndex] = BKV
        set CombinedIndex[CombineMaxIndex] = Item_LinkenSphere
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X0V
        set CombineIndex2[CombineMaxIndex] = OKV
        set CombinedIndex[CombineMaxIndex] = ASV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = I8V
        set CombineIndex2[CombineMaxIndex] = X0V
        set CombineIndex3[CombineMaxIndex] = BLV
        set CombinedIndex[CombineMaxIndex] = AUV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X0V
        set CombineIndex2[CombineMaxIndex] = OYV
        set CombineIndex3[CombineMaxIndex] = OYV
        set CombinedIndex[CombineMaxIndex] = AWV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OKV
        set CombineIndex2[CombineMaxIndex] = BMV
        set CombinedIndex[CombineMaxIndex] = AZV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OOV
        set CombineIndex2[CombineMaxIndex] = OUV
        set CombineIndex3[CombineMaxIndex] = BPV
        set CombinedIndex[CombineMaxIndex] = Item_HeartOfTarrasque
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OOV
        set CombineIndex2[CombineMaxIndex] = I_V
        set CombineIndex3[CombineMaxIndex] = BQV
        set CombinedIndex[CombineMaxIndex] = A2V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OOV
        set CombineIndex2[CombineMaxIndex] = I0V
        set CombineIndex3[CombineMaxIndex] = BQV
        set CombinedIndex[CombineMaxIndex] = A2V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OTV
        set CombineIndex2[CombineMaxIndex] = OTV
        set CombineIndex3[CombineMaxIndex] = OCV
        set CombineIndex4[CombineMaxIndex] = XKV
        set CombinedIndex[CombineMaxIndex] = A3V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OTV
        set CombineIndex2[CombineMaxIndex] = OTV
        set CombineIndex3[CombineMaxIndex] = OCV
        set CombineIndex4[CombineMaxIndex] = XLV
        set CombinedIndex[CombineMaxIndex] = A3V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XJV
        set CombineIndex2[CombineMaxIndex] = IOV
        set CombineIndex3[CombineMaxIndex] = A8V
        set CombinedIndex[CombineMaxIndex] = XHV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XJV
        set CombineIndex2[CombineMaxIndex] = IOV
        set CombineIndex3[CombineMaxIndex] = A9V
        set CombinedIndex[CombineMaxIndex] = XHV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X1V
        set CombineIndex2[CombineMaxIndex] = ODV
        set CombineIndex3[CombineMaxIndex] = RXV
        set CombinedIndex[CombineMaxIndex] = Item_TheButterfly
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OMV
        set CombineIndex2[CombineMaxIndex] = XZV
        set CombineIndex3[CombineMaxIndex] = B7V
        set CombinedIndex[CombineMaxIndex] = N_V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OCV
        set CombineIndex2[CombineMaxIndex] = OAV
        set CombineIndex3[CombineMaxIndex] = XUV
        set CombineIndex4[CombineMaxIndex] = OPV
        set CombinedIndex[CombineMaxIndex] = Item_AghanimScepterBasic
        set CombineMaxIndex = CombineMaxIndex + 1

        // 神杖升级
        set CombineIndex1[CombineMaxIndex] = Recipe_AghanimBlessing
        set CombineIndex2[CombineMaxIndex] = Item_AghanimScepter
        set CombinedIndex[CombineMaxIndex] = Item_AghanimBlessing
        set CombineMaxIndex = CombineMaxIndex + 1

        // 包含没有成功升级的版本
        set CombineIndex1[CombineMaxIndex] = Recipe_AghanimBlessing
        set CombineIndex2[CombineMaxIndex] = Item_AghanimScepterBasic
        set CombinedIndex[CombineMaxIndex] = Item_AghanimBlessing
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IEV
        set CombineIndex2[CombineMaxIndex] = IEV
        set CombineIndex3[CombineMaxIndex] = BSV
        set CombinedIndex[CombineMaxIndex] = A6V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OTV
        set CombineIndex2[CombineMaxIndex] = OIV
        set CombineIndex3[CombineMaxIndex] = OWV
        set CombinedIndex[CombineMaxIndex] = A7V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OUV
        set CombineIndex2[CombineMaxIndex] = OFV
        set CombineIndex3[CombineMaxIndex] = OQV
        set CombinedIndex[CombineMaxIndex] = A8V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OUV
        set CombineIndex2[CombineMaxIndex] = OFV
        set CombineIndex3[CombineMaxIndex] = OSV
        set CombinedIndex[CombineMaxIndex] = A8V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X2V
        set CombineIndex2[CombineMaxIndex] = OGV
        set CombineIndex3[CombineMaxIndex] = BTV
        set CombinedIndex[CombineMaxIndex] = NVV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X7V
        set CombineIndex2[CombineMaxIndex] = ITV
        set CombineIndex3[CombineMaxIndex] = B3V
        set CombinedIndex[CombineMaxIndex] = NEV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = R5V
        set CombineIndex3[CombineMaxIndex] = BUV
        set CombinedIndex[CombineMaxIndex] = NXV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IXV
        set CombineIndex2[CombineMaxIndex] = IRV
        set CombineIndex3[CombineMaxIndex] = OXV
        set CombineIndex4[CombineMaxIndex] = BWV
        set CombinedIndex[CombineMaxIndex] = NOV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IXV
        set CombineIndex2[CombineMaxIndex] = IIV
        set CombineIndex3[CombineMaxIndex] = OXV
        set CombineIndex4[CombineMaxIndex] = BWV
        set CombinedIndex[CombineMaxIndex] = NOV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X7V
        set CombineIndex2[CombineMaxIndex] = OBV
        set CombineIndex3[CombineMaxIndex] = XZV
        set CombineIndex4[CombineMaxIndex] = BYV
        set CombinedIndex[CombineMaxIndex] = NRV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = I3V
        set CombineIndex2[CombineMaxIndex] = NAV
        set CombineIndex3[CombineMaxIndex] = NYV
        set CombinedIndex[CombineMaxIndex] = NIV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OHV
        set CombineIndex2[CombineMaxIndex] = OHV
        set CombineIndex3[CombineMaxIndex] = OFV
        set CombineIndex4[CombineMaxIndex] = ONV
        set CombinedIndex[CombineMaxIndex] = NNV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XPV
        set CombineIndex2[CombineMaxIndex] = X6V
        set CombineIndex3[CombineMaxIndex] = XWV
        set CombineIndex4[CombineMaxIndex] = BZV
        set CombinedIndex[CombineMaxIndex] = NFV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OIV
        set CombineIndex2[CombineMaxIndex] = OBV
        set CombineIndex3[CombineMaxIndex] = B_V
        set CombinedIndex[CombineMaxIndex] = NGV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IHV
        set CombineIndex2[CombineMaxIndex] = IHV
        set CombineIndex3[CombineMaxIndex] = B9V
        set CombinedIndex[CombineMaxIndex] = NJV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = XWV
        set CombineIndex3[CombineMaxIndex] = XWV
        set CombinedIndex[CombineMaxIndex] = NKV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = Item_MagicStick
        set CombineIndex2[CombineMaxIndex] = Item_IronwoodBranch
        set CombineIndex3[CombineMaxIndex] = Item_IronwoodBranch
        set CombineIndex4[CombineMaxIndex] = XSV
        set CombinedIndex[CombineMaxIndex] = Item_MagicWand
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OHV
        set CombineIndex2[CombineMaxIndex] = OPV
        set CombineIndex3[CombineMaxIndex] = B0V
        set CombinedIndex[CombineMaxIndex] = NMV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = NNV
        set CombineIndex2[CombineMaxIndex] = IXV
        set CombineIndex3[CombineMaxIndex] = B1V
        set CombinedIndex[CombineMaxIndex] = NPV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OQV
        set CombineIndex2[CombineMaxIndex] = OLV
        set CombineIndex3[CombineMaxIndex] = OLV
        set CombinedIndex[CombineMaxIndex] = NQV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OSV
        set CombineIndex2[CombineMaxIndex] = OLV
        set CombineIndex3[CombineMaxIndex] = OLV
        set CombinedIndex[CombineMaxIndex] = NQV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OMV
        set CombineIndex2[CombineMaxIndex] = X3V
        set CombineIndex3[CombineMaxIndex] = X3V
        set CombineIndex4[CombineMaxIndex] = B4V
        set CombinedIndex[CombineMaxIndex] = NUV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OMV
        set CombineIndex2[CombineMaxIndex] = OHV
        set CombineIndex3[CombineMaxIndex] = B5V
        set CombinedIndex[CombineMaxIndex] = NYV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X1V
        set CombineIndex2[CombineMaxIndex] = NTV
        set CombinedIndex[CombineMaxIndex] = ROV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = X2V
        set CombinedIndex[CombineMaxIndex] = NZV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OJV
        set CombineIndex2[CombineMaxIndex] = IJV
        set CombineIndex3[CombineMaxIndex] = B6V
        set CombinedIndex[CombineMaxIndex] = RRV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = RRV
        set CombineIndex2[CombineMaxIndex] = B6V
        set CombinedIndex[CombineMaxIndex] = RRV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = RIV
        set CombineIndex2[CombineMaxIndex] = B6V
        set CombinedIndex[CombineMaxIndex] = RRV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X6V
        set CombineIndex2[CombineMaxIndex] = ILV
        set CombineIndex3[CombineMaxIndex] = B8V
        set CombinedIndex[CombineMaxIndex] = N0V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = XMV
        set CombineIndex2[CombineMaxIndex] = OGV
        set CombineIndex3[CombineMaxIndex] = OHV
        set CombinedIndex[CombineMaxIndex] = Item_TranquilBoots
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OPV
        set CombineIndex2[CombineMaxIndex] = OPV
        set CombineIndex3[CombineMaxIndex] = OUV
        set CombinedIndex[CombineMaxIndex] = RCV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IPV
        set CombineIndex2[CombineMaxIndex] = RXV
        set CombinedIndex[CombineMaxIndex] = N1V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IQV
        set CombineIndex2[CombineMaxIndex] = OKV
        set CombinedIndex[CombineMaxIndex] = N2V
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IKV
        set CombineIndex2[CombineMaxIndex] = IRV
        set CombinedIndex[CombineMaxIndex] = RUV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = IKV
        set CombineIndex2[CombineMaxIndex] = IIV
        set CombinedIndex[CombineMaxIndex] = RWV
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OAV
        set CombineIndex2[CombineMaxIndex] = XQV
        set CombineIndex3[CombineMaxIndex] = XQV
        set CombinedIndex[CombineMaxIndex] = Item_DragonLance
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = NJV
        set CombineIndex2[CombineMaxIndex] = I8V
        set CombineIndex3[CombineMaxIndex] = Recipe_Bloodthorn
        set CombinedIndex[CombineMaxIndex] = Item_Bloodthorn
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = OAV
        set CombineIndex2[CombineMaxIndex] = IHV
        set CombinedIndex[CombineMaxIndex] = it_hyzr
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = Item_DragonLance
        set CombineIndex2[CombineMaxIndex] = NMV
        set CombineIndex3[CombineMaxIndex] = Recipe_HurricanePike
        set CombinedIndex[CombineMaxIndex] = Item_HurricanePike
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X6V
        set CombineIndex2[CombineMaxIndex] = I6V
        set CombinedIndex[CombineMaxIndex] = it_fj 
    
        set CombineMaxIndex = CombineMaxIndex + 1

        set CombineIndex1[CombineMaxIndex] = X2V
        set CombineIndex2[CombineMaxIndex] = OWV
        set CombineIndex3[CombineMaxIndex] = Recipe_AetherLens
        set CombinedIndex[CombineMaxIndex] = Item_AetherLens
    endfunction


    // 物品索引
    globals
        integer Item_AghanimScepter
        integer Item_AghanimScepterGiftable
        integer Item_AghanimScepterBasic
        
        integer Recipe_AghanimBlessing
        integer Item_AghanimBlessing
        
        integer XGV
        integer XHV
        integer XJV
        integer XKV
        integer XLV
        integer XMV
        integer it_hyzr
        integer it_fj
        integer Item_DragonLance
        integer Item_Bloodthorn
        integer Recipe_Bloodthorn
        integer Recipe_AetherLens
        integer Item_AetherLens
        integer Item_HurricanePike
        integer Recipe_HurricanePike
        integer XPV
        integer XQV
        integer XSV
        integer XTV
        integer XUV
        integer XWV
        integer XYV
        integer XZV
        integer X_V
        integer X0V
        integer X1V
        integer X2V
        integer X3V
        integer ITem_GemOfTrueSight
        integer ITem_GemOfTrueSight_CourierEdition
        integer X6V
        integer X7V
        integer Item_IronwoodBranch
        integer Item_KelenDagger
        integer Item_DisabledKelenDagger
        integer OEV
        integer OXV
        integer OOV
        integer ORV
        integer OIV
        integer OAV
        integer ONV
        integer OBV
        integer OCV
        integer ODV
        integer OFV
        integer OGV
        integer OHV
        integer OJV
        integer OKV
        integer OLV
        integer OMV
        integer OPV
        integer OQV
        integer OSV
        integer OTV
        integer OUV
        integer OWV
        integer OYV
        integer OZV
        integer O_V
        integer O0V
        integer O1V
        integer O2V
        integer O3V
        integer O4V
        integer O5V
        integer O6V
        integer O7V
        integer O8V
        integer Item_MagicStick
        integer RVV
        integer REV
        integer RXV
        integer ROV
        integer RRV
        integer RIV
        integer RAV
        integer Item_TranquilBoots
        integer Item_DisabledTranquilBoots
        integer RCV
        integer Item_MoonShard
        integer Item_OctarineCore
        integer RGV
        integer RHV
        integer RJV
        integer RKV
        integer RLV
        integer RMV
        integer RPV
        integer RQV
        integer RSV
        integer RTV
        integer RUV
        integer RWV
        integer RYV
        integer RZV
        integer R_V
        integer Item_AncientTangoOfEssifation
        integer R1V
        integer R2V
        integer Item_SentryWard
        integer R4V
        integer R5V
        integer R6V
        integer R7V
        integer Item_DustOfAppearance
        integer R9V
        integer IVV
        integer IEV
        integer IXV
        integer IOV
        integer IRV
        integer IIV
        integer IAV
        integer INV
        integer IBV
        integer ICV
        integer IDV
        integer IFV
        integer IGV
        integer IHV
        integer IJV
        integer IKV
        integer ILV
        integer IMV
        integer IPV
        integer IQV
        integer ISV
        integer ITV
        integer IUV
        integer IWV
        integer IYV
        integer IZV
        integer I_V
        integer I0V
        integer I1V
        integer Item_EulScepterOfDivinity
        integer I3V
        integer I4V
        integer I5V
        integer I6V
        integer I7V
        integer I8V
        integer I9V
        integer AVV
        integer AEV
        integer AXV
        integer AOV
        integer ARV
        integer AIV
        integer AAV
        integer ANV
        integer ABV
        integer ACV
        integer ADV
        integer AFV
        integer AGV
        integer AHV
        integer AJV
        integer AKV
        integer ALV
        integer AMV
        integer Item_LinkenSphere
        integer AQV
        integer ASV
        integer ATV
        integer AUV
        integer AWV
        integer AYV
        integer AZV
        integer A_V
        integer Item_HeartOfTarrasque
        integer Item_DisabledHeartOfTarrasque
        integer A2V
        integer A3V
        integer A4V
        integer Item_TheButterfly
        integer A6V
        integer A7V
        integer A8V
        integer A9V
        integer NVV
        integer NEV
        integer NXV
        integer NOV
        integer NRV
        integer NIV
        integer NAV
        integer NNV
        integer NBV
        integer NCV
        integer NDV
        integer NFV
        integer NGV
        integer NHV
        integer NJV
        integer NKV
        integer Item_MagicWand
        integer NMV
        integer NPV
        integer NQV
        integer NSV
        integer NTV
        integer NUV
        integer NWV
        integer NYV
        integer NZV
        integer N_V
        integer N0V
        integer N1V
        integer N2V
        integer N3V
        integer N4V
        integer N5V
        integer N6V
        integer N7V
        integer N8V
        integer N9V
        integer BVV
        integer BEV
        integer BXV
        integer BOV
        integer BRV
        integer BIV
        integer BAV
        integer BNV
        integer BBV
        integer BCV
        integer BDV
        integer BFV
        integer BGV
        integer BHV
        integer BJV
        integer BKV
        integer BLV
        integer BMV
        integer BPV
        integer BQV
        integer BSV
        integer BTV
        integer BUV
        integer BWV
        integer BYV
        integer BZV
        integer B_V
        integer B0V
        integer B1V
        integer FastCombine_AghanimScepterBasic
        integer B3V
        integer B4V
        integer B5V
        integer B6V
        integer B7V
        integer B8V
        integer B9V
        integer CVV

    endglobals

endlibrary
