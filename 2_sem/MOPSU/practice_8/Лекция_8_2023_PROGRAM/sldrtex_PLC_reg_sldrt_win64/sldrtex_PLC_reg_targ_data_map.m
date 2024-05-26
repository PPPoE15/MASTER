    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 1;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (sldrtex_PLC_reg_P)
        ;%
            section.nData     = 14;
            section.data(14)  = dumData; %prealloc

                    ;% sldrtex_PLC_reg_P.DiscretePIDController_D
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% sldrtex_PLC_reg_P.DiscretePIDController_DifferentiatorICPrevScaledInput
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% sldrtex_PLC_reg_P.DiscretePIDController_I
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% sldrtex_PLC_reg_P.DiscretePIDController_InitialConditionForIntegrator
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% sldrtex_PLC_reg_P.RealTimeSynchronization_MaxMissedTicks
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% sldrtex_PLC_reg_P.DiscretePIDController_P
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

                    ;% sldrtex_PLC_reg_P.RealTimeSynchronization_YieldWhenWaiting
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 6;

                    ;% sldrtex_PLC_reg_P.TransferFcn_A
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 7;

                    ;% sldrtex_PLC_reg_P.TransferFcn_C
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 9;

                    ;% sldrtex_PLC_reg_P.Step_Time
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 11;

                    ;% sldrtex_PLC_reg_P.Step_Y0
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 12;

                    ;% sldrtex_PLC_reg_P.Step_YFinal
                    section.data(12).logicalSrcIdx = 11;
                    section.data(12).dtTransOffset = 13;

                    ;% sldrtex_PLC_reg_P.Tsamp_WtEt
                    section.data(13).logicalSrcIdx = 12;
                    section.data(13).dtTransOffset = 14;

                    ;% sldrtex_PLC_reg_P.Integrator_gainval
                    section.data(14).logicalSrcIdx = 13;
                    section.data(14).dtTransOffset = 15;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (sldrtex_PLC_reg_B)
        ;%
            section.nData     = 6;
            section.data(6)  = dumData; %prealloc

                    ;% sldrtex_PLC_reg_B.TransferFcn
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% sldrtex_PLC_reg_B.ZeroOrderHold
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% sldrtex_PLC_reg_B.Sum
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% sldrtex_PLC_reg_B.Tsamp
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% sldrtex_PLC_reg_B.IntegralGain
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% sldrtex_PLC_reg_B.Sum_g
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% sldrtex_PLC_reg_B.RealTimeSynchronization
                    section.data(1).logicalSrcIdx = 6;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            sigMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 2;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (sldrtex_PLC_reg_DW)
        ;%
            section.nData     = 2;
            section.data(2)  = dumData; %prealloc

                    ;% sldrtex_PLC_reg_DW.UD_DSTATE
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% sldrtex_PLC_reg_DW.Integrator_DSTATE
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 3;
            section.data(3)  = dumData; %prealloc

                    ;% sldrtex_PLC_reg_DW.Scope_PWORK.LoggedData
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

                    ;% sldrtex_PLC_reg_DW.RealTimeSynchronization_PWORK
                    section.data(2).logicalSrcIdx = 3;
                    section.data(2).dtTransOffset = 1;

                    ;% sldrtex_PLC_reg_DW.Scope1_PWORK.LoggedData
                    section.data(3).logicalSrcIdx = 4;
                    section.data(3).dtTransOffset = 2;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 694181879;
    targMap.checksum1 = 1131154076;
    targMap.checksum2 = 3475416291;
    targMap.checksum3 = 2787510189;

