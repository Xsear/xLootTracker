LOOTPANEL = 
{
	{	
		Name 		= 'pos',
		Id			= 'Anchor',
		Scale		= 1,
		Translation	= {x=0,y=0,z=0},
		Rotation 	= {axis={x=0,y=0,z=1},angle=90},
		BindTo		= 'World',
		LookAt		= 'screen',
	},
	
	{
		Name		= 'panel_rt',
		Id			= 'RenderTarget',
		RTGlobal	= false,
		RT			= {width=1024, height=1024},
		Widget		= [[
		<Group dimensions='dock:fill;' style='alpha:1.0'>
			<!--<StillArt dimensions='dock:fill' style='texture:colors; region:white; tint:#FFFFFF; alpha:0.5;'/>-->


			<Group name='Panel' dimensions='width:98%; height:80%; top:20%;'>

				<!--<Border name='PanelBorder' dimensions='dock:fill'  />-->

				<Group name='Content' dimensions='left:5; top:5; right:100%-5; bottom:100%-5;' style='clip-children:true;'>
					<!--<StillArt name='contentBackground' dimensions='dock:fill' style='texture:colors; region:white; tint:#00000; alpha:0.8;'/>-->
					<Border name='contentBackground' dimensions='width:100%-5; height:100%-5' class='PanelBackDrop' style='tint:#00000;' />
					
					<Group name='Header' dimensions='width:100%;height:200;top:0'>
						
						<StillArt name='headerBar' dimensions='width:100%-5; height:100%-5' style='texture:colors; region:white; tint:#000000; alpha:0.8;'/>

						<Text name='itemName' dimensions='top:16; left:0; width:100%; height:64;' style='wrap:true' class='LootPanel_Text_Large' />
						<Text name='itemAssignedTo' dimensions='top:70; left:0; width:100%; height:32;' style='relative:bottom' class='LootPanel_Text_Large' />

					</Group>



					<Group name='IconBar' dimensions='left:0; top:20%; width:100%; height:30%;' style='clip-children:true;'>

						<WebImage name='itemIcon'         dimensions='left:10%; width:120; height:120;' style='fixed-bounds:true; valign:center;'>

						</WebImage>

						<!-- width:20%; height:30%;-->
						<WebImage name='battleframeIcon'         dimensions='left:40%+60; width:80; height:80;' style='fixed-bounds:true; valign:center;'>
							<FocusBox name='fb' dimensions='dock:fill'/>
						</WebImage>
						<!--<StillArt name='timerBackground'            dimensions='left:70%; width:20%; height:30%;' style='texture:colors; region:white; tint:#000000; alpha:0.8;'/>-->
						<Text name='timer' dimensions='left:70%; width:20%; height:30%;' class='LootPanel_Text_Timer'/>

					</Group>


					<!-- Stats and Attributes -->
	                <ListLayout name='ItemStats' dimensions='center-x:50%; top:42%; width:100%; height:40%;' style='vertical:true; vpadding:9; clip-children:false;'>
	                    
	                </ListLayout>


					<Group name='ButtonRow' dimensions='center-x:50%; top:75%; width:60%; height:5%;' style='clip-children:true;'>
					
					</Group>

				</Group>
			</Group>

		</Group>
						]],
	},
	
	{
		Name		= 'worldPlane',
		Id			= 'plane',
		Scale 		= 2,
		CullAlpha	= 0,
		Anchor		= 'pos',
		RT			= 'panel_rt',
	},
};