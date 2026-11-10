<REPO>/build-register/CMakeFiles/matmul_register_fast.dir/src/cpu/blocked_ikj.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)>:
   0:	endbr64
   4:	push   %r15
   6:	mov    %rdx,%r15
   9:	push   %r14
   b:	push   %r13
   d:	push   %r12
   f:	push   %rbp
  10:	push   %rbx
  11:	sub    $0x108,%rsp
  18:	mov    0x150(%rsp),%rax
  20:	mov    0x148(%rsp),%r12
  28:	mov    %rdi,0x88(%rsp)
  30:	mov    %r9,0x80(%rsp)
  38:	mov    0x140(%rsp),%rbp
  40:	test   %rax,%rax
  43:	mov    %rax,0xb8(%rsp)
  4b:	sete   %al
  4e:	test   %r12,%r12
  51:	sete   %dl
  54:	or     %dl,%al
  56:	jne    5c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x5c>
  5c:	test   %rbp,%rbp
  5f:	je     65 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x65>
  65:	mov    %rcx,%rbx
  68:	test   %rcx,%rcx
  6b:	je     50c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x50c>
  71:	mov    %r8,%r13
  74:	test   %r8,%r8
  77:	je     50c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x50c>
  7d:	test   %r15,%r15
  80:	je     86 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x86>
  86:	cmpq   $0x0,0x80(%rsp)
  8f:	je     55c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x55c>
  95:	cmpq   $0x0,0x88(%rsp)
  9e:	je     a4 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xa4>
  a4:	mov    %rsi,%r14
  a7:	test   %rsi,%rsi
  aa:	je     b0 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xb0>
  b0:	mov    %rcx,%rdx
  b3:	imul   %r8,%rdx
  b7:	shl    $0x2,%rdx
  bb:	lea    (%r15,%rdx,1),%rax
  bf:	cmp    %rax,%r15
  c2:	je     ce <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xce>
  c4:	xor    %esi,%esi
  c6:	mov    %r15,%rdi
  c9:	call   ce <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xce>
  ce:	mov    0x80(%rsp),%rax
  d6:	mov    %r15,%r9
  d9:	mov    %rbx,%rdx
  dc:	mov    %r14,%r11
  df:	movq   $0x0,0x60(%rsp)
  e8:	sub    %r14,%r9
  eb:	shl    $0x2,%rax
  ef:	mov    %r9,%rbx
  f2:	mov    %r15,%r9
  f5:	mov    %r13,%r15
  f8:	mov    %rax,0x70(%rsp)
  fd:	lea    0x0(,%r13,4),%rax
 105:	mov    %rax,0x98(%rsp)
 10d:	mov    0x60(%rsp),%rdi
 112:	mov    %rdx,%rax
 115:	sub    %rdi,%rax
 118:	mov    %rdi,%rsi
 11b:	mov    %rdi,0xb0(%rsp)
 123:	cmp    %rbp,%rax
 126:	cmova  %rbp,%rax
 12a:	add    %rax,%rdi
 12d:	mov    %rsi,%rax
 130:	mov    %rdi,0x60(%rsp)
 135:	cmp    %rdi,%rsi
 138:	jae    501 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x501>
 13e:	mov    %r15,0x8(%rsp)
 143:	mov    %r9,%r13
 146:	mov    %r12,%r10
 149:	mov    %r11,%r14
 14c:	mov    0x80(%rsp),%rsi
 154:	mov    %rbp,0xc0(%rsp)
 15c:	xor    %r9d,%r9d
 15f:	mov    %rdx,0xc8(%rsp)
 167:	imul   %rax,%rsi
 16b:	imul   %r15,%rax
 16f:	mov    %rsi,0x90(%rsp)
 177:	mov    %rax,%rsi
 17a:	mov    0x8(%rsp),%rdx
 17f:	mov    %r9,%r12
 182:	mov    %r10,0xd8(%rsp)
 18a:	lea    (%r12,%rsi,1),%r8
 18e:	mov    %rbx,0xe0(%rsp)
 196:	sub    %r9,%rdx
 199:	mov    %rsi,0xd0(%rsp)
 1a1:	cmp    %r10,%rdx
 1a4:	mov    %rdx,%rax
 1a7:	cmova  %r10,%rax
 1ab:	add    %rax,%r9
 1ae:	mov    %rax,(%rsp)
 1b2:	lea    (%r9,%rsi,1),%rdx
 1b6:	mov    %r9,%rsi
 1b9:	lea    0x0(%r13,%rdx,4),%rdi
 1be:	xor    %edx,%edx
 1c0:	mov    %rdi,0xa0(%rsp)
 1c8:	lea    (%rbx,%r8,4),%rdi
 1cc:	mov    %rdi,0xa8(%rsp)
 1d4:	lea    -0x1(%rax),%rdi
 1d8:	mov    %rdi,0x10(%rsp)
 1dd:	mov    %rax,%rdi
 1e0:	shr    $0x2,%rdi
 1e4:	shl    $0x4,%rdi
 1e8:	mov    %rdi,%rbp
 1eb:	mov    %rax,%rdi
 1ee:	and    $0x3,%eax
 1f1:	and    $0xfffffffffffffffc,%rdi
 1f5:	mov    %rax,0x20(%rsp)
 1fa:	mov    %rdi,0x78(%rsp)
 1ff:	mov    %r8,%rdi
 202:	mov    0x98(%rsp),%r8
 20a:	mov    0x80(%rsp),%rax
 212:	mov    0xb8(%rsp),%rbx
 21a:	mov    %rdx,%rcx
 21d:	sub    %rdx,%rax
 220:	cmp    %rbx,%rax
 223:	cmova  %rbx,%rax
 227:	add    %rax,%rdx
 22a:	cmp    %rdx,%rcx
 22d:	jae    4ae <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x4ae>
 233:	cmp    %rsi,%r12
 236:	jae    4ae <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x4ae>
 23c:	mov    0x90(%rsp),%rax
 244:	mov    0x88(%rsp),%rbx
 24c:	mov    %rdi,0x18(%rsp)
 251:	mov    %rsi,0xe8(%rsp)
 259:	mov    0xa8(%rsp),%r9
 261:	add    %rdx,%rax
 264:	mov    %rdx,0xf0(%rsp)
 26c:	lea    (%rbx,%rax,4),%r15
 270:	mov    %rcx,%rax
 273:	mov    %rdi,0xf8(%rsp)
 27b:	sub    %rdx,%rax
 27e:	lea    0x0(,%rax,4),%rbx
 286:	mov    0x8(%rsp),%rax
 28b:	imul   %rcx,%rax
 28f:	mov    0xb0(%rsp),%rcx
 297:	add    %r12,%rax
 29a:	mov    %rax,0x68(%rsp)
 29f:	mov    0xa0(%rsp),%rax
 2a7:	mov    %rax,0x40(%rsp)
 2ac:	nopl   0x0(%rax)
 2b0:	mov    0x18(%rsp),%rax
 2b5:	mov    %rcx,0x50(%rsp)
 2ba:	mov    %rbx,%r10
 2bd:	mov    0x68(%rsp),%rsi
 2c2:	mov    %r8,0x58(%rsp)
 2c7:	mov    %r9,%r8
 2ca:	lea    0x0(%r13,%rax,4),%r11
 2cf:	mov    %rax,%rdi
 2d2:	lea    (%r14,%r9,1),%rax
 2d6:	sub    %r12,%rdi
 2d9:	mov    %r11,0x48(%rsp)
 2de:	mov    0x78(%rsp),%r11
 2e3:	mov    %rdi,0x28(%rsp)
 2e8:	lea    (%r15,%rbx,1),%rdi
 2ec:	movss  (%rdi),%xmm2
 2f0:	cmpq   $0x1,(%rsp)
 2f5:	je     3f0 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3f0>
 2fb:	mov    %r8,0x30(%rsp)
 300:	mov    %rsi,%rcx
 303:	lea    -0x4(%r8),%rbx
 307:	mov    %r10,0x38(%rsp)
 30c:	sub    %r12,%rcx
 30f:	lea    0x0(,%rsi,4),%r9
 317:	mov    %rbx,%rdx
 31a:	sub    %r9,%rdx
 31d:	cmp    $0x8,%rdx
 321:	jbe    51e <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x51e>
 327:	cmpq   $0x2,0x10(%rsp)
 32d:	jbe    546 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x546>
 333:	movaps %xmm2,%xmm1
 336:	lea    (%r14,%r9,1),%r8
 33a:	xor    %edx,%edx
 33c:	shufps $0x0,%xmm1,%xmm1
 340:	movups (%r8,%rdx,1),%xmm0
 345:	movups (%rax,%rdx,1),%xmm3
 349:	mulps  %xmm1,%xmm0
 34c:	addps  %xmm3,%xmm0
 34f:	movups %xmm0,(%rax,%rdx,1)
 353:	add    $0x10,%rdx
 357:	cmp    %rbp,%rdx
 35a:	jne    340 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x340>
 35c:	testb  $0x3,(%rsp)
 360:	je     3c8 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3c8>
 362:	mov    0x20(%rsp),%r10
 367:	mov    %r11,%r8
 36a:	lea    (%r11,%r12,1),%rdx
 36e:	mov    %r10,%r9
 371:	cmp    $0x1,%r10
 375:	je     3a8 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3a8>
 377:	mov    0x18(%rsp),%r10
 37c:	add    %r8,%r10
 37f:	add    %rsi,%r8
 382:	movq   (%r14,%r8,4),%xmm0
 388:	mulps  %xmm0,%xmm1
 38b:	movq   0x0(%r13,%r10,4),%xmm0
 392:	addps  %xmm0,%xmm1
 395:	movlps %xmm1,0x0(%r13,%r10,4)
 39b:	test   $0x1,%r9b
 39f:	je     3c8 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3c8>
 3a1:	and    $0xfffffffffffffffe,%r9
 3a5:	add    %r9,%rdx
 3a8:	mov    0x28(%rsp),%r10
 3ad:	lea    (%r10,%rdx,1),%r8
 3b1:	add    %rcx,%rdx
 3b4:	mulss  (%r14,%rdx,4),%xmm2
 3ba:	addss  0x0(%r13,%r8,4),%xmm2
 3c1:	movss  %xmm2,0x0(%r13,%r8,4)
 3c8:	add    $0x4,%rdi
 3cc:	cmp    %r15,%rdi
 3cf:	je     52d <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x52d>
 3d5:	add    0x8(%rsp),%rsi
 3da:	movss  (%rdi),%xmm2
 3de:	mov    %rsi,%rcx
 3e1:	sub    %r12,%rcx
 3e4:	jmp    30f <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x30f>
 3e9:	nopl   0x0(%rax)
 3f0:	lea    0x0(,%rsi,4),%r9
 3f8:	mov    0x48(%rsp),%rdx
 3fd:	mov    0x40(%rsp),%rcx
 402:	add    %r14,%r9
 405:	nopl   0x0(%rax,%rax,1)
 40a:	data16 cs nopw 0x0(%rax,%rax,1)
 415:	data16 cs nopw 0x0(%rax,%rax,1)
 420:	movss  (%r9),%xmm0
 425:	add    $0x4,%rdx
 429:	add    $0x4,%r9
 42d:	mulss  %xmm2,%xmm0
 431:	addss  -0x4(%rdx),%xmm0
 436:	movss  %xmm0,-0x4(%rdx)
 43b:	cmp    %rcx,%rdx
 43e:	jne    420 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x420>
 440:	add    $0x4,%rdi
 444:	add    0x8(%rsp),%rsi
 449:	cmp    %r15,%rdi
 44c:	jne    2ec <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x2ec>
 452:	mov    %r8,%r9
 455:	mov    0x50(%rsp),%rcx
 45a:	mov    0x58(%rsp),%r8
 45f:	mov    %r10,%rbx
 462:	nopl   (%rax)
 465:	data16 cs nopw 0x0(%rax,%rax,1)
 470:	mov    0x8(%rsp),%rdi
 475:	add    %r8,0x40(%rsp)
 47a:	add    $0x1,%rcx
 47e:	add    %r8,%r9
 481:	add    %rdi,0x18(%rsp)
 486:	add    0x70(%rsp),%r15
 48b:	cmp    %rcx,0x60(%rsp)
 490:	jne    2b0 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x2b0>
 496:	mov    0xe8(%rsp),%rsi
 49e:	mov    0xf0(%rsp),%rdx
 4a6:	mov    0xf8(%rsp),%rdi
 4ae:	cmp    0x80(%rsp),%rdx
 4b6:	jb     20a <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x20a>
 4bc:	mov    0x8(%rsp),%rax
 4c1:	mov    %rsi,%r9
 4c4:	mov    0xd8(%rsp),%r10
 4cc:	mov    0xd0(%rsp),%rsi
 4d4:	mov    0xe0(%rsp),%rbx
 4dc:	cmp    %rax,%r9
 4df:	jb     17a <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x17a>
 4e5:	mov    %r10,%r12
 4e8:	mov    %r14,%r11
 4eb:	mov    %r13,%r9
 4ee:	mov    %rax,%r15
 4f1:	mov    0xc0(%rsp),%rbp
 4f9:	mov    0xc8(%rsp),%rdx
 501:	cmp    %rdx,0x60(%rsp)
 506:	jb     10d <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x10d>
 50c:	add    $0x108,%rsp
 513:	pop    %rbx
 514:	pop    %rbp
 515:	pop    %r12
 517:	pop    %r13
 519:	pop    %r14
 51b:	pop    %r15
 51d:	ret
 51e:	mov    0x30(%rsp),%r8
 523:	mov    0x38(%rsp),%r10
 528:	jmp    3f8 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3f8>
 52d:	mov    0x50(%rsp),%rcx
 532:	mov    0x58(%rsp),%r8
 537:	mov    0x30(%rsp),%r9
 53c:	mov    0x38(%rsp),%rbx
 541:	jmp    470 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x470>
 546:	movaps %xmm2,%xmm1
 549:	mov    (%rsp),%r9
 54d:	mov    %r12,%rdx
 550:	xor    %r8d,%r8d
 553:	shufps $0x0,%xmm1,%xmm1
 557:	jmp    377 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x377>
 55c:	imul   %r8,%rbx
 560:	lea    0x0(,%rbx,4),%rdx
 568:	lea    (%r15,%rdx,1),%rax
 56c:	cmp    %rax,%r15
 56f:	je     50c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x50c>
 571:	add    $0x108,%rsp
 578:	mov    %r15,%rdi
 57b:	xor    %esi,%esi
 57d:	pop    %rbx
 57e:	pop    %rbp
 57f:	pop    %r12
 581:	pop    %r13
 583:	pop    %r14
 585:	pop    %r15
 587:	jmp    58c <.LC1+0x55c>

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x4e>
  4e:	jmp    1c <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  50:	endbr64
  54:	mov    %rax,%rbp
  57:	mov    %rbx,%rdi
  5a:	call   5f <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x5f>
  5f:	mov    %rbp,%rdi
  62:	call   67 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x67>
  67:	endbr64
  6b:	jmp    54 <mini_gpu::matmul_cpu_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x54>
