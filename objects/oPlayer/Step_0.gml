/// @description Handle movement, collision and animation
key_left = - (keyboard_check(vk_left) || keyboard_check(ord("A")));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
key_jump_down = keyboard_check(vk_up) || keyboard_check(ord("W"));
key_shoot_down = keyboard_check(vk_space);

// Calculate movement
move = key_left + key_right;
hsp = move * moveSpeed;

vsp += global.grav;

if (place_meeting(x, y+1, oBrickWall))
{
	jumps = maxJumps;
}
else if (jumps == maxJumps)
{
	jumps -= 1;
}

if (key_jump) && (jumps > 0)
{
	vsp = -jumpSpeed;
	jumps -= 1;
}

if (vsp < 0) && (!key_jump_down)
{
	vsp = max(vsp, -jumpSpeed/2);
}

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

// Visualize movement
if (abs(key_left) xor key_right) {
	image_xscale = key_right + key_left;
	image_speed = animationSpeed;
}
else
{
	image_speed = 0;
	image_index = 0;
}

// Shoot
if (key_shoot_down) && (canShoot)
{
	canShoot = false;
	var bullet = instance_create_layer(x+gun_x_offset*image_xscale, y-gun_y_offsets[image_index], "Bullets", oBullet);
	bullet.hspeed = 2 * image_xscale;
	alarm[0] = 60 / fireRate;
}