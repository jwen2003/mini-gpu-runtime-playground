<REPO>/build-register/CMakeFiles/matmul_cpu.dir/src/cpu/blocked_ikj.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)>:
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
  56:	jne    5c <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x5c>
  5c:	test   %rbp,%rbp
  5f:	je     65 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x65>
  65:	mov    %rcx,%rbx
  68:	test   %rcx,%rcx
  6b:	je     515 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x515>
  71:	mov    %r8,%r13
  74:	test   %r8,%r8
  77:	je     515 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x515>
  7d:	test   %r15,%r15
  80:	je     86 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x86>
  86:	cmpq   $0x0,0x80(%rsp)
  8f:	je     55a <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x55a>
  95:	cmpq   $0x0,0x88(%rsp)
  9e:	je     a4 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xa4>
  a4:	mov    %rsi,%r14
  a7:	test   %rsi,%rsi
  aa:	je     b0 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xb0>
  b0:	mov    %rcx,%rdx
  b3:	imul   %r8,%rdx
  b7:	shl    $0x2,%rdx
  bb:	lea    (%r15,%rdx,1),%rax
  bf:	cmp    %rax,%r15
  c2:	je     ce <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xce>
  c4:	xor    %esi,%esi
  c6:	mov    %r15,%rdi
  c9:	call   ce <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0xce>
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
 138:	jae    50a <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x50a>
 13e:	mov    0x80(%rsp),%rsi
 146:	mov    %r9,%r14
 149:	mov    %r15,%r13
 14c:	mov    %r12,%r10
 14f:	mov    %rbp,0xc0(%rsp)
 157:	xor    %r9d,%r9d
 15a:	imul   %rax,%rsi
 15e:	mov    %rdx,0xc8(%rsp)
 166:	imul   %r15,%rax
 16a:	mov    %r11,%r15
 16d:	mov    %rsi,0x90(%rsp)
 175:	mov    %rax,%rsi
 178:	mov    %r13,%rdx
 17b:	mov    %r9,%rbp
 17e:	mov    %r10,0xd8(%rsp)
 186:	sub    %r9,%rdx
 189:	lea    0x0(%rbp,%rsi,1),%r8
 18e:	mov    %rbx,0xe0(%rsp)
 196:	cmp    %r10,%rdx
 199:	mov    %rdx,%rax
 19c:	mov    %rsi,0xd0(%rsp)
 1a4:	cmova  %r10,%rax
 1a8:	add    %rax,%r9
 1ab:	mov    %rax,0x8(%rsp)
 1b0:	lea    (%r9,%rsi,1),%rdx
 1b4:	mov    %r9,%rsi
 1b7:	lea    (%r14,%rdx,4),%rdi
 1bb:	xor    %edx,%edx
 1bd:	mov    %rdi,0xa0(%rsp)
 1c5:	lea    (%rbx,%r8,4),%rdi
 1c9:	mov    %rdi,0xa8(%rsp)
 1d1:	lea    -0x1(%rax),%rdi
 1d5:	mov    %rdi,0x10(%rsp)
 1da:	mov    %rax,%rdi
 1dd:	shr    $0x2,%rdi
 1e1:	shl    $0x4,%rdi
 1e5:	mov    %rdi,%r12
 1e8:	mov    %rax,%rdi
 1eb:	and    $0x3,%eax
 1ee:	and    $0xfffffffffffffffc,%rdi
 1f2:	mov    %rax,0x28(%rsp)
 1f7:	mov    %r13,%rax
 1fa:	mov    %rbp,%r13
 1fd:	mov    %rdi,0x20(%rsp)
 202:	mov    %r8,%rdi
 205:	mov    0x98(%rsp),%r8
 20d:	mov    %rax,%rbp
 210:	mov    0x80(%rsp),%rax
 218:	mov    0xb8(%rsp),%rbx
 220:	mov    %rdx,%rcx
 223:	sub    %rdx,%rax
 226:	cmp    %rbx,%rax
 229:	cmova  %rbx,%rax
 22d:	add    %rax,%rdx
 230:	cmp    %rdx,%rcx
 233:	jae    4b9 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x4b9>
 239:	cmp    %rsi,%r13
 23c:	jae    4b9 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x4b9>
 242:	mov    0x90(%rsp),%rax
 24a:	mov    0x88(%rsp),%rbx
 252:	mov    %rdi,0x18(%rsp)
 257:	mov    %rsi,0xe8(%rsp)
 25f:	mov    0xa8(%rsp),%r9
 267:	add    %rdx,%rax
 26a:	mov    %rdx,0xf0(%rsp)
 272:	lea    (%rbx,%rax,4),%rbx
 276:	mov    %rcx,%rax
 279:	mov    %rdi,0xf8(%rsp)
 281:	sub    %rdx,%rax
 284:	lea    0x0(,%rax,4),%rax
 28c:	mov    %rax,0x78(%rsp)
 291:	mov    %rcx,%rax
 294:	mov    0xb0(%rsp),%rcx
 29c:	imul   %rbp,%rax
 2a0:	add    %r13,%rax
 2a3:	mov    %rax,0x68(%rsp)
 2a8:	mov    0xa0(%rsp),%rax
 2b0:	mov    %rax,0x48(%rsp)
 2b5:	data16 cs nopw 0x0(%rax,%rax,1)
 2c0:	mov    0x18(%rsp),%rax
 2c5:	mov    0x68(%rsp),%rsi
 2ca:	mov    %rcx,0x58(%rsp)
 2cf:	mov    %r8,%r10
 2d2:	mov    %r9,%r8
 2d5:	mov    %rax,%rdi
 2d8:	lea    (%r14,%rax,4),%r11
 2dc:	lea    (%r15,%r9,1),%rax
 2e0:	sub    %r13,%rdi
 2e3:	mov    %r11,0x50(%rsp)
 2e8:	mov    %rdi,0x30(%rsp)
 2ed:	mov    0x78(%rsp),%rdi
 2f2:	add    %rbx,%rdi
 2f5:	movss  (%rdi),%xmm2
 2f9:	cmpq   $0x1,0x8(%rsp)
 2ff:	je     420 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x420>
 305:	mov    %r10,0x38(%rsp)
 30a:	mov    %rsi,%rcx
 30d:	lea    -0x4(%r8),%r11
 311:	mov    %r8,0x40(%rsp)
 316:	sub    %r13,%rcx
 319:	lea    0x0(,%rsi,4),%r9
 321:	mov    %r11,%rdx
 324:	sub    %r9,%rdx
 327:	cmp    $0x8,%rdx
 32b:	jbe    527 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x527>
 331:	cmpq   $0x2,0x10(%rsp)
 337:	jbe    54a <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x54a>
 33d:	movaps %xmm2,%xmm1
 340:	lea    (%r15,%r9,1),%r8
 344:	xor    %edx,%edx
 346:	shufps $0x0,%xmm1,%xmm1
 34a:	data16 cs nopw 0x0(%rax,%rax,1)
 355:	data16 cs nopw 0x0(%rax,%rax,1)
 360:	movups (%r8,%rdx,1),%xmm0
 365:	movups (%rax,%rdx,1),%xmm3
 369:	mulps  %xmm1,%xmm0
 36c:	addps  %xmm3,%xmm0
 36f:	movups %xmm0,(%rax,%rdx,1)
 373:	add    $0x10,%rdx
 377:	cmp    %r12,%rdx
 37a:	jne    360 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x360>
 37c:	testb  $0x3,0x8(%rsp)
 381:	je     3f8 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3f8>
 383:	mov    0x20(%rsp),%rdx
 388:	mov    0x28(%rsp),%r10
 38d:	mov    %rdx,%r8
 390:	mov    %r10,%r9
 393:	add    %r13,%rdx
 396:	cmp    $0x1,%r10
 39a:	je     3da <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3da>
 39c:	mov    0x18(%rsp),%r10
 3a1:	movaps %xmm2,%xmm1
 3a4:	shufps $0xe0,%xmm1,%xmm1
 3a8:	movq   %xmm1,%xmm1
 3ac:	add    %r8,%r10
 3af:	add    %rsi,%r8
 3b2:	movq   (%r15,%r8,4),%xmm0
 3b8:	mulps  %xmm1,%xmm0
 3bb:	movq   (%r14,%r10,4),%xmm1
 3c1:	movq   %xmm0,%xmm0
 3c5:	addps  %xmm1,%xmm0
 3c8:	movlps %xmm0,(%r14,%r10,4)
 3cd:	test   $0x1,%r9b
 3d1:	je     3f8 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x3f8>
 3d3:	and    $0xfffffffffffffffe,%r9
 3d7:	add    %r9,%rdx
 3da:	mov    0x30(%rsp),%r10
 3df:	lea    (%r10,%rdx,1),%r8
 3e3:	add    %rcx,%rdx
 3e6:	mulss  (%r15,%rdx,4),%xmm2
 3ec:	addss  (%r14,%r8,4),%xmm2
 3f2:	movss  %xmm2,(%r14,%r8,4)
 3f8:	add    $0x4,%rdi
 3fc:	cmp    %rbx,%rdi
 3ff:	je     536 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x536>
 405:	add    %rbp,%rsi
 408:	movss  (%rdi),%xmm2
 40c:	mov    %rsi,%rcx
 40f:	sub    %r13,%rcx
 412:	jmp    319 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x319>
 417:	nopw   0x0(%rax,%rax,1)
 420:	lea    0x0(,%rsi,4),%r9
 428:	mov    0x50(%rsp),%rdx
 42d:	mov    0x48(%rsp),%rcx
 432:	add    %r15,%r9
 435:	data16 cs nopw 0x0(%rax,%rax,1)
 440:	movss  (%r9),%xmm0
 445:	add    $0x4,%rdx
 449:	add    $0x4,%r9
 44d:	mulss  %xmm2,%xmm0
 451:	addss  -0x4(%rdx),%xmm0
 456:	movss  %xmm0,-0x4(%rdx)
 45b:	cmp    %rcx,%rdx
 45e:	jne    440 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x440>
 460:	add    $0x4,%rdi
 464:	add    %rbp,%rsi
 467:	cmp    %rbx,%rdi
 46a:	jne    2f5 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x2f5>
 470:	mov    0x58(%rsp),%rcx
 475:	mov    %r8,%r9
 478:	mov    %r10,%r8
 47b:	nopl   0x0(%rax,%rax,1)
 480:	add    %r8,0x48(%rsp)
 485:	add    $0x1,%rcx
 489:	add    0x70(%rsp),%rbx
 48e:	add    %r8,%r9
 491:	add    %rbp,0x18(%rsp)
 496:	cmp    %rcx,0x60(%rsp)
 49b:	jne    2c0 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x2c0>
 4a1:	mov    0xe8(%rsp),%rsi
 4a9:	mov    0xf0(%rsp),%rdx
 4b1:	mov    0xf8(%rsp),%rdi
 4b9:	cmp    0x80(%rsp),%rdx
 4c1:	jb     210 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x210>
 4c7:	mov    %rsi,%r9
 4ca:	mov    0xd8(%rsp),%r10
 4d2:	mov    %rbp,%r13
 4d5:	mov    0xd0(%rsp),%rsi
 4dd:	mov    0xe0(%rsp),%rbx
 4e5:	cmp    %rbp,%r9
 4e8:	jb     178 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x178>
 4ee:	mov    0xc0(%rsp),%rbp
 4f6:	mov    %r15,%r11
 4f9:	mov    %r10,%r12
 4fc:	mov    %r14,%r9
 4ff:	mov    0xc8(%rsp),%rdx
 507:	mov    %r13,%r15
 50a:	cmp    %rdx,0x60(%rsp)
 50f:	jb     10d <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x10d>
 515:	add    $0x108,%rsp
 51c:	pop    %rbx
 51d:	pop    %rbp
 51e:	pop    %r12
 520:	pop    %r13
 522:	pop    %r14
 524:	pop    %r15
 526:	ret
 527:	mov    0x38(%rsp),%r10
 52c:	mov    0x40(%rsp),%r8
 531:	jmp    428 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x428>
 536:	mov    0x58(%rsp),%rcx
 53b:	mov    0x38(%rsp),%r8
 540:	mov    0x40(%rsp),%r9
 545:	jmp    480 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x480>
 54a:	mov    0x8(%rsp),%r9
 54f:	mov    %r13,%rdx
 552:	xor    %r8d,%r8d
 555:	jmp    39c <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x39c>
 55a:	imul   %r8,%rbx
 55e:	lea    0x0(,%rbx,4),%rdx
 566:	lea    (%r15,%rdx,1),%rax
 56a:	cmp    %rax,%r15
 56d:	je     515 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)+0x515>
 56f:	add    $0x108,%rsp
 576:	mov    %r15,%rdi
 579:	xor    %esi,%esi
 57b:	pop    %rbx
 57c:	pop    %rbp
 57d:	pop    %r12
 57f:	pop    %r13
 581:	pop    %r14
 583:	pop    %r15
 585:	jmp    58a <.LC1+0x55a>

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x4e>
  4e:	jmp    1c <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  50:	endbr64
  54:	mov    %rax,%rbp
  57:	mov    %rbx,%rdi
  5a:	call   5f <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x5f>
  5f:	mov    %rbp,%rdi
  62:	call   67 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x67>
  67:	endbr64
  6b:	jmp    54 <mini_gpu::matmul_cpu_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) [clone .cold]+0x54>
