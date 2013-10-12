PANEL = 
{
	{	Name 		= "pos",
		Id			= "Anchor",
		Scale		= 1,
		Translation	= {x=0,y=0,z=0},
		Rotation 	= {axis={x=0,y=0,z=1},angle=90},
		BindTo		= "World",
		LookAt		= "screen",
	},
	
	{
		Name		= "panel_rt",
		Id			= "RenderTarget",
		RTGlobal	= false,
		RT			= {width=1024, height=1024},
		Widget		= [[<Group dimensions="dock:fill;" style="alpha:1.0">
							<!--<StillArt dimensions="dock:fill" style="texture:colors; region:white; tint:#FFFFFF; alpha:0.5;"/>-->

							<Group name="content" dimensions="top:20%;width:98%;height:80%;" style="clip-children:true;">

								<!--<StillArt name="contentBackground" dimensions="dock:fill" style="texture:colors; region:white; tint:#00000; alpha:0.8;"/>-->
								<Border name="contentBackground" dimensions="dock:fill" class="PanelBackDrop" style="tint:#00000;" />

								
								<Group name="Header" dimensions="width:100%;height:200;top:0">
									
									<StillArt name="headerBar" dimensions="dock:fill" style="texture:colors; region:white; tint:#000000; alpha:0.8;"/>

            						<Text name="itemName" dimensions="top:16; left:0; width:100%; height:64;" style="wrap:true" class="LootPanel_Text_Large" />
            						<Text name="itemAssignedTo" dimensions="top:70; left:0; width:100%; height:32;" style="relative:bottom" class="LootPanel_Text_Large" />

								</Group>

								<Group name="IconBar" dimensions="left:0; top:20%; width:100%; height:30%;" style="clip-children:true;">

									<WebImage name="itemIcon"         dimensions="left:10%; width:120; height:120;" style="fixed-bounds:true; valign:center;">

									</WebImage>

									<!-- width:20%; height:30%;-->
									<WebImage name="battleframeIcon"         dimensions="left:40%+60; width:80; height:80;" style="fixed-bounds:true; valign:center;">
										<FocusBox name="fb" dimensions="dock:fill"/>
									</WebImage>
									<!--<StillArt name="timerBackground"            dimensions="left:70%; width:20%; height:30%;" style="texture:colors; region:white; tint:#000000; alpha:0.8;"/>-->
									<Text name="timer" dimensions="left:70%; width:20%; height:30%;" class="LootPanel_Text_Timer"/>

								</Group>


								<Group name="ItemStats" dimensions="center-x:50%; top:40%; width:100%; height:40%;" style="clip-children:true;">
									<!--<StillArt dimensions="dock:fill" style="texture:colors; region:white; tint:#0000FF; alpha:0.5;"/>-->

									<!--<StillArt dimensions="top:0; left:10%; width:40%; height:100%;" style="texture:colors; region:white; tint:#FF0000; alpha:0.5;"/>-->
									<!--<StillArt dimensions="top:0; left:50%; width:40%; height:100%;" style="texture:colors; region:white; tint:#00FFFF; alpha:0.5;"/>-->
								</Group>


								<!--<Stillart name="Dragon" dimensions="left:0; center-y:50%; width:100%; height:400;" style="texture:PanelTex; region:Dragon; tint:FF4F00;"/>-->

								<Group name="ButtonRow" dimensions="center-x:50%; top:75%; width:60%; height:5%;" style="clip-children:true;">
								
								</Group>


							</Group>

							<!--<Border dimensions="top:20%-4;width:98%;bottom:78%+4;" class="PanelBackDrop" style="tint:#FFFFFF; alpha:0.5;"/>-->


							<!--<Stillart name="Marker" dimensions="center-x:50%; center-y:80%; width:20%; height:20%;" style="texture:PanelTex; region:ArrowMarker1; tint:FF0000;"/>-->
						</Group>]],
	},
	
	{
		Name		= "worldPlane",
		Id			= "plane",
		Scale 		= 2,
		CullAlpha	= 0,
		Anchor		= "pos",
		RT			= "panel_rt",
	},
};