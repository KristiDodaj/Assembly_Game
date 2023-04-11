#####################################################################
#
# CSCB58 Winter 2023 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Kristi Dodaj, 1008025101, dodajkri, kristi.dodaj@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 
# - Unit height in pixels: 4 
# - Display width in pixels: 256 
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3 (all of the milestones are reached)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. Double Jump
# 2. Shooting Enemies
# 3. Win condition 
# 4. Fail condition
# 5. Pick-up effects (3 Pick Ups)
# 6. Moving Objects (The 3 Pick Ups are also moving objects)
#
# Link to video demonstration for final submission:
# - https://youtu.be/LmhGR3P6qjg
#
# Are you OK with us sharing the video with people outside course staff?
# - yes: https://github.com/KristiDodaj/Assembly_Game.git
#
# Any additional information that the TA needs to know:
# - NOTE that the pick ups are designed so you can go through them to make it harder to catch. You can
#   only catch them by jumping on top of them in the center similar to super mario.
# - NOTE that the pick ups also stop moving when the character is jumping so it easier for the character
#   to jump on top of them
#
###############################################################


.eqv BASE_ADDRESS 0x10008000
.eqv buffer_space 32768
.eqv sleep_time 40
.eqv gray 0x00d9d9d9
.eqv red 0x00cb3030
.eqv pink 0x00ff66c4
.eqv white 0x00ffffff
.eqv black 0x00000000
.eqv green 0x007ed957
.eqv yellow 0x00ffde59
.eqv orange 0x00ff914d
.eqv purple 0x008c52ff
.eqv blue 0x005dadec
.eqv brown 0x006c5156

.data

.text

##########################
#   PAINT BACKGROUND
##########################

setup:
	# setup colors and address
	li $t0, BASE_ADDRESS
	li $t1, gray    # change color to gray
	move $t2, $t0	 # where t2 will store the current adress as it updates
	addi $t3, $t0, buffer_space	# where t3 is the last target address
	
	li $t4, 128    # length of two first rows in units
	

paint_background:
	bge $t2, $t3, stop_painting_background	  # check whether finished
	sw $t1, 0($t2)    
	addi $t2, $t2, 4    # update the current adress
	
	j paint_background


stop_painting_background:
	move $t2, $t0    # reset current address
	li $t1, red    # update color to red

paint_upper_wall:
	beq $t4, 0, stop_painting_upper_wall    #check whether finished
	sw $t1, 0($t2)    
	addi $t2, $t2, 4    # update the current adress
	addi $t4, $t4, -1 # decrement the display width
	
	j paint_upper_wall
	
stop_painting_upper_wall:
	li $t4, 128    # reset length of two rows
	move $t2, $t0    # reset current address
	addi $t2, $t2, 32256   # point it to the beginning address

paint_lower_wall:
	beq $t4, 0, stop_painting_lower_wall    #check whether finished	
	sw $t1, 0($t2)    
	addi $t2, $t2, 4    # update the current adress
	addi $t4, $t4, -1 # decrement the display width
	
	j paint_lower_wall

stop_painting_lower_wall:
	li $t4, 128    # reset length of two columns
	move $t2, $t0    # reset current address
	
paint_first_column:
		beq $t4, 0, stop_painting_first_column    #check whether finished
		sw $t1, 0($t2)     
		sw $t1, 4($t2)    
		addi $t2, $t2, 256 # move to the next row
		addi $t4, $t4, -1 # decrement the display height

		j paint_first_column

stop_painting_first_column:
	li $t4, 128    # reset length of two columns
	move $t2, $t0    # reset current address
	addi $t2, $t2, 248   # point it to the beginning address

paint_last_column:
		beq $t4, 0, stop_painting_last_column    #check whether finished
		
		sw $t1, 0($t2)    
		sw $t1, 4($t2)     
		addi $t2, $t2, 256 # move to the next row
		addi $t4, $t4, -1 # decrement the display height

		j paint_last_column

stop_painting_last_column:
		move $t2, $t0    # reset current address
		addi $t2, $t2, 32076   # point it to the beginning address


##########################
#     LEVEL DESIGN
##########################

level_1:	


		# draw barrier for picked up items
		move $t2, $t0   
		addi $t2, $t2,  2816    
		li $t7, 62  
		
		draw_barrier:
			beq $t7, $zero, platform
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_barrier 
		
		
		
		#draw platforms
		platform:
			move $t2, $t0    
			addi $t2, $t2,  8192    
			li $t7, 45   
		
		
		draw_platform_1:
			beq $t7, $zero, end_1
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_platform_1 
		end_1:
			move $t2, $t0    
			addi $t2, $t2,  11008
			li $s7, black
			sw $s7, 8($t2)
			sw $s7, 12($t2)
			sw $s7, 16($t2)
			sw $s7, 20($t2)
			addi $t2, $t2,  256
			sw $s7, 8($t2)
			sw $s7, 12($t2)
			sw $s7, 16($t2)
			sw $s7, 20($t2)
			addi $t2, $t2,  256
			sw $s7, 8($t2)
			sw $s7, 12($t2)
			sw $s7, 16($t2)
			sw $s7, 20($t2)
			addi $t2, $t2,  256
			sw $s7, 8($t2)
			sw $s7, 12($t2)
			sw $s7, 16($t2)
			sw $s7, 20($t2)
			addi $t2, $t2,  256
			sw $s7, 8($t2)
			sw $s7, 12($t2)
			sw $s7, 16($t2)
			sw $s7, 20($t2)
			
			addi $t2, $t2,  -12032
			
			move $t2, $t0    
			addi $t2, $t2,  14072   
			li $t7, 25
		
	
		draw_platform_2:
			beq $t7, $zero, end_2
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_platform_2 
		end_2:
			addi, $t2, $t2, 72
			li $t7, 25    
			
		draw_platform_3:
			beq $t7, $zero, end_3
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_platform_3 
		end_3:
			move $t2, $t0    
			addi $t2, $t2,  20036
			li $t7, 48
		
		draw_platform_4:
			beq $t7, $zero, end_4
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_platform_4
		
		end_4:
			move $t2, $t0    
			addi $t2, $t2, 25928
			li $t7, 45
		
		draw_platform_5:
			beq $t7, $zero, end_5
			sw $t1, 0($t2)
			addi, $t2, $t2, 4
			addi $t7, $t7, -1
			j draw_platform_5
		end_5:
		
			li $s7, black
			addi $t2, $t2, -264
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, 4
			sw $s7, 0($t2)
			addi $t2, $t2, 4
			sw $s7, 0($t2)
			addi $t2, $t2, 4
			sw $s7, 0($t2)
			addi $t2, $t2, 4
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			
			addi $t2, $t2, -248
			sw $s7, 0($t2)
			addi $t2, $t2, -256
			sw $s7, 0($t2)
			addi $t2, $t2, -4
			sw $s7, 0($t2)
			addi $t2, $t2, 8
			sw $s7, 0($t2)
			addi $t2, $t2, 1280
			sw $s7, 0($t2)
			addi $t2, $t2, 252
			sw $s7, 0($t2)
			addi $t2, $t2, 256
			sw $s7, 0($t2)
			addi $t2, $t2, 256
			sw $s7, 0($t2)
			addi $t2, $t2, 256
			sw $s7, 0($t2)
			
			# paint laser
			li $s4, 7000
			li $s3, 0
			jal paint_laser_level_1
			
			# paint camera
			li $s2, 1000
			li $s1, 0
			jal paint_camera_level_1
			
			# paint pick up 1
			li $t9, 20
			li $s7, BASE_ADDRESS
			addi $s7, $s7, 32196
			jal draw_pick_up_1
			
			# paint pick up 2
			li $s0, BASE_ADDRESS
			addi $s0, $s0, 19852
			jal draw_pick_up_2
			
			# paint pick up 3
			li $t0, BASE_ADDRESS
			addi $t0, $t0, 8024
			jal draw_pick_up_3
	
	
			li $t2, BASE_ADDRESS   # reset current address
			addi $t2, $t2, 32076   # point it to the beginning address
			li $t1, pink    # update color to pink
			li $t4, gray


##########################
#    MOVEMENT/PHYSICS
##########################


# draw initial player

draw_player:
		li $t4, gray
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		li $t4, white
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t4, 4($t2)
		sw $t4, 8($t2)
		sw $t4, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t4, 4($t2)
		sw $t1, 8($t2)
		sw $t4, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		
		
		addi $t2, $t2, 2304
		
		
		# sleep for a moment
		li $v0, 32
		li $a0, sleep_time
		syscall
		
		addi $s4, $s4, -40
		addi $s2, $s2, -60
		
# main loop
						
main_loop:
    		
    		# check time for pick up movements
    		beq $t9, $zero, make_move_1
    		addi $t9, $t9, -1
    		
    		# check time for laser and camera shooting
    		blt $s4, $zero, handle_laser
    		blt $s2, $zero, handle_camera
    		
    		# check if won
    		li $t6, brown
		addi $t2, $t2, -2816
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2816
    		beq $t6, $t7, win
    		
    		# check for key press
    		jal key_press_check
    		
   
    		# sleep for a moment
		li $v0, 32
		li $a0, 20
		syscall
		
		# update laser and camera time and check if character is shot
		addi $s4, $s4, -40
		addi $s2, $s2, -60
		jal check_for_shooting
		
		# check for gravity
		j gravity_loop
		
    		j main_loop
    		
# Animate the movement of the three pick up objects
    		
make_move_1:
		li $t9, 20
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 2064
		beq $t4, $s7, make_move_2
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 31172
    		beq $t4, $s7, reset_pick_up_1
    		
    		jal clear_pick_up_1
		addi $s7, $s7, -256
    		jal draw_pick_up_1
    	
    		
    		j make_move_2
	
    
reset_pick_up_1:
		jal clear_pick_up_1
		li $s7, BASE_ADDRESS
		addi $s7, $s7, 32196
		jal draw_pick_up_1
		
		j make_move_2

make_move_2:
		li $t9, 20
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 2088
		beq $t4, $s0, make_move_3
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 18828
    		beq $t4, $s0, reset_pick_up_2
    		
    		jal clear_pick_up_2
		addi $s0, $s0, -256
    		jal draw_pick_up_2
    		
    		j make_move_3
    

reset_pick_up_2:
		jal clear_pick_up_2
		li $s0, BASE_ADDRESS
		addi $s0, $s0, 19852
		jal draw_pick_up_2
		
		j reset_pick_up_3
		
make_move_3:
		li $t9, 20
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 2112
		beq $t4, $t0, main_loop
		li $t4, BASE_ADDRESS
		addi $t4, $t4, 7000
    		beq $t4, $t0, reset_pick_up_3
    		
    		jal clear_pick_up_3
		addi $t0, $t0, -256
    		jal draw_pick_up_3
    		
    		j main_loop

reset_pick_up_3:
		jal clear_pick_up_3
		li $t0, BASE_ADDRESS
		addi $t0, $t0,  8024
		jal draw_pick_up_3
		
		j main_loop

# Animate the laser and camera by turning it on and off		
    		
handle_laser:
		beq, $s3, $zero, turn_off
		jal paint_laser_level_1
		li $s4, 7000
		li $s3, 0
		j main_loop
turn_off:
		jal clear_laser_level_1
		li $s4, 7000
		li $s3, 1
		j main_loop

handle_camera:
		beq, $s1, $zero, turn_off_camera
		jal paint_camera_level_1
		li $s2, 1000
		li $s1, 0
		j main_loop

turn_off_camera:
		jal clear_camera_level_1
		li $s2, 1000
		li $s1, 1
		j main_loop
		
# check and react based on key presses

key_press_check:
		# check that key is pressed	
		li $t8, 0xffff0000
		lw $t7, 0($t8)
		beq $t7, 1, key_pressed
		jr $ra

key_pressed:
		# check for what key is presses and break down the cases
		lw $t7, 4($t8)
		beq $t7, 112, respond_to_p
		beq $t7, 97, respond_to_a
		beq $t7, 100, respond_to_d
		beq $t7, 119, respond_to_w
		j draw_player

respond_to_p:
		j setup
		
respond_to_a:
		# check if valid move
		li $t6, red
		addi $t2, $t2, -4
    		lw $t7, 0($t2)
    		addi $t2, $t2, 4
    		beq $t6, $t7, draw_player
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
		# clear and redraw
		jal clear_player
		addi $t2, $t2, -4
		j draw_player
		

respond_to_d:
		# check if valid move
		li $t6, red
		addi $t2, $t2, 20
    		lw $t7, 0($t2)
    		addi $t2, $t2, -20
    		beq $t6, $t7, draw_player
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
		# clear and redraw
		jal clear_player
		addi $t2, $t2, 4
		j draw_player
		
respond_to_w:
		li $a1, 1
		jal jump
		
respond_to_w_after_jump:
		li $a1, 0
    		j draw_player
    		
# Define the pick up effects
   
slow:	
	jal clear_pick_up_1
	li $s7, BASE_ADDRESS
	addi $s7, $s7, 2064
	jal clear_camera_level_1
	li $s2, 18000
	jal draw_pick_up_1
	j continue

remove_laser:
	jal clear_pick_up_2
	li $s0, BASE_ADDRESS
	addi $s0, $s0, 2088
	
	jal clear_player
	li $t2, BASE_ADDRESS
	addi $t2, $t2, 8412
	jal draw_pick_up_2
	jal draw_player
	j main_loop

paint_door:
	jal clear_pick_up_3
	li $t0, BASE_ADDRESS
	addi $t0, $t0, 2112
	jal draw_pick_up_3
	jal draw_door
	j continue
			
# Define jump and gravity
 
jump:

    li $t5, 2
    bgt $a1, $t5, gravity
   
    li $t5, 15
    li $a3, 0    # 0 signifies that we are in the jump stage
    li $a2, 0    # 0 lets us know we can check for key inputs while jumping
     
    jump_loop:
    
    	beq $a2, $zero, key_press_check_on_air
    	li $a2, 0

        beqz $t5, end_jump
        
        jal check_for_shooting

        # check for obsticles on left end
        li $t6, red
       	addi $t2, $t2, -2560
    	lw $t7, 0($t2)
    	beq $t6, $t7, hit_obsticle_left
	
    	addi $t2, $t2, 2560
    	
    	# check for obsticles in the right hand
    	li $t6, red
    	addi $t2, $t2, -2540
    	lw $t7, 0($t2)
    	beq $t6, $t7, hit_obsticle_right
    	addi $t2, $t2, 2540
    	
    	# update shooters
    	blt $s4, $zero, handle_laser_jump
    	blt $s2, $zero, handle_camera_jump
    	addi $s4, $s4, -40
	addi $s2, $s2, -60
	
        # Move up
        jal clear_player
        addi $t2, $t2, -256
        jal redraw_player
        
        # Decrement velocity
        addi $t5, $t5, -1

        # Delay
        li $v0, 32
        li $a0, 2
        syscall

        j jump_loop

    end_jump:
        # Restore the original position
        j gravity
        

gravity:
    
    li $t5, red
    li $a3, 1    # 1 signifies that we are in the gravity stage
    	
    gravity_loop:
    
    	beq $a2, $zero, key_press_check_on_air
    	li $a2, 0
    	li $t6, 0
    	addi $t2, $t2, 256
    	lw $t7, 0($t2)
    	beq $t5, $t7, end_gravity
    	addi $t2, $t2, -256
    	li $t5, orange
    	beq $t5, $t7, slow
    	li $t5, purple
    	beq $t5, $t7, remove_laser
    	li $t5, blue
    	beq $t5, $t7, paint_door
    	addi $t2, $t2, 256
    	li $t5, red
    	addi $t2, $t2, -256
    	li $t6, 1
    	addi $t2, $t2, 276
    	lw $t7, 0($t2)
    	beq $t5, $t7, end_gravity
    	addi $t2, $t2, -276
    	
    	jal check_for_shooting
        
	continue:
        # Move down
        jal clear_player
        addi $t2, $t2, 256
        jal redraw_player
        
        # update shooters
    	blt $s4, $zero, handle_laser_jump
    	blt $s2, $zero, handle_camera_jump
    	addi $s4, $s4, -40
	addi $s2, $s2, -60

        # Delay
        li $v0, 32
        li $a0, 2
        syscall

        j gravity_loop

    end_gravity:
    	beq $t6, $zero, adjust_1
    	j adjust_2
 	
adjust_1:
	addi $t2, $t2, -256
	j respond_to_w_after_jump

 	
adjust_2:
	addi $t2, $t2, -276
	j respond_to_w_after_jump
 hit_obsticle_left:
 	# make character come down if hitting obsticle from above
 	addi $t2, $t2, 2560
 	jal clear_player
 	j end_jump
 
hit_obsticle_right:
  	# make character come down if hitting obsticle from above
 	addi $t2, $t2, 2540
 	jal clear_player
 	j end_jump
 
key_press_check_on_air:
		# check that key is pressed
		li $a2, 1
		li $t8 0xffff0000
		lw $t7 0($t8)
		beq $t7, 1, key_pressed_on_air
		beq $a3, $zero, jump_loop
		j gravity_loop

# Check and define behaviour for key presses on air

key_pressed_on_air:
		# check for what key is presses and break down the cases
		lw $t7, 4($t8)
		beq $t7, 112, respond_to_p
		beq $t7, 97, respond_to_a_on_air
		beq $t7, 100, respond_to_d_on_air
		beq $t7, 119, respond_to_w_on_air
		beq $a3, $zero, jump_loop
		j gravity_loop

handle_laser_jump:
		beq, $s3, $zero, turn_off_jump
		jal paint_laser_level_1
		li $s4, 7000
		li $s3, 0
		beq $a3, $zero, jump_loop
		j gravity_loop
turn_off_jump:
		jal clear_laser_level_1
		li $s4, 7000
		li $s3, 1
		beq $a3, $zero, jump_loop
		j gravity_loop
		
handle_camera_jump:
		beq, $s1, $zero, turn_off_camera_jump
		jal paint_camera_level_1
		li $s2, 1000
		li $s1, 0
		beq $a3, $zero, jump_loop
		j gravity_loop

turn_off_camera_jump:
		jal clear_camera_level_1
		li $s2, 1000
		li $s1, 1
		beq $a3, $zero, jump_loop
		j gravity_loop		

respond_to_p_on_air:
		j setup
		
respond_to_a_on_air:
		# check if valid move
		li $t6, red
		addi $t2, $t2, -4
    		lw $t7, 0($t2)
    		addi $t2, $t2, 4
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -260
    		lw $t7, 0($t2)
    		addi $t2, $t2, 260
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -516
    		lw $t7, 0($t2)
    		addi $t2, $t2, 516
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -772
    		lw $t7, 0($t2)
    		addi $t2, $t2, 772
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -1028
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1028
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -1284
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1284
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -1540
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1540
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -1796
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1796
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -2052
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2052
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		addi $t2, $t2, -2564
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2564
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		
		# clear and redraw
		jal clear_player
		addi $t2, $t2, -4
		jal redraw_player
		beq $a3, $zero, jump_loop
		j gravity_loop

respond_to_d_on_air:
		# check if valid move
		li $t6, red
		addi $t2, $t2, 20
    		lw $t7, 0($t2)
    		addi $t2, $t2, -20
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -236
    		lw $t7, 0($t2)
    		addi $t2, $t2, 236
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -492
    		lw $t7, 0($t2)
    		addi $t2, $t2, 492
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -748
    		lw $t7, 0($t2)
    		addi $t2, $t2, 748
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -1004
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1004
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -1260
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1260
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -1516
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1516
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -1772
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1772
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -2028
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2028
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		addi $t2, $t2, -2284
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2284
    		beq $t6, $t7, deal_with_obsticle_on_jump
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
   
		# clear and redraw
		jal clear_player
		addi $t2, $t2, 4
		jal redraw_player
		beq $a3, $zero, jump_loop
		j gravity_loop

respond_to_w_on_air:
		addi $a1, $a1, 1
		jal jump
		

deal_with_obsticle_on_jump:
		beq $a3, $zero, jump_loop
		j gravity_loop

# Check if character is hit by shooters

check_for_shooting:
		# check if shot on the left end of character
		addi $t2, $t2, -4
    		lw $t7, 0($t2)
    		addi $t2, $t2, 4
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		addi $t2, $t2, -260
    		lw $t7, 0($t2)
    		addi $t2, $t2, 260
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose

    		addi $t2, $t2, -516
    		lw $t7, 0($t2)
    		addi $t2, $t2, 516
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -772
    		lw $t7, 0($t2)
    		addi $t2, $t2, 772
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -1028
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1028
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -1284
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1284
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -1540
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1540
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -1796
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1796
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -2052
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2052
    	
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		addi $t2, $t2, -2564
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2564
    	
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		li $t6, red
    		
    		# check if shot on the right end of main character
		
		addi $t2, $t2, 20
    		lw $t7, 0($t2)
    		addi $t2, $t2, -20
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -236
    		lw $t7, 0($t2)
    		addi $t2, $t2, 236
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -492
    		lw $t7, 0($t2)
    		addi $t2, $t2, 492
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -748
    		lw $t7, 0($t2)
    		addi $t2, $t2, 748
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -1004
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1004
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -1260
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1260
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -1516
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1516
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -1772
    		lw $t7, 0($t2)
    		addi $t2, $t2, 1772
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -2028
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2028
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
    		
    		
    		addi $t2, $t2, -2284
    		lw $t7, 0($t2)
    		addi $t2, $t2, 2284
    		
    		li $t6, yellow
    		beq $t6, $t7, loose
    		li $t6, green
    		beq $t6, $t7, loose
		
		jr $ra			
 
 # Define a redraw player function
 
 redraw_player:
		li $t4, gray
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t4, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		li $t4, white
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t4, 4($t2)
		sw $t4, 8($t2)
		sw $t4, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t4, 4($t2)
		sw $t1, 8($t2)
		sw $t4, 12($t2)
		sw $t1, 16($t2)
		addi $t2, $t2, -256
		sw $t1, 0($t2)
		sw $t1, 4($t2)
		sw $t1, 8($t2)
		sw $t1, 12($t2)
		sw $t1, 16($t2)
		
		
		addi $t2, $t2, 2304
		
		
		# sleep for a moment
		li $v0, 32
		li $a0, sleep_time
		syscall
		
		addi $s4, $s4, -40
		addi $s2, $s2, -60
		
		jr $ra


# Define a clear player function

clear_player:

 		li $t3, gray
 		
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		addi $t2, $t2, -256
		sw $t3, 0($t2)
		sw $t3, 4($t2)
		sw $t3, 8($t2)
		sw $t3, 12($t2)
		sw $t3, 16($t2)
		
		addi $t2, $t2, 2304
		
		jr $ra

#########################
#    PAINT OBJECTS
#########################


# Paint and clear laser

paint_laser_level_1:
	li $s6, BASE_ADDRESS
	addi $s6, $s6, 11544
	li $s5, green
	sw $s5, 0($s6)
	li $s4, 56
	
	laser_loop_one:
		beq $s4, $zero, end_laser_loop_1
		addi $s4, $s4, -1
		sw $s5, 0($s6)
		addi $s6, $s6, 4
		
		j laser_loop_one

	end_laser_loop_1:
		jr $ra

clear_laser_level_1:
	li $s6, BASE_ADDRESS
	addi $s6, $s6, 11544
	li $s5, gray
	sw $s5, 0($s6)
	li $s4, 56
	
	laser_loop_one_clear:
		beq $s4, $zero, end_laser_loop_1_clear
		addi $s4, $s4, -1
		sw $s5, 0($s6)
		addi $s6, $s6, 4
		
		j laser_loop_one_clear

	end_laser_loop_1_clear:
		jr $ra	

clear_laser_head:
		li $s6, BASE_ADDRESS
		addi $s6, $s6, 11008
		li $s5, gray
	
		sw $s5, 8($s6)
		sw $s5, 12($s6)
		sw $s5, 16($s6)
		sw $s5, 20($s6)
		addi $s6, $s6,  256
		sw $s5, 8($s6)
		sw $s5, 12($s6)
		sw $s5, 16($s6)
		sw $s5, 20($s6)
		addi $s6, $s6,  256
		sw $s5, 8($s6)
		sw $s5, 12($s6)
		sw $s5, 16($s6)
		sw $s5, 20($s6)
		addi $s6, $s6,  256
		sw $s5, 8($s6)
		sw $s5, 12($s6)
		sw $s5, 16($s6)
		sw $s5, 20($s6)
		addi $s6, $s6,  256
		sw $s5, 8($s6)
		sw $s5, 12($s6)
		sw $s5, 16($s6)
		sw $s5, 20($s6)
		
		jr $ra

# Paint and clear camera

paint_camera_level_1:
	li $s6, BASE_ADDRESS
	addi $s6, $s6, 24072
	li $s5, yellow
	sw $s5, 0($s6)
	li $s4, 55
	
	camera_loop_one:
		beq $s4, $zero, end_camera_loop_1
		addi $s4, $s4, -1
		sw $s5, 0($s6)
		addi $s6, $s6, 4
		
		j laser_loop_one
		
	end_camera_loop_1:
		jr $ra


clear_camera_level_1:
	li $s6, BASE_ADDRESS
	addi $s6, $s6, 24072
	li $s5, gray
	sw $s5, 0($s6)
	li $s4, 55
	
	camera_loop_one_clear:
		beq $s4, $zero, end_camera_loop_1_clear
		addi $s4, $s4, -1
		sw $s5, 0($s6)
		addi $s6, $s6, 4
		
		j camera_loop_one_clear
		
	end_camera_loop_1_clear:
		jr $ra
		
# Paint and clear pick ups

draw_pick_up_1:
	
	li $s5, orange
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	li $s5, orange
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	li $s5, white
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	li $s5, orange
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	li $s5, white
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	li $s5, orange
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	li $s5, white
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	li $s5, orange
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	li $s5, white
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	li $s5, orange
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	li $s5, orange
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, 1008
	
	jr $ra
	
clear_pick_up_1:
	
	li $s5, gray
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	addi $s7, $s7, -4
	sw $s5, 0($s7)
	
	addi $s7, $s7, -256
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	addi $s7, $s7, 4
	sw $s5, 0($s7)
	
	addi $s7, $s7, 1008
	
	jr $ra
	
	
draw_pick_up_2:
	
	li $s5, purple
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	li $s5, purple
	addi $s0, $s0, -256
	sw $s5, 0($s0)
	li $s5, white
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	li $s5, purple
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)
	li $s5, white
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	li $s5, purple
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	li $s5, white
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	li $s5, purple
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)
	li $s5, white
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	li $s5, purple
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)
	li $s5, purple
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 1008
	
	jr $ra

	
clear_pick_up_2:
	
	li $s5, gray
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)	
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)	
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -4
	sw $s5, 0($s0)	
	addi $s0, $s0, -256
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 4
	sw $s5, 0($s0)	
	addi $s0, $s0, 1008
	
	jr $ra
	
draw_pick_up_3:
	
	li $s5, blue
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	li $s5, blue
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	li $s5, white
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	li $s5, blue
	addi $t0, $t0, -4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	li $s5, white
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	li $s5, blue
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	li $s5, white
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	li $s5, blue
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	li $s5, white
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	li $s5, blue
	addi $t0, $t0, -4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	li $s5, blue
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, 1008
	
	jr $ra

clear_pick_up_3:
	
	li $s5, gray
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)
	addi $t0, $t0, -4
	sw $s5, 0($t0)	
	addi $t0, $t0, -256
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, 4
	sw $s5, 0($t0)	
	addi $t0, $t0, 1008
	
	jr $ra
	
# Paint the door in the finish line

draw_door:
	li $s6, BASE_ADDRESS
	li $s5, gray
	addi, $s6, $s6, 7940
	sw $s5, 0($s6)	
	
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	li $s5, brown
	addi, $s6, $s6, -256
	sw $s5, 0($s6)
	
	addi, $s6, $s6, -4
	sw $s5, 0($s6)
	
	li $s5, gray
	
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	addi, $s6, $s6, 256
	sw $s5, 0($s6)
	
	jr $ra

#########################
#    WIN/LOSE SCREEN
#########################

# Paint win screen

win:
	
	li $s5, green
	li $s6, BASE_ADDRESS
	addi $t3, $t0, buffer_space	
	

	paint_background_green:
	
	bge $s6, $t3, stop_painting_background_green	  
	
	sw $s5, 0($s6)    
	addi $s6, $s6, 4   
	
	j paint_background_green


	stop_painting_background_green:
	li $s6, BASE_ADDRESS
	li $s5, white
	
	addi $s6, $s6, 12840
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)   
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)   
	addi $s6, $s6, -252
	sw $s5, 0($s6)   
	
	addi $s6, $s6, 12
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	
	
	
	addi $s6, $s6, 16
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6) 
	addi $s6, $s6, 260
	sw $s5, 0($s6) 
	addi $s6, $s6, 260
	sw $s5, 0($s6) 
	addi $s6, $s6, 260
	sw $s5, 0($s6) 
	   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)  
	addi $s6, $s6, -256
	sw $s5, 0($s6) 
	
		
	win_loop:
	jal key_press_check_game_win
	j win_loop

# Paint loose screen

loose:
	
	
	li $s5, black
	li $s6, BASE_ADDRESS
	addi $t3, $t0, buffer_space	
	

	paint_background_black:
	
	bge $s6, $t3, stop_painting_background_black	  
	
	sw $s5, 0($s6)    
	addi $s6, $s6, 4   
	
	j paint_background_black


	stop_painting_background_black:
	li $s6, BASE_ADDRESS
	li $s5, white	
	
	addi $s6, $s6, 12840
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6)   
	addi $s6, $s6, 260
	sw $s5, 0($s6)    
	addi $s6, $s6, 260
	sw $s5, 0($s6) 
	
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)    
	addi $s6, $s6, 256
	sw $s5, 0($s6)    
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)    
	addi $s6, $s6, 256
	sw $s5, 0($s6) 
	
	addi $s6, $s6, -1792
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)   
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)    
	addi $s6, $s6, -252
	sw $s5, 0($s6)   
	addi $s6, $s6, -252
	sw $s5, 0($s6)
	   
	addi $s6, $s6, 12
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6) 
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	
	    
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6) 
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	
	addi $s6, $s6, 40
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6) 
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)	
	
	
	li $s6, BASE_ADDRESS	
	addi $s6, $s6, 20520
	sw $s5, 0($s6)
	
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)	
	
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, 12
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6) 
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)   
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	
	    
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6) 
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)   
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	
	addi $s6, $s6, 40
	
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	addi $s6, $s6, -4
	sw $s5, 0($s6)
	
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	addi $s6, $s6, -256
	sw $s5, 0($s6)
	
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	addi $s6, $s6, 40
	
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	addi $s6, $s6, 256
	sw $s5, 0($s6)
	
	addi $s6, $s6, -3604
	
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	addi $s6, $s6, 4
	sw $s5, 0($s6)
	
	loose_loop:
	jal key_press_check_game_end
	j loose_loop
	
# Check for restart during loosing or winning screen

key_press_check_game_end:
		# check that key is pressed	
		li $t9 0xffff0000
		lw $t8 0($t9)
		beq $t8, 1, key_pressed_game_end
		j loose_loop

key_pressed_game_end:
		# check for what key is presses and break down the cases
		lw $t7, 4($t9)
		beq $t7, 112, respond_to_p_end
		j loose_loop

respond_to_p_end:
		j setup
	
	  
key_press_check_game_win:
		# check that key is pressed	
		li $t9 0xffff0000
		lw $t8 0($t9)
		beq $t8, 1, key_pressed_game_win
		j win_loop

key_pressed_game_win:
		# check for what key is presses and break down the cases
		lw $t7, 4($t9)
		beq $t7, 112, respond_to_p_end
		j win_loop



