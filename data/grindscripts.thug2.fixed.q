
:i function $GetBoardGrindBone$$objId$ = $skater$
	:i %GLOBAL%$objId$.$GetSparksPos$
	:i switch %GLOBAL%$SparksPos$
		:i case $front$
			:i if %GLOBAL%$objId$.$BoardIsRotated$
				:i %GLOBAL%$Bone$ = $Bone_Board_Tail$
			:i else 
				:i %GLOBAL%$Bone$ = $Bone_Board_Nose$
			:i endif
			:i endcase
		case $rear$
			:i if %GLOBAL%$objId$.$BoardIsRotated$
				:i %GLOBAL%$Bone$ = $Bone_Board_Nose$
			:i else 
				:i %GLOBAL%$Bone$ = $Bone_Board_Tail$
			:i endif
			:i endcase
		default 
			:i %GLOBAL%$Bone$ = $Bone_Board_Root$
			:i end_switch
	
	:i return
	$Bone$ = %GLOBAL%$Bone$
:i endfunction
:i function $SkateInOrBail$$moveleft$ = %i(1,00000001)$moveright$ = %i(4294967295,ffffffff)$movey$ = %i(4294967291,fffffffb)
	:i $GetTags$
	:i if $IsSkaterOnVehicle$
		:i $OutAnim$ = %GLOBAL%$grind_out_anim$
		:i $GrindBail$ = $vehicle_bail$
	:i endif
	:i $NoRailTricks$
	:i $StopBalanceTrick$
	:i $KillExtraTricks$
	:i $SetExtraTricks$$NoTricks$
	:i if NOT $IsSkaterOnVehicle$
		:i $OnGroundExceptions$$NoEndRun$
	:i endif
	:i if NOT  (%GLOBAL%$GrindBail$ = $Airborne$) 
		:i $OnExceptionRun$$SkateInOrBail_Out$
	:i endif
	:i $SetQueueTricks$$NoTricks$
	:i $ClearManualTrick$
	:i if $GotParam$$Fallingright$
		:i $Goto$$SkateIn_Right$$Params$ = :s{ isNull :s}
	:i endif
	:i if $GotParam$$FallingLeft$
		:i $Goto$$SkateIn_Left$$Params$ = :s{ isNull :s}
	:i endif
	:i if $GotParam$$GrindRelease$
		:i $TriggerGrindOff$
		:i if $Held$$Right$
			:i $Goto$$SkateIn_Right$$Params$ = :s{ isNull :s}
		:i endif
		:i if $Held$$Left$
			:i $Goto$$SkateIn_Left$$Params$ = :s{ isNull :s}
		:i endif
		:i if $SkateInAble$$Left$
			:i $Goto$$SkateIn_Left$$Params$ = :s{ isNull :s}
		:i else 
			:i $Goto$$SkateIn_Right$$Params$ = :s{ isNull :s}
		:i endif
	:i endif
	:i if $GotParam$$GrindBail$
		:i $Goto$%GLOBAL%$GrindBail$
	:i else 
		:i $Goto$$FiftyFiftyFall$
	:i endif
:i endfunction
:i function $OnGroundExceptions_NoOllieAfterEndofRun$
	:i $OnGroundExceptions$$NoEndRun$
	:i if $GoalManager_GoalShouldExpire$
		:i $ClearException$$Ollied$
		:i $ClearException$$GroundGone$
		:i $ClearException$$WallPush$
	:i endif
:i endfunction
:i function $SkateIn_Right$
	:i if $SkateInAble$$Right$
		:i $skatein$ = %i(1,00000001)
	:i else 
		:i if $NearGround$$Right$
			:i $skatein$ = %i(1,00000001)
			:i $Params$ = :s{$no_land_anim$ = %i(1,00000001):s}
		:i endif
	:i endif
	:i if $GotParam$$skatein$
		:i $SetLandedFromVert$
		:i $SetState$$ground$
		:i $Move$$y$ = %i(4294967291,fffffffb)
		:i $Move$$x$ = %i(4294967295,ffffffff)
		:i $OrientToNormal$
		:i $Rotate$$y$ = %i(4294967266,ffffffe2)$Duration$ = %f(0.200000)$seconds$
		:i if NOT $IsSkaterOnVehicle$
			:i $OnGroundExceptions_NoOllieAfterEndofRun$
		:i endif
		:i $OnExceptionRun$$SkateInOrBail_Out$
		:i $SetQueueTricks$$NoTricks$
		:i $SetManualTricks$$NoTricks$
		:i $SetExtraTricks_Reverts$
		:i if $IsSkaterOnVehicle$
			:i $Goto$$vehicle_rail_exit$$Params$ = :s{$callback$ = $vehicle_land$:s}
		:i else 
			:i if $GotParam$$OutAnim$
				:i $PlayAnim$$Anim$ = %GLOBAL%$OutAnim$$BlendPeriod$ = %f(0.300000)
			:i else 
				:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$Backwards$$BlendPeriod$ = %f(0.300000)
			:i endif
			:i $WaitAnimWhilstChecking$
			:i $Goto$$SkateInLand$$Params$ = %GLOBAL%$Params$
		:i endif
	:i else 
		:i $Move$$y$ = %GLOBAL%$movey$
		:i $Move$$x$ = %GLOBAL%$moveright$
		:i if $IsSkaterOnVehicle$
			:i $vehicle_rail_exit$$Params$ = :s{$callback$ = $vehicle_bail$:s}
		:i else 
			:i $SkateIn_Bail$ isNull $dir$ = $Right$
		:i endif
	:i endif
:i endfunction
:i function $SkateIn_Left$
	:i if $SkateInAble$$Left$
		:i $skatein$ = %i(1,00000001)
	:i else 
		:i if $NearGround$$Left$
			:i $skatein$ = %i(1,00000001)
			:i $Params$ = :s{$no_land_anim$ = %i(1,00000001):s}
		:i endif
	:i endif
	:i if $GotParam$$skatein$
		:i $SetLandedFromVert$
		:i $SetState$$ground$
		:i $Move$$x$ = %i(1,00000001)
		:i $Move$$y$ = %i(4294967291,fffffffb)
		:i $OrientToNormal$
		:i $Rotate$$y$ = %i(30,0000001e)$Duration$ = %f(0.200000)$seconds$
		:i $SetState$$ground$
		:i if NOT $IsSkaterOnVehicle$
			:i $OnGroundExceptions_NoOllieAfterEndofRun$
		:i endif
		:i $OnExceptionRun$$SkateInOrBail_Out$
		:i $SetQueueTricks$$NoTricks$
		:i $SetManualTricks$$NoTricks$
		:i $SetExtraTricks_Reverts$
		:i if $IsSkaterOnVehicle$
			:i $Goto$$vehicle_rail_exit$$Params$ = :s{$callback$ = $vehicle_land$:s}
		:i else 
			:i if $GotParam$$OutAnim$
				:i $PlayAnim$$Anim$ = %GLOBAL%$OutAnim$$BlendPeriod$ = %f(0.300000)
			:i else 
				:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$Backwards$$BlendPeriod$ = %f(0.300000)
			:i endif
			:i $WaitAnimWhilstChecking$
			:i $Goto$$SkateInLand$$Params$ = %GLOBAL%$Params$
		:i endif
	:i else 
		:i $Move$$y$ = %GLOBAL%$movey$
		:i $Move$$x$ = %GLOBAL%$moveright$
		:i if $IsSkaterOnVehicle$
			:i $vehicle_rail_exit$$Params$ = :s{$callback$ = $vehicle_bail$:s}
		:i else 
			:i $SkateIn_Bail$ isNull $dir$ = $Left$
		:i endif
	:i endif
:i endfunction
:i function $SkateIn_Bail$
	:i if $Flipped$
		:i if  (%GLOBAL%$dir$ = $Left$) 
			:i $dir$ = $backward$
		:i else 
			:i $dir$ = $forward$
		:i endif
	:i else 
		:i if  (%GLOBAL%$dir$ = $Left$) 
			:i $dir$ = $forward$
		:i else 
			:i $dir$ = $backward$
		:i endif
	:i endif
	:i if $GotParam$$GrindBail$
		:i $Goto$%GLOBAL%$GrindBail$$Params$ = :s{$dir$ = %GLOBAL%$dir$:s}
	:i else 
		:i $Goto$$FiftyFiftyFall$$Params$ = :s{$dir$ = %GLOBAL%$dir$:s}
	:i endif
:i endfunction
:i function $SkateInLand$
	:i $OnExceptionRun$$SkateInLandOut$
	:i $NollieOff$
	:i $PressureOff$
	:i $Vibrate$$Actuator$ = %i(1,00000001)$Percent$ = %i(80,00000050)$Duration$ = %f(0.100000)
	:i if NOT $GotParam$$no_land_anim$
		:i if $Crouched$
			:i $PlayAnim$$Anim$ = $CrouchedLand$$BlendPeriod$ = %f(0.100000)
		:i else 
			:i $PlayAnim$$Anim$ = $Land$$BlendPeriod$ = %f(0.100000)
		:i endif
	:i endif
	:i $OnExceptionRun$$SkateInLandOut$
	:i $OnGroundExceptions_NoOllieAfterEndofRun$
	:i $SetManualTricks$$NoTricks$
	:i if NOT $GotParam$$no_land_anim$
		:i $WaitAnim$%i(10,0000000a)$Percent$
	:i endif
	:i $LandSkaterTricks$
	:i $OnGroundExceptions$
	:i $CheckforNetBrake$
	:i $AllowRailtricks$
	:i if NOT $GotParam$$no_land_anim$
		:i $WaitAnimWhilstChecking$$AndManuals$
	:i endif
	:i $Goto$$OnGroundAI$
:i endfunction
:i function $SkateInLandOut$
	:i $AllowRailtricks$
	:i $LandSkaterTricks$
:i endfunction
:i function $SkateInOrBail_Out$
	:i $KillExtraTricks$
	:i if NOT $InAir$
		:i $LandSkaterTricks$
	:i endif
	:i $ResetLandedFromVert$
:i endfunction
:i $Extra_FS_Grinds$ = 
:i :a{
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Triangle$;$b$ = $Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_5050_FS$$Params$ = :s{$Name$ = %sc(8,"FS 50-50")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Triangle$;$Square$;%i(300,0000012c):s}$Scr$ = $Trick_NoseSlide_FS$$Params$ = :s{$Name$ = %sc(12,"FS Noseslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Triangle$;$Circle$;%i(300,0000012c):s}$Scr$ = $Trick_Nosegrind_FS$$Params$ = :s{$Name$ = %sc(12,"FS Nosegrind")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Circle$;$b$ = $Circle$;%i(300,0000012c):s}$Scr$ = $Trick_Crooked_FS$$Params$ = :s{$Name$ = %sc(10,"FS Crooked")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Circle$;$Square$;%i(300,0000012c):s}$Scr$ = $Trick_Bluntslide_FS$$Params$ = :s{$Name$ = %sc(13,"FS Bluntslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Circle$;$Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_NoseBluntSlide_FS$$Params$ = :s{$Name$ = %sc(17,"FS Nosebluntslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Square$;$b$ = $Square$;%i(300,0000012c):s}$Scr$ = $Trick_Smith_FS$$Params$ = :s{$Name$ = %sc(8,"FS Smith")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Square$;$Circle$;%i(300,0000012c):s}$Scr$ = $Trick_5_0_FS$$Params$ = :s{$Name$ = %sc(6,"FS 5-0")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Square$;$Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_Tailslide_FS$$Params$ = :s{$Name$ = %sc(12,"FS Tailslide")$IsExtra$ = $yes$:s}:s}
	:i :a}
:i $Extra_BS_Grinds$ = 
:i :a{
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Triangle$;$b$ = $Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_5050_BS$$Params$ = :s{$Name$ = %sc(8,"BS 50-50")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Triangle$;$Square$;%i(300,0000012c):s}$Scr$ = $Trick_NoseSlide_BS$$Params$ = :s{$Name$ = %sc(12,"BS Noseslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Triangle$;$Circle$;%i(300,0000012c):s}$Scr$ = $Trick_Nosegrind_BS$$Params$ = :s{$Name$ = %sc(12,"BS Nosegrind")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Circle$;$b$ = $Circle$;%i(300,0000012c):s}$Scr$ = $Trick_Crooked_BS$$Params$ = :s{$Name$ = %sc(10,"BS Crooked")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Circle$;$Square$;%i(300,0000012c):s}$Scr$ = $Trick_Bluntslide_BS$$Params$ = :s{$Name$ = %sc(13,"BS Bluntslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Circle$;$Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_NoseBluntSlide_BS$$Params$ = :s{$Name$ = %sc(17,"BS Nosebluntslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Square$;$Triangle$;%i(300,0000012c):s}$Scr$ = $Trick_Tailslide_BS$$Params$ = :s{$Name$ = %sc(12,"BS Tailslide")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$a$ = $Square$;$b$ = $Square$;%i(300,0000012c):s}$Scr$ = $Trick_Smith_BS$$Params$ = :s{$Name$ = %sc(8,"BS Smith")$IsExtra$ = $yes$:s}:s}
	:i :s{$Trigger$ = :s{$InOrder$;$Square$;$Circle$;%i(300,0000012c):s}$Scr$ = $Trick_5_0_BS$$Params$ = :s{$Name$ = %sc(6,"BS 5-0")$IsExtra$ = $yes$:s}:s}
	:i :a}
:i $GrindRelease$ = 
:i :a{
	:i :s{$Trigger$ = :s{$Press$;$R2$;%i(100,00000064):s}$Scr$ = $SkateInOrBail$$NGC_Trigger$ = :s{$Press$;$R1$;%i(100,00000064):s}$Xbox_Trigger$ = :s{$AirTrickLogic$;$L2$;$R2$;%i(200,000000c8):s}$Params$ = :s{$GrindRelease$$GrindBail$ = $Airborne$$moveright$ = %i(4294967291,fffffffb)$movey$ = %i(5,00000005):s}:s}
	:i :a}
:i $SPECIALGRIND_SCORE$ = %i(1250,000004e2)
:i $GRINDTAP_TIME$ = %i(1000,000003e8)
:i $GRINDTAP_SCORE$ = %i(400,00000190)
:i $GRINDTAP_TWEAK$ = %i(25,00000019)
:i $GrindTaps_FS$ = :a{
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$UpRight$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_CrailSlide_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$DownRight$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Darkslide_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$DownLeft$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_DoubleBluntSlide2$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$UpLeft$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_HangTenNoseGrind_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Up$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_NosegrindPivot_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Right$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Salad_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Left$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Hurricane_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Down$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_GrindOverturn_FS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :a}
:i $GrindTaps_BS$ = :a{
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$UpRight$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_CrailSlide_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$DownRight$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Darkslide_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$DownLeft$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_DoubleBluntSlide2$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$UpLeft$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_HangTenNoseGrind_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Up$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_NosegrindPivot_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Right$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Salad_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Down$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_GrindOverturn_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :s{$Trigger$ = :s{$TripleInOrderSloppy$;$Left$;$b$ = $Triangle$;$c$ = $Triangle$;$GRINDTAP_TIME$:s}$Scr$ = $Trick_Hurricane_BS$$Params$ = :s{$IsExtra$ = %i(1,00000001):s}:s}
	:i :a}
:i function $Grind$$GrindTweak$ = %i(7,00000007)$boardscuff$ = %i(0,00000000)$InitSpeed$ = %f(1.000000)$SparksPos$ = $rear$
	:i $Obj_GetType$
	:i if  (%GLOBAL%$ObjType$ = $OBJECT_TYPE_PED$) 
		:i $Goto$$Ped_Skater_BeginGrind$$Params$ =  isNull 
		:i return
		
	:i endif
	:i $KillExtraTricks$
	:i if $IsSkaterOnVehicle$
		:i $Goto$$vehicle_grind$
	:i endif
	:i if $IsOnMotoskateboard$
		:i if NOT $GotParam$$motoskateboard_grind$
			:i $Goto$$Trick_Motoskateboard_Grind$
		:i endif
		:i $NoSpecial$ = $NoSpecial$
	:i endif
	:i if $BailIsOn$
		:i $SetState$$Air$
		:i $Goto$$DoingTrickBail$
	:i endif
	:i if $InNetGame$
		:i if $BailIsOn$
			:i $SetState$$Air$
			:i $Goto$$DoingTrickBail$
		:i endif
	:i endif
	:i $BailOff$
	:i $CancelRotateDisplay$
	:i $TurnOffSpecialItem$
	:i $LaunchStateChangeEvent$$State$ = $Skater_OnRail$
	:i $ResetProjectileInput$
	:i if NOT $GotParam$$IsATap$
		:i if NOT $GotParam$$IsExtra$
			:i if $ChecksumEquals$$a$ = %GLOBAL%$Extratricks$$b$ = $Extra_BS_Grinds$
				:i $SetExtraTricks$$GrindTaps_BS$
			:i else 
				:i $SetExtraTricks$$GrindTaps_FS$
			:i endif
		:i endif
	:i endif
	:i $SetTags$$OutAnim$ = %GLOBAL%$OutAnim$$initanim$ = %GLOBAL%$initanim$$InitSpeed$ = %GLOBAL%$InitSpeed$$Anim$ = %GLOBAL%$Anim$
	:i $SetTrickName$%s(0,"")
	:i $SetTrickScore$%i(0,00000000)
	:i $Display$$Blockspin$
	:i $Obj_ClearFlag$$FLAG_SKATER_MANUALCHEESE$
	:i $Obj_ClearFlag$$FLAG_SKATER_REVERTCHEESE$
	:i if $GotParam$$SpecialItem_details$
		:i $TurnOnSpecialItem$$SpecialItem_details$ = %GLOBAL%$SpecialItem_details$
	:i endif
	:i if $GotParam$$SwitchBoardOff$
		:i $SwitchoffBoard$
	:i endif
	:i if $GotParam$$IsSpecial$
		:i $BroadcastEvent$$type$ = $SkaterEnterSpecialTrick$
		:i $OnExitRun$$Exit_Special_Grind$
	:i else 
		:i $OnExitRun$$Exit_Grind$
	:i endif
	:i if $GotParam$$SpecialSounds$
		:i $Obj_SpawnScript$%GLOBAL%$SpecialSounds$
	:i endif
	:i $Vibrate$$Actuator$ = %i(1,00000001)$Percent$ = %i(50,00000032)$Duration$ = %f(0.250000)
	:i $Vibrate$$Actuator$ = %i(0,00000000)$Percent$ = %i(50,00000032)
	:i $ClearExceptions$
	:i if $GotParam$$Nollie$
		:i $SetException$$Ex$ = $Ollied$$Scr$ = $NollieNoDisplay$
		:i $NollieOn$
	:i else 
		:i if $GotParam$$OutAnimOnOllie$
			:i $SetException$$Ex$ = $Ollied$$Scr$ = $Ollie$$Params$ = :s{ isNull :s}
		:i else 
			:i $SetException$$Ex$ = $Ollied$$Scr$ = $Ollie$
		:i endif
		:i $NollieOff$
	:i endif
	:i $PressureOff$
	:i %GLOBAL%$is_grind$ = %i(0,00000000)
	:i if $GotParam$$type$
		:i if  (%GLOBAL%$type$ = $Grind$) 
			:i %GLOBAL%$is_grind$ = %i(1,00000001)
		:i endif
	:i else 
		:i $script_assert$%s(32,"No type specified on grind trick")
	:i endif
	:i $SetSparksPos$%GLOBAL%$SparksPos$
	:i if  (%GLOBAL%$is_grind$ = %i(1,00000001)) 
		:i $SparksOn$
	:i else 
		:i $GetBoardScuff$
		:i %GLOBAL%$boardscuff$ =  (%GLOBAL%$boardscuff$ + %i(1,00000001)) 
		:i $SetTags$$boardscuff$ = %GLOBAL%$boardscuff$
		:i $DoBoardScuff$$boardscuff$ = %GLOBAL%$boardscuff$
		:i $SparksOff$
		:i $SparksOn$$type$ = $slide$
	:i endif
	:i $SetException$$Ex$ = $OffRail$$Scr$ = $OffRail$$Params$ = :s{$KissedRail$$initanim$ = %GLOBAL%$initanim$$InitSpeed$ = %GLOBAL%$InitSpeed$$OutAnim$ = %GLOBAL%$OutAnim$$BoardRotate$ = %GLOBAL%$BoardRotate$$OutAnimBackwards$ = %GLOBAL%$OutAnimBackwards$:s}
	:i $SetException$$Ex$ = $Landed$$Scr$ = $Grind_to_Land$
	:i $SetException$$Ex$ = $OffMeterTop$$Scr$ = $SkateInOrBail$$Params$ = :s{ isNull $FallingLeft$:s}
	:i $SetException$$Ex$ = $OffMeterBottom$$Scr$ = $SkateInOrBail$$Params$ = :s{ isNull $Fallingright$:s}
	:i $SetException$$Ex$ = $SkaterCollideBail$$Scr$ = $SkaterCollideBail$
	:i $SetEventHandler$$Ex$ = $MadeOtherSkaterBail$$Scr$ = $MadeOtherSkaterBail_Called$
	:i $OnExceptionRun$$Grind_Kissed$
	:i $ClearTrickQueue$
	:i $ClearManualTrick$
	:i $ClearExtraGrindTrick$
	:i $SetQueueTricks$$NoTricks$
	:i $SetManualTricks$$NoTricks$
	:i $SetRailSound$%GLOBAL%$type$
	:i if $GotParam$$IsSpecial$
		:i $SetGrindTweak$%i(36,00000024)
		:i %GLOBAL%$score$ = $SPECIALGRIND_SCORE$
	:i else 
		:i if $GotParam$$IsATap$
			:i $SetGrindTweak$$GRINDTAP_TWEAK$
			:i %GLOBAL%$score$ = $GRINDTAP_SCORE$
		:i else 
			:i $SetGrindTweak$%GLOBAL%$GrindTweak$
		:i endif
	:i endif
	:i if $GotParam$$IsExtra$
		:i $LaunchExtraMessage$
	:i endif
	:i if $GotParam$$Profile$
		:i if $ProfileEquals$$is_named$ = %GLOBAL%$Profile$
			:i $SwitchOnAtomic$$special_item$
			:i $SwitchOffAtomic$$special_item_2$
		:i endif
	:i endif
	:i if $GotParam$$FullScreenEffect$
		:i %GLOBAL%$FullScreenEffect$
		:i $OnExitRun$$Exit_FullScreenEffect$
	:i endif
	:i if NOT $AnimEquals$$JumpAirTo5050$
		:i if $GotParam$$NoBlend$
			:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$BlendPeriod$ = %f(0.000000)$Speed$ = %GLOBAL%$InitSpeed$
		:i else 
			:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$BlendPeriod$ = %f(0.300000)$Speed$ = %GLOBAL%$InitSpeed$
		:i endif
	:i endif
	:i if $GotParam$$IsATap$
		:i $DoBalanceTrick$$ButtonA$ = $Right$$ButtonB$ = $Left$$type$ = %GLOBAL%$type$$DoFlipCheck$$ClearCheese$$IsATap$ = %i(1,00000001)
	:i else 
		:i if $GotParam$$IsExtra$
			:i $DoBalanceTrick$$ButtonA$ = $Right$$ButtonB$ = $Left$$type$ = %GLOBAL%$type$$DoFlipCheck$$ClearCheese$$IsATap$ = %i(1,00000001)
		:i else 
			:i $DoBalanceTrick$$ButtonA$ = $Right$$ButtonB$ = $Left$$type$ = %GLOBAL%$type$$DoFlipCheck$
		:i endif
	:i endif
	:i $GetSingleTag$$AcidDropCheese$
	:i if $GotParam$$AcidDropCheese$
		:i if  (%GLOBAL%$AcidDropCheese$ > %i(0,00000000)) 
			:i $AdjustBalance$$TimeAdd$ = %i(0,00000000)$SpeedMult$ = %i(2,00000002)$LeanMult$ = %f(3.200000)
			:i $RemoveTags$$tags$ = :a{$AcidDropCheese$:a}
		:i endif
	:i endif
	:i $Wait$%i(15,0000000f)$frames$
	:i $SetExtraTricks$$GrindRelease$
	:i $Wait$%i(1,00000001)$frame$
	:i if $GotParam$$Stream$
		:i if NOT $IsStreamPlaying$$SFXSpecialStream$
			:i $PlayStream$%GLOBAL%$Stream$$vol$ = %i(200,000000c8)$priority$ = $StreamPriorityHigh$$id$ = $SFXSpecialStream$
		:i endif
	:i endif
	:i if $GotParam$$IsSpecial$
		:i $LaunchSpecialMessage$$text$ = %s(13,"Special Grind")
	:i endif
	:i $SetException$$Ex$ = $OffRail$$Scr$ = $OffRail$$Params$ = :s{$initanim$ = %GLOBAL%$initanim$$InitSpeed$ = %GLOBAL%$InitSpeed$$OutAnim$ = %GLOBAL%$OutAnim$$BoardRotate$ = %GLOBAL%$BoardRotate$$OutAnimBackwards$ = %GLOBAL%$OutAnimBackwards$:s}
	:i $OnExceptionRun$$Normal_Grind$
	:i $SetTrickName$%GLOBAL%$Name$
	:i 
:i $SetTrickScore$%GLOBAL%$score$
:i $Display$$Blockspin$$NoSpecial$ = %GLOBAL%$NoSpecial$
:i if $AnimEquals$$JumpAirTo5050$
	:i $Obj_WaitAnimFinished$
	:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$BlendPeriod$ = %f(0.300000)$Speed$ = %GLOBAL%$InitSpeed$
:i endif
:i $Obj_WaitAnimFinished$
:i if $GotParam$$FlipAfterInit$
	:i $Flip$
	:i $PlayBonkSound$
	:i $BoardRotate$
	:i $BlendperiodOut$%i(0,00000000)
:i endif
:i if $GotParam$$Idle$
	:i $PlayAnim$$Anim$ = %GLOBAL%$Anim$$Cycle$$NoRestart$
:i else 
	:i if $GotParam$$Anim3$
		:i if $GotParam$$Anim2$
			:i $PlayAnim$select(2f,3, 01 00 01 00 01 00) :OFFSET(0):OFFSET(1):OFFSET(2)
				 :POS(0) $Anim$ = %GLOBAL%$Anim$
			:BREAKTO(3)
				 :POS(1) $Anim$ = %GLOBAL%$Anim2$
			:BREAKTO(3)
				 :POS(2) $Anim$ = %GLOBAL%$Anim3$ :POS(3) $wobble$$wobbleparams$ = $grindwobble_params$
			:i else 
				:i $ScriptAssert$%s(100,"Script Assert: Added Anim3 to a grind without a valid anim2...check grindscripts.q Problem Anim = %a")$a$ = %GLOBAL%$Anim$
			:i endif
		:i else 
			:i if $GotParam$$Anim2$
				:i $PlayAnim$select(2f,2, 01 00 01 00) :OFFSET(4):OFFSET(5)
					 :POS(4) $Anim$ = %GLOBAL%$Anim$
				:BREAKTO(6)
					 :POS(5) $Anim$ = %GLOBAL%$Anim2$ :POS(6) $wobble$$wobbleparams$ = $grindwobble_params$
				:i else 
					:i $PlayAnim$$Anim$ = %GLOBAL%$Anim$$wobble$$wobbleparams$ = $grindwobble_params$
				:i endif
			:i endif
		:i endif
		:i if $GotParam$$FlipBeforeOutAnim$
			:i $BlendperiodOut$%f(0.000000)
			:i $FlipAfter$
		:i endif
		:i if $AnimEquals$:a{$FiftyFifty_Range$$NoseGrind_Range$$TailGrind_Range$:a}
			:i $Wait$%f(0.250000)$seconds$
		:i endif
		:i if NOT $IsOnMotoskateboard$
			:i if $GotParam$$Extratricks$
				:i $SetExtraTricks$%GLOBAL%$Extratricks$$ignore$ = %GLOBAL%$Name$$GrindRelease$
			:i else 
				:i $SetExtraTricks$$GrindRelease$
			:i endif
		:i endif
		:i if $GotParam$$ScreenShake$
			:i $Grind_ScreenShake$$ScreenShake$ = %GLOBAL%$ScreenShake$
		:i endif
		:i if $GotParam$$specialtrick_particles$
			:i 
		:i $Emit_SpecialTrickParticles$$specialitem_particles$ = %GLOBAL%$specialitem_particles$
	:i endif
	:i $WaitWhilstChecking_ForPressure$ isNull 
:i endfunction
:i function $Grind_to_Land$
	:i $StopBalanceTrick$
	:i $Goto$$Land$
:i endfunction
:i function $Exit_FullScreenEffect$
	:i %GLOBAL%$skaterlights_target$ =  ($tod_skaterlights$) 
	:i $SetFogColor$$r$ = $fog_red$$b$ = $fog_blue$$g$ = $fog_green$$a$ = $fog_alpha$
	:i $SetFogDistance$$distance$ = $fog_dist$
	:i $KillManualVibration$
	:i $Exit_Grind$
:i endfunction
:i function $Exit_FullScreenEffect_and_Special$
	:i $BroadcastEvent$$type$ = $SkaterExitSpecialTrick$
	:i $Exit_FullScreenEffect$
:i endfunction
:i function $Exit_Grind$
	:i $SwitchOnBoard$
	:i $CleanUp_SpecialTrickParticles$
:i endfunction
:i function $Exit_Special_Grind$
	:i $Exit_Special$
	:i $Exit_Grind$
:i endfunction
:i function $Exit_Special$
	:i $BroadcastEvent$$type$ = $SkaterExitSpecialTrick$
:i endfunction
:i function $GetBoardScuff$$ManualName$ = %sc(4,"none")
	:i $GetTags$
	:i return
	$boardscuff$ = %GLOBAL%$boardscuff$
:i endfunction
:i function $Grind_ScreenShake$$ScreenShake$ = %i(60,0000003c)
	:i if $AnimEquals$:a{$ElbowSmash_Idle$$FlipKickDad$:a}
		:i while
			
			:i $Wait$%i(1,00000001)$frame$
			:i if $FrameIs$%GLOBAL%$ScreenShake$
				:i $BloodSplat$
				:i $PlaySound$$BailSlap03$
				:i $ShakeCamera$:s{
					:i $Duration$ = %f(0.500000)
					:i $vert_amp$ = %f(9.000000)
					:i $horiz_amp$ = %f(3.000000)
					:i $vert_vel$ = %f(10.270000)
					:i $horiz_vel$ = %f(5.920000)
				:i :s}
			:i endif
		:i loop_to 
	:i endif
:i endfunction
:i $grindwobble_params$ = :s{
	:i $WobbleAmpA$ = :s{%vec2(0.100000,0.100000)$STATS_RAILBALANCE$:s}
	:i $WobbleAmpB$ = :s{%vec2(0.040000,0.040000)$STATS_RAILBALANCE$:s}
	:i $WobbleK1$ = :s{%vec2(0.002200,0.002200)$STATS_RAILBALANCE$:s}
	:i $WobbleK2$ = :s{%vec2(0.001700,0.001700)$STATS_RAILBALANCE$:s}
	:i $SpazFactor$ = :s{%vec2(1.500000,1.500000)$STATS_RAILBALANCE$:s}
:i :s}
:i function $Grind_Kissed$
	:i if $GotParam$$MadeOtherSkaterBail$
	:i else 
		:i $KillExtraTricks$
	:i endif
	:i $SetTrickName$%s(0,"")
	:i $SetTrickScore$%i(0,00000000)
	:i $Display$$Blockspin$
	:i $Obj_KillSpawnedScript$$Name$ = $CheckForShuffle$
	:i $Obj_SpawnScript$$CheckForShuffle$
:i endfunction
:i function $CheckForShuffle$
	:i $SetException$$Ex$ = $SkaterEnterRail$$Scr$ = $Awardshuffle$
	:i $Wait$%i(15,0000000f)$frames$
:i endfunction
:i function $Awardshuffle$
	:i $SetTrickName$%sc(0,"")
	:i $SetTrickScore$%i(100,00000064)
	:i $Display$$Blockspin$$NoDegrade$
	:i if NOT $InSplitscreenGame$
		:i $Create_Panel_Message$$text$ = %s(13,"Shuffle Bonus")$id$ = $perfect$$rgba$ = :a{%i(50,00000032)%i(120,00000078)%i(200,000000c8)%i(128,00000080):a}$pos$ = %vec2(110.000000,340.000000)$style$ = $perfect_style$
		:i $Create_Panel_Message$$text$ = %s(11,"+100 Points")$id$ = $perfect2$$rgba$ = :a{%i(50,00000032)%i(120,00000078)%i(200,000000c8)%i(100,00000064):a}$pos$ = %vec2(110.000000,360.000000)$style$ = $perfect_style$
	:i else 
		:i $PerfectSloppy_2p$$text$ = %s(8,"Shuffle!")$rgb$ = :a{%i(50,00000032)%i(120,00000078)%i(50,00000032)%i(128,00000080):a}
	:i endif
:i endfunction
:i function $Normal_Grind$
	:i if $GotParam$$MadeOtherSkaterBail$
	:i else 
		:i $KillExtraTricks$
	:i endif
	:i $SwitchOffAtomic$$special_item$
	:i $SwitchOnAtomic$$special_item_2$
:i endfunction
:i function $OffRail$$InitSpeed$ = %f(1.000000)
	:i if $GotParam$$KissedRail$
		:i $SetTrickScore$%i(50,00000032)
		:i $SetTrickName$%s(15,"Kissed the Rail")
		:i $Display$$Blockspin$$NoMult$
	:i endif
	:i $StopBalanceTrick$
	:i $KillExtraTricks$
	:i $Vibrate$$Actuator$ = %i(0,00000000)$Percent$ = %i(0,00000000)
	:i $SetState$$Air$
	:i $SetException$$Ex$ = $Landed$$Scr$ = $Land$
	:i $SetException$$Ex$ = $WallRideLeft$$Scr$ = $WallRide$$Params$ = :s{$Left$:s}
	:i $SetException$$Ex$ = $WallRideRight$$Scr$ = $WallRide$$Params$ = :s{$Right$:s}
	:i $SetException$$Ex$ = $WallPlant$$Scr$ = $Air_WallPlant$
	:i $DoNextTrick$
	:i if $GotParam$$EarlyOut$
		:i $PlayAnim$$Anim$ = %GLOBAL%$EarlyOut$$BlendPeriod$ = %f(0.100000)$Backwards$
	:i else 
		:i if $GotParam$$OutAnim$
			:i if $GotParam$$OutAnimBackwards$
				:i $PlayAnim$$Anim$ = %GLOBAL%$OutAnim$$Backwards$$BlendPeriod$ = %f(0.100000)$Speed$ = %GLOBAL%$InitSpeed$
			:i else 
				:i $PlayAnim$$Anim$ = %GLOBAL%$OutAnim$$BlendPeriod$ = %f(0.100000)$Speed$ = %GLOBAL%$InitSpeed$
			:i endif
		:i else 
			:i $PlayAnim$$Anim$ = %GLOBAL%$initanim$$BlendPeriod$ = %f(0.100000)$Backwards$$Speed$ = %GLOBAL%$InitSpeed$
		:i endif
	:i endif
	:i if $GotParam$$BoardRotate$
		:i $BlendperiodOut$%i(0,00000000)
		:i $BoardRotateAfter$
	:i endif
	:i if $GotParam$$FlipAfter$
		:i $FlipAfter$
	:i endif
	:i $Obj_WaitAnimFinished$
	:i $Goto$$Airborne$
:i endfunction
:i function $Trick_5050_BS$$Name$ = %sc(8,"BS 50-50")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_FiftyFifty$$Anim$ = $FiftyFifty2_range$$Anim2$ = $FiftyFifty_Range$$Anim3$ = $FiftyFifty3_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparkPos$ = $rear$:s}
:i endfunction
:i function $Trick_5050_FS$$Name$ = %sc(8,"FS 50-50")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_FiftyFifty$$Anim$ = $FiftyFifty2_range$$Anim2$ = $FiftyFifty_Range$$Anim3$ = $FiftyFifty3_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_5050_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_5050_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_5050_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_5050_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Boardslide_FS$$Name$ = %sc(13,"FS Boardslide")
	:i $Rotate$
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(200,000000c8)$GrindTweak$ = %i(14,0000000e)$initanim$ = $Init_FSBoardslide$$Anim$ = $FSBoardslide_range$$OutAnim$ = $FSBoardslide_Out$$NoBlend$ = $yes$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $front$:s}
:i endfunction
:i function $Trick_Boardslide_BS$$Name$ = %sc(13,"BS Boardslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(200,000000c8)$GrindTweak$ = %i(14,0000000e)$initanim$ = $Init_BSBoardslide$$Anim$ = $BSBoardslide_range$$OutAnim$ = $BSBoardslide_Out$$NoBlend$ = $yes$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $rear$:s}
:i endfunction
:i function $Trick_Lipslide_FS$$Name$ = %sc(11,"FS Lipslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(200,000000c8)$GrindTweak$ = %i(14,0000000e)$initanim$ = $Init_FSLipslide$$Anim$ = $BSBoardslide_range$$OutAnim$ = $BSBoardslide_Out$$NoBlend$ = $yes$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $front$:s}
:i endfunction
:i function $Trick_Lipslide_BS$$Name$ = %sc(11,"BS Lipslide")
	:i $Rotate$
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(200,000000c8)$GrindTweak$ = %i(14,0000000e)$initanim$ = $Init_BSLipslide$$Anim$ = $FSBoardslide_range$$OutAnim$ = $FSBoardslide_Out$$NoBlend$ = $yes$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $rear$:s}
:i endfunction
:i function $Trick_Tailslide_FS$
	:i if $BadLedge$
		:i $Goto$$Trick_NoseSlide_BS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i else 
		:i $Goto$$Trick_Tailslide_FS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i endif
:i endfunction
:i function $Trick_Tailslide_FS_ok$$Name$ = %sc(12,"FS Tailslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(150,00000096)$GrindTweak$ = %i(11,0000000b)$initanim$ = $Init_FSTailslide$$InitSpeed$ = %f(1.500000)$Anim$ = $FSTailslide_range$$OutAnim$ = $FSTailslide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Tailslide_BS$
	:i if $BadLedge$
		:i $Goto$$Trick_NoseSlide_FS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i else 
		:i $Goto$$Trick_Tailslide_BS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i endif
:i endfunction
:i function $Trick_Tailslide_BS_ok$$Name$ = %sc(12,"BS Tailslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(150,00000096)$GrindTweak$ = %i(11,0000000b)$initanim$ = $Init_Tailslide$$InitSpeed$ = %f(1.500000)$Anim$ = $Tailslide_range$$OutAnim$ = $BSTailslide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Tailslide_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Tailslide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Tailslide_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Tailslide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NoseSlide_FS$
	:i if $BadLedge$
		:i $Goto$$Trick_Tailslide_BS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i else 
		:i $Goto$$Trick_NoseSlide_FS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i endif
:i endfunction
:i function $Trick_NoseSlide_FS_ok$$Name$ = %sc(12,"FS Noseslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(150,00000096)$GrindTweak$ = %i(11,0000000b)$initanim$ = $Init_FSNoseslide$$InitSpeed$ = %f(1.500000)$Anim$ = $FSNoseslide_range$$type$ = $slide$$Nollie$ = $yes$$OutAnim$ = $FSNoseSlide_Out$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_NoseSlide_BS$
	:i if $BadLedge$
		:i $Goto$$Trick_Tailslide_FS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i else 
		:i $Goto$$Trick_NoseSlide_BS_ok$$Params$ = :s{$IsExtra$ = %GLOBAL%$IsExtra$$NoBlend$ = %GLOBAL%$NoBlend$:s}
	:i endif
:i endfunction
:i function $Trick_NoseSlide_BS_ok$$Name$ = %sc(12,"BS Noseslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(150,00000096)$GrindTweak$ = %i(11,0000000b)$initanim$ = $Init_Noseslide$$InitSpeed$ = %f(1.500000)$Anim$ = $Noseslide_range$$OutAnim$ = $BSNoseslide_Out$$type$ = $slide$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Noseslide_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseSlide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Noseslide_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseSlide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Nosegrind_FS$$Name$ = %sc(12,"FS Nosegrind")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_Nosegrind$$InitSpeed$ = %f(1.500000)$Anim$ = $NoseGrind_Range$$type$ = $Grind$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Nosegrind_BS$$Name$ = %sc(12,"BS Nosegrind")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_Nosegrind$$InitSpeed$ = %f(1.500000)$Anim$ = $NoseGrind_Range$$type$ = $Grind$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_NoseGrind_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_5_0_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NoseGrind_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_5_0_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_5_0_FS$$Name$ = %sc(6,"FS 5-0")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_Tailgrind$$InitSpeed$ = %f(1.500000)$Anim$ = $TailGrind_Range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_5_0_BS$$Name$ = %sc(6,"BS 5-0")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(100,00000064)$initanim$ = $Init_Tailgrind$$InitSpeed$ = %f(1.500000)$Anim$ = $TailGrind_Range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_5_0_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Nosegrind_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_5_0_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Nosegrind_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Crooked_FS$$Name$ = %sc(10,"FS Crooked")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_FSCrooked$$InitSpeed$ = %f(1.500000)$Anim$ = $FSCrooked_range$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Crooked_FS_rot$
	:i $Rotate$
	:i $Goto$$Trick_Crooked_FS$
:i endfunction
:i function $Trick_Crooked_BS$$Name$ = %sc(10,"BS Crooked")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_BSCrooked$$InitSpeed$ = %f(1.500000)$Anim$ = $BSCrooked_range$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Crooked_FS_180$
	:i if $Backwards$
	:i endif
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Crooked_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Crooked_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Crooked_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NGCRook_FS_rot$
	:i $Rotate$
	:i $Goto$$Trick_NGCRook_FS$
:i endfunction
:i function $Trick_NGCRook_FS$$Name$ = %sc(12,"FS Overcrook")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_FSOvercrook$$InitSpeed$ = %f(1.500000)$Anim$ = $FSOvercrook_range$$type$ = $Grind$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_NGCrook_BS$$Name$ = %sc(12,"BS Overcrook")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_BSOvercrook$$InitSpeed$ = %f(1.500000)$Anim$ = $BSOvercrook_range$$type$ = $Grind$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_NGCRook_FS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_NGCrook_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NGCrook_BS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_NGCRook_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Smith_FS$$Name$ = %sc(8,"FS Smith")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_FSSmith$$InitSpeed$ = %f(1.500000)$Anim$ = $FSSmith_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Smith_FS_rot$
	:i $Rotate$
	:i $Goto$$Trick_Smith_FS$
:i endfunction
:i function $Trick_Smith_BS$$Name$ = %sc(8,"BS Smith")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_BSSmith$$InitSpeed$ = %f(1.500000)$Anim$ = $BSSmith_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Smith_FS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Smith_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Smith_BS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Smith_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Feeble_FS$$Name$ = %sc(9,"FS Feeble")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_FSFeeble$$InitSpeed$ = %f(1.500000)$Anim$ = $FSFeeble_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Feeble_FS_rot$
	:i $Rotate$
	:i $Goto$$Trick_Feeble_FS$
:i endfunction
:i function $Trick_Feeble_BS$$Name$ = %sc(9,"BS Feeble")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(125,0000007d)$GrindTweak$ = %i(9,00000009)$initanim$ = $Init_BSFeeble$$InitSpeed$ = %f(1.500000)$Anim$ = $BSFeeble_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_Feeble_FS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Feeble_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Feeble_BS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Feeble_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Bluntslide_BS$$Name$ = %sc(13,"BS Bluntslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(250,000000fa)$GrindTweak$ = %i(18,00000012)$initanim$ = $Init_BSBluntSlide$$InitSpeed$ = %f(1.500000)$Anim$ = $BSBluntSlide_range$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_Bluntslide_FS$$Name$ = %sc(13,"FS Bluntslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(250,000000fa)$GrindTweak$ = %i(18,00000012)$initanim$ = $Init_FSBluntSlide$$InitSpeed$ = %f(1.500000)$Anim$ = $FSBluntSlide_range$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_NoseBluntSlide_BS$$Name$ = %sc(17,"BS Nosebluntslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(250,000000fa)$GrindTweak$ = %i(18,00000012)$initanim$ = $Init_BSNoseblunt$$InitSpeed$ = %f(1.500000)$Anim$ = $BSNoseblunt_range$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Nollie$ = $yes$
		:i $SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_NoseBluntSlide_FS$$Name$ = %sc(17,"FS Nosebluntslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(250,000000fa)$GrindTweak$ = %i(18,00000012)$initanim$ = $Init_FSNoseblunt$$InitSpeed$ = %f(1.500000)$Anim$ = $FSNoseblunt_range$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Nollie$ = $yes$$IsExtra$ = %GLOBAL%$IsExtra$$Extratricks$ = $Extra_FS_Grinds$
		:i $SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_Bluntslide_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Bluntslide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Bluntslide_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Bluntslide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Nosebluntslide_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseBluntSlide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Nosebluntslide_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseBluntSlide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_DoubleBluntSlide2$
	:i $Grind$:s{$Name$ = %sc(18,"Double Blunt Slide")$score$ = $GRINDTAP_SCORE$$initanim$ = $DoubleBlunt_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $DoubleBlunt_Idle$$Idle$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_FS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_DoubleBluntSlide2_180$
	:i $BackwardsGrind$$Grind$ = $Trick_DoubleBluntSlide2$
:i endfunction
:i function $Trick_Salad_FS$$Name$ = %sc(8,"FS Salad")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$initanim$ = $FSSaladGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $FSSaladGrind_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$Extratricks$ = $Extra_FS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Salad_BS$$Name$ = %sc(8,"BS Salad")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$initanim$ = $BSSaladGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $BSSaladGrind_range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Salad_FS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Salad_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Salad_BS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_Salad_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Hurricane_BS$
	:i $Grind$:s{$Name$ = %sc(12,"BS Hurricane")$initanim$ = $BSHurricaneGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $BSHurricaneGrind_Range$$OutAnim$ = $Init_Tailgrind$$OutAnimBackwards$ = %i(1,00000001)$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Nollie$ = $yes$$FlipBeforeOutAnim$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_Hurricane_FS$
	:i $Grind$:s{$Name$ = %sc(12,"FS Hurricane")$initanim$ = $FSHurricaneGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $FSHurricaneGrind_Range$$OutAnim$ = $Nollie$$type$ = $Grind$$NoBlend$ = $NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$FlipBeforeOutAnim$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Hurricane_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Hurricane_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Hurricane_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Hurricane_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Darkslide_BS$
	:i $Grind$:s{$Name$ = %sc(12,"BS Darkslide")$initanim$ = $Darkslide_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $Darkslide_Range$$OutAnim$ = $Darkslide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$OutAnimOnOllie$$BoardRotate$ = $yes$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Darkslide_FS$
	:i $Grind$:s{$Name$ = %sc(12,"FS Darkslide")$initanim$ = $FSDarkSlide_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $FSDarkSlide_Range$$OutAnim$ = $FSDarkSlide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$OutAnimOnOllie$$BoardRotate$ = $yes$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Darkslide_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Darkslide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Darkslide_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Darkslide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_CrailSlide_BS$
	:i $Grind$:s{$Name$ = %sc(14,"BS Crail Slide")$initanim$ = $CrailSlide_Init$$Anim$ = $CrailSlide_Range$$OutAnim$ = $CrailSlide_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_CrailSlide_FS$
	:i $Grind$:s{$Name$ = %sc(14,"FS Crail Slide")$initanim$ = $CrailSlide_Init$$Anim$ = $CrailSlide_Range$$OutAnim$ = $CrailSlide_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_CrailSlide_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_CrailSlide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_CrailSlide_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_CrailSlide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_GrindOverturn_BS$
	:i $Grind$:s{$Name$ = %sc(15,"BS 5-0 Overturn")$initanim$ = $GrindOverturn_Init$$Anim$ = $GrindOverturn_Range$$OutAnim$ = $Init_Nosegrind$$OutAnimBackwards$ = %i(1,00000001)$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$FlipBeforeOutAnim$$Extratricks$ = $Extra_BS_Grinds$$Nollie$ = %i(1,00000001)$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_GrindOverturn_FS$
	:i $Grind$:s{$Name$ = %sc(15,"FS 5-0 Overturn")$initanim$ = $GrindOverturn_Init$$Anim$ = $GrindOverturn_Range$$OutAnim$ = $Init_Nosegrind$$OutAnimBackwards$ = %i(1,00000001)$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$FlipBeforeOutAnim$$Extratricks$ = $Extra_FS_Grinds$$Nollie$ = %i(1,00000001)$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $rear$:s}
:i endfunction
:i function $Trick_GrindOverturn_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_GrindOverturn_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_GrindOverturn_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_GrindOverturn_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_HangTenNoseGrind_BS$
	:i $Grind$:s{$Name$ = %sc(18,"Hang Ten Nosegrind")$initanim$ = $HangTenNoseGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $HangTenNoseGrind_Range$$OutAnim$ = $HangTenNoseGrind_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$Nollie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_HangTenNoseGrind_FS$
	:i $Grind$:s{$Name$ = %sc(18,"Hang Ten Nosegrind")$initanim$ = $HangTenNoseGrind_Init$$InitSpeed$ = %f(1.500000)$Anim$ = $HangTenNoseGrind_Range$$OutAnim$ = $HangTenNoseGrind_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$Nollie$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_HangTenNoseGrind_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_HangTenNoseGrind_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_HangTenNoseGrind_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_HangTenNoseGrind_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NosegrindPivot_BS$
	:i $Grind$:s{$Name$ = %sc(18,"Nosegrind to Pivot")$initanim$ = $NosegrindPivot_Init$$InitSpeed$ = %f(1.750000)$Anim$ = $NosegrindPivot_Range$$OutAnim$ = $Init_Tailgrind$$OutAnimBackwards$ = %i(1,00000001)$NoBlend$ = $NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$BoardRotate$ = $yes$$FlipBeforeOutAnim$$EarlyOut$ = $Init_Tailgrind$$Extratricks$ = $Extra_BS_Grinds$$IsATap$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $Grind$$SparksPos$ = $front$:s}
:i endfunction
:i function $Trick_NosegrindPivot_FS$
	:i $Goto$$Trick_NosegrindPivot_BS$$Params$ = :s{$IsExtra$ = $IsExtra$:s}
:i endfunction
:i function $Trick_NosegrindPivot_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NosegrindPivot_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NosegrindPivot_FS_180$
	:i $Goto$$Trick_NosegrindPivot_BS_180$
:i endfunction
:i function $Trick_Muska_Burn_BS$$Name$ = %sc(19,"BS Muska 5-0 Flames")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Muska_Burn_init$$Anim$ = $Special_Muska_Burn_range$$OutAnim$ = $Special_Muska_Burn_out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparkPos$ = $rear$$Stream$ = $Spec_Muska01$:s}
:i endfunction
:i function $Trick_Muska_Burn_FS$$Name$ = %sc(19,"FS Muska 5-0 Flames")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Muska_Burn_init$$Anim$ = $Special_Muska_Burn_range$$OutAnim$ = $Special_Muska_Burn_out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_Muska01$:s}
:i endfunction
:i function $Trick_Muska_Burn_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Muska_Burn_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Muska_Burn_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Muska_Burn_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Worm_BS$$Name$ = %sc(7,"BS Worm")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Muska_Worm_Init$$Anim$ = $Special_Muska_Worm_idle$$Idle$$OutAnim$ = $Special_Muska_Worm_out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparkPos$ = $rear$$Stream$ = $Spec_Muska02$:s}
:i endfunction
:i function $Trick_Worm_FS$$Name$ = %sc(7,"FS Worm")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Muska_Worm_Init$$Anim$ = $Special_Muska_Worm_idle$$Idle$$OutAnim$ = $Special_Muska_Worm_out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_Muska02$:s}
:i endfunction
:i function $Trick_Worm_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Worm_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Worm_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Worm_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_TheBird_BS$$Name$ = %sc(10,"BS TheBird")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Hand_TheBird_Init$$Anim$ = $Special_Hand_TheBird_Range$$OutAnim$ = $Special_Hand_TheBird_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $SparkPos$ = $rear$$Stream$ = $Spec_TheHand01$:s}
:i endfunction
:i function $Trick_TheBird_FS$$Name$ = %sc(10,"FS TheBird")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Hand_TheBird_Init$$Anim$ = $Special_Hand_TheBird_Range$$OutAnim$ = $Special_Hand_TheBird_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_TheHand01$:s}
:i endfunction
:i function $Trick_TheBird_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_TheBird_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_TheBird_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_TheBird_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BullF_Sword_BS$$Name$ = %sc(21,"BS Espana Sword Slide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_BullF_Sword_Init$$Anim$ = $Special_BullF_Sword_Idle$$Idle$$OutAnim$ = $Special_BullF_Sword_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$SpecialItem_details$ = $Sword_details$$Stream$ = $Spec_Toreador01$:s}
:i endfunction
:i function $Trick_BullF_Sword_FS$$Name$ = %sc(21,"FS Espana Sword Slide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_BullF_Sword_Init$$Anim$ = $Special_BullF_Sword_Idle$$Idle$$OutAnim$ = $Special_BullF_Sword_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SpecialItem_details$ = $Sword_details$$Stream$ = $Spec_Toreador01$:s}
:i endfunction
:i function $Trick_BullF_Sword_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_BullF_Sword_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BullF_Sword_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_BullF_Sword_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Bam_Chainsaw_BS$$Name$ = %sc(18,"BS Chainsaw Rocker")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Bam_Chainsaw_Init$$Anim$ = $Special_Bam_Chainsaw_Idle$$Idle$$OutAnim$ = $Special_Bam_Chainsaw_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$SpecialItem_details$ = $Chainsaw_details$$Stream$ = $Spec_Margera02$:s}
:i endfunction
:i function $Trick_Bam_Chainsaw_FS$$Name$ = %sc(18,"FS Chainsaw Rocker")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Bam_Chainsaw_Init$$Anim$ = $Special_Bam_Chainsaw_Idle$$Idle$$OutAnim$ = $Special_Bam_Chainsaw_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SpecialItem_details$ = $Chainsaw_details$$Stream$ = $Spec_Margera02$:s}
:i endfunction
:i function $Trick_Bam_Chainsaw_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Bam_Chainsaw_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Bam_Chainsaw_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Bam_Chainsaw_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_ShecklerPrimo_BS$$Name$ = %sc(8,"BS Shark")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Sheckler_Primo_Init$$Anim$ = $Special_Sheckler_Primo_Range$$OutAnim$ = $Special_Sheckler_Primo_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$SpecialItem_details$ = $Shark_details$$Stream$ = $Spec_Sheckler02$:s}
:i endfunction
:i function $Trick_ShecklerPrimo_FS$$Name$ = %sc(8,"FS Shark")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Sheckler_Primo_Init$$Anim$ = $Special_Sheckler_Primo_Range$$OutAnim$ = $Special_Sheckler_Primo_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SpecialItem_details$ = $Shark_details$$Stream$ = $Spec_Sheckler02$:s}
:i endfunction
:i function $Trick_ShecklerPrimo_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_ShecklerPrimo_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_ShecklerPrimo_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_ShecklerPrimo_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Waxslide_BS$$Name$ = %sc(11,"BS Waxslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Shrek_Waxslide_Init$$Anim$ = $Special_Shrek_Waxslide_Range$$OutAnim$ = $Special_Shrek_Waxslide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$Stream$ = $Spec_Shrek02$:s}
:i endfunction
:i function $Trick_Waxslide_FS$$Name$ = %sc(11,"FS Waxslide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Shrek_Waxslide_Init$$Anim$ = $Special_Shrek_Waxslide_Range$$OutAnim$ = $Special_Shrek_Waxslide_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_Shrek02$:s}
:i endfunction
:i function $Trick_Waxslide_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Waxslide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Waxslide_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Waxslide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Hero_BS$$Name$ = %sc(7,"BS Hero")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Soldier_AmerHero2_Init$$Anim$ = $Special_Soldier_AmerHero2_Idle$$Idle$$OutAnim$ = $Special_Soldier_AmerHero2_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$SpecialItem_details$ = $Flag_details$$Stream$ = $Spec_CallofDuty02$:s}
:i endfunction
:i function $Trick_Hero_FS$$Name$ = %sc(7,"FS Hero")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Soldier_AmerHero2_Init$$Anim$ = $Special_Soldier_AmerHero2_Idle$$Idle$$OutAnim$ = $Special_Soldier_AmerHero2_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SpecialItem_details$ = $Flag_details$$Stream$ = $Spec_CallofDuty02$:s}
:i endfunction
:i function $Trick_Hero_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Hero_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Hero_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Hero_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_RockNRollSwitch_BS$$Name$ = %sc(17,"BS Lip Bodyvarial")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Bob_RockNRollSwitch_Init$$Anim$ = $Special_Bob_RockNRollSwitch_Idle$$Idle$$OutAnim$ = $Special_Bob_RockNRollSwitch_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$Stream$ = $Spec_Burnquist02$:s}
:i endfunction
:i function $Trick_RockNRollSwitch_FS$$Name$ = %sc(19,"FS Board Bodyvarial")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_Bob_RockNRollSwitch_Init$$Anim$ = $Special_Bob_RockNRollSwitch_Idle$$Idle$$OutAnim$ = $Special_Bob_RockNRollSwitch_Out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_Burnquist02$:s}
:i endfunction
:i function $Trick_RockNRollSwitch_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_RockNRollSwitch_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_RockNRollSwitch_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_RockNRollSwitch_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BiteBoard_BS$$Name$ = %sc(10,"Bite Board")
	:i if $BoardIsRotated$
		:i $BoardRotate$
	:i endif
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_SteveO_BiteBoard$$Anim$ = $FiftyFifty2_range$$OutAnim$ = $Init_FiftyFifty$$OutAnimBackwards$ = %i(1,00000001)$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$SparkPos$ = $rear$$Stream$ = $Spec_SteveO01$:s}
:i endfunction
:i function $Trick_BiteBoard_FS$$Name$ = %sc(10,"Bite Board")
	:i if $BoardIsRotated$
		:i $BoardRotate$
	:i endif
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(600,00000258)$initanim$ = $Special_SteveO_BiteBoard$$Anim$ = $FiftyFifty2_range$$OutAnim$ = $Init_FiftyFifty$$OutAnimBackwards$ = %i(1,00000001)$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$$Stream$ = $Spec_SteveO01$:s}
:i endfunction
:i function $Trick_BiteBoard_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_BiteBoard_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BiteBoard_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_BiteBoard_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Franklin_Grind2$
	:i $SpawnScript$$Franklin_Grind_SFX$
	:i $Grind$:s{$Name$ = %sc(17,"Franklin Grind!!!")$score$ = %i(600,00000258)$initanim$ = $Special_FranklinGrind_Init$$Anim$ = $Special_FranklinGrind_Idle$$Idle$$OutAnim$ = $Special_FranklinGrind_Out$$type$ = $slide$$NoBlend$ = $yes$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$OutAnimOnOllie$$Nollie$ = $no$$Extratricks$ = $Extra_BS_Grinds$$SpecialItem_details$ = $FranklinKite_details$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Franklin_Grind2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Franklin_Grind2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Shortbus2$
	:i $Grind$:s{$Name$ = %sc(12,"Stupid Grind")$score$ = %i(500,000001f4)$initanim$ = $Shortbus_Init$$Anim$ = $Shortbus_idle$$Idle$$OutAnim$ = $Shortbus_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Nollie$ = $yes$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Shortbus2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Shortbus2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_RodneyGrind2$
	:i $Grind$:s{$Name$ = %sc(12,"Rodney Primo")$score$ = %i(500,000001f4)$initanim$ = $RodneyGrind_Init$$Anim$ = $RodneyGrind_range$$OutAnim$ = $RodneyGrind_Out$$type$ = $Grind$$BoardRotate$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$Nollie$ = $yes$$IsSpecial$$InitSpeed$ = %f(0.700000)$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_GrindNBarf2$
	:i $Grind$:s{$Name$ = %sc(12,"Grind N Barf")$InitSpeed$ = %f(1.500000)$score$ = %i(500,000001f4)$initanim$ = $GrindNBarf_Init$$Anim$ = $GrindNBarf_range$$OutAnim$ = $GrindNBarf_Out$$type$ = $Grind$$BoardRotate$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$Nollie$ = $yes$$IsSpecial$$OutAnimOnOllie$$Stream$ = $DryHeaveSpecial$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_RowleyDarkSlideHandStand2$
	:i $Grind$:s{$Name$ = %sc(19,"Darkslide Handstand")$score$ = %i(700,000002bc)$initanim$ = $RowleyDarkSlideHandStand_Init$$Anim$ = $RowleyDarkSlideHandStand_range$$OutAnim$ = $RowleyDarkSlideHandStand_Out$$type$ = $slide$$NoBlend$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_RowleyDarkSlideHandStand2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_RowleyDarkSlideHandStand2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_PrimoHandStand2$
	:i $Grind$:s{$Name$ = %sc(15,"Primo Handstand")$score$ = %i(700,000002bc)$initanim$ = $PrimoHandStand_Init$$Anim$ = $PrimoHandStand_range$$OutAnim$ = $PrimoHandStand_Out$$type$ = $slide$$NoBlend$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$IsSpecial$$Stream$ = $nj_pipeignite$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_PrimoHandStand2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_PrimoHandStand2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_OneFootDarkSlide2$
	:i $Grind$:s{$Name$ = %sc(18,"One Foot Darkslide")$score$ = %i(600,00000258)$initanim$ = $OneFootDarkSlide_Init$$Anim$ = $OneFootDarkSlide_range$$OutAnim$ = $OneFootDarkSlide_Out$$type$ = $slide$$NoBlend$ = $yes$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_OneFootDarkslide2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_OneFootDarkSlide2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_FiftyFiftySwitcheroo2$
	:i $Grind$:s{$Name$ = %sc(15,"5050 Switcheroo")$score$ = %i(600,00000258)$initanim$ = $FiftyFiftySwitcheroo_Init$$Anim$ = $FiftyFiftySwitcheroo_Idle$$Idle$$type$ = $Grind$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Speed$ = %i(3,00000003)$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_HCNHDF2$
	:i $Grind$:s{$Name$ = %sc(16,"Crooks DarkSlide")$score$ = %i(700,000002bc)$initanim$ = $HCNHDF_Init$$Anim$ = $HCNHDF_range$$OutAnim$ = $HCNHDF_Out$$InitSpeed$ = %f(1.500000)$type$ = $slide$$NoBlend$ = $yes$
		:i $GrindBail$ = $BackwardsGrindBails$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_HCNHDF2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_HCNHDF2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_FSNollie360FlipCrook2$
	:i $Grind$:s{$Name$ = %sc(20,"Nollie 360flip Crook")$score$ = %i(600,00000258)$initanim$ = $FSNollie360FlipCrook_Init$$Anim$ = $FSNollie360FlipCrook_range$$OutAnim$ = $FSNollie360FlipCrook_Out$$type$ = $Grind$$NoBlend$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_FSNollie360FlipCrook2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_FSNollie360FlipCrook2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_MoonwalkGrind2$
	:i $Grind$:s{$Name$ = %sc(15,"Moonwalk Five-O")$score$ = %i(600,00000258)$initanim$ = $Moonwalkgrind_Init$$Anim$ = $Moonwalkgrind_idle$$Idle$$OutAnim$ = $Moonwalkgrind_Out$$type$ = $Grind$$NoBlend$ = $yes$
		:i $GrindBail$ = $BackwardsGrindBails$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_MoonwalkGrind2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_MoonwalkGrind2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_360ShovitNoseGrind2$
	:i $Grind$:s{$Name$ = %sc(22,"360 Shove-It NoseGrind")$score$ = %i(600,00000258)$initanim$ = $_360ShovitNoseGrind_Init$$Anim$ = $_360ShovitNoseGrind_range$$InitSpeed$ = %f(2.000000)$OutAnim$ = $_360ShovitNoseGrind_Out$$type$ = $Grind$$NoBlend$ = $yes$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_360ShovitNoseGrind2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_360ShovitNoseGrind2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Coffin_BS$
	:i $Grind$:s{$Name$ = %sc(9,"BS Coffin")$score$ = %i(500,000001f4)$initanim$ = $CoffinGrind_Init$$Anim$ = $CoffinGrind_Range$$OutAnim$ = $CoffinGrind_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Coffin_FS$
	:i $Grind$:s{$Name$ = %sc(9,"FS Coffin")$score$ = %i(500,000001f4)$initanim$ = $CoffinGrind_Init$$Anim$ = $CoffinGrind_Range$$OutAnim$ = $CoffinGrind_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_BS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_Coffin_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Coffin_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_Coffin_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_Coffin_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_fandangle_BS$
	:i $Grind$:s{$Name$ = %sc(12,"BS Fandangle")$score$ = %i(500,000001f4)$initanim$ = $fandangle_Init$$Anim$ = $fandangle_Range$$OutAnim$ = $Fandangle_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$$OutAnimOnOllie$$BoardRotate$ = $yes$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_fandangle_FS$
	:i $Grind$:s{$Name$ = %sc(12,"FS Fandangle")$score$ = %i(500,000001f4)$initanim$ = $fandangle_Init$$Anim$ = $fandangle_Range$$OutAnim$ = $Fandangle_Out$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$OutAnimOnOllie$$BoardRotate$ = $yes$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_fandangle_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_fandangle_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_fandangle_FS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_fandangle_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BigHitter_BS$$Extratricks$ = $Extra_BS_Grinds$
	:i $Grind$:s{$Name$ = %sc(13,"Big Hitter II")$score$ = %i(500,000001f4)$initanim$ = $BigHitter_Init$$Anim$ = $BigHitter_Range$$OutAnim$ = $BigHitter_out$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$IsSpecial$$Extratricks$ = %GLOBAL%$Extratricks$$OutAnimOnOllie$:s}
:i endfunction
:i function $Trick_BigHitter_FS$
	:i $Goto$$Trick_BigHitter_BS$$Params$ = :s{$Extratricks$ = $Extra_FS_Grinds$:s}
:i endfunction
:i function $Trick_BigHitter_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_BigHitter_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_BigHitter_FS_180$
	:i $Goto$$Trick_BigHitter_BS_180$
:i endfunction
:i function $Trick_TailblockSlide_BS$
	:i $Grind$:s{$Name$ = %sc(15,"Tailblock Slide")$score$ = %i(500,000001f4)$initanim$ = $TailblockSlide_Init$$Anim$ = $TailblockSlide_Range$$OutAnim$ = $TailblockSlide_Init$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = %GLOBAL%$Extratricks$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$:s}
:i endfunction
:i function $Trick_TailblockSlide_FS$
	:i $Goto$$Trick_TailblockSlide_BS$$Params$ = :s{$Extratricks$ = $Extra_FS_Grinds$:s}
:i endfunction
:i function $Trick_TailblockSlide_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_TailblockSlide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_TailblockSlide_FS_180$
	:i $Goto$$Trick_TailblockSlide_BS_180$
:i endfunction
:i function $Trick_DrunkGrind_BS$
	:i $Grind$:s{$Name$ = %sc(11,"S.U.I Grind")$score$ = %i(500,000001f4)$initanim$ = $DrunkGrind_Init$$Anim$ = $DrunkGrind_Idle$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$OutAnimOnOllie$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_NoseSlideLipSlide_FS$
	:i if $BadLedge$
		:i $Goto$$Trick_NoseSlideLipSlide_BS_ok$
	:i else 
		:i $Goto$$Trick_NoseSlideLipSlide_FS_ok$
	:i endif
:i endfunction
:i function $Trick_NoseSlideLipSlide_FS_ok$$Name$ = %sc(21,"FS Noseslide LipSlide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(500,000001f4)$initanim$ = $FSNoseSlideLipSlide$$Anim$ = $BSBoardslide_range$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_FS_Grinds$$IsSpecial$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $front$:s}
:i endfunction
:i function $Trick_NoseSlideLipSlide_BS$
	:i if $BadLedge$
		:i $Goto$$Trick_NoseSlideLipSlide_FS_ok$
	:i else 
		:i $Goto$$Trick_NoseSlideLipSlide_BS_ok$
	:i endif
:i endfunction
:i function $Trick_NoseSlideLipSlide_BS_ok$$Name$ = %sc(21,"BS NoseSlide LipSlide")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(500,000001f4)$initanim$ = $BSNoseSlideLipSlide$$Anim$ = $FSBoardslide_range$$Nollie$ = $yes$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsSpecial$$IsExtra$ = %GLOBAL%$IsExtra$
		:i $type$ = $slide$$SparkPos$ = $rear$:s}
:i endfunction
:i function $Trick_NoseSlideLipSlide_FS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseSlideLipSlide_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_NoseSlideLipSlide_BS_180$
	:i $FlipAndRotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_NoseSlideLipSlide_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_CrookedBigSpin_BS$
	:i $Grind$:s{$Name$ = %sc(33,"Crook BigSpinFlip Switch FS Crook")$score$ = %i(500,000001f4)
		$special_item$$initanim$ = $CrookBigSpinFlipCrook$$Anim$ = $FSCrooked_range$$OutAnim$ = $Init_FSCrooked$$OutAnimBackwards$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $BackwardsGrindBails$$IsSpecial$$FlipAfterInit$$Extratricks$ = $Extra_FS_Grinds$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_CrookedBigSpin_FS$
	:i $Goto$$Trick_CrookedBigSpin_BS$$Params$ = :s{$NoBlend$ = $yes$$Name$ = %sc(31,"Overcrook BigSpinFlip Overcrook"):s}
:i endfunction
:i function $Trick_CrookedBigSpin_BS_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_CrookedBigSpin_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_CrookedBigSpin_FS_180$
	:i $Goto$$Trick_CrookedBigSpin_BS_180$
:i endfunction
:i function $Trick_50Fingerflip2$
	:i $Grind$:s{$Name$ = %sc(24,"5-0 Fingerflip Nosegrind")$score$ = %i(500,000001f4)$initanim$ = $TailGrindFingerFlip$$Anim$ = $NoseGrind_Range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_BS_Grinds$:s}
:i endfunction
:i function $Trick_50Fingerflip2_180$
	:i $BackwardsGrind$$Grind$ = $Trick_50Fingerflip2$
:i endfunction
:i function $Trick_DaffyBrokenGrind2$
	:i $Grind$:s{$Name$ = %sc(11,"Daffy Grind")$score$ = %i(500,000001f4)$initanim$ = $DaffyBroken_Init$$Anim$ = $DaffyBroken_Range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$IsSpecial$$Extratricks$ = $Extra_FS_Grinds$$SpecialItem_details$ = $bustedboard_details$:s}
:i endfunction
:i function $Trick_DaffyBrokenGrind2_180$
	:i $BackwardsGrind$$Grind$ = $Trick_DaffyBrokenGrind2$
:i endfunction
:i function $Trick_BballSlide2_180$
	:i $BackwardsGrind$$Grind$ = $Trick_BballSlide2$
:i endfunction
:i function $Trick_ElbowSmash2$
	:i $Grind$:s{$Name$ = %sc(11,"Elbow Smash")$score$ = %i(500,000001f4)$initanim$ = $ElbowSmash_Init$$Anim$ = $ElbowSmash_Idle$$Idle$$OutAnim$ = $Elbowsmash_out$$OutAnimOnOllie$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$$Idle$
		:i $GrindBail$ = $FiftyFiftyFall$$ScreenShake$ = %i(60,0000003c)$IsSpecial$:s}
:i endfunction
:i function $Trick_ElbowSmash2_180$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$$Trick_ElbowSmash2$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_OneFootSmith_FS$$Name$ = %sc(17,"FS One Foot Smith")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(500,000001f4)$initanim$ = $SmithFS_Init$$Anim$ = $SmithFS_Range$$type$ = $slide$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $GrindFallLR$$Extratricks$ = $Extra_FS_Grinds$$IsSpecial$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_OneFootSmith_BS$$Name$ = %sc(17,"BS One Foot Smith")
	:i $Grind$:s{$Name$ = %GLOBAL%$Name$$score$ = %i(500,000001f4)$initanim$ = $Smith_Init$$Anim$ = $Smith_Range$$type$ = $Grind$$NoBlend$ = %GLOBAL%$NoBlend$
		:i $GrindBail$ = $FiftyFiftyFall$$Extratricks$ = $Extra_BS_Grinds$$IsSpecial$$IsExtra$ = %GLOBAL%$IsExtra$:s}
:i endfunction
:i function $Trick_OneFootSmith_FS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_OneFootSmith_BS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $Trick_OneFootSmith_BS_180$
	:i $FlipAndRotate$
	:i $Goto$$Trick_OneFootSmith_FS$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $BackwardsGrind$
	:i $Rotate$
	:i $BoardRotateAfter$
	:i $Goto$%GLOBAL%$Grind$$Params$ = :s{$NoBlend$ = $yes$:s}
:i endfunction
:i function $PointRail$
	:i $Vibrate$$Actuator$ = %i(0,00000000)$Percent$ = %i(50,00000032)$Duration$ = %f(0.100000)
	:i $Obj_SpawnScript$$PointRailSparks$
	:i $BroadcastEvent$$type$ = $SkaterPointRail$
	:i $SetTrickName$%sc(15,"Kissed the Rail")
	:i $SetTrickScore$%i(50,00000032)
	:i $Display$$NoMult$
	:i $Goto$$Airborne$$Params$ = :s{$AllowVibration$:s}
:i endfunction
:i function $PointRailSpin$$init_anim$ = $natas_spin_init$$range_anim$ = $natas_spin_range$
	:i $SetException$$Ex$ = $Ollied$$Scr$ = $ExitPointRailSpin$
	:i $SetException$$Ex$ = $OffMeterTop$$Scr$ = $PointRailSpinBail$
	:i $SetException$$Ex$ = $OffMeterBottom$$Scr$ = $PointRailSpinBail$
	:i $SetException$$Ex$ = $SkaterCollideBail$$Scr$ = $SkaterCollideBail$
	:i $SetRailSound$$slide$
	:i $SetQueueTricks$$NoTricks$
	:i if $SkaterIsNamed$$natas$
		:i $init_anim$ = $special_natas_spin_init$
		:i $range_anim$ = $special_natas_spin_range$
	:i endif
	:i $PlayAnim$$Anim$ = %GLOBAL%$init_anim$
	:i $Obj_WaitAnimFinished$
	:i $DoBalanceTrick$$ButtonA$ = $Right$$ButtonB$ = $Left$$type$ = $Grind$
	:i $PlayAnim$$Anim$ = %GLOBAL%$range_anim$$wobble$
	:i $SetTrickName$%sc(0,"")
	:i $SetTrickScore$%i(0,00000000)
	:i $Display$$Blockspin$
	:i $SetTrickName$%sc(10,"Natas Spin")
	:i $SetTrickScore$%i(50,00000032)
	:i $Display$$natas$
	:i $Vibrate$$Actuator$ = %i(1,00000001)$Percent$ = %i(50,00000032)$Duration$ = %f(0.250000)
	:i $Vibrate$$Actuator$ = %i(0,00000000)$Percent$ = %i(50,00000032)
	:i $OnExitRun$$Natas_Exit$
	:i $Block$
:i endfunction
:i function $Natas_Exit$
	:i $Vibrate$$Actuator$ = %i(0,00000000)$Percent$ = %i(0,00000000)
	:i $SetTrickName$%sc(0,"")
	:i $SetTrickScore$%i(0,00000000)
	:i $Display$$Blockspin$
:i endfunction
:i $natas_exit_speed$ = %i(300,0000012c)
:i function $ExitPointRailSpin$
	:i $StopBalanceTrick$
	:i $NoRailTricks$
	:i $Obj_KillSpawnedScript$$Name$ = $turn_on_rail_tricks$
	:i $Obj_SpawnScript$$turn_on_rail_tricks$
	:i if $UpPressed$
		:i if $RightPressed$
			:i $CheckNatasExitDirection$$dir$ = $UpRight$
		:i else 
			:i if $LeftPressed$
				:i $CheckNatasExitDirection$$dir$ = $UpLeft$
			:i else 
				:i $CheckNatasExitDirection$$dir$ = $Up$
			:i endif
		:i endif
	:i else 
		:i if $DownPressed$
			:i if $RightPressed$
				:i $CheckNatasExitDirection$$dir$ = $DownRight$
			:i else 
				:i if $LeftPressed$
					:i $CheckNatasExitDirection$$dir$ = $DownLeft$
				:i else 
					:i $CheckNatasExitDirection$$dir$ = $Down$
				:i endif
			:i endif
		:i else 
			:i if $RightPressed$
				:i $CheckNatasExitDirection$$dir$ = $Right$
			:i else 
				:i if $LeftPressed$
					:i $CheckNatasExitDirection$$dir$ = $Left$
				:i endif
			:i endif
		:i endif
	:i endif
	:i $SetSpeed$$natas_exit_speed$
	:i $Jump$
	:i $DoNextTrick$
	:i $Ollie$$OutAnim$ = $Natas_spin_out$$JumpSpeed$ = %i(0,00000000)
:i endfunction
:i function $turn_on_rail_tricks$$time$ = %i(10,0000000a)
	:i $Wait$%GLOBAL%$time$$frames$
	:i $AllowRailtricks$
:i endfunction
:i function $PointRailSpinBail$
	:i $SetSpeed$%i(200,000000c8)
	:i $PitchBail$
:i endfunction
:i function $PointRailSparks$
	:i $SetSparksPos$$rear$
	:i $SparksOn$$RailNotRequired$
	:i $Wait$%f(0.200000)$seconds$
	:i $SparksOff$
:i endfunction
:i :end
