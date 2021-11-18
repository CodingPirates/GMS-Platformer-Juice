// Calculate movement
move = sign(oPlayer.x - x);
hsp = move * moveSpeed;

vsp += global.grav;

// Horizontal Collisions

if (place_meeting(x+hsp, y, oBrickWall))
{
	while (!place_meeting(x+sign(hsp), y, oBrickWall))
	{
		x += sign(hsp);
	}
	hsp = 0;	
}

x += hsp;

// Vertical Collisions

if (place_meeting(x, y+vsp, oBrickWall))
{
	while (!place_meeting(x, y+sign(vsp), oBrickWall))
	{
		y += sign(vsp);
	}
	vsp = 0;	
}

y += vsp;