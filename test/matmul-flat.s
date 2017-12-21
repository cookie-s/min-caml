	.globl _start
	.text
_start:
# 0x000000 | code & data seg |
# 0x2_0000 | stack       seg |
# 0x8_0000 | heap        seg |
	lis	%r3, 0x0002	# sp
	lis	%r4, 0x0008	# hp
	b	_min_caml_start
	.data
	.align 	8
  .comm min_caml_n_objects, 4
#  .comm min_caml_objects, 240
  .comm min_caml_screen, 24
  .comm	min_caml_viewpoint, 24
  .comm min_caml_light, 24
#  .comm min_caml_beam, 8
#  .comm min_caml_and_net, 200
#  .comm min_caml_or_net, 4
  .comm min_caml_solver_dist, 8
  .comm min_caml_intsec_rectside, 4
#  .comm min_caml_tmin, 8
  .comm min_caml_intersection_point, 24
  .comm min_caml_intersected_object_id, 4
  .comm min_caml_nvector, 24
  .comm min_caml_texture_color, 24
  .comm min_caml_diffuse_ray, 24
  .comm min_caml_rgb, 24
  .comm min_caml_image_size, 8
  .comm min_caml_image_center, 8
  .comm min_caml_scan_pitch, 8
  .comm min_caml_startp, 24
  .comm min_caml_startp_fast, 24
  .comm min_caml_screenx_dir, 24
  .comm min_caml_screeny_dir, 24
  .comm min_caml_screenz_dir, 24
  .comm min_caml_ptrace_dirvec, 24
#  .comm min_caml_dirvecs, 20
#  .comm min_caml_light_dirvec, 264
#  .comm min_caml_reflections, 720
  .comm min_caml_n_reflections, 4
#	create_array
	.text
	.align	2
	.globl	min_caml_create_array
min_caml_create_array:
	or	%r2, %r6, %r2  # mr	%r6, %r2
	or	%r4, %r2, %r4  # mr	%r2, %r4
create_array_loop:
	cmpwi	%cr7, %r6, 0
	bne	%cr7, create_array_cont
	blr
create_array_cont:
	stw	%r5, 0(%r4)
	addi	%r6, %r6, -1  # subi  %r6, %r6, 1
	addi	%r4, %r4, 4
	b	create_array_loop
#	create_float_array
	.globl	min_caml_create_float_array
min_caml_create_float_array:
	or	%r2, %r5, %r2  # mr	%r5, %r2
	or	%r4, %r2, %r4  # mr	%r2, %r4
create_float_array_loop:
	cmpwi	%cr7, %r5, 0
	bne	%cr7, create_float_array_cont
	blr
create_float_array_cont:
	stfs	%f0, 0(%r4)
	addi	%r5, %r5, -1  # subi	%r5, %r5, 1
	addi	%r4, %r4, 8
	b	create_float_array_loop
	.data
	#.literal8
	.align 3
l.1210:	 # 12.000000
	.long	1094713344
	.align 3
l.1207:	 # 11.000000
	.long	1093664768
	.align 3
l.1204:	 # 10.000000
	.long	1092616192
	.align 3
l.1201:	 # 9.000000
	.long	1091567616
	.align 3
l.1198:	 # 8.000000
	.long	1090519040
	.align 3
l.1195:	 # 7.000000
	.long	1088421888
	.align 3
l.1192:	 # 6.000000
	.long	1086324736
	.align 3
l.1189:	 # 5.000000
	.long	1084227584
	.align 3
l.1186:	 # 4.000000
	.long	1082130432
	.align 3
l.1183:	 # 3.000000
	.long	1077936128
	.align 3
l.1180:	 # 2.000000
	.long	1073741824
	.align 3
l.1177:	 # 1.000000
	.long	1065353216
	.align 3
l.1174:	 # 0.000000
	.long	0
	.text
	.globl _min_caml_start
	.align 2
mul_sub.1134:
	lwz	%r6, 8(%r29)
	lwz	%r7, 4(%r29)
	cmpwi	%cr7, %r5, -1
	bne	%cr7, beq_else.1261
	blr
beq_else.1261:
	addi	%r8, %r0, 1	# li
	slw	%r8, %r8, %r5 # swap
	and	%r6, %r6, %r8
	cmpwi	%cr7, %r6, 0
	bne	%cr7, beq_else.1262
	addi	%r5, %r5, -1	# subi %r5, %r5, 1
	lwz	%r28, 0(%r29)
	mtspr	9, %r28	# mtctr
	bctr
beq_else.1262:
	slw	%r7, %r6, %r5 # swap
	add	%r2, %r2, %r6
	addi	%r5, %r5, -1	# subi %r5, %r5, 1
	lwz	%r28, 0(%r29)
	mtspr	9, %r28	# mtctr
	bctr
mul.504:
	cmpwi	%cr7, %r2, 0
	blt	%cr7, bge_else.1263
	or	%r2, %r6, %r2	# mr %r6, %r2
	b	bge_cont.1264
bge_else.1263:
	neg	%r6, %r2
bge_cont.1264:
	cmpwi	%cr7, %r5, 0
	blt	%cr7, bge_else.1265
	or	%r5, %r7, %r5	# mr %r7, %r5
	b	bge_cont.1266
bge_else.1265:
	neg	%r7, %r5
bge_cont.1266:
	or	%r4, %r29, %r4	# mr %r29, %r4
	addi	%r4, %r4, 16
	addis	%r8, %r0, (mul_sub.1134)@h	# lis
	ori	%r8, %r8, (mul_sub.1134)@l
	stw	%r8, 0(%r29)
	stw	%r7, 8(%r29)
	stw	%r6, 4(%r29)
	addi	%r6, %r0, 0	# li
	addi	%r7, %r0, 30	# li
	stw	%r5, 0(%r3)
	stw	%r2, 4(%r3)
	mfspr	%r31, 8	# mflr
	or	%r7, %r5, %r7	# mr %r5, %r7
	or	%r6, %r2, %r6	# mr %r2, %r6
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	lwz	%r31, 0(%r29)
	mtspr	9, %r31	#mtctr
	bctrl
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	mtspr	8, %r31	# mtlr
	addis	%r5, %r0, 32767	# lis
	ori	%r5, %r5, 65535
	and	%r2, %r2, %r5
	lwz	%r5, 4(%r3)
	addi	%r1, %r0, 31	# lis
	srw	%r5, %r5, %r1 # swap
	lwz	%r6, 0(%r3)
	addi	%r1, %r0, 31	# lis
	srw	%r6, %r6, %r1 # swap
	xor	%r5, %r5, %r6
	cmpwi	%cr7, %r5, 0
	bne	%cr7, beq_else.1267
	blr
beq_else.1267:
	neg	%r2, %r2
	blr
div_sub.1100:
	cmpwi	%cr7, %r7, -1
	bne	%cr7, beq_else.1268
	blr
beq_else.1268:
	srw	%r5, %r8, %r7 # swap
	cmp	%cr7, %r6, %r8
	bgt	%cr7, ble_else.1269
	addi	%r8, %r0, 1	# li
	slw	%r8, %r8, %r7 # swap
	add	%r2, %r8, %r2
	slw	%r6, %r8, %r7 # swap
	subf	%r5, %r8, %r5	# sub	%r5, %r5, %r8
	addi	%r7, %r7, -1	# subi %r7, %r7, 1
	b	div_sub.1100
ble_else.1269:
	addi	%r7, %r7, -1	# subi %r7, %r7, 1
	b	div_sub.1100
div.507:
	cmpwi	%cr7, %r2, 0
	blt	%cr7, bge_else.1270
	or	%r2, %r6, %r2	# mr %r6, %r2
	b	bge_cont.1271
bge_else.1270:
	neg	%r6, %r2
bge_cont.1271:
	cmpwi	%cr7, %r5, 0
	blt	%cr7, bge_else.1272
	or	%r5, %r7, %r5	# mr %r7, %r5
	b	bge_cont.1273
bge_else.1272:
	neg	%r7, %r5
bge_cont.1273:
	addi	%r8, %r0, 0	# li
	addi	%r9, %r0, 30	# li
	stw	%r5, 0(%r3)
	stw	%r2, 4(%r3)
	mfspr	%r31, 8	# mflr
	or	%r6, %r5, %r6	# mr %r5, %r6
	or	%r8, %r2, %r8	# mr %r2, %r8
	or	%r7, %r6, %r7	# mr %r6, %r7
	or	%r9, %r7, %r9	# mr %r7, %r9
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	div_sub.1100
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	mtspr	8, %r31	# mtlr
	addis	%r5, %r0, 32767	# lis
	ori	%r5, %r5, 65535
	and	%r2, %r2, %r5
	lwz	%r5, 4(%r3)
	addi	%r1, %r0, 31	# lis
	srw	%r5, %r5, %r1 # swap
	lwz	%r6, 0(%r3)
	addi	%r1, %r0, 31	# lis
	srw	%r6, %r6, %r1 # swap
	xor	%r5, %r5, %r6
	cmpwi	%cr7, %r5, 0
	bne	%cr7, beq_else.1274
	blr
beq_else.1274:
	neg	%r2, %r2
	blr
print_newline.510:
	addi	%r2, %r0, 10	# li
	out	%r2, 0
	blr
print_int_sub.1080:
	cmpwi	%cr7, %r2, 10
	blt	%cr7, bge_else.1276
	addi	%r5, %r0, 10	# li
	stw	%r2, 0(%r3)
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	div.507
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	print_int_sub.1080
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	mtspr	8, %r31	# mtlr
	addi	%r5, %r0, 10	# li
	lwz	%r2, 0(%r3)
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	div.507
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	mtspr	8, %r31	# mtlr
	addi	%r5, %r0, 10	# li
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	mul.504
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r5, 0(%r3)
	subf	%r2, %r2, %r5	# sub	%r2, %r5, %r2
	addi	%r2, %r2, 48
	out	%r2, 0
	blr
bge_else.1276:
	addi	%r2, %r2, 48
	out	%r2, 0
	blr
print_int.512:
	cmpwi	%cr7, %r2, 0
	blt	%cr7, bge_else.1279
	b	print_int_sub.1080
bge_else.1279:
	addi	%r5, %r0, 45	# li
	out	%r5, 0
	neg	%r2, %r2
	b	print_int_sub.1080
loop3.577:
	cmpwi	%cr7, %r5, 0
	blt	%cr7, bge_else.1280
	addi	%r1, %r0, 2	# li
	slw	%r2, %r10, %r1 # swap
	lwzx	%r10, %r9, %r10
	addi	%r1, %r0, 2	# li
	slw	%r2, %r11, %r1 # swap
	lwzx	%r11, %r9, %r11
	addi	%r1, %r0, 3	# li
	slw	%r6, %r12, %r1 # swap
	lfdx	%f0, %r11, %r12
	addi	%r1, %r0, 2	# li
	slw	%r2, %r11, %r1 # swap
	lwzx	%r11, %r7, %r11
	addi	%r1, %r0, 3	# li
	slw	%r5, %r12, %r1 # swap
	lfdx	%f1, %r11, %r12
	addi	%r1, %r0, 2	# li
	slw	%r5, %r11, %r1 # swap
	lwzx	%r11, %r8, %r11
	addi	%r1, %r0, 3	# li
	slw	%r6, %r12, %r1 # swap
	lfdx	%f2, %r11, %r12
	fmul	%f1, %f1, %f2
	fadd	%f0, %f0, %f1
	addi	%r1, %r0, 3	# li
	slw	%r6, %r11, %r1 # swap
	stfdx	%f0, %r10, %r11
	addi	%r5, %r5, -1	# subi %r5, %r5, 1
	b	loop3.577
bge_else.1280:
	blr
loop2.584:
	cmpwi	%cr7, %r6, 0
	blt	%cr7, bge_else.1282
	addi	%r10, %r5, -1	# subi %r10, %r5, 1
	stw	%r9, 0(%r3)
	stw	%r8, 4(%r3)
	stw	%r7, 8(%r3)
	stw	%r5, 12(%r3)
	stw	%r2, 16(%r3)
	stw	%r6, 20(%r3)
	mfspr	%r31, 8	# mflr
	or	%r10, %r5, %r10	# mr %r5, %r10
	stw	%r31, 28(%r3)
	addi	%r3, %r3, 32
	bl	loop3.577
	addi	%r3, %r3, -32	# subi
	lwz	%r31, 28(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 20(%r3)
	addi	%r6, %r2, -1	# subi %r6, %r2, 1
	lwz	%r2, 16(%r3)
	lwz	%r5, 12(%r3)
	lwz	%r7, 8(%r3)
	lwz	%r8, 4(%r3)
	lwz	%r9, 0(%r3)
	b	loop2.584
bge_else.1282:
	blr
loop1.591:
	cmpwi	%cr7, %r2, 0
	blt	%cr7, bge_else.1284
	addi	%r10, %r6, -1	# subi %r10, %r6, 1
	stw	%r9, 0(%r3)
	stw	%r8, 4(%r3)
	stw	%r7, 8(%r3)
	stw	%r6, 12(%r3)
	stw	%r5, 16(%r3)
	stw	%r2, 20(%r3)
	mfspr	%r31, 8	# mflr
	or	%r10, %r6, %r10	# mr %r6, %r10
	stw	%r31, 28(%r3)
	addi	%r3, %r3, 32
	bl	loop2.584
	addi	%r3, %r3, -32	# subi
	lwz	%r31, 28(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 20(%r3)
	addi	%r2, %r2, -1	# subi %r2, %r2, 1
	lwz	%r5, 16(%r3)
	lwz	%r6, 12(%r3)
	lwz	%r7, 8(%r3)
	lwz	%r8, 4(%r3)
	lwz	%r9, 0(%r3)
	b	loop1.591
bge_else.1284:
	blr
mul.598:
	addi	%r2, %r2, -1	# subi %r2, %r2, 1
	b	loop1.591
init.606:
	cmpwi	%cr7, %r2, 0
	blt	%cr7, bge_else.1286
	addis	%r31, %r0, (l.1174)@h	# lis
	ori	%r31, %r31, (l.1174)@l
	lfs	%f0, 0(%r31)	# float
	stw	%r5, 0(%r3)
	stw	%r6, 4(%r3)
	stw	%r2, 8(%r3)
	mfspr	%r31, 8	# mflr
	or	%r5, %r2, %r5	# mr %r2, %r5
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	min_caml_create_float_array
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r5, 8(%r3)
	addi	%r1, %r0, 2	# li
	slw	%r5, %r6, %r1 # swap
	lwz	%r7, 4(%r3)
	stwx	%r2, %r7, %r6
	addi	%r2, %r5, -1	# subi %r2, %r5, 1
	lwz	%r5, 0(%r3)
	or	%r7, %r6, %r7	# mr %r6, %r7
	b	init.606
bge_else.1286:
	blr
make.610:
	stw	%r5, 0(%r3)
	stw	%r2, 4(%r3)
	mfspr	%r31, 8	# mflr
	or	%r6, %r5, %r6	# mr %r5, %r6
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	min_caml_create_array
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	or	%r2, %r6, %r2	# mr %r6, %r2
	mtspr	8, %r31	# mtlr
	lwz	%r2, 4(%r3)
	addi	%r2, %r2, -1	# subi %r2, %r2, 1
	lwz	%r5, 0(%r3)
	stw	%r6, 8(%r3)
	mfspr	%r31, 8	# mflr
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	init.606
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 8(%r3)
	blr
_min_caml_start: # main entry point
#	main program starts
	addi	%r2, %r0, 0	# li
	addis	%r31, %r0, (l.1174)@h	# lis
	ori	%r31, %r31, (l.1174)@l
	lfs	%f0, 0(%r31)	# float
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	min_caml_create_float_array
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	or	%r2, %r6, %r2	# mr %r6, %r2
	mtspr	8, %r31	# mtlr
	addi	%r2, %r0, 2	# li
	addi	%r5, %r0, 3	# li
	stw	%r6, 0(%r3)
	mfspr	%r31, 8	# mflr
	stw	%r31, 4(%r3)
	addi	%r3, %r3, 8
	bl	make.610
	addi	%r3, %r3, -8	# subi
	lwz	%r31, 4(%r3)
	mtspr	8, %r31	# mtlr
	addi	%r5, %r0, 3	# li
	addi	%r6, %r0, 2	# li
	lwz	%r7, 0(%r3)
	stw	%r2, 4(%r3)
	mfspr	%r31, 8	# mflr
	or	%r5, %r2, %r5	# mr %r2, %r5
	or	%r6, %r5, %r6	# mr %r5, %r6
	or	%r7, %r6, %r7	# mr %r6, %r7
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	make.610
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	mtspr	8, %r31	# mtlr
	addi	%r5, %r0, 2	# li
	addi	%r6, %r0, 2	# li
	lwz	%r7, 0(%r3)
	stw	%r2, 8(%r3)
	mfspr	%r31, 8	# mflr
	or	%r5, %r2, %r5	# mr %r2, %r5
	or	%r6, %r5, %r6	# mr %r5, %r6
	or	%r7, %r6, %r7	# mr %r6, %r7
	stw	%r31, 12(%r3)
	addi	%r3, %r3, 16
	bl	make.610
	addi	%r3, %r3, -16	# subi
	lwz	%r31, 12(%r3)
	or	%r2, %r9, %r2	# mr %r9, %r2
	mtspr	8, %r31	# mtlr
	lwz	%r7, 4(%r3)
	lwz	%r2, 0(%r7)
	addis	%r31, %r0, (l.1177)@h	# lis
	ori	%r31, %r31, (l.1177)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 0(%r2)	# float
	lwz	%r2, 0(%r7)
	addis	%r31, %r0, (l.1180)@h	# lis
	ori	%r31, %r31, (l.1180)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 8(%r2)	# float
	lwz	%r2, 0(%r7)
	addis	%r31, %r0, (l.1183)@h	# lis
	ori	%r31, %r31, (l.1183)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 16(%r2)	# float
	lwz	%r2, 4(%r7)
	addis	%r31, %r0, (l.1186)@h	# lis
	ori	%r31, %r31, (l.1186)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 0(%r2)	# float
	lwz	%r2, 4(%r7)
	addis	%r31, %r0, (l.1189)@h	# lis
	ori	%r31, %r31, (l.1189)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 8(%r2)	# float
	lwz	%r2, 4(%r7)
	addis	%r31, %r0, (l.1192)@h	# lis
	ori	%r31, %r31, (l.1192)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 16(%r2)	# float
	lwz	%r8, 8(%r3)
	lwz	%r2, 0(%r8)
	addis	%r31, %r0, (l.1195)@h	# lis
	ori	%r31, %r31, (l.1195)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 0(%r2)	# float
	lwz	%r2, 0(%r8)
	addis	%r31, %r0, (l.1198)@h	# lis
	ori	%r31, %r31, (l.1198)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 8(%r2)	# float
	lwz	%r2, 4(%r8)
	addis	%r31, %r0, (l.1201)@h	# lis
	ori	%r31, %r31, (l.1201)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 0(%r2)	# float
	lwz	%r2, 4(%r8)
	addis	%r31, %r0, (l.1204)@h	# lis
	ori	%r31, %r31, (l.1204)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 8(%r2)	# float
	lwz	%r2, 8(%r8)
	addis	%r31, %r0, (l.1207)@h	# lis
	ori	%r31, %r31, (l.1207)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 0(%r2)	# float
	lwz	%r2, 8(%r8)
	addis	%r31, %r0, (l.1210)@h	# lis
	ori	%r31, %r31, (l.1210)@l
	lfs	%f0, 0(%r31)	# float
	stfs	%f0, 8(%r2)	# float
	addi	%r2, %r0, 2	# li
	addi	%r5, %r0, 3	# li
	addi	%r6, %r0, 2	# li
	stw	%r9, 12(%r3)
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	mul.598
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 12(%r3)
	lwz	%r5, 0(%r2)
	lfs	%f0, 0(%r5)	# float
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	min_caml_truncate
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_int.512
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_newline.510
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 12(%r3)
	lwz	%r5, 0(%r2)
	lfs	%f0, 8(%r5)	# float
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	min_caml_truncate
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_int.512
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_newline.510
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 12(%r3)
	lwz	%r5, 4(%r2)
	lfs	%f0, 0(%r5)	# float
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	min_caml_truncate
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_int.512
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_newline.510
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	lwz	%r2, 12(%r3)
	lwz	%r2, 4(%r2)
	lfs	%f0, 8(%r2)	# float
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	min_caml_truncate
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_int.512
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
	mfspr	%r31, 8	# mflr
	stw	%r31, 20(%r3)
	addi	%r3, %r3, 24
	bl	print_newline.510
	addi	%r3, %r3, -24	# subi
	lwz	%r31, 20(%r3)
	mtspr	8, %r31	# mtlr
#	main program ends
	sc