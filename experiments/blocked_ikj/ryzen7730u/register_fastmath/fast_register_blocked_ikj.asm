<REPO>/build-register/CMakeFiles/matmul_register_fast.dir/src/cpu/register_blocked_ikj.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <void mini_gpu::(anonymous namespace)::microkernel<2ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
       0:	shl    $0x2,%rcx
       4:	movups (%rdx),%xmm6
       7:	movups 0x10(%rdx),%xmm5
       b:	lea    (%rdx,%rcx,1),%r11
       f:	lea    0x10(%rdx,%rcx,1),%r10
      14:	movups (%r11),%xmm4
      18:	movups (%r10),%xmm3
      1c:	test   %r9,%r9
      1f:	je     80 <void mini_gpu::(anonymous namespace)::microkernel<2ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x80>
      21:	lea    (%rdi,%r9,4),%rax
      25:	nopl   0x0(%rax,%rax,1)
      2a:	data16 cs nopw 0x0(%rax,%rax,1)
      35:	data16 cs nopw 0x0(%rax,%rax,1)
      40:	movups (%rsi),%xmm1
      43:	movups 0x10(%rsi),%xmm0
      47:	add    %rcx,%rsi
      4a:	movss  (%rdi),%xmm2
      4e:	movaps %xmm1,%xmm7
      51:	shufps $0x0,%xmm2,%xmm2
      55:	mulps  %xmm2,%xmm7
      58:	mulps  %xmm0,%xmm2
      5b:	addps  %xmm7,%xmm6
      5e:	addps  %xmm2,%xmm5
      61:	movss  (%rdi,%r8,4),%xmm2
      67:	add    $0x4,%rdi
      6b:	shufps $0x0,%xmm2,%xmm2
      6f:	mulps  %xmm2,%xmm1
      72:	mulps  %xmm2,%xmm0
      75:	addps  %xmm1,%xmm4
      78:	addps  %xmm0,%xmm3
      7b:	cmp    %rdi,%rax
      7e:	jne    40 <void mini_gpu::(anonymous namespace)::microkernel<2ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x40>
      80:	movups %xmm6,(%rdx)
      83:	movups %xmm5,0x10(%rdx)
      87:	movups %xmm4,(%r11)
      8b:	movups %xmm3,(%r10)
      8f:	ret

0000000000000090 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
      90:	mov    %rcx,%rax
      93:	shl    $0x2,%rcx
      97:	push   %r14
      99:	mov    %r9,%r14
      9c:	lea    (%rdx,%rcx,1),%r9
      a0:	push   %r13
      a2:	lea    0x10(%rdx,%rcx,1),%r13
      a7:	mov    %rdx,%r10
      aa:	push   %r12
      ac:	lea    (%r9,%rcx,1),%r11
      b0:	lea    0x10(%rdx,%rax,8),%r12
      b5:	lea    (%rax,%rax,2),%rax
      b9:	push   %rbp
      ba:	lea    (%r11,%rcx,1),%rbp
      be:	push   %rbx
      bf:	lea    0x10(%rdx,%rax,4),%rbx
      c4:	movups (%rdx),%xmm10
      c8:	movups 0x10(%rdx),%xmm9
      cd:	movups (%r9),%xmm8
      d1:	movups 0x0(%r13),%xmm7
      d6:	movups (%r11),%xmm6
      da:	movups (%r12),%xmm5
      df:	movups 0x0(%rbp),%xmm4
      e3:	movups (%rbx),%xmm3
      e6:	test   %r14,%r14
      e9:	je     18c <void mini_gpu::(anonymous namespace)::microkernel<4ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0xfc>
      ef:	mov    %rsi,%rdx
      f2:	lea    (%r8,%r8,2),%rsi
      f6:	mov    %rdi,%rax
      f9:	shl    $0x2,%rsi
      fd:	lea    (%rdi,%r14,4),%rdi
     101:	nopl   0x0(%rax)
     105:	data16 cs nopw 0x0(%rax,%rax,1)
     110:	movups (%rdx),%xmm1
     113:	movups 0x10(%rdx),%xmm0
     117:	add    %rcx,%rdx
     11a:	movss  (%rax),%xmm2
     11e:	movaps %xmm1,%xmm11
     122:	shufps $0x0,%xmm2,%xmm2
     126:	mulps  %xmm2,%xmm11
     12a:	mulps  %xmm0,%xmm2
     12d:	addps  %xmm11,%xmm10
     131:	movaps %xmm1,%xmm11
     135:	addps  %xmm2,%xmm9
     139:	movss  (%rax,%r8,4),%xmm2
     13f:	shufps $0x0,%xmm2,%xmm2
     143:	mulps  %xmm2,%xmm11
     147:	mulps  %xmm0,%xmm2
     14a:	addps  %xmm11,%xmm8
     14e:	movaps %xmm1,%xmm11
     152:	addps  %xmm2,%xmm7
     155:	movss  (%rax,%r8,8),%xmm2
     15b:	add    $0x4,%rax
     15f:	shufps $0x0,%xmm2,%xmm2
     163:	mulps  %xmm2,%xmm11
     167:	mulps  %xmm0,%xmm2
     16a:	addps  %xmm11,%xmm6
     16e:	addps  %xmm2,%xmm5
     171:	movss  -0x4(%rax,%rsi,1),%xmm2
     177:	shufps $0x0,%xmm2,%xmm2
     17b:	mulps  %xmm2,%xmm1
     17e:	mulps  %xmm2,%xmm0
     181:	addps  %xmm1,%xmm4
     184:	addps  %xmm0,%xmm3
     187:	cmp    %rax,%rdi
     18a:	jne    110 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x80>
     18c:	movups %xmm10,(%r10)
     190:	movups %xmm9,0x10(%r10)
     195:	movups %xmm8,(%r9)
     199:	movups %xmm7,0x0(%r13)
     19e:	movups %xmm6,(%r11)
     1a2:	movups %xmm5,(%r12)
     1a7:	movups %xmm4,0x0(%rbp)
     1ab:	movups %xmm3,(%rbx)
     1ae:	pop    %rbx
     1af:	pop    %rbp
     1b0:	pop    %r12
     1b2:	pop    %r13
     1b4:	pop    %r14
     1b6:	ret
     1b7:	nopw   0x0(%rax,%rax,1)

00000000000001c0 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
     1c0:	push   %r15
     1c2:	lea    0x0(,%rcx,4),%rax
     1ca:	mov    %r9,%r15
     1cd:	lea    0x0(,%rcx,8),%r9
     1d5:	push   %r14
     1d7:	lea    (%rdx,%rax,1),%r11
     1db:	lea    (%rcx,%rcx,2),%rcx
     1df:	push   %r13
     1e1:	lea    (%r11,%rax,1),%r10
     1e5:	shl    $0x2,%rcx
     1e9:	lea    0x10(%rdx,%rax,1),%r14
     1ee:	push   %r12
     1f0:	lea    0x20(%rdx,%rax,1),%r13
     1f5:	lea    0x30(%rdx,%rax,1),%r12
     1fa:	push   %rbp
     1fb:	lea    0x10(%rdx,%r9,1),%rbp
     200:	push   %rbx
     201:	lea    0x20(%rdx,%r9,1),%rbx
     206:	lea    0x30(%rdx,%r9,1),%r9
     20b:	sub    $0x20,%rsp
     20f:	movups (%rdx),%xmm5
     212:	movups 0x10(%rdx),%xmm6
     216:	movups 0x20(%rdx),%xmm7
     21a:	movups (%r14),%xmm14
     21e:	mov    %rsi,0x10(%rsp)
     223:	lea    (%r10,%rax,1),%rsi
     227:	movaps %xmm5,-0x78(%rsp)
     22c:	movups 0x30(%rdx),%xmm5
     230:	movups 0x0(%r13),%xmm13
     235:	movaps %xmm6,-0x58(%rsp)
     23a:	movups (%r11),%xmm6
     23e:	movups (%r12),%xmm12
     243:	movaps %xmm7,-0x68(%rsp)
     248:	movups (%r10),%xmm7
     24c:	movups 0x0(%rbp),%xmm11
     251:	movaps %xmm5,-0x48(%rsp)
     256:	movups (%rbx),%xmm10
     25a:	movaps %xmm6,-0x38(%rsp)
     25f:	movaps %xmm7,-0x28(%rsp)
     264:	movups (%r9),%xmm9
     268:	movups (%rsi),%xmm8
     26c:	mov    %rsi,-0x10(%rsp)
     271:	lea    0x10(%rdx,%rcx,1),%rsi
     276:	mov    %rsi,-0x8(%rsp)
     27b:	movups (%rsi),%xmm7
     27e:	lea    0x20(%rdx,%rcx,1),%rsi
     283:	lea    0x30(%rdx,%rcx,1),%rcx
     288:	movups (%rsi),%xmm6
     28b:	movups (%rcx),%xmm5
     28e:	mov    %rsi,(%rsp)
     292:	mov    %rcx,0x8(%rsp)
     297:	test   %r15,%r15
     29a:	je     3cd <void mini_gpu::(anonymous namespace)::microkernel<4ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x20d>
     2a0:	lea    (%r8,%r8,2),%rcx
     2a4:	mov    0x10(%rsp),%rsi
     2a9:	lea    (%rdi,%r15,4),%r15
     2ad:	shl    $0x2,%rcx
     2b1:	nopl   0x0(%rax)
     2b5:	data16 cs nopw 0x0(%rax,%rax,1)
     2c0:	movups (%rsi),%xmm3
     2c3:	movss  (%rdi),%xmm4
     2c7:	movups 0x10(%rsi),%xmm2
     2cb:	movups 0x20(%rsi),%xmm1
     2cf:	movaps %xmm3,%xmm15
     2d3:	shufps $0x0,%xmm4,%xmm4
     2d7:	movups 0x30(%rsi),%xmm0
     2db:	add    %rax,%rsi
     2de:	mulps  %xmm4,%xmm15
     2e2:	addps  -0x78(%rsp),%xmm15
     2e8:	movaps %xmm15,-0x78(%rsp)
     2ee:	movaps %xmm2,%xmm15
     2f2:	mulps  %xmm4,%xmm15
     2f6:	addps  -0x58(%rsp),%xmm15
     2fc:	movaps %xmm15,-0x58(%rsp)
     302:	movaps %xmm1,%xmm15
     306:	mulps  %xmm4,%xmm15
     30a:	mulps  %xmm0,%xmm4
     30d:	addps  -0x68(%rsp),%xmm15
     313:	addps  -0x48(%rsp),%xmm4
     318:	movaps %xmm15,-0x68(%rsp)
     31e:	movaps %xmm3,%xmm15
     322:	movaps %xmm4,-0x48(%rsp)
     327:	movss  (%rdi,%r8,4),%xmm4
     32d:	shufps $0x0,%xmm4,%xmm4
     331:	mulps  %xmm4,%xmm15
     335:	addps  -0x38(%rsp),%xmm15
     33b:	movaps %xmm15,-0x38(%rsp)
     341:	movaps %xmm2,%xmm15
     345:	mulps  %xmm4,%xmm15
     349:	addps  %xmm15,%xmm14
     34d:	movaps %xmm1,%xmm15
     351:	mulps  %xmm4,%xmm15
     355:	mulps  %xmm0,%xmm4
     358:	addps  %xmm15,%xmm13
     35c:	movaps %xmm3,%xmm15
     360:	addps  %xmm4,%xmm12
     364:	movss  (%rdi,%r8,8),%xmm4
     36a:	add    $0x4,%rdi
     36e:	shufps $0x0,%xmm4,%xmm4
     372:	mulps  %xmm4,%xmm15
     376:	addps  -0x28(%rsp),%xmm15
     37c:	movaps %xmm15,-0x28(%rsp)
     382:	movaps %xmm2,%xmm15
     386:	mulps  %xmm4,%xmm15
     38a:	addps  %xmm15,%xmm11
     38e:	movaps %xmm1,%xmm15
     392:	mulps  %xmm4,%xmm15
     396:	mulps  %xmm0,%xmm4
     399:	addps  %xmm15,%xmm10
     39d:	addps  %xmm4,%xmm9
     3a1:	movss  -0x4(%rdi,%rcx,1),%xmm4
     3a7:	shufps $0x0,%xmm4,%xmm4
     3ab:	mulps  %xmm4,%xmm3
     3ae:	mulps  %xmm4,%xmm2
     3b1:	mulps  %xmm4,%xmm1
     3b4:	mulps  %xmm4,%xmm0
     3b7:	addps  %xmm3,%xmm8
     3bb:	addps  %xmm2,%xmm7
     3be:	addps  %xmm1,%xmm6
     3c1:	addps  %xmm0,%xmm5
     3c4:	cmp    %rdi,%r15
     3c7:	jne    2c0 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x100>
     3cd:	movaps -0x78(%rsp),%xmm0
     3d2:	movaps -0x58(%rsp),%xmm1
     3d7:	mov    -0x10(%rsp),%rax
     3dc:	movaps -0x68(%rsp),%xmm2
     3e1:	movups %xmm0,(%rdx)
     3e4:	movaps -0x48(%rsp),%xmm3
     3e9:	movaps -0x38(%rsp),%xmm0
     3ee:	movups %xmm1,0x10(%rdx)
     3f2:	movaps -0x28(%rsp),%xmm1
     3f7:	movups %xmm2,0x20(%rdx)
     3fb:	movups %xmm3,0x30(%rdx)
     3ff:	movups %xmm0,(%r11)
     403:	movups %xmm14,(%r14)
     407:	movups %xmm13,0x0(%r13)
     40c:	movups %xmm12,(%r12)
     411:	movups %xmm1,(%r10)
     415:	movups %xmm11,0x0(%rbp)
     41a:	movups %xmm10,(%rbx)
     41e:	movups %xmm9,(%r9)
     422:	movups %xmm8,(%rax)
     426:	mov    -0x8(%rsp),%rax
     42b:	movups %xmm7,(%rax)
     42e:	mov    (%rsp),%rax
     432:	movups %xmm6,(%rax)
     435:	mov    0x8(%rsp),%rax
     43a:	movups %xmm5,(%rax)
     43d:	add    $0x20,%rsp
     441:	pop    %rbx
     442:	pop    %rbp
     443:	pop    %r12
     445:	pop    %r13
     447:	pop    %r14
     449:	pop    %r15
     44b:	ret
     44c:	nopl   0x0(%rax)

0000000000000450 <void mini_gpu::(anonymous namespace)::microkernel<8ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
     450:	push   %r15
     452:	mov    %rcx,%rax
     455:	shl    $0x2,%rcx
     459:	mov    %rdi,%r10
     45c:	push   %r14
     45e:	lea    0x10(%rdx,%rcx,1),%rdi
     463:	lea    (%rdx,%rcx,1),%r15
     467:	mov    %rsi,%r11
     46a:	push   %r13
     46c:	mov    %rdx,%rsi
     46f:	lea    (%r15,%rcx,1),%r14
     473:	push   %r12
     475:	lea    (%r14,%rcx,1),%r13
     479:	push   %rbp
     47a:	lea    0x0(%r13,%rcx,1),%r12
     47f:	push   %rbx
     480:	sub    $0x1b0,%rsp
     487:	movups 0x10(%rdx),%xmm5
     48b:	movups 0x20(%rdx),%xmm6
     48f:	movups 0x30(%rdx),%xmm7
     493:	movups (%rdx),%xmm14
     497:	mov    %rdi,0xe8(%rsp)
     49f:	movaps %xmm5,-0x68(%rsp)
     4a4:	movups (%r15),%xmm5
     4a8:	movaps %xmm6,-0x78(%rsp)
     4ad:	movups (%rdi),%xmm6
     4b0:	lea    0x20(%rdx,%rcx,1),%rdi
     4b5:	mov    %rdi,0xf0(%rsp)
     4bd:	movaps %xmm7,0xd8(%rsp)
     4c5:	movups (%rdi),%xmm7
     4c8:	lea    0x30(%rdx,%rcx,1),%rdi
     4cd:	lea    0x0(,%rax,8),%rdx
     4d5:	movaps %xmm5,-0x58(%rsp)
     4da:	movups (%rdi),%xmm5
     4dd:	lea    0x10(%rsi,%rdx,1),%rbx
     4e2:	mov    %rdi,0xf8(%rsp)
     4ea:	lea    0x20(%rsi,%rdx,1),%rdi
     4ef:	movaps %xmm7,-0x38(%rsp)
     4f4:	movaps %xmm5,-0x28(%rsp)
     4f9:	movaps %xmm6,-0x48(%rsp)
     4fe:	movups (%r14),%xmm6
     502:	movups (%rdi),%xmm5
     505:	mov    %rdi,0x108(%rsp)
     50d:	lea    (%rax,%rax,2),%rdi
     511:	movups (%rbx),%xmm7
     514:	mov    %rbx,0x100(%rsp)
     51c:	lea    0x30(%rsi,%rdx,1),%rbx
     521:	lea    0x0(,%rdi,4),%rdx
     529:	mov    %rbx,0x110(%rsp)
     531:	movaps %xmm6,-0x18(%rsp)
     536:	movups (%rbx),%xmm6
     539:	lea    0x10(%rsi,%rdx,1),%rbx
     53e:	mov    %rbx,0x118(%rsp)
     546:	movaps %xmm5,0x8(%rsp)
     54b:	movups (%rbx),%xmm5
     54e:	lea    0x20(%rsi,%rdx,1),%rbx
     553:	mov    %rbx,0x120(%rsp)
     55b:	movaps %xmm7,-0x8(%rsp)
     560:	movups 0x0(%r13),%xmm7
     565:	movaps %xmm6,0x18(%rsp)
     56a:	movups (%rbx),%xmm6
     56d:	lea    0x30(%rsi,%rdx,1),%rbx
     572:	lea    0x1(%rax),%rdx
     576:	shl    $0x4,%rdx
     57a:	mov    %rbx,0x128(%rsp)
     582:	movaps %xmm7,0x28(%rsp)
     587:	movups (%rbx),%xmm7
     58a:	lea    (%rsi,%rdx,1),%rbx
     58e:	movaps %xmm5,0x38(%rsp)
     593:	movups (%r12),%xmm5
     598:	mov    %rbx,0x130(%rsp)
     5a0:	movaps %xmm6,0x48(%rsp)
     5a5:	movups (%rbx),%xmm6
     5a8:	lea    0x10(%rsi,%rdx,1),%rbx
     5ad:	lea    0x20(%rsi,%rdx,1),%rdx
     5b2:	mov    %rdx,0x140(%rsp)
     5ba:	movaps %xmm5,0x68(%rsp)
     5bf:	movups (%rdx),%xmm5
     5c2:	lea    (%rcx,%rax,1),%rdx
     5c6:	shl    $0x2,%rdx
     5ca:	movaps %xmm7,0x58(%rsp)
     5cf:	movups (%rbx),%xmm7
     5d2:	imul   $0x1c,%rax,%rax
     5d6:	lea    0x10(%rsi,%rdx,1),%rbp
     5db:	mov    %rbx,0x138(%rsp)
     5e3:	lea    (%r12,%rcx,1),%rbx
     5e7:	movaps %xmm6,0x78(%rsp)
     5ec:	movaps %xmm7,0x88(%rsp)
     5f4:	movaps %xmm5,0x98(%rsp)
     5fc:	movups 0x0(%rbp),%xmm7
     600:	movups (%rbx),%xmm6
     603:	mov    %rbp,0x150(%rsp)
     60b:	lea    0x20(%rsi,%rdx,1),%rbp
     610:	lea    0x30(%rsi,%rdx,1),%rdx
     615:	movups (%rdx),%xmm13
     619:	movups 0x0(%rbp),%xmm5
     61d:	mov    %rdx,0x160(%rsp)
     625:	lea    0x0(,%rdi,8),%rdx
     62d:	lea    0x10(%rsi,%rdx,1),%rdi
     632:	mov    %rbx,0x148(%rsp)
     63a:	add    %rcx,%rbx
     63d:	movups (%rdi),%xmm11
     641:	mov    %rdi,0x170(%rsp)
     649:	lea    0x20(%rsi,%rdx,1),%rdi
     64e:	movups (%rdi),%xmm10
     652:	mov    %rdi,0x178(%rsp)
     65a:	lea    0x30(%rsi,%rdx,1),%rdi
     65f:	movups (%rdi),%xmm9
     663:	mov    %rdi,0x180(%rsp)
     66b:	lea    (%rbx,%rcx,1),%rdi
     66f:	movups (%rdi),%xmm8
     673:	mov    %rdi,0x188(%rsp)
     67b:	lea    0x10(%rsi,%rax,1),%rdi
     680:	mov    %rdi,0x190(%rsp)
     688:	movups (%rbx),%xmm12
     68c:	movaps %xmm7,0xb8(%rsp)
     694:	movups (%rdi),%xmm7
     697:	lea    0x20(%rsi,%rax,1),%rdi
     69c:	lea    0x30(%rsi,%rax,1),%rax
     6a1:	movaps %xmm6,0xa8(%rsp)
     6a9:	movups (%rdi),%xmm6
     6ac:	movaps %xmm5,0xc8(%rsp)
     6b4:	movups (%rax),%xmm5
     6b7:	mov    %rbp,0x158(%rsp)
     6bf:	mov    %rbx,0x168(%rsp)
     6c7:	mov    %rdi,0x198(%rsp)
     6cf:	mov    %rax,0x1a0(%rsp)
     6d7:	test   %r9,%r9
     6da:	je     99f <void mini_gpu::(anonymous namespace)::microkernel<8ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x54f>
     6e0:	lea    0x0(,%r8,4),%rdi
     6e8:	add    %r8,%r9
     6eb:	mov    %r11,%rdx
     6ee:	lea    (%r10,%rdi,1),%rax
     6f2:	lea    (%r10,%r9,4),%rbp
     6f6:	mov    %rdi,%rbx
     6f9:	mov    %r8,%r10
     6fc:	lea    (%r8,%r8,2),%r9
     700:	add    %r8,%rdi
     703:	neg    %rbx
     706:	shl    $0x4,%r10
     70a:	lea    0x0(,%r9,4),%r11
     712:	shl    $0x2,%rdi
     716:	shl    $0x3,%r9
     71a:	nopw   0x0(%rax,%rax,1)
     720:	movups (%rdx),%xmm3
     723:	movss  (%rax,%rbx,1),%xmm4
     728:	movups 0x10(%rdx),%xmm2
     72c:	movups 0x20(%rdx),%xmm1
     730:	movaps %xmm3,%xmm15
     734:	shufps $0x0,%xmm4,%xmm4
     738:	movups 0x30(%rdx),%xmm0
     73c:	add    %rcx,%rdx
     73f:	mulps  %xmm4,%xmm15
     743:	addps  %xmm15,%xmm14
     747:	movaps %xmm2,%xmm15
     74b:	mulps  %xmm4,%xmm15
     74f:	addps  -0x68(%rsp),%xmm15
     755:	movaps %xmm15,-0x68(%rsp)
     75b:	movaps %xmm1,%xmm15
     75f:	mulps  %xmm4,%xmm15
     763:	mulps  %xmm0,%xmm4
     766:	addps  -0x78(%rsp),%xmm15
     76c:	addps  0xd8(%rsp),%xmm4
     774:	movaps %xmm15,-0x78(%rsp)
     77a:	movaps %xmm3,%xmm15
     77e:	movaps %xmm4,0xd8(%rsp)
     786:	movss  (%rax),%xmm4
     78a:	shufps $0x0,%xmm4,%xmm4
     78e:	mulps  %xmm4,%xmm15
     792:	addps  -0x58(%rsp),%xmm15
     798:	movaps %xmm15,-0x58(%rsp)
     79e:	movaps %xmm2,%xmm15
     7a2:	mulps  %xmm4,%xmm15
     7a6:	addps  -0x48(%rsp),%xmm15
     7ac:	movaps %xmm15,-0x48(%rsp)
     7b2:	movaps %xmm1,%xmm15
     7b6:	mulps  %xmm4,%xmm15
     7ba:	mulps  %xmm0,%xmm4
     7bd:	addps  -0x38(%rsp),%xmm15
     7c3:	addps  -0x28(%rsp),%xmm4
     7c8:	movaps %xmm15,-0x38(%rsp)
     7ce:	movaps %xmm3,%xmm15
     7d2:	movaps %xmm4,-0x28(%rsp)
     7d7:	movss  (%rax,%r8,4),%xmm4
     7dd:	shufps $0x0,%xmm4,%xmm4
     7e1:	mulps  %xmm4,%xmm15
     7e5:	addps  -0x18(%rsp),%xmm15
     7eb:	movaps %xmm15,-0x18(%rsp)
     7f1:	movaps %xmm2,%xmm15
     7f5:	mulps  %xmm4,%xmm15
     7f9:	addps  -0x8(%rsp),%xmm15
     7ff:	movaps %xmm15,-0x8(%rsp)
     805:	movaps %xmm1,%xmm15
     809:	mulps  %xmm4,%xmm15
     80d:	mulps  %xmm0,%xmm4
     810:	addps  0x8(%rsp),%xmm15
     816:	addps  0x18(%rsp),%xmm4
     81b:	movaps %xmm15,0x8(%rsp)
     821:	movaps %xmm3,%xmm15
     825:	movaps %xmm4,0x18(%rsp)
     82a:	movss  (%rax,%r8,8),%xmm4
     830:	add    $0x4,%rax
     834:	shufps $0x0,%xmm4,%xmm4
     838:	mulps  %xmm4,%xmm15
     83c:	addps  0x28(%rsp),%xmm15
     842:	movaps %xmm15,0x28(%rsp)
     848:	movaps %xmm2,%xmm15
     84c:	mulps  %xmm4,%xmm15
     850:	addps  0x38(%rsp),%xmm15
     856:	movaps %xmm15,0x38(%rsp)
     85c:	movaps %xmm1,%xmm15
     860:	mulps  %xmm4,%xmm15
     864:	mulps  %xmm0,%xmm4
     867:	addps  0x48(%rsp),%xmm15
     86d:	addps  0x58(%rsp),%xmm4
     872:	movaps %xmm15,0x48(%rsp)
     878:	movaps %xmm3,%xmm15
     87c:	movaps %xmm4,0x58(%rsp)
     881:	movss  -0x4(%rax,%r11,1),%xmm4
     888:	shufps $0x0,%xmm4,%xmm4
     88c:	mulps  %xmm4,%xmm15
     890:	addps  0x68(%rsp),%xmm15
     896:	movaps %xmm15,0x68(%rsp)
     89c:	movaps %xmm2,%xmm15
     8a0:	mulps  %xmm4,%xmm15
     8a4:	addps  0x78(%rsp),%xmm15
     8aa:	movaps %xmm15,0x78(%rsp)
     8b0:	movaps %xmm1,%xmm15
     8b4:	mulps  %xmm4,%xmm15
     8b8:	addps  0x88(%rsp),%xmm15
     8c1:	mulps  %xmm0,%xmm4
     8c4:	addps  0x98(%rsp),%xmm4
     8cc:	movaps %xmm15,0x88(%rsp)
     8d5:	movaps %xmm3,%xmm15
     8d9:	movaps %xmm4,0x98(%rsp)
     8e1:	movss  -0x4(%rax,%r10,1),%xmm4
     8e8:	shufps $0x0,%xmm4,%xmm4
     8ec:	mulps  %xmm4,%xmm15
     8f0:	addps  0xa8(%rsp),%xmm15
     8f9:	movaps %xmm15,0xa8(%rsp)
     902:	movaps %xmm2,%xmm15
     906:	mulps  %xmm4,%xmm15
     90a:	addps  0xb8(%rsp),%xmm15
     913:	movaps %xmm15,0xb8(%rsp)
     91c:	movaps %xmm1,%xmm15
     920:	mulps  %xmm4,%xmm15
     924:	addps  0xc8(%rsp),%xmm15
     92d:	mulps  %xmm0,%xmm4
     930:	movaps %xmm15,0xc8(%rsp)
     939:	movaps %xmm3,%xmm15
     93d:	addps  %xmm4,%xmm13
     941:	movss  -0x4(%rax,%rdi,1),%xmm4
     947:	shufps $0x0,%xmm4,%xmm4
     94b:	mulps  %xmm4,%xmm15
     94f:	addps  %xmm15,%xmm12
     953:	movaps %xmm2,%xmm15
     957:	mulps  %xmm4,%xmm15
     95b:	addps  %xmm15,%xmm11
     95f:	movaps %xmm1,%xmm15
     963:	mulps  %xmm4,%xmm15
     967:	mulps  %xmm0,%xmm4
     96a:	addps  %xmm15,%xmm10
     96e:	addps  %xmm4,%xmm9
     972:	movss  -0x4(%rax,%r9,1),%xmm4
     979:	shufps $0x0,%xmm4,%xmm4
     97d:	mulps  %xmm4,%xmm3
     980:	mulps  %xmm4,%xmm2
     983:	mulps  %xmm4,%xmm1
     986:	mulps  %xmm4,%xmm0
     989:	addps  %xmm3,%xmm8
     98d:	addps  %xmm2,%xmm7
     990:	addps  %xmm1,%xmm6
     993:	addps  %xmm0,%xmm5
     996:	cmp    %rax,%rbp
     999:	jne    720 <void mini_gpu::(anonymous namespace)::microkernel<8ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2d0>
     99f:	movaps -0x68(%rsp),%xmm0
     9a4:	movaps -0x78(%rsp),%xmm1
     9a9:	movups %xmm14,(%rsi)
     9ad:	movaps 0xd8(%rsp),%xmm2
     9b5:	movaps -0x58(%rsp),%xmm3
     9ba:	movups %xmm0,0x10(%rsi)
     9be:	mov    0xe8(%rsp),%rax
     9c6:	movaps -0x48(%rsp),%xmm0
     9cb:	movups %xmm1,0x20(%rsi)
     9cf:	movaps -0x38(%rsp),%xmm1
     9d4:	movups %xmm2,0x30(%rsi)
     9d8:	movaps -0x28(%rsp),%xmm2
     9dd:	movups %xmm3,(%r15)
     9e1:	movaps -0x18(%rsp),%xmm3
     9e6:	movups %xmm0,(%rax)
     9e9:	mov    0xf0(%rsp),%rax
     9f1:	movaps -0x8(%rsp),%xmm0
     9f6:	movups %xmm1,(%rax)
     9f9:	mov    0xf8(%rsp),%rax
     a01:	movaps 0x8(%rsp),%xmm1
     a06:	movups %xmm2,(%rax)
     a09:	mov    0x100(%rsp),%rax
     a11:	movaps 0x18(%rsp),%xmm2
     a16:	movups %xmm3,(%r14)
     a1a:	movaps 0x28(%rsp),%xmm3
     a1f:	movups %xmm0,(%rax)
     a22:	mov    0x108(%rsp),%rax
     a2a:	movups %xmm1,(%rax)
     a2d:	mov    0x110(%rsp),%rax
     a35:	movups %xmm2,(%rax)
     a38:	mov    0x118(%rsp),%rax
     a40:	movups %xmm3,0x0(%r13)
     a45:	movaps 0x38(%rsp),%xmm0
     a4a:	movaps 0x48(%rsp),%xmm1
     a4f:	movaps 0x58(%rsp),%xmm2
     a54:	movaps 0x68(%rsp),%xmm3
     a59:	movups %xmm0,(%rax)
     a5c:	mov    0x120(%rsp),%rax
     a64:	movaps 0x78(%rsp),%xmm0
     a69:	movups %xmm1,(%rax)
     a6c:	mov    0x128(%rsp),%rax
     a74:	movaps 0x88(%rsp),%xmm1
     a7c:	movups %xmm2,(%rax)
     a7f:	mov    0x130(%rsp),%rax
     a87:	movaps 0x98(%rsp),%xmm2
     a8f:	movups %xmm3,(%r12)
     a94:	movaps 0xa8(%rsp),%xmm3
     a9c:	movups %xmm0,(%rax)
     a9f:	mov    0x138(%rsp),%rax
     aa7:	movaps 0xb8(%rsp),%xmm0
     aaf:	movups %xmm1,(%rax)
     ab2:	mov    0x140(%rsp),%rax
     aba:	movaps 0xc8(%rsp),%xmm1
     ac2:	movups %xmm2,(%rax)
     ac5:	mov    0x148(%rsp),%rax
     acd:	movups %xmm3,(%rax)
     ad0:	mov    0x150(%rsp),%rax
     ad8:	movups %xmm0,(%rax)
     adb:	mov    0x158(%rsp),%rax
     ae3:	movups %xmm1,(%rax)
     ae6:	mov    0x160(%rsp),%rax
     aee:	movups %xmm13,(%rax)
     af2:	mov    0x168(%rsp),%rax
     afa:	movups %xmm12,(%rax)
     afe:	mov    0x170(%rsp),%rax
     b06:	movups %xmm11,(%rax)
     b0a:	mov    0x178(%rsp),%rax
     b12:	movups %xmm10,(%rax)
     b16:	mov    0x180(%rsp),%rax
     b1e:	movups %xmm9,(%rax)
     b22:	mov    0x188(%rsp),%rax
     b2a:	movups %xmm8,(%rax)
     b2e:	mov    0x190(%rsp),%rax
     b36:	movups %xmm7,(%rax)
     b39:	mov    0x198(%rsp),%rax
     b41:	movups %xmm6,(%rax)
     b44:	mov    0x1a0(%rsp),%rax
     b4c:	movups %xmm5,(%rax)
     b4f:	add    $0x1b0,%rsp
     b56:	pop    %rbx
     b57:	pop    %rbp
     b58:	pop    %r12
     b5a:	pop    %r13
     b5c:	pop    %r14
     b5e:	pop    %r15
     b60:	ret
     b61:	nopl   0x0(%rax)
     b65:	data16 cs nopw 0x0(%rax,%rax,1)

0000000000000b70 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)>:
     b70:	endbr64
     b74:	push   %r15
     b76:	push   %r14
     b78:	push   %r13
     b7a:	push   %r12
     b7c:	push   %rbp
     b7d:	push   %rbx
     b7e:	sub    $0x158,%rsp
     b85:	mov    0x198(%rsp),%rax
     b8d:	mov    %rsi,0x10(%rsp)
     b92:	mov    0x1a0(%rsp),%rsi
     b9a:	mov    %rdx,0x18(%rsp)
     b9f:	test   %rax,%rax
     ba2:	mov    %rax,0x48(%rsp)
     ba7:	mov    0x190(%rsp),%r14
     baf:	sete   %al
     bb2:	test   %rsi,%rsi
     bb5:	mov    %rdi,0x38(%rsp)
     bba:	mov    0x1a8(%rsp),%ebx
     bc1:	sete   %dl
     bc4:	mov    %r9,0x8(%rsp)
     bc9:	or     %dl,%al
     bcb:	mov    %rsi,0x50(%rsp)
     bd0:	jne    bd6 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x66>
     bd6:	test   %r14,%r14
     bd9:	je     bdf <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6f>
     bdf:	mov    %rcx,%r12
     be2:	test   %rcx,%rcx
     be5:	je     11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
     beb:	mov    %r8,%r13
     bee:	test   %r8,%r8
     bf1:	je     11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
     bf7:	cmpq   $0x0,0x18(%rsp)
     bfd:	je     c03 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x93>
     c03:	cmpq   $0x0,0x8(%rsp)
     c09:	je     11fe <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x68e>
     c0f:	cmpq   $0x0,0x38(%rsp)
     c15:	sete   %al
     c18:	cmpq   $0x0,0x10(%rsp)
     c1e:	sete   %dl
     c21:	or     %dl,%al
     c23:	jne    c29 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb9>
     c29:	mov    %rcx,%rdx
     c2c:	mov    0x18(%rsp),%rsi
     c31:	imul   %r8,%rdx
     c35:	shl    $0x2,%rdx
     c39:	lea    (%rsi,%rdx,1),%rax
     c3d:	cmp    %rax,%rsi
     c40:	je     c4c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xdc>
     c42:	mov    %rsi,%rdi
     c45:	xor    %esi,%esi
     c47:	call   c4c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xdc>
     c4c:	cmp    $0x2,%ebx
     c4f:	je     1232 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6c2>
     c55:	jg     1e5d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12ed>
     c5b:	test   %ebx,%ebx
     c5d:	jne    1875 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd05>
     c63:	mov    0x8(%rsp),%rax
     c68:	mov    %r13,0x20(%rsp)
     c6d:	xor    %edi,%edi
     c6f:	lea    0x0(,%r13,4),%r13
     c77:	shl    $0x2,%rax
     c7b:	mov    %rax,0xd8(%rsp)
     c83:	mov    %r12,%rdx
     c86:	mov    %rdi,%rax
     c89:	sub    %rdi,%rdx
     c8c:	cmp    %r14,%rdx
     c8f:	cmova  %r14,%rdx
     c93:	add    %rdx,%rdi
     c96:	cmp    %rdi,%rax
     c99:	jae    1867 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xcf7>
     c9f:	movq   $0x0,0x28(%rsp)
     ca8:	mov    %r13,%r10
     cab:	mov    %r14,%rbx
     cae:	mov    %r12,%r13
     cb1:	mov    %rax,%r14
     cb4:	mov    %rdi,%r12
     cb7:	mov    0x28(%rsp),%rsi
     cbc:	mov    0x20(%rsp),%rax
     cc1:	mov    %r12,%rbp
     cc4:	mov    %r13,%r15
     cc7:	mov    0x48(%rsp),%rdi
     ccc:	mov    %r14,%r12
     ccf:	mov    %r10,%r13
     cd2:	movq   $0x0,0x30(%rsp)
     cdb:	sub    %rsi,%rax
     cde:	mov    %rsi,%rcx
     ce1:	cmp    %rdi,%rax
     ce4:	mov    %rcx,%r14
     ce7:	cmova  %rdi,%rax
     ceb:	add    %rax,%rsi
     cee:	mov    %rsi,0x28(%rsp)
     cf3:	mov    0x30(%rsp),%rsi
     cf8:	mov    0x8(%rsp),%rax
     cfd:	mov    %r12,%r11
     d00:	mov    0x50(%rsp),%rcx
     d05:	mov    0x20(%rsp),%rdx
     d0a:	sub    %rsi,%rax
     d0d:	mov    %rsi,0x80(%rsp)
     d15:	cmp    %rcx,%rax
     d18:	cmova  %rcx,%rax
     d1c:	imul   %rsi,%rdx
     d20:	mov    %rax,%rdi
     d23:	mov    %rax,0xb0(%rsp)
     d2b:	mov    %rsi,%rax
     d2e:	add    %rsi,%rdi
     d31:	imul   %r13,%rsi
     d35:	mov    %rdx,0x58(%rsp)
     d3a:	sub    %rdi,%rax
     d3d:	mov    %rdi,0x30(%rsp)
     d42:	lea    0x0(,%rax,4),%rax
     d4a:	mov    %rax,0xe8(%rsp)
     d52:	mov    %rsi,0xe0(%rsp)
     d5a:	mov    %rbp,%rax
     d5d:	xor    %r8d,%r8d
     d60:	sub    %r11,%rax
     d63:	cmp    $0x1,%rax
     d67:	je     d74 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x204>
     d69:	mov    $0x1,%r8d
     d6f:	mov    $0x2,%eax
     d74:	add    %r11,%rax
     d77:	mov    %rax,0x40(%rsp)
     d7c:	cmp    0x28(%rsp),%r14
     d81:	jae    181e <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xcae>
     d87:	mov    0x20(%rsp),%rax
     d8c:	mov    %r14,%r9
     d8f:	mov    %rbx,%r10
     d92:	mov    0x80(%rsp),%rsi
     d9a:	mov    %rbp,0x120(%rsp)
     da2:	mov    %r11,%rbp
     da5:	imul   %r11,%rax
     da9:	mov    %r12,0x128(%rsp)
     db1:	mov    %r14,%r12
     db4:	mov    0x18(%rsp),%r14
     db9:	mov    %r8b,0x130(%rsp)
     dc1:	mov    %r15,0x138(%rsp)
     dc9:	mov    %rax,0x70(%rsp)
     dce:	mov    0x8(%rsp),%rax
     dd3:	imul   %r11,%rax
     dd7:	lea    (%rax,%rsi,1),%rdx
     ddb:	mov    0x38(%rsp),%rsi
     de0:	add    0x30(%rsp),%rax
     de5:	lea    (%rsi,%rdx,4),%rdi
     de9:	lea    (%rsi,%rax,4),%rax
     ded:	mov    0x28(%rsp),%rsi
     df2:	mov    %rdi,0xc0(%rsp)
     dfa:	mov    %rax,0xd0(%rsp)
     e02:	jmp    e6d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2fd>
     e04:	cmpb   $0x0,0x130(%rsp)
     e0c:	je     e97 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x327>
     e12:	mov    0x70(%rsp),%rax
     e17:	mov    0x8(%rsp),%r8
     e1c:	mov    %r10,0x60(%rsp)
     e21:	mov    0x20(%rsp),%rcx
     e26:	mov    0xc0(%rsp),%rdi
     e2e:	add    %r9,%rax
     e31:	add    0x58(%rsp),%r9
     e36:	lea    (%r14,%rax,4),%rdx
     e3a:	mov    0x10(%rsp),%rax
     e3f:	lea    (%rax,%r9,4),%rsi
     e43:	mov    0xb0(%rsp),%r9
     e4b:	call   0 <void mini_gpu::(anonymous namespace)::microkernel<2ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
     e50:	mov    0x60(%rsp),%r10
     e55:	mov    0x28(%rsp),%rdx
     e5a:	cmp    %rdx,0x68(%rsp)
     e5f:	jae    1800 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc90>
     e65:	mov    0x68(%rsp),%r9
     e6a:	mov    %rdx,%rsi
     e6d:	sub    %r9,%rsi
     e70:	mov    $0x8,%eax
     e75:	cmp    %rax,%rsi
     e78:	mov    %rsi,0xb8(%rsp)
     e80:	cmovbe %rsi,%rax
     e84:	lea    (%rax,%r9,1),%rbx
     e88:	mov    %rbx,0x68(%rsp)
     e8d:	cmp    $0x7,%rsi
     e91:	ja     e04 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x294>
     e97:	cmp    0x40(%rsp),%rbp
     e9c:	jae    e55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2e5>
     e9e:	mov    0x30(%rsp),%rcx
     ea3:	cmp    %rcx,0x80(%rsp)
     eab:	jae    e55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2e5>
     ead:	mov    0x68(%rsp),%rbx
     eb2:	cmp    %rbx,%r9
     eb5:	jae    e55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2e5>
     eb7:	mov    0x70(%rsp),%rdx
     ebc:	mov    $0xfffffffffffffffc,%rcx
     ec3:	mov    %rbp,0x60(%rsp)
     ec8:	mov    %rax,0x88(%rsp)
     ed0:	mov    0xd0(%rsp),%r11
     ed8:	lea    (%rdx,%r9,1),%r15
     edc:	add    %rbx,%rdx
     edf:	lea    (%r14,%rdx,4),%rbx
     ee3:	lea    0x0(,%r15,4),%rsi
     eeb:	mov    %rbx,0x78(%rsp)
     ef0:	mov    0x58(%rsp),%rbx
     ef5:	lea    (%r14,%rsi,1),%r8
     ef9:	lea    (%rbx,%r9,1),%rdx
     efd:	mov    0x10(%rsp),%rbx
     f02:	lea    (%rbx,%rdx,4),%rdi
     f06:	mov    0xe0(%rsp),%rdx
     f0e:	mov    %rdi,0x100(%rsp)
     f16:	mov    %rax,%rdi
     f19:	add    %rbx,%rdx
     f1c:	shr    $0x2,%rdi
     f20:	lea    -0x1(%rax),%rbx
     f24:	lea    (%rdx,%r9,4),%rdx
     f28:	mov    %rbx,0xf0(%rsp)
     f30:	sub    %rdx,%rcx
     f33:	mov    %rdi,0x108(%rsp)
     f3b:	mov    %rax,%rdi
     f3e:	mov    %rcx,%rbx
     f41:	mov    %rax,%rcx
     f44:	and    $0x3,%edi
     f47:	and    $0xfffffffffffffffc,%rcx
     f4b:	mov    %rdi,0x118(%rsp)
     f53:	mov    %rcx,0x110(%rsp)
     f5b:	nopl   0x0(%rax,%rax,1)
     f60:	mov    %r15,%rax
     f63:	add    %r14,%rsi
     f66:	mov    %r12,%rcx
     f69:	mov    0x58(%rsp),%rdi
     f6e:	sub    %r9,%rax
     f71:	mov    %r10,0x90(%rsp)
     f79:	mov    %rbp,%r12
     f7c:	mov    %rcx,%rbp
     f7f:	mov    %rax,0xc8(%rsp)
     f87:	mov    0xe8(%rsp),%rax
     f8f:	mov    %rsi,0xf8(%rsp)
     f97:	mov    0x100(%rsp),%rsi
     f9f:	lea    (%r11,%rax,1),%rdx
     fa3:	lea    (%rbx,%r8,1),%rax
     fa7:	movss  (%rdx),%xmm0
     fab:	cmpq   $0x1,0xb8(%rsp)
     fb4:	je     1102 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x592>
     fba:	mov    %r12,0x98(%rsp)
     fc2:	mov    %rbp,0xa0(%rsp)
     fca:	mov    %rbx,0xa8(%rsp)
     fd2:	cmp    $0x8,%rax
     fd6:	jbe    10ea <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x57a>
     fdc:	cmpq   $0x2,0xf0(%rsp)
     fe5:	jbe    1788 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc18>
     feb:	mov    $0x10,%ecx
     ff0:	mov    $0x20,%r10d
     ff6:	movaps %xmm0,%xmm1
     ff9:	cmpq   $0x1,0x108(%rsp)
    1002:	cmove  %rcx,%r10
    1006:	xor    %ecx,%ecx
    1008:	shufps $0x0,%xmm1,%xmm1
    100c:	nopw   0x0(%rax,%rax,1)
    1015:	data16 cs nopw 0x0(%rax,%rax,1)
    1020:	movups (%rsi,%rcx,1),%xmm2
    1024:	movups (%r8,%rcx,1),%xmm3
    1029:	mulps  %xmm1,%xmm2
    102c:	addps  %xmm3,%xmm2
    102f:	movups %xmm2,(%r8,%rcx,1)
    1034:	add    $0x10,%rcx
    1038:	cmp    %rcx,%r10
    103b:	jne    1020 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x4b0>
    103d:	testb  $0x3,0x88(%rsp)
    1045:	je     10c4 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x554>
    1047:	mov    0x110(%rsp),%rbx
    104f:	mov    0x118(%rsp),%r10
    1057:	mov    %rbx,%rbp
    105a:	lea    (%r9,%rbx,1),%rcx
    105e:	mov    %r10,%rbx
    1061:	cmp    $0x1,%r10
    1065:	je     109f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x52f>
    1067:	lea    (%r15,%rbp,1),%r10
    106b:	lea    (%r14,%r10,4),%r12
    106f:	lea    (%rdi,%r9,1),%r10
    1073:	add    %rbp,%r10
    1076:	mov    0x10(%rsp),%rbp
    107b:	movq   0x0(%rbp,%r10,4),%xmm2
    1082:	mulps  %xmm2,%xmm1
    1085:	movq   (%r12),%xmm2
    108b:	addps  %xmm2,%xmm1
    108e:	movlps %xmm1,(%r12)
    1093:	test   $0x1,%bl
    1096:	je     10c4 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x554>
    1098:	and    $0xfffffffffffffffe,%rbx
    109c:	add    %rbx,%rcx
    109f:	mov    0xc8(%rsp),%rbx
    10a7:	lea    (%rbx,%rcx,1),%r10
    10ab:	mov    0x10(%rsp),%rbx
    10b0:	add    %rdi,%rcx
    10b3:	mulss  (%rbx,%rcx,4),%xmm0
    10b8:	addss  (%r14,%r10,4),%xmm0
    10be:	movss  %xmm0,(%r14,%r10,4)
    10c4:	add    $0x4,%rdx
    10c8:	cmp    %rdx,%r11
    10cb:	je     17a8 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc38>
    10d1:	sub    %r13,%rax
    10d4:	movss  (%rdx),%xmm0
    10d8:	add    %r13,%rsi
    10db:	add    0x20(%rsp),%rdi
    10e0:	cmp    $0x8,%rax
    10e4:	ja     fdc <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x46c>
    10ea:	mov    0x98(%rsp),%r12
    10f2:	mov    0xa0(%rsp),%rbp
    10fa:	mov    0xa8(%rsp),%rbx
    1102:	mov    0xf8(%rsp),%rcx
    110a:	mov    %rsi,%r10
    110d:	nopl   0x0(%rax)
    1114:	data16 cs nopw 0x0(%rax,%rax,1)
    111f:	data16 cs nopw 0x0(%rax,%rax,1)
    112a:	data16 cs nopw 0x0(%rax,%rax,1)
    1135:	data16 cs nopw 0x0(%rax,%rax,1)
    1140:	movss  (%r10),%xmm1
    1145:	add    $0x4,%rcx
    1149:	add    $0x4,%r10
    114d:	mulss  %xmm0,%xmm1
    1151:	addss  -0x4(%rcx),%xmm1
    1156:	movss  %xmm1,-0x4(%rcx)
    115b:	cmp    %rcx,0x78(%rsp)
    1160:	jne    1140 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x5d0>
    1162:	add    $0x4,%rdx
    1166:	add    %r13,%rsi
    1169:	add    0x20(%rsp),%rdi
    116e:	sub    %r13,%rax
    1171:	cmp    %rdx,%r11
    1174:	jne    fa7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x437>
    117a:	mov    %rbp,%rax
    117d:	mov    0x90(%rsp),%r10
    1185:	mov    %r12,%rbp
    1188:	mov    %rax,%r12
    118b:	jmp    17c8 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc58>
    1190:	mov    %r15,%r13
    1193:	mov    0x138(%rsp),%rbx
    119b:	mov    0x140(%rsp),%r14
    11a3:	mov    0x148(%rsp),%r15
    11ab:	cmp    %r14,0x28(%rsp)
    11b0:	jb     132f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x7bf>
    11b6:	mov    %r13,%rdx
    11b9:	mov    0x68(%rsp),%r9
    11be:	mov    %r12,%r13
    11c1:	mov    0x20(%rsp),%r11
    11c6:	mov    0x130(%rsp),%r12
    11ce:	cmp    0x8(%rsp),%r9
    11d3:	jb     12b2 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x742>
    11d9:	mov    %rdx,%rbp
    11dc:	cmp    %r11,0x30(%rsp)
    11e1:	jb     1279 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x709>
    11e7:	cmp    %r12,%r14
    11ea:	jb     1254 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6e4>
    11ec:	add    $0x158,%rsp
    11f3:	pop    %rbx
    11f4:	pop    %rbp
    11f5:	pop    %r12
    11f7:	pop    %r13
    11f9:	pop    %r14
    11fb:	pop    %r15
    11fd:	ret
    11fe:	mov    %rcx,%rdx
    1201:	mov    0x18(%rsp),%rbx
    1206:	imul   %r8,%rdx
    120a:	shl    $0x2,%rdx
    120e:	lea    (%rbx,%rdx,1),%rax
    1212:	cmp    %rax,%rbx
    1215:	je     11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
    1217:	add    $0x158,%rsp
    121e:	mov    %rbx,%rdi
    1221:	xor    %esi,%esi
    1223:	pop    %rbx
    1224:	pop    %rbp
    1225:	pop    %r12
    1227:	pop    %r13
    1229:	pop    %r14
    122b:	pop    %r15
    122d:	jmp    1232 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6c2>
    1232:	mov    0x8(%rsp),%rax
    1237:	mov    %r14,%rbp
    123a:	mov    %r13,%r11
    123d:	xor    %r14d,%r14d
    1240:	lea    0x0(,%r13,4),%r13
    1248:	shl    $0x2,%rax
    124c:	mov    %rax,0xf0(%rsp)
    1254:	mov    %r12,%rax
    1257:	mov    %r14,%r15
    125a:	sub    %r14,%rax
    125d:	cmp    %rbp,%rax
    1260:	cmova  %rbp,%rax
    1264:	add    %rax,%r14
    1267:	cmp    %r14,%r15
    126a:	jae    11e7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x677>
    1270:	movq   $0x0,0x30(%rsp)
    1279:	mov    0x30(%rsp),%rbx
    127e:	mov    0x48(%rsp),%rsi
    1283:	mov    %r11,%rax
    1286:	sub    %rbx,%rax
    1289:	mov    %rbx,%rcx
    128c:	cmp    %rsi,%rax
    128f:	cmova  %rsi,%rax
    1293:	add    %rax,%rbx
    1296:	mov    %rbx,0x30(%rsp)
    129b:	cmp    %rbx,%rcx
    129e:	jae    11dc <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x66c>
    12a4:	mov    %rbp,%rdx
    12a7:	mov    0x38(%rsp),%rbp
    12ac:	xor    %r9d,%r9d
    12af:	mov    %rcx,%rbx
    12b2:	mov    0x8(%rsp),%rax
    12b7:	mov    0x50(%rsp),%rdi
    12bc:	mov    %r9,0x70(%rsp)
    12c1:	mov    0x10(%rsp),%rsi
    12c6:	mov    %r15,0x28(%rsp)
    12cb:	sub    %r9,%rax
    12ce:	mov    %r11,0x20(%rsp)
    12d3:	cmp    %rdi,%rax
    12d6:	mov    %r12,0x130(%rsp)
    12de:	mov    %r13,%r12
    12e1:	cmova  %rdi,%rax
    12e5:	mov    %r9,%rdi
    12e8:	mov    %rax,0xb8(%rsp)
    12f0:	add    %rax,%r9
    12f3:	mov    %rdi,%rax
    12f6:	imul   %r11,%rdi
    12fa:	mov    %r9,0x68(%rsp)
    12ff:	mov    %rdi,0x40(%rsp)
    1304:	mov    %rax,%rdi
    1307:	sub    %r9,%rax
    130a:	lea    0x0(,%rax,4),%rax
    1312:	mov    %rax,0x100(%rsp)
    131a:	mov    %rdi,%rax
    131d:	imul   %r13,%rax
    1321:	mov    %rdx,%r13
    1324:	add    %rsi,%rax
    1327:	mov    %rax,0x128(%rsp)
    132f:	mov    0x28(%rsp),%rcx
    1334:	mov    %r14,%rdx
    1337:	mov    $0x4,%eax
    133c:	mov    %rbx,%r10
    133f:	mov    %r14,0x140(%rsp)
    1347:	mov    0x18(%rsp),%r14
    134c:	sub    %rcx,%rdx
    134f:	mov    %rcx,%rdi
    1352:	mov    %rcx,0xe0(%rsp)
    135a:	cmp    %rax,%rdx
    135d:	mov    %r15,0x148(%rsp)
    1365:	mov    %r13,%r15
    1368:	mov    0x30(%rsp),%r13
    136d:	cmovbe %rdx,%rax
    1371:	mov    %rbx,0x138(%rsp)
    1379:	add    %rax,%rcx
    137c:	mov    0x20(%rsp),%rax
    1381:	cmp    $0x3,%rdx
    1385:	mov    0x70(%rsp),%rdx
    138a:	seta   0xc0(%rsp)
    1392:	imul   %rdi,%rax
    1396:	mov    %rcx,0x28(%rsp)
    139b:	mov    %rax,0x78(%rsp)
    13a0:	mov    0x8(%rsp),%rax
    13a5:	imul   %rdi,%rax
    13a9:	add    %rax,%rdx
    13ac:	add    0x68(%rsp),%rax
    13b1:	lea    0x0(%rbp,%rdx,4),%rdx
    13b6:	lea    0x0(%rbp,%rax,4),%rax
    13bb:	mov    %rdx,0xc8(%rsp)
    13c3:	mov    %rax,0xf8(%rsp)
    13cb:	jmp    1428 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8b8>
    13cd:	cmpb   $0x0,0xc0(%rsp)
    13d5:	je     1446 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8d6>
    13d7:	mov    0x78(%rsp),%rax
    13dc:	mov    0xb8(%rsp),%r9
    13e4:	mov    0x8(%rsp),%r8
    13e9:	mov    0x20(%rsp),%rcx
    13ee:	add    %r10,%rax
    13f1:	mov    0xc8(%rsp),%rdi
    13f9:	add    0x40(%rsp),%r10
    13fe:	lea    (%r14,%rax,4),%rdx
    1402:	mov    0x10(%rsp),%rax
    1407:	lea    (%rax,%r10,4),%rsi
    140b:	call   1c0 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    1410:	mov    0x30(%rsp),%rdi
    1415:	cmp    %rdi,0x60(%rsp)
    141a:	jae    1190 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x620>
    1420:	mov    0x60(%rsp),%r10
    1425:	mov    %rdi,%r13
    1428:	sub    %r10,%r13
    142b:	mov    $0x10,%eax
    1430:	cmp    %rax,%r13
    1433:	cmovbe %r13,%rax
    1437:	lea    (%rax,%r10,1),%rbx
    143b:	mov    %rbx,0x60(%rsp)
    1440:	cmp    $0xf,%r13
    1444:	ja     13cd <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x85d>
    1446:	mov    0xe0(%rsp),%rcx
    144e:	cmp    0x28(%rsp),%rcx
    1453:	jae    1410 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8a0>
    1455:	mov    0x68(%rsp),%rdx
    145a:	cmp    %rdx,0x70(%rsp)
    145f:	jae    1410 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8a0>
    1461:	mov    0x60(%rsp),%rdx
    1466:	cmp    %rdx,%r10
    1469:	jae    1410 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8a0>
    146b:	mov    0x78(%rsp),%rbx
    1470:	mov    %rcx,0x58(%rsp)
    1475:	mov    %rax,%rcx
    1478:	and    $0xfffffffffffffffc,%rcx
    147c:	add    %rbx,%rdx
    147f:	lea    (%rbx,%r10,1),%rdi
    1483:	mov    %rcx,0x110(%rsp)
    148b:	lea    (%r14,%rdx,4),%rbx
    148f:	mov    0x40(%rsp),%rdx
    1494:	lea    0x0(,%rdi,4),%rsi
    149c:	mov    %rbx,0x88(%rsp)
    14a4:	mov    0x10(%rsp),%rbx
    14a9:	lea    (%r14,%rsi,1),%r11
    14ad:	add    %r10,%rdx
    14b0:	lea    (%rbx,%rdx,4),%rdx
    14b4:	mov    0x128(%rsp),%rbx
    14bc:	mov    %rdx,0xe8(%rsp)
    14c4:	lea    (%rbx,%r10,4),%rdx
    14c8:	lea    -0x1(%rax),%rbx
    14cc:	mov    %rdx,0xa8(%rsp)
    14d4:	mov    %rax,%rdx
    14d7:	shr    $0x2,%rdx
    14db:	mov    %rbx,0xd8(%rsp)
    14e3:	mov    0xf8(%rsp),%rbx
    14eb:	shl    $0x4,%rdx
    14ef:	mov    %rdx,0x108(%rsp)
    14f7:	lea    (%rcx,%r10,1),%rdx
    14fb:	mov    %rdx,0x118(%rsp)
    1503:	mov    %rax,%rdx
    1506:	sub    %rcx,%rdx
    1509:	mov    %rdx,0x120(%rsp)
    1511:	nopl   0x0(%rax)
    1515:	data16 cs nopw 0x0(%rax,%rax,1)
    1520:	mov    %rdi,%rcx
    1523:	add    %r14,%rsi
    1526:	mov    %r15,0x90(%rsp)
    152e:	mov    0x40(%rsp),%r9
    1533:	sub    %r10,%rcx
    1536:	mov    %rsi,0xb0(%rsp)
    153e:	mov    0xe8(%rsp),%r8
    1546:	mov    %rcx,0xd0(%rsp)
    154e:	mov    0x100(%rsp),%rcx
    1556:	lea    (%rbx,%rcx,1),%rdx
    155a:	mov    $0xfffffffffffffffc,%rcx
    1561:	sub    0xa8(%rsp),%rcx
    1569:	add    %r11,%rcx
    156c:	movss  (%rdx),%xmm0
    1570:	cmp    $0x1,%r13
    1574:	je     16ab <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb3b>
    157a:	mov    %r13,0x98(%rsp)
    1582:	mov    %rbp,0xa0(%rsp)
    158a:	cmp    $0x8,%rcx
    158e:	jbe    169b <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb2b>
    1594:	cmpq   $0x2,0xd8(%rsp)
    159d:	jbe    1710 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xba0>
    15a3:	movaps %xmm0,%xmm1
    15a6:	xor    %esi,%esi
    15a8:	shufps $0x0,%xmm1,%xmm1
    15ac:	nopw   0x0(%rax,%rax,1)
    15b5:	data16 cs nopw 0x0(%rax,%rax,1)
    15c0:	movups (%r8,%rsi,1),%xmm2
    15c5:	movups (%r11,%rsi,1),%xmm5
    15ca:	mulps  %xmm1,%xmm2
    15cd:	addps  %xmm5,%xmm2
    15d0:	movups %xmm2,(%r11,%rsi,1)
    15d5:	add    $0x10,%rsi
    15d9:	cmp    0x108(%rsp),%rsi
    15e1:	jne    15c0 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xa50>
    15e3:	test   $0x3,%al
    15e5:	je     1675 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb05>
    15eb:	mov    0x118(%rsp),%rsi
    15f3:	mov    0x120(%rsp),%rbp
    15fb:	mov    0x110(%rsp),%r15
    1603:	mov    %rbp,0x80(%rsp)
    160b:	mov    %rsi,%r13
    160e:	cmp    $0x1,%rbp
    1612:	je     164f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xadf>
    1614:	mov    0x10(%rsp),%rbp
    1619:	add    %r9,%r13
    161c:	add    %rdi,%r15
    161f:	movq   0x0(%rbp,%r13,4),%xmm2
    1626:	mulps  %xmm2,%xmm1
    1629:	movq   (%r14,%r15,4),%xmm2
    162f:	addps  %xmm2,%xmm1
    1632:	movlps %xmm1,(%r14,%r15,4)
    1637:	mov    0x80(%rsp),%r15
    163f:	test   $0x1,%r15b
    1643:	je     1675 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb05>
    1645:	mov    %r15,%rbp
    1648:	and    $0xfffffffffffffffe,%rbp
    164c:	add    %rbp,%rsi
    164f:	mov    0xd0(%rsp),%r15
    1657:	lea    (%r15,%rsi,1),%r13
    165b:	mov    0x10(%rsp),%r15
    1660:	add    %r9,%rsi
    1663:	mulss  (%r15,%rsi,4),%xmm0
    1669:	addss  (%r14,%r13,4),%xmm0
    166f:	movss  %xmm0,(%r14,%r13,4)
    1675:	add    $0x4,%rdx
    1679:	cmp    %rbx,%rdx
    167c:	je     1730 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xbc0>
    1682:	sub    %r12,%rcx
    1685:	movss  (%rdx),%xmm0
    1689:	add    %r12,%r8
    168c:	add    0x20(%rsp),%r9
    1691:	cmp    $0x8,%rcx
    1695:	ja     1594 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xa24>
    169b:	mov    0x98(%rsp),%r13
    16a3:	mov    0xa0(%rsp),%rbp
    16ab:	mov    %rax,0x80(%rsp)
    16b3:	mov    0xb0(%rsp),%r15
    16bb:	mov    %r8,%rsi
    16be:	xchg   %ax,%ax
    16c0:	movss  (%rsi),%xmm1
    16c4:	add    $0x4,%r15
    16c8:	add    $0x4,%rsi
    16cc:	mulss  %xmm0,%xmm1
    16d0:	addss  -0x4(%r15),%xmm1
    16d6:	movss  %xmm1,-0x4(%r15)
    16dc:	cmp    0x88(%rsp),%r15
    16e4:	jne    16c0 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb50>
    16e6:	add    $0x4,%rdx
    16ea:	add    %r12,%r8
    16ed:	add    0x20(%rsp),%r9
    16f2:	sub    %r12,%rcx
    16f5:	mov    0x80(%rsp),%rax
    16fd:	cmp    %rbx,%rdx
    1700:	jne    156c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x9fc>
    1706:	mov    0x90(%rsp),%r15
    170e:	jmp    1748 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xbd8>
    1710:	movaps %xmm0,%xmm1
    1713:	mov    %r10,%rsi
    1716:	xor    %r15d,%r15d
    1719:	mov    %r10,%r13
    171c:	mov    %rax,0x80(%rsp)
    1724:	shufps $0x0,%xmm1,%xmm1
    1728:	jmp    1614 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xaa4>
    172d:	nopl   (%rax)
    1730:	mov    0x98(%rsp),%r13
    1738:	mov    0x90(%rsp),%r15
    1740:	mov    0xa0(%rsp),%rbp
    1748:	addq   $0x1,0x58(%rsp)
    174e:	add    0xf0(%rsp),%rbx
    1756:	add    %r12,%r11
    1759:	add    %r12,0x88(%rsp)
    1761:	mov    0x58(%rsp),%rsi
    1766:	add    0x20(%rsp),%rdi
    176b:	cmp    0x28(%rsp),%rsi
    1770:	je     1410 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8a0>
    1776:	lea    0x0(,%rdi,4),%rsi
    177e:	jmp    1520 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x9b0>
    1783:	nopl   0x0(%rax,%rax,1)
    1788:	movaps %xmm0,%xmm1
    178b:	mov    0x88(%rsp),%rbx
    1793:	mov    %r9,%rcx
    1796:	xor    %ebp,%ebp
    1798:	shufps $0x0,%xmm1,%xmm1
    179c:	jmp    1067 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x4f7>
    17a1:	nopl   0x0(%rax)
    17a8:	mov    0x98(%rsp),%rbp
    17b0:	mov    0xa0(%rsp),%r12
    17b8:	mov    0x90(%rsp),%r10
    17c0:	mov    0xa8(%rsp),%rbx
    17c8:	addq   $0x1,0x60(%rsp)
    17ce:	add    0xd8(%rsp),%r11
    17d6:	add    %r13,%r8
    17d9:	add    %r13,0x78(%rsp)
    17de:	mov    0x60(%rsp),%rax
    17e3:	add    0x20(%rsp),%r15
    17e8:	cmp    0x40(%rsp),%rax
    17ed:	je     e55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2e5>
    17f3:	lea    0x0(,%r15,4),%rsi
    17fb:	jmp    f60 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x3f0>
    1800:	mov    %r12,%r14
    1803:	mov    0x120(%rsp),%rbp
    180b:	mov    0x128(%rsp),%r12
    1813:	mov    %r10,%rbx
    1816:	mov    0x138(%rsp),%r15
    181e:	cmp    %rbp,0x40(%rsp)
    1823:	jae    182f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xcbf>
    1825:	mov    0x40(%rsp),%r11
    182a:	jmp    d5a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1ea>
    182f:	mov    0x8(%rsp),%rcx
    1834:	cmp    %rcx,0x30(%rsp)
    1839:	jb     cf3 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x183>
    183f:	mov    %r13,%r10
    1842:	mov    %r12,%r14
    1845:	mov    0x20(%rsp),%rdi
    184a:	mov    %rbp,%r12
    184d:	mov    %r15,%r13
    1850:	cmp    %rdi,0x28(%rsp)
    1855:	jb     cb7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x147>
    185b:	mov    %rbp,%rdi
    185e:	mov    %rbx,%r14
    1861:	mov    %r15,%r12
    1864:	mov    %r10,%r13
    1867:	cmp    %r12,%rdi
    186a:	jb     c83 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x113>
    1870:	jmp    11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
    1875:	cmp    $0x1,%ebx
    1878:	jne    2478 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1908>
    187e:	mov    0x8(%rsp),%rax
    1883:	lea    0x0(,%r13,4),%r10
    188b:	xor    %r15d,%r15d
    188e:	shl    $0x2,%rax
    1892:	mov    %rax,0xd0(%rsp)
    189a:	mov    %r12,%rax
    189d:	mov    %r15,%rdx
    18a0:	sub    %r15,%rax
    18a3:	cmp    %r14,%rax
    18a6:	cmova  %r14,%rax
    18aa:	add    %rax,%r15
    18ad:	cmp    %r15,%rdx
    18b0:	jae    1e4f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12df>
    18b6:	movq   $0x0,0x20(%rsp)
    18bf:	mov    %rdx,%rbp
    18c2:	mov    0x20(%rsp),%rbx
    18c7:	mov    0x48(%rsp),%rdx
    18cc:	mov    %r13,%rax
    18cf:	sub    %rbx,%rax
    18d2:	mov    %rbx,%rcx
    18d5:	cmp    %rdx,%rax
    18d8:	cmova  %rdx,%rax
    18dc:	add    %rax,%rbx
    18df:	mov    %rbx,0x20(%rsp)
    18e4:	cmp    %rbx,%rcx
    18e7:	jae    1e44 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12d4>
    18ed:	movq   $0x0,0x28(%rsp)
    18f6:	mov    %rcx,%rbx
    18f9:	mov    %r12,0x108(%rsp)
    1901:	mov    %r14,%r12
    1904:	mov    %r13,%r14
    1907:	mov    %r10,%r13
    190a:	mov    0x28(%rsp),%rcx
    190f:	mov    0x8(%rsp),%rax
    1914:	mov    %rbp,0x30(%rsp)
    1919:	mov    0x50(%rsp),%rsi
    191e:	mov    %rbp,0x118(%rsp)
    1926:	mov    %r14,%rbp
    1929:	sub    %rcx,%rax
    192c:	mov    %rcx,0x78(%rsp)
    1931:	cmp    %rsi,%rax
    1934:	cmova  %rsi,%rax
    1938:	mov    %rax,%r9
    193b:	mov    %rcx,%rax
    193e:	lea    (%rcx,%r9,1),%rdi
    1942:	mov    %r9,0x110(%rsp)
    194a:	imul   %r14,%rcx
    194e:	mov    %rdi,0x28(%rsp)
    1953:	mov    %r13,%r14
    1956:	mov    %rcx,0x58(%rsp)
    195b:	mov    %rax,%rcx
    195e:	sub    %rdi,%rax
    1961:	imul   %r13,%rcx
    1965:	lea    0x0(,%rax,4),%rax
    196d:	mov    %rax,0xd8(%rsp)
    1975:	mov    %rcx,0xe8(%rsp)
    197d:	mov    0x30(%rsp),%rcx
    1982:	mov    %r15,%rdx
    1985:	mov    $0x4,%eax
    198a:	mov    %rbx,%r9
    198d:	mov    %r15,0x120(%rsp)
    1995:	sub    %rcx,%rdx
    1998:	mov    %rcx,%r11
    199b:	mov    %rbx,0x130(%rsp)
    19a3:	cmp    %rax,%rdx
    19a6:	mov    %r11,0x128(%rsp)
    19ae:	cmovbe %rdx,%rax
    19b2:	mov    %r12,0x138(%rsp)
    19ba:	add    %rax,%rcx
    19bd:	cmp    $0x3,%rdx
    19c1:	mov    %rbp,%rax
    19c4:	mov    0x78(%rsp),%rdx
    19c9:	seta   0xa0(%rsp)
    19d1:	imul   %r11,%rax
    19d5:	mov    %rcx,0x30(%rsp)
    19da:	mov    0x38(%rsp),%rcx
    19df:	mov    %rax,0x68(%rsp)
    19e4:	mov    0x8(%rsp),%rax
    19e9:	imul   %r11,%rax
    19ed:	add    %rax,%rdx
    19f0:	add    0x28(%rsp),%rax
    19f5:	lea    (%rcx,%rdx,4),%rsi
    19f9:	lea    (%rcx,%rax,4),%rax
    19fd:	mov    %rsi,0xa8(%rsp)
    1a05:	mov    %rax,0xc8(%rsp)
    1a0d:	jmp    1a63 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xef3>
    1a0f:	cmpb   $0x0,0xa0(%rsp)
    1a17:	je     1a89 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf19>
    1a19:	mov    0x68(%rsp),%rax
    1a1e:	mov    0x18(%rsp),%rsi
    1a23:	mov    %rbp,%rcx
    1a26:	mov    0x8(%rsp),%r8
    1a2b:	mov    0xa8(%rsp),%rdi
    1a33:	add    %r9,%rax
    1a36:	add    0x58(%rsp),%r9
    1a3b:	lea    (%rsi,%rax,4),%rdx
    1a3f:	mov    0x10(%rsp),%rax
    1a44:	lea    (%rax,%r9,4),%rsi
    1a48:	mov    0x110(%rsp),%r9
    1a50:	call   90 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    1a55:	cmp    0x20(%rsp),%r12
    1a5a:	jae    1df2 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1282>
    1a60:	mov    %r12,%r9
    1a63:	mov    0x20(%rsp),%rdi
    1a68:	mov    $0x8,%eax
    1a6d:	sub    %r9,%rdi
    1a70:	cmp    %rax,%rdi
    1a73:	mov    %rdi,0x98(%rsp)
    1a7b:	cmovbe %rdi,%rax
    1a7f:	lea    (%rax,%r9,1),%r12
    1a83:	cmp    $0x7,%rdi
    1a87:	ja     1a0f <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xe9f>
    1a89:	mov    0x128(%rsp),%rdi
    1a91:	cmp    0x30(%rsp),%rdi
    1a96:	jae    1a55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xee5>
    1a98:	mov    0x28(%rsp),%rcx
    1a9d:	cmp    %rcx,0x78(%rsp)
    1aa2:	jae    1a55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xee5>
    1aa4:	cmp    %r12,%r9
    1aa7:	jae    1a55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xee5>
    1aa9:	mov    0x68(%rsp),%rbx
    1aae:	mov    0x18(%rsp),%rcx
    1ab3:	mov    %rdi,%r8
    1ab6:	mov    %rax,%rdi
    1ab9:	shr    $0x2,%rdi
    1abd:	mov    0xc8(%rsp),%r10
    1ac5:	lea    (%rbx,%r9,1),%r13
    1ac9:	lea    (%rbx,%r12,1),%rdx
    1acd:	mov    0x10(%rsp),%rbx
    1ad2:	mov    %rdi,0xf8(%rsp)
    1ada:	lea    0x0(,%r13,4),%rsi
    1ae2:	lea    (%rcx,%rdx,4),%rdx
    1ae6:	mov    %rax,%rdi
    1ae9:	lea    (%rcx,%rsi,1),%r15
    1aed:	mov    0x58(%rsp),%rcx
    1af2:	mov    %rdx,0x60(%rsp)
    1af7:	and    $0xfffffffffffffffc,%rdi
    1afb:	mov    %rdi,0x80(%rsp)
    1b03:	add    %r9,%rdi
    1b06:	lea    (%rcx,%r9,1),%rdx
    1b0a:	mov    0xe8(%rsp),%rcx
    1b12:	mov    %rdi,0x100(%rsp)
    1b1a:	lea    (%rbx,%rdx,4),%rdx
    1b1e:	mov    %rdx,0xe0(%rsp)
    1b26:	lea    (%rbx,%rcx,1),%rdx
    1b2a:	lea    -0x1(%rax),%rbx
    1b2e:	mov    $0xfffffffffffffffc,%rcx
    1b35:	lea    (%rdx,%r9,4),%rdx
    1b39:	mov    %rbx,0xc0(%rsp)
    1b41:	mov    %r8,%rbx
    1b44:	sub    %rdx,%rcx
    1b47:	mov    %rcx,%r11
    1b4a:	nopw   0x0(%rax,%rax,1)
    1b50:	mov    0xd8(%rsp),%rdi
    1b58:	mov    %r13,%rdx
    1b5b:	mov    %r12,%rcx
    1b5e:	mov    %rbx,%r12
    1b61:	sub    %r9,%rdx
    1b64:	mov    %rcx,%rbx
    1b67:	mov    %rdx,0xb0(%rsp)
    1b6f:	lea    (%r10,%rdi,1),%rdx
    1b73:	lea    (%r11,%r15,1),%rdi
    1b77:	mov    %rdi,0x40(%rsp)
    1b7c:	mov    0x18(%rsp),%rdi
    1b81:	add    %rdi,%rsi
    1b84:	mov    0x58(%rsp),%rdi
    1b89:	mov    %rsi,0xb8(%rsp)
    1b91:	mov    0xe0(%rsp),%rsi
    1b99:	movss  (%rdx),%xmm0
    1b9d:	cmpq   $0x1,0x98(%rsp)
    1ba6:	je     1d0d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x119d>
    1bac:	mov    %rax,%rcx
    1baf:	sub    0x80(%rsp),%rcx
    1bb7:	mov    %r12,0x88(%rsp)
    1bbf:	mov    %rcx,0xf0(%rsp)
    1bc7:	mov    %r11,0x90(%rsp)
    1bcf:	cmpq   $0x8,0x40(%rsp)
    1bd5:	jbe    1cfd <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x118d>
    1bdb:	cmpq   $0x2,0xc0(%rsp)
    1be4:	jbe    1d90 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1220>
    1bea:	mov    $0x10,%ecx
    1bef:	mov    $0x20,%r8d
    1bf5:	movaps %xmm0,%xmm1
    1bf8:	cmpq   $0x1,0xf8(%rsp)
    1c01:	cmove  %rcx,%r8
    1c05:	xor    %ecx,%ecx
    1c07:	shufps $0x0,%xmm1,%xmm1
    1c0b:	cs nopw 0x0(%rax,%rax,1)
    1c15:	data16 cs nopw 0x0(%rax,%rax,1)
    1c20:	movups (%rsi,%rcx,1),%xmm2
    1c24:	movups (%r15,%rcx,1),%xmm4
    1c29:	mulps  %xmm1,%xmm2
    1c2c:	addps  %xmm4,%xmm2
    1c2f:	movups %xmm2,(%r15,%rcx,1)
    1c34:	add    $0x10,%rcx
    1c38:	cmp    %r8,%rcx
    1c3b:	jne    1c20 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x10b0>
    1c3d:	test   $0x3,%al
    1c3f:	je     1cd5 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1165>
    1c45:	mov    0x100(%rsp),%rcx
    1c4d:	mov    0xf0(%rsp),%r11
    1c55:	mov    0x80(%rsp),%r12
    1c5d:	mov    %r11,0x70(%rsp)
    1c62:	mov    %rcx,%r8
    1c65:	cmp    $0x1,%r11
    1c69:	je     1ca8 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1138>
    1c6b:	mov    0x18(%rsp),%r11
    1c70:	add    %r13,%r12
    1c73:	add    %rdi,%r8
    1c76:	lea    (%r11,%r12,4),%r12
    1c7a:	mov    0x10(%rsp),%r11
    1c7f:	movq   (%r11,%r8,4),%xmm2
    1c85:	mov    0x70(%rsp),%r11
    1c8a:	mulps  %xmm2,%xmm1
    1c8d:	movq   (%r12),%xmm2
    1c93:	addps  %xmm2,%xmm1
    1c96:	movlps %xmm1,(%r12)
    1c9b:	test   $0x1,%r11b
    1c9f:	je     1cd5 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1165>
    1ca1:	and    $0xfffffffffffffffe,%r11
    1ca5:	add    %r11,%rcx
    1ca8:	mov    0xb0(%rsp),%r11
    1cb0:	lea    (%r11,%rcx,1),%r8
    1cb4:	mov    0x18(%rsp),%r11
    1cb9:	add    %rdi,%rcx
    1cbc:	lea    (%r11,%r8,4),%r8
    1cc0:	mov    0x10(%rsp),%r11
    1cc5:	mulss  (%r11,%rcx,4),%xmm0
    1ccb:	addss  (%r8),%xmm0
    1cd0:	movss  %xmm0,(%r8)
    1cd5:	add    $0x4,%rdx
    1cd9:	cmp    %rdx,%r10
    1cdc:	je     1db0 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1240>
    1ce2:	sub    %r14,0x40(%rsp)
    1ce7:	movss  (%rdx),%xmm0
    1ceb:	add    %r14,%rsi
    1cee:	add    %rbp,%rdi
    1cf1:	cmpq   $0x8,0x40(%rsp)
    1cf7:	ja     1bdb <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x106b>
    1cfd:	mov    0x88(%rsp),%r12
    1d05:	mov    0x90(%rsp),%r11
    1d0d:	mov    0xb8(%rsp),%r8
    1d15:	mov    %rsi,%rcx
    1d18:	nopl   0x0(%rax)
    1d1f:	data16 cs nopw 0x0(%rax,%rax,1)
    1d2a:	data16 cs nopw 0x0(%rax,%rax,1)
    1d35:	data16 cs nopw 0x0(%rax,%rax,1)
    1d40:	movss  (%rcx),%xmm1
    1d44:	add    $0x4,%r8
    1d48:	add    $0x4,%rcx
    1d4c:	mulss  %xmm0,%xmm1
    1d50:	addss  -0x4(%r8),%xmm1
    1d56:	movss  %xmm1,-0x4(%r8)
    1d5c:	cmp    %r8,0x60(%rsp)
    1d61:	jne    1d40 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x11d0>
    1d63:	add    $0x4,%rdx
    1d67:	sub    %r14,0x40(%rsp)
    1d6c:	add    %r14,%rsi
    1d6f:	add    %rbp,%rdi
    1d72:	cmp    %r10,%rdx
    1d75:	jne    1b99 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1029>
    1d7b:	mov    %rbx,%rdi
    1d7e:	mov    %r12,%rbx
    1d81:	mov    %rdi,%r12
    1d84:	jmp    1dc3 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1253>
    1d86:	cs nopw 0x0(%rax,%rax,1)
    1d90:	movaps %xmm0,%xmm1
    1d93:	mov    %rax,0x70(%rsp)
    1d98:	mov    %r9,%rcx
    1d9b:	xor    %r12d,%r12d
    1d9e:	mov    %r9,%r8
    1da1:	shufps $0x0,%xmm1,%xmm1
    1da5:	jmp    1c6b <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x10fb>
    1daa:	nopw   0x0(%rax,%rax,1)
    1db0:	mov    %rbx,%r12
    1db3:	mov    0x90(%rsp),%r11
    1dbb:	mov    0x88(%rsp),%rbx
    1dc3:	add    %r14,0x60(%rsp)
    1dc8:	add    $0x1,%rbx
    1dcc:	add    %r14,%r15
    1dcf:	add    %rbp,%r13
    1dd2:	add    0xd0(%rsp),%r10
    1dda:	cmp    0x30(%rsp),%rbx
    1ddf:	je     1a55 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xee5>
    1de5:	lea    0x0(,%r13,4),%rsi
    1ded:	jmp    1b50 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xfe0>
    1df2:	mov    0x120(%rsp),%r15
    1dfa:	mov    0x130(%rsp),%rbx
    1e02:	mov    0x138(%rsp),%r12
    1e0a:	cmp    %r15,0x30(%rsp)
    1e0f:	jb     197d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xe0d>
    1e15:	mov    %r14,%r13
    1e18:	mov    0x8(%rsp),%rdx
    1e1d:	mov    %rbp,%r14
    1e20:	mov    0x118(%rsp),%rbp
    1e28:	cmp    %rdx,0x28(%rsp)
    1e2d:	jb     190a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd9a>
    1e33:	mov    %r13,%r10
    1e36:	mov    %r14,%r13
    1e39:	mov    %r12,%r14
    1e3c:	mov    0x108(%rsp),%r12
    1e44:	cmp    %r13,0x20(%rsp)
    1e49:	jb     18c2 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd52>
    1e4f:	cmp    %r12,%r15
    1e52:	jb     189a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd2a>
    1e58:	jmp    11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
    1e5d:	cmp    $0x3,%ebx
    1e60:	jne    247d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x190d>
    1e66:	mov    0x8(%rsp),%rax
    1e6b:	mov    %r13,%r10
    1e6e:	xor    %r15d,%r15d
    1e71:	lea    0x0(,%r13,4),%r13
    1e79:	shl    $0x2,%rax
    1e7d:	mov    %rax,0xc8(%rsp)
    1e85:	mov    %r12,%rax
    1e88:	mov    %r15,%rdx
    1e8b:	sub    %r15,%rax
    1e8e:	cmp    %r14,%rax
    1e91:	cmova  %r14,%rax
    1e95:	add    %rax,%r15
    1e98:	cmp    %r15,%rdx
    1e9b:	jae    245c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x18ec>
    1ea1:	xor    %r8d,%r8d
    1ea4:	mov    %rdx,%rbp
    1ea7:	mov    0x48(%rsp),%rsi
    1eac:	mov    %r10,%rax
    1eaf:	mov    %r8,%rcx
    1eb2:	sub    %r8,%rax
    1eb5:	cmp    %rsi,%rax
    1eb8:	cmova  %rsi,%rax
    1ebc:	add    %rax,%r8
    1ebf:	cmp    %r8,%rcx
    1ec2:	jae    2453 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x18e3>
    1ec8:	movq   $0x0,0x20(%rsp)
    1ed1:	mov    %rcx,%rbx
    1ed4:	mov    %r8,0x60(%rsp)
    1ed9:	mov    %r12,0x100(%rsp)
    1ee1:	mov    %r14,%r12
    1ee4:	mov    %r10,%r14
    1ee7:	mov    0x20(%rsp),%rcx
    1eec:	mov    0x8(%rsp),%rax
    1ef1:	mov    %rbp,0x28(%rsp)
    1ef6:	mov    0x50(%rsp),%rdi
    1efb:	sub    %rcx,%rax
    1efe:	mov    %rcx,%r8
    1f01:	cmp    %rdi,%rax
    1f04:	mov    %r8,0x78(%rsp)
    1f09:	cmova  %rdi,%rax
    1f0d:	mov    0x10(%rsp),%rdi
    1f12:	add    %rax,%rcx
    1f15:	mov    %rax,%r9
    1f18:	mov    %r14,%rax
    1f1b:	imul   %r8,%rax
    1f1f:	mov    %rcx,0x20(%rsp)
    1f24:	mov    %r9,0x108(%rsp)
    1f2c:	mov    %rax,0x30(%rsp)
    1f31:	mov    %r8,%rax
    1f34:	sub    %rcx,%rax
    1f37:	lea    0x0(,%rax,4),%rax
    1f3f:	mov    %rax,0xd8(%rsp)
    1f47:	mov    %r8,%rax
    1f4a:	imul   %r13,%rax
    1f4e:	add    %rdi,%rax
    1f51:	mov    %rax,0xf8(%rsp)
    1f59:	mov    %r14,%rax
    1f5c:	mov    %r13,%r14
    1f5f:	mov    %rax,%r13
    1f62:	mov    0x28(%rsp),%rdi
    1f67:	mov    %r15,%rdx
    1f6a:	mov    $0x8,%eax
    1f6f:	mov    %rbx,%r9
    1f72:	mov    0x38(%rsp),%rsi
    1f77:	mov    %rbx,0x118(%rsp)
    1f7f:	sub    %rdi,%rdx
    1f82:	mov    %rdi,%r8
    1f85:	mov    %r15,0x110(%rsp)
    1f8d:	mov    0x60(%rsp),%r11
    1f92:	cmp    %rax,%rdx
    1f95:	mov    %rbp,0x120(%rsp)
    1f9d:	mov    %r8,%rbx
    1fa0:	cmovbe %rdx,%rax
    1fa4:	mov    %r12,0x128(%rsp)
    1fac:	add    %rax,%rdi
    1faf:	cmp    $0x7,%rdx
    1fb3:	mov    %r13,%rax
    1fb6:	seta   0xa0(%rsp)
    1fbe:	imul   %r8,%rax
    1fc2:	mov    %rdi,0x28(%rsp)
    1fc7:	mov    0x78(%rsp),%rdi
    1fcc:	mov    %rax,0x68(%rsp)
    1fd1:	mov    0x8(%rsp),%rax
    1fd6:	imul   %r8,%rax
    1fda:	lea    (%rax,%rdi,1),%rdx
    1fde:	add    0x20(%rsp),%rax
    1fe3:	lea    (%rsi,%rdx,4),%rdi
    1fe7:	lea    (%rsi,%rax,4),%rax
    1feb:	mov    %rdi,0xa8(%rsp)
    1ff3:	mov    %rax,0xd0(%rsp)
    1ffb:	jmp    205b <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14eb>
    1ffd:	cmpb   $0x0,0xa0(%rsp)
    2005:	je     2079 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1509>
    2007:	mov    0x68(%rsp),%rax
    200c:	mov    0x18(%rsp),%rcx
    2011:	mov    0x8(%rsp),%r8
    2016:	mov    0xa8(%rsp),%rdi
    201e:	add    %r9,%rax
    2021:	add    0x30(%rsp),%r9
    2026:	lea    (%rcx,%rax,4),%rdx
    202a:	mov    0x10(%rsp),%rax
    202f:	mov    %r13,%rcx
    2032:	lea    (%rax,%r9,4),%rsi
    2036:	mov    0x108(%rsp),%r9
    203e:	call   450 <void mini_gpu::(anonymous namespace)::microkernel<8ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    2043:	mov    0x60(%rsp),%rdx
    2048:	cmp    %rdx,0x58(%rsp)
    204d:	jae    23fe <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x188e>
    2053:	mov    0x58(%rsp),%r9
    2058:	mov    %rdx,%r11
    205b:	sub    %r9,%r11
    205e:	mov    $0x10,%eax
    2063:	cmp    %rax,%r11
    2066:	cmovbe %r11,%rax
    206a:	lea    (%rax,%r9,1),%rsi
    206e:	mov    %rsi,0x58(%rsp)
    2073:	cmp    $0xf,%r11
    2077:	ja     1ffd <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x148d>
    2079:	cmp    0x28(%rsp),%rbx
    207e:	jae    2043 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14d3>
    2080:	mov    0x20(%rsp),%rsi
    2085:	cmp    %rsi,0x78(%rsp)
    208a:	jae    2043 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14d3>
    208c:	mov    0x58(%rsp),%rdi
    2091:	cmp    %rdi,%r9
    2094:	jae    2043 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14d3>
    2096:	mov    0x68(%rsp),%rsi
    209b:	mov    0x18(%rsp),%r8
    20a0:	mov    $0xfffffffffffffffc,%rbp
    20a7:	mov    %rax,0x80(%rsp)
    20af:	mov    0xd0(%rsp),%r10
    20b7:	mov    %rbx,0x40(%rsp)
    20bc:	lea    (%rsi,%rdi,1),%rdx
    20c0:	lea    (%rsi,%r9,1),%r12
    20c4:	mov    0x10(%rsp),%rsi
    20c9:	lea    (%r8,%rdx,4),%rdi
    20cd:	mov    0x30(%rsp),%rdx
    20d2:	lea    0x0(,%r12,4),%rcx
    20da:	mov    %rdi,0x70(%rsp)
    20df:	lea    (%r8,%rcx,1),%r15
    20e3:	mov    %rbx,%r8
    20e6:	mov    %r11,%rbx
    20e9:	add    %r9,%rdx
    20ec:	lea    (%rsi,%rdx,4),%rdi
    20f0:	mov    0xf8(%rsp),%rdx
    20f8:	lea    -0x1(%rax),%rsi
    20fc:	mov    %rdi,0xc0(%rsp)
    2104:	mov    %rax,%rdi
    2107:	lea    (%rdx,%r9,4),%rdx
    210b:	and    $0xfffffffffffffffc,%rdi
    210f:	mov    %rsi,0xb8(%rsp)
    2117:	sub    %rdx,%rbp
    211a:	mov    %rax,%rdx
    211d:	mov    %rdi,0xe8(%rsp)
    2125:	mov    %rax,%rdi
    2128:	shr    $0x2,%rdx
    212c:	and    $0x3,%edi
    212f:	mov    %rbp,%r11
    2132:	shl    $0x4,%rdx
    2136:	mov    %rdi,0xf0(%rsp)
    213e:	mov    %rdx,0xe0(%rsp)
    2146:	cs nopw 0x0(%rax,%rax,1)
    2150:	mov    %r12,%rax
    2153:	mov    0x18(%rsp),%rsi
    2158:	mov    0x30(%rsp),%rdi
    215d:	mov    %r11,0x88(%rsp)
    2165:	sub    %r9,%rax
    2168:	mov    %rax,0xb0(%rsp)
    2170:	mov    0xd8(%rsp),%rax
    2178:	lea    (%rsi,%rcx,1),%rbp
    217c:	mov    0xc0(%rsp),%rsi
    2184:	lea    (%r10,%rax,1),%rdx
    2188:	lea    (%r11,%r15,1),%rax
    218c:	mov    %rbx,%r11
    218f:	mov    %rbp,%rbx
    2192:	movss  (%rdx),%xmm0
    2196:	cmp    $0x1,%r11
    219a:	je     22f3 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1783>
    21a0:	mov    %r11,0x90(%rsp)
    21a8:	mov    %r8,0x98(%rsp)
    21b0:	mov    %rbx,0x130(%rsp)
    21b8:	cmp    $0x8,%rax
    21bc:	jbe    22db <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x176b>
    21c2:	cmpq   $0x2,0xb8(%rsp)
    21cb:	jbe    2390 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1820>
    21d1:	movaps %xmm0,%xmm1
    21d4:	xor    %ecx,%ecx
    21d6:	shufps $0x0,%xmm1,%xmm1
    21da:	nopl   0x0(%rax,%rax,1)
    21df:	data16 cs nopw 0x0(%rax,%rax,1)
    21ea:	data16 cs nopw 0x0(%rax,%rax,1)
    21f5:	data16 cs nopw 0x0(%rax,%rax,1)
    2200:	movups (%rsi,%rcx,1),%xmm2
    2204:	movups (%r15,%rcx,1),%xmm6
    2209:	mulps  %xmm1,%xmm2
    220c:	addps  %xmm6,%xmm2
    220f:	movups %xmm2,(%r15,%rcx,1)
    2214:	add    $0x10,%rcx
    2218:	cmp    0xe0(%rsp),%rcx
    2220:	jne    2200 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1690>
    2222:	testb  $0x3,0x80(%rsp)
    222a:	je     22b7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1747>
    2230:	mov    0xe8(%rsp),%rbx
    2238:	mov    0xf0(%rsp),%r8
    2240:	mov    %rbx,%r11
    2243:	lea    (%r9,%rbx,1),%rcx
    2247:	mov    %r8,%rbx
    224a:	cmp    $0x1,%r8
    224e:	je     228b <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x171b>
    2250:	mov    0x18(%rsp),%rbp
    2255:	lea    (%r12,%r11,1),%r8
    2259:	lea    0x0(%rbp,%r8,4),%rbp
    225e:	lea    (%rdi,%r9,1),%r8
    2262:	add    %r11,%r8
    2265:	mov    0x10(%rsp),%r11
    226a:	movq   (%r11,%r8,4),%xmm2
    2270:	mulps  %xmm2,%xmm1
    2273:	movq   0x0(%rbp),%xmm2
    2278:	addps  %xmm2,%xmm1
    227b:	movlps %xmm1,0x0(%rbp)
    227f:	test   $0x1,%bl
    2282:	je     22b7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1747>
    2284:	and    $0xfffffffffffffffe,%rbx
    2288:	add    %rbx,%rcx
    228b:	mov    0xb0(%rsp),%rbx
    2293:	lea    (%rbx,%rcx,1),%r8
    2297:	mov    0x18(%rsp),%rbx
    229c:	add    %rdi,%rcx
    229f:	lea    (%rbx,%r8,4),%r8
    22a3:	mov    0x10(%rsp),%rbx
    22a8:	mulss  (%rbx,%rcx,4),%xmm0
    22ad:	addss  (%r8),%xmm0
    22b2:	movss  %xmm0,(%r8)
    22b7:	add    $0x4,%rdx
    22bb:	cmp    %r10,%rdx
    22be:	je     23b0 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1840>
    22c4:	sub    %r14,%rax
    22c7:	movss  (%rdx),%xmm0
    22cb:	add    %r14,%rsi
    22ce:	add    %r13,%rdi
    22d1:	cmp    $0x8,%rax
    22d5:	ja     21c2 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1652>
    22db:	mov    0x90(%rsp),%r11
    22e3:	mov    0x98(%rsp),%r8
    22eb:	mov    0x130(%rsp),%rbx
    22f3:	mov    %rax,0x90(%rsp)
    22fb:	mov    %rsi,%rcx
    22fe:	mov    %rbx,%rbp
    2301:	nopl   0x0(%rax,%rax,1)
    2309:	data16 cs nopw 0x0(%rax,%rax,1)
    2314:	data16 cs nopw 0x0(%rax,%rax,1)
    231f:	data16 cs nopw 0x0(%rax,%rax,1)
    232a:	data16 cs nopw 0x0(%rax,%rax,1)
    2335:	data16 cs nopw 0x0(%rax,%rax,1)
    2340:	movss  (%rcx),%xmm1
    2344:	add    $0x4,%rbp
    2348:	add    $0x4,%rcx
    234c:	mulss  %xmm0,%xmm1
    2350:	addss  -0x4(%rbp),%xmm1
    2355:	movss  %xmm1,-0x4(%rbp)
    235a:	cmp    0x70(%rsp),%rbp
    235f:	jne    2340 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x17d0>
    2361:	mov    0x90(%rsp),%rax
    2369:	add    $0x4,%rdx
    236d:	add    %r14,%rsi
    2370:	add    %r13,%rdi
    2373:	sub    %r14,%rax
    2376:	cmp    %r10,%rdx
    2379:	jne    2192 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1622>
    237f:	mov    %r11,%rbx
    2382:	mov    0x88(%rsp),%r11
    238a:	jmp    23c8 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1858>
    238c:	nopl   0x0(%rax)
    2390:	movaps %xmm0,%xmm1
    2393:	mov    0x80(%rsp),%rbx
    239b:	mov    %r9,%rcx
    239e:	xor    %r11d,%r11d
    23a1:	shufps $0x0,%xmm1,%xmm1
    23a5:	jmp    2250 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x16e0>
    23aa:	nopw   0x0(%rax,%rax,1)
    23b0:	mov    0x90(%rsp),%rbx
    23b8:	mov    0x98(%rsp),%r8
    23c0:	mov    0x88(%rsp),%r11
    23c8:	addq   $0x1,0x40(%rsp)
    23ce:	add    %r14,%r15
    23d1:	mov    0x40(%rsp),%rax
    23d6:	add    %r13,%r12
    23d9:	add    %r14,0x70(%rsp)
    23de:	add    0xc8(%rsp),%r10
    23e6:	cmp    0x28(%rsp),%rax
    23eb:	je     2470 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1900>
    23f1:	lea    0x0(,%r12,4),%rcx
    23f9:	jmp    2150 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15e0>
    23fe:	mov    0x110(%rsp),%r15
    2406:	mov    0x118(%rsp),%rbx
    240e:	mov    0x120(%rsp),%rbp
    2416:	mov    0x128(%rsp),%r12
    241e:	cmp    %r15,0x28(%rsp)
    2423:	jb     1f62 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x13f2>
    2429:	mov    %r13,%rax
    242c:	mov    0x8(%rsp),%rsi
    2431:	mov    %r14,%r13
    2434:	mov    %rax,%r14
    2437:	cmp    %rsi,0x20(%rsp)
    243c:	jb     1ee7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1377>
    2442:	mov    %r12,%r14
    2445:	mov    0x100(%rsp),%r12
    244d:	mov    %rdx,%r8
    2450:	mov    %rax,%r10
    2453:	cmp    %r10,%r8
    2456:	jb     1ea7 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1337>
    245c:	cmp    %r12,%r15
    245f:	jb     1e85 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1315>
    2465:	jmp    11ec <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x67c>
    246a:	nopw   0x0(%rax,%rax,1)
    2470:	mov    %r8,%rbx
    2473:	jmp    2043 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14d3>
    2478:	jmp    247d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x190d>
    247d:	jmp    2482 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1912>

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x4e>
  4e:	jmp    1c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  50:	mov    $0x10,%edi
  55:	call   5a <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x5a>
  5a:	lea    0x0(%rip),%rsi        # 61 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x61>
  61:	mov    %rax,%rdi
  64:	mov    %rax,%rbx
  67:	call   6c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x6c>
  6c:	jmp    1c <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  6e:	endbr64
  72:	mov    %rax,%rbp
  75:	mov    %rbx,%rdi
  78:	call   7d <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x7d>
  7d:	mov    %rbp,%rdi
  80:	call   85 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x85>
  85:	endbr64
  89:	jmp    72 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x72>
  8b:	endbr64
  8f:	jmp    72 <mini_gpu::matmul_cpu_register_blocked_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x72>
