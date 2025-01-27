
library PseudoRandomDistribution initializer Init

    globals
        private real array C
        private hashtable HT = InitHashtable()
    endglobals

    private function Init takes nothing returns nothing
        set C[1]=0.0156
        set C[2]=0.062
        set C[3]=0.1386
        set C[4]=0.2449
        set C[5]=0.3802
        set C[6]=0.544
        set C[7]=0.7359
        set C[8]=0.9552
        set C[9]=1.2016
        set C[10]=1.4746
        set C[11]=1.7736
        set C[12]=2.0983
        set C[13]=2.4482
        set C[14]=2.823
        set C[15]=3.2221
        set C[16]=3.6452
        set C[17]=4.092
        set C[18]=4.562
        set C[19]=5.0549
        set C[20]=5.5704
        set C[21]=6.1081
        set C[22]=6.6676
        set C[23]=7.2488
        set C[24]=7.8511
        set C[25]=8.4744
        set C[26]=9.1183
        set C[27]=9.7826
        set C[28]=10.467
        set C[29]=11.1712
        set C[30]=11.8949
        set C[31]=12.6379
        set C[32]=13.4001
        set C[33]=14.1805
        set C[34]=14.981
        set C[35]=15.7983
        set C[36]=16.6329
        set C[37]=17.4909
        set C[38]=18.3625
        set C[39]=19.2486
        set C[40]=20.1547
        set C[41]=21.092
        set C[42]=22.0365
        set C[43]=22.9899
        set C[44]=23.954
        set C[45]=24.9307
        set C[46]=25.9872
        set C[47]=27.0453
        set C[48]=28.1008
        set C[49]=29.1552
        set C[50]=30.2103
        set C[51]=31.2677
        set C[52]=32.3291
        set C[53]=33.412
        set C[54]=34.737
        set C[55]=36.0398
        set C[56]=37.3217
        set C[57]=38.584
        set C[58]=39.8278
        set C[59]=41.0545
        set C[60]=42.265
        set C[61]=43.4604
        set C[62]=44.6419
        set C[63]=45.8104
        set C[64]=46.967
        set C[65]=48.1125
        set C[66]=49.2481
        set C[67]=50.7463
        set C[68]=52.9412
        set C[69]=55.0725
        set C[70]=57.1429
        set C[71]=59.1549
        set C[72]=61.1111
        set C[73]=63.0137
        set C[74]=64.8649
        set C[75]=66.6667
        set C[76]=68.4211
        set C[77]=70.1299
        set C[78]=71.7949
        set C[79]=73.4177
        set C[80]=75.
        set C[81]=76.5432
        set C[82]=78.0488
        set C[83]=79.5181
        set C[84]=80.9524
        set C[85]=82.3529
        set C[86]=83.7209
        set C[87]=85.0575
        set C[88]=86.3636
        set C[89]=87.6404
        set C[90]=88.8889
        set C[91]=90.1099
        set C[92]=91.3043
        set C[93]=92.4731
        set C[94]=93.617
        set C[95]=94.7368
        set C[96]=95.8333
        set C[97]=96.9072
        set C[98]=97.9592
        set C[99]=98.9899
        set C[100]=99.9899
    endfunction

    function GetUnitPseudoRandom takes unit whichUnit, integer id, integer probability returns boolean
        local integer h = GetHandleId(whichUnit)
        local real    c
        local real    random
        local real    last

        set c      = C[probability]
        set random = GetRandomReal(0., 100.)
        set last   = LoadReal(HT, h, id)
        if random < ( last + c ) then
            call SaveReal(HT, h, id, 0)
            return true
        endif
        call SaveReal(HT, h, id, last + c)
        return false
    endfunction

    function ResetUnitPseudoRandom takes unit whichUnit returns nothing
        call FlushChildHashtable(HT, GetHandleId(whichUnit))
    endfunction

endlibrary
