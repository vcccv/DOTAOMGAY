
library ScepterUpgradeDefine requires ScepterUpgradeLib

    // 注册神杖升级
    function HeroSkillsAghanimScepterUpgrade_Init takes nothing returns nothing
        local integer scepterUpgradeIndex
        call RegisterScepterUpgrade('A0O2', 'A28A', 'A289', 0)
        call RegisterScepterUpgrade('A0DH', 'A1MZ', 'A1OB', 0)
        call RegisterScepterUpgrade('A0ER', 'A2S7', 'A2S8', 0)
        call RegisterScepterUpgrade('A0MQ', 'A1BS', 'A1B6', 0)
        call RegisterScepterUpgrade('A0Z8', 'A1CW', 'A1CV', 0)
        call RegisterScepterUpgrade('A0QR', 'A1BL', 'A1B3', 0)
        call RegisterScepterUpgrade('A0M1', 'A1BR', 'A1AX', 0)
        call RegisterScepterUpgrade('A29L', 'A448', 'A447', 0)
        call RegisterScepterUpgrade('A0RP', 'A44A', 'A449', 0)
        call RegisterScepterUpgrade('A054', 'A0UE', 'A00U', 0)
        call RegisterScepterUpgrade('A1T5', 'A236', 'A235', 0)
        call RegisterScepterUpgrade('A0IN', 'A1BT', 'A1AW', 0)
        call RegisterScepterUpgrade('A03R', 'A0U2', 'A0AV', 0)
        call RegisterScepterUpgrade('A0S8', 'A1QR', 'A1QP', 0)
        call RegisterScepterUpgrade('A0LT', 'A1CT', 'A1CS', 0)
        call RegisterScepterUpgrade('A29G', 'A0U0', 'A29H', 0)
        call RegisterScepterUpgrade('A1W8', 'A0U8', 'A1W9', 0)
        call RegisterScepterUpgrade('A0L3', 'A2QB', 'A2QC', 0)
        call RegisterScepterUpgrade('A01P', 'A0TO', 'A09Z', 0)
        call RegisterScepterUpgrade('A12P', 'A1DC', 'A1D6', 0)
        call RegisterScepterUpgrade('A0AK', 'A1G0', 'A1FY', 0)
        call RegisterScepterUpgrade('A0O5', 'A1BN', 'A1B1', 0)
        call RegisterScepterUpgrade('A00H', 'A0TY', 'A0A1', 0)
        call RegisterScepterUpgrade('A04P', 'A1BV', 'A1AU', 0)
        call RegisterScepterUpgrade('A0LC', 'A444', 'A443', 0)
        call RegisterScepterUpgrade('A0E2', 'A1MS', 'A1MR', 0)
        call RegisterScepterUpgrade('A0MU', 'A0UI', 'A0A2', 0)
        call RegisterScepterUpgrade('A0NS', 'A1DE', 'A1DA', 0)
        call RegisterScepterUpgrade('A0FL', 'A1D5', 'A1CX', 0)
        call RegisterScepterUpgrade('A0G4', 'A1DG', 'A1D8', 0)
        call RegisterScepterUpgrade('A06R', 'A1BM', 'A1B4', 0)
        call RegisterScepterUpgrade('A013', 'A0UA', 'A0A6', 0)
        call RegisterScepterUpgrade('A080', 'A1V0', 'A1UZ', 0)
        call RegisterScepterUpgrade('A1AO', 'A1UW', 'A1UV', 0)
        call RegisterScepterUpgrade('A0J1', 'A1DD', 'A1D7', 0)
        call RegisterScepterUpgrade('A02Q', 'A1DH', 'A1D9', 0)
        call RegisterScepterUpgrade('A0QK', 'A21R', 'A21Q', 0)
        call RegisterScepterUpgrade('A095', 'A0TQ', 'A09W', 0)
        call RegisterScepterUpgrade('A05T', 'A0U4', 'A08H', 0)
        call RegisterScepterUpgrade('A067', 'A0UC', 'A08P', 0)
        call RegisterScepterUpgrade('A0CC', 'A0TU', 'A02Z', 0)
        call RegisterScepterUpgrade('A0OK', 'A1VX', 'A1VW', 0)
        call RegisterScepterUpgrade('A28R', 'A0TW', 'A28S', 0)

        call RegisterScepterUpgrade('S008', 'A1US', 'S00U', 0)
        call RegisterScepterUpgrade('A10Q', 'A1DF', 'A1DB', 0)
        call RegisterScepterUpgrade('A1NE', 'A2IH', 'A2IG', 0)
        call RegisterScepterUpgrade('A21F', 'A0U6', 'A21G', 0)
        call RegisterScepterUpgrade('A0NT', 'A0UG', 'A0NX', 0)
        call RegisterScepterUpgrade('A1MI', 'A2QF', 'A2QE', 0)
        call RegisterScepterUpgrade('A2BG', 'A30I', 'A30H', 0)
        call RegisterScepterUpgrade('A27H', 'A30K', 'A30J', 0)
        call RegisterScepterUpgrade('A1BX', 'A30M', 'A30L', 0)
        call RegisterScepterUpgrade('A1U6', 'A30O', 'A30N', 0)
        call RegisterScepterUpgrade('A343', 'A34K', 'A34J', 0)
        call RegisterScepterUpgrade('A0DY', 'A1WC', 'A1WB', 0)
        call RegisterScepterUpgrade('A0WP', 'A43E', 'A43D', 0)
        call RegisterScepterUpgrade('A1RK', 'A43I', 'A43H', 0)
        call RegisterScepterUpgrade('A1A1', 'A43K', 'A43J', 0)
        call RegisterScepterUpgrade('A2E5', 'A43R', 'A43S', 0)
        call RegisterScepterUpgrade('A07Z', 'A44R', 'A44S', 0)
        call RegisterScepterUpgrade('A2O6', 'A3G0', 'A384', 0)
        call RegisterScepterUpgrade('A2CI', 'A38D', 'A38C', 0)
        call RegisterScepterUpgrade('A07U', 'A38F', 'A38E', 0)
        call RegisterScepterUpgrade('A1YQ', 'A3DD', 'A3DE', 0)
        call RegisterScepterUpgrade('A0CT', 'A3DN', 'A3DM', 0)
        call RegisterScepterUpgrade('A01Y', 'A1BP', 'A1AZ', 0)
        call RegisterScepterUpgrade('A14O', 'A3FP', 'A3FJ', 0)
        call RegisterScepterUpgrade('A19O', 'A1MW', 'A1MV', 0)
        call RegisterScepterUpgrade('A06B', 'A472', 'A471', 0)
        call RegisterScepterUpgrade('A15S', 'A3JY', 'A3JX', 0)
        call RegisterScepterUpgrade('A05E', 'A3JZ', 'A33F', 0)
        call RegisterScepterUpgrade('A049', 'A33H', 'A33G', 0)
        call RegisterScepterUpgrade('A28T', 'A3JA', 'A361', 0)
        call RegisterScepterUpgrade('Z610', 'A3K4', 'A3K5', 0)
        
        call RegisterScepterUpgrade('A0FW', 'S3OD', 'A3OD', 0) // 刚被兽 粘稠鼻液
        call RegisterScepterUpgrade('A0KV', 'S3UG', 'A3UG', 0) // 群星坠落
        call RegisterScepterUpgrade('A11K', 'S31K', 'Z31K', 0) // 舰队统帅 幽灵船
        call RegisterScepterUpgrade('A046', 'S3OH', 'A3OH', 0) // 潮汐猎人 巨浪
        call RegisterScepterUpgrade('A06O', 'S3NX', 'A3NX', 0) // 沙王 掘地穿刺
        call RegisterScepterUpgrade('A02S', 'A3Y7', 'A3Y8', 0) // 猛犸 震荡波
        call RegisterScepterUpgrade('A14R', 'S3WT', 'A3WT', 0) // 蓝猫 电子漩涡
        call RegisterScepterUpgrade('A29J', 'S3OJ', 'A3OJ', 0) // 影魔r
        
        call RegisterScepterUpgrade('A1TB', 'A470', 'A3FQ', 0)
        call RegisterScepterUpgrade('A0O3', 0, 'A0O3', 0)
        call RegisterScepterUpgrade('QM03', 0, 0, 0)
        call RegisterScepterUpgrade('A0A5', 0, 0, 0)
        call RegisterScepterUpgrade('A0CY', 0, 0, 0)
        call RegisterScepterUpgrade('A088', 0, 0, 0)
        set scepterUpgradeIndex = RegisterScepterUpgrade('A085', 0, 0, 0)
        call RegisterSkillScepterUpgradeMethod(scepterUpgradeIndex, "MultiCastOnGetScepterUpgrade", "MultiCastOnLostScepterUpgrade")
    endfunction

    // 注册神杖特效技能
    function RegisterHeroSkillAghanimEffect takes integer unitId, integer abilId returns nothing
    endfunction
    function HeroSkillAghanimEffect_Init takes nothing returns nothing
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[1],   'A1NR')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[2],   'A0PF')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[3],   'A1X2')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[4],   0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[5],   'A0Q9')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[6],   0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[7],   0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[8],   'A1OC')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[9],   0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[10],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[11],  'A0PC')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[12],  'A1QL')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[13],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[14],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[15],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[16],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[17],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[18],  'A0P9')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[19],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[20],  'A20M')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[21],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[22],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[23],  'A1R7')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[24],  'A20V')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[25],  'A1NQ')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[26],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[27],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[28],  'A0P8')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[29],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[30],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[31],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[32],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[33],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[34],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[35],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[36],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[37],  'A29E')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[38],  'A1VF')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[39],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[40],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[41],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[42],  'A1NS')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[43],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[44],  'A1RG')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[45],  'A220')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[46],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[47],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[48],  'A23E')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[49],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[50],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[51],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[52],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[53],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[54],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[55],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[56],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[57],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[58],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[59],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[60],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[61],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[62],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[63],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[64],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[65],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[66],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[67],  'A0P7')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[68],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[69],  'A1R3')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[70],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[71],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[72],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[73],  'A0PB')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[74],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[75],  'A1R8')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[76],  'A1R9')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[77],  'A1VB')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[78],  'A1VE')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[79],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[80],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[81],  'A1NX')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[82],  'A1V9')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[83],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[84],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[85],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[86],  'A1V5')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[87],  'A1VZ')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[88],  'A1UY')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[89],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[90],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[91],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[92],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[93],  'A21Z')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[94],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[95],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[96],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[97],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[98],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[99],  0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[100], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[101], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[102], 'A0PE')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[103], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[104], 'A0PA')
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[105], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[106], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[107], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[108], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[109], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[110], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[111], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[112], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[113], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[114], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[115], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[116], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[117], 0)
        call RegisterHeroSkillAghanimEffect(HeroListTypeId[118], 0)
    endfunction

endlibrary
