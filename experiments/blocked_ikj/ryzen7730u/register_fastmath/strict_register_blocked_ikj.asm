<REPO>/build-register/CMakeFiles/matmul_register_strict.dir/src/cpu/register_blocked_ikj.cpp.o:     file format elf64-x86-64


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

0000000000000b70 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)>:
     b70:	endbr64
     b74:	push   %r15
     b76:	push   %r14
     b78:	push   %r13
     b7a:	mov    %rdx,%r13
     b7d:	push   %r12
     b7f:	push   %rbp
     b80:	push   %rbx
     b81:	sub    $0x158,%rsp
     b88:	mov    0x198(%rsp),%rax
     b90:	mov    %rdi,0x38(%rsp)
     b95:	mov    0x1a0(%rsp),%rdi
     b9d:	mov    %rsi,0x10(%rsp)
     ba2:	test   %rax,%rax
     ba5:	mov    %rax,0x48(%rsp)
     baa:	mov    0x190(%rsp),%r14
     bb2:	sete   %al
     bb5:	test   %rdi,%rdi
     bb8:	mov    %r9,0x8(%rsp)
     bbd:	mov    0x1a8(%rsp),%ebx
     bc4:	sete   %dl
     bc7:	mov    %rdi,0x50(%rsp)
     bcc:	or     %dl,%al
     bce:	jne    bd4 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x64>
     bd4:	test   %r14,%r14
     bd7:	je     bdd <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6d>
     bdd:	mov    %rcx,%r12
     be0:	test   %rcx,%rcx
     be3:	je     11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
     be9:	mov    %r8,%r15
     bec:	test   %r8,%r8
     bef:	je     11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
     bf5:	test   %r13,%r13
     bf8:	je     bfe <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8e>
     bfe:	cmpq   $0x0,0x8(%rsp)
     c04:	je     11de <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x66e>
     c0a:	cmpq   $0x0,0x38(%rsp)
     c10:	sete   %al
     c13:	cmpq   $0x0,0x10(%rsp)
     c19:	sete   %dl
     c1c:	or     %dl,%al
     c1e:	jne    c24 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb4>
     c24:	mov    %rcx,%rdx
     c27:	imul   %r8,%rdx
     c2b:	shl    $0x2,%rdx
     c2f:	lea    0x0(%r13,%rdx,1),%rax
     c34:	cmp    %rax,%r13
     c37:	je     c43 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd3>
     c39:	xor    %esi,%esi
     c3b:	mov    %r13,%rdi
     c3e:	call   c43 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd3>
     c43:	cmp    $0x2,%ebx
     c46:	je     120e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x69e>
     c4c:	jg     1f0b <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x139b>
     c52:	test   %ebx,%ebx
     c54:	jne    18fd <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd8d>
     c5a:	mov    0x8(%rsp),%rax
     c5f:	mov    %r15,0x18(%rsp)
     c64:	mov    %r13,%r11
     c67:	mov    %r12,%rbp
     c6a:	lea    0x0(,%r15,4),%r10
     c72:	xor    %r15d,%r15d
     c75:	shl    $0x2,%rax
     c79:	mov    %r10,0x80(%rsp)
     c81:	mov    %rax,0xc0(%rsp)
     c89:	mov    %rbp,%rdx
     c8c:	mov    %r15,%rax
     c8f:	sub    %r15,%rdx
     c92:	cmp    %r14,%rdx
     c95:	cmova  %r14,%rdx
     c99:	add    %rdx,%r15
     c9c:	cmp    %r15,%rax
     c9f:	jae    18ef <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd7f>
     ca5:	movq   $0x0,0x20(%rsp)
     cae:	mov    %rbp,%r12
     cb1:	mov    %rax,%r13
     cb4:	mov    %r11,%r10
     cb7:	mov    %r15,%rbp
     cba:	mov    0x20(%rsp),%rbx
     cbf:	mov    0x18(%rsp),%rax
     cc4:	mov    %r14,%r15
     cc7:	movq   $0x0,0x28(%rsp)
     cd0:	mov    0x48(%rsp),%rdi
     cd5:	sub    %rbx,%rax
     cd8:	mov    %rbx,%rcx
     cdb:	cmp    %rdi,%rax
     cde:	cmova  %rdi,%rax
     ce2:	add    %rax,%rbx
     ce5:	mov    %rbx,0x20(%rsp)
     cea:	mov    %r12,%rbx
     ced:	mov    %r13,%r12
     cf0:	mov    %rcx,%r13
     cf3:	mov    0x28(%rsp),%rdi
     cf8:	mov    0x8(%rsp),%rax
     cfd:	mov    %r12,0x30(%rsp)
     d02:	mov    0x50(%rsp),%rcx
     d07:	sub    %rdi,%rax
     d0a:	mov    %rdi,0x78(%rsp)
     d0f:	cmp    %rcx,%rax
     d12:	cmova  %rcx,%rax
     d16:	mov    0x18(%rsp),%rcx
     d1b:	mov    %rax,%r14
     d1e:	imul   %rdi,%rcx
     d22:	mov    %rdi,%rax
     d25:	lea    (%rdi,%r14,1),%rsi
     d29:	mov    %r14,0x100(%rsp)
     d31:	mov    %r10,%r14
     d34:	sub    %rsi,%rax
     d37:	mov    %rsi,0x28(%rsp)
     d3c:	lea    0x0(,%rax,4),%rax
     d44:	mov    %rcx,0x58(%rsp)
     d49:	mov    %rax,0xd0(%rsp)
     d51:	mov    0x80(%rsp),%rax
     d59:	imul   %rdi,%rax
     d5d:	mov    %rax,0xc8(%rsp)
     d65:	mov    %rbp,%rax
     d68:	sub    0x30(%rsp),%rax
     d6d:	xor    %r8d,%r8d
     d70:	cmp    $0x1,%rax
     d74:	je     d81 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x211>
     d76:	mov    $0x1,%r8d
     d7c:	mov    $0x2,%eax
     d81:	add    0x30(%rsp),%rax
     d86:	mov    %rax,0x40(%rsp)
     d8b:	cmp    0x20(%rsp),%r13
     d90:	jae    189c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd2c>
     d96:	mov    0x30(%rsp),%rdi
     d9b:	mov    0x18(%rsp),%rax
     da0:	mov    %r13,%r11
     da3:	mov    %r13,0x120(%rsp)
     dab:	mov    %rbp,0x108(%rsp)
     db3:	mov    0x80(%rsp),%r13
     dbb:	imul   %rdi,%rax
     dbf:	mov    %r12,0x110(%rsp)
     dc7:	mov    %r8b,0x118(%rsp)
     dcf:	mov    %r15,0x128(%rsp)
     dd7:	mov    %rax,0x68(%rsp)
     ddc:	mov    0x8(%rsp),%rax
     de1:	mov    %rbx,0x130(%rsp)
     de9:	imul   %rdi,%rax
     ded:	mov    0x78(%rsp),%rdi
     df2:	lea    (%rax,%rdi,1),%rdx
     df6:	mov    0x38(%rsp),%rdi
     dfb:	add    0x28(%rsp),%rax
     e00:	lea    (%rdi,%rdx,4),%rsi
     e04:	lea    (%rdi,%rax,4),%rax
     e08:	mov    %rsi,0xa8(%rsp)
     e10:	mov    %rax,0xb8(%rsp)
     e18:	jmp    e6b <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2fb>
     e1a:	cmpb   $0x0,0x118(%rsp)
     e22:	je     e89 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x319>
     e24:	mov    0x68(%rsp),%rax
     e29:	mov    0x100(%rsp),%r9
     e31:	mov    0x8(%rsp),%r8
     e36:	mov    0x18(%rsp),%rcx
     e3b:	add    %r11,%rax
     e3e:	mov    0xa8(%rsp),%rdi
     e46:	add    0x58(%rsp),%r11
     e4b:	lea    (%r14,%rax,4),%rdx
     e4f:	mov    0x10(%rsp),%rax
     e54:	lea    (%rax,%r11,4),%rsi
     e58:	call   0 <void mini_gpu::(anonymous namespace)::microkernel<2ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
     e5d:	cmp    0x20(%rsp),%rbp
     e62:	jae    1874 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd04>
     e68:	mov    %rbp,%r11
     e6b:	mov    0x20(%rsp),%r12
     e70:	mov    $0x8,%eax
     e75:	sub    %r11,%r12
     e78:	cmp    %rax,%r12
     e7b:	cmovbe %r12,%rax
     e7f:	lea    (%rax,%r11,1),%rbp
     e83:	cmp    $0x7,%r12
     e87:	ja     e1a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2aa>
     e89:	mov    0x30(%rsp),%rbx
     e8e:	cmp    0x40(%rsp),%rbx
     e93:	jae    e5d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2ed>
     e95:	mov    0x28(%rsp),%rsi
     e9a:	cmp    %rsi,0x78(%rsp)
     e9f:	jae    e5d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2ed>
     ea1:	cmp    %rbp,%r11
     ea4:	jae    e5d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2ed>
     ea6:	mov    0x68(%rsp),%rdi
     eab:	mov    %rbx,0x60(%rsp)
     eb0:	mov    %rbp,%r9
     eb3:	mov    $0xfffffffffffffffc,%rbx
     eba:	mov    %rax,0x88(%rsp)
     ec2:	mov    0xb8(%rsp),%r10
     eca:	lea    (%rdi,%rbp,1),%rdx
     ece:	lea    (%rdi,%r11,1),%r15
     ed2:	mov    %r12,%rbp
     ed5:	lea    (%r14,%rdx,4),%rdi
     ed9:	lea    0x0(,%r15,4),%rsi
     ee1:	mov    %rdi,0x70(%rsp)
     ee6:	mov    0x58(%rsp),%rdi
     eeb:	lea    (%r14,%rsi,1),%r8
     eef:	lea    (%rdi,%r11,1),%rdx
     ef3:	mov    0x10(%rsp),%rdi
     ef8:	lea    (%rdi,%rdx,4),%rcx
     efc:	mov    %rcx,0xe0(%rsp)
     f04:	mov    0xc8(%rsp),%rcx
     f0c:	lea    (%rdi,%rcx,1),%rdx
     f10:	mov    %rax,%rcx
     f13:	lea    -0x1(%rax),%rdi
     f17:	lea    (%rdx,%r11,4),%rdx
     f1b:	shr    $0x2,%rcx
     f1f:	mov    %rdi,0xd8(%rsp)
     f27:	mov    %rcx,0xe8(%rsp)
     f2f:	sub    %rdx,%rbx
     f32:	mov    %rax,%rcx
     f35:	mov    %rax,%rdx
     f38:	and    $0xfffffffffffffffc,%rcx
     f3c:	and    $0x3,%edx
     f3f:	mov    %rcx,0xf0(%rsp)
     f47:	mov    %rdx,0xf8(%rsp)
     f4f:	nop
     f50:	mov    %r15,%rax
     f53:	lea    (%r14,%rsi,1),%r12
     f57:	mov    0x58(%rsp),%rdi
     f5c:	mov    0xe0(%rsp),%rsi
     f64:	sub    %r11,%rax
     f67:	mov    %rbx,0x90(%rsp)
     f6f:	mov    %rax,0xb0(%rsp)
     f77:	mov    0xd0(%rsp),%rax
     f7f:	lea    (%r10,%rax,1),%rdx
     f83:	lea    (%rbx,%r8,1),%rax
     f87:	mov    %rbp,%rbx
     f8a:	mov    %r12,%rbp
     f8d:	mov    %r9,%r12
     f90:	movss  (%rdx),%xmm0
     f94:	cmp    $0x1,%rbx
     f98:	je     10f3 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x583>
     f9e:	mov    %rbx,0x98(%rsp)
     fa6:	mov    %r12,0xa0(%rsp)
     fae:	mov    %rbp,0x138(%rsp)
     fb6:	cmp    $0x8,%rax
     fba:	jbe    10db <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x56b>
     fc0:	cmpq   $0x2,0xd8(%rsp)
     fc9:	jbe    1810 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xca0>
     fcf:	mov    $0x20,%r9d
     fd5:	mov    $0x10,%ebx
     fda:	movaps %xmm0,%xmm2
     fdd:	cmpq   $0x1,0xe8(%rsp)
     fe6:	cmove  %rbx,%r9
     fea:	xor    %ecx,%ecx
     fec:	shufps $0x0,%xmm2,%xmm2
     ff0:	nopl   0x0(%rax,%rax,1)
     ff5:	data16 cs nopw 0x0(%rax,%rax,1)
    1000:	movups (%rsi,%rcx,1),%xmm1
    1004:	movups (%r8,%rcx,1),%xmm3
    1009:	mulps  %xmm2,%xmm1
    100c:	addps  %xmm3,%xmm1
    100f:	movups %xmm1,(%r8,%rcx,1)
    1014:	add    $0x10,%rcx
    1018:	cmp    %rcx,%r9
    101b:	jne    1000 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x490>
    101d:	testb  $0x3,0x88(%rsp)
    1025:	je     10b5 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x545>
    102b:	mov    0xf0(%rsp),%rcx
    1033:	mov    0xf8(%rsp),%r9
    103b:	mov    %rcx,%rbx
    103e:	mov    %r9,%rbp
    1041:	add    %r11,%rcx
    1044:	cmp    $0x1,%r9
    1048:	je     1090 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x520>
    104a:	lea    (%rdi,%r11,1),%r9
    104e:	lea    (%r15,%rbx,1),%r12
    1052:	movaps %xmm0,%xmm2
    1055:	add    %rbx,%r9
    1058:	mov    0x10(%rsp),%rbx
    105d:	shufps $0xe0,%xmm2,%xmm2
    1061:	movq   %xmm2,%xmm2
    1065:	movq   (%rbx,%r9,4),%xmm1
    106b:	mulps  %xmm2,%xmm1
    106e:	movq   (%r14,%r12,4),%xmm2
    1074:	movq   %xmm1,%xmm1
    1078:	addps  %xmm2,%xmm1
    107b:	movlps %xmm1,(%r14,%r12,4)
    1080:	test   $0x1,%bpl
    1084:	je     10b5 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x545>
    1086:	mov    %rbp,%r9
    1089:	and    $0xfffffffffffffffe,%r9
    108d:	add    %r9,%rcx
    1090:	mov    0xb0(%rsp),%rbx
    1098:	lea    (%rbx,%rcx,1),%r9
    109c:	mov    0x10(%rsp),%rbx
    10a1:	add    %rdi,%rcx
    10a4:	mulss  (%rbx,%rcx,4),%xmm0
    10a9:	addss  (%r14,%r9,4),%xmm0
    10af:	movss  %xmm0,(%r14,%r9,4)
    10b5:	add    $0x4,%rdx
    10b9:	cmp    %rdx,%r10
    10bc:	je     1828 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xcb8>
    10c2:	sub    %r13,%rax
    10c5:	movss  (%rdx),%xmm0
    10c9:	add    %r13,%rsi
    10cc:	add    0x18(%rsp),%rdi
    10d1:	cmp    $0x8,%rax
    10d5:	ja     fc0 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x450>
    10db:	mov    0x98(%rsp),%rbx
    10e3:	mov    0xa0(%rsp),%r12
    10eb:	mov    0x138(%rsp),%rbp
    10f3:	mov    %rsi,%rcx
    10f6:	mov    %rbp,%r9
    10f9:	nopl   0x0(%rax)
    1100:	movss  (%rcx),%xmm1
    1104:	add    $0x4,%r9
    1108:	add    $0x4,%rcx
    110c:	mulss  %xmm0,%xmm1
    1110:	addss  -0x4(%r9),%xmm1
    1116:	movss  %xmm1,-0x4(%r9)
    111c:	cmp    %r9,0x70(%rsp)
    1121:	jne    1100 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x590>
    1123:	add    $0x4,%rdx
    1127:	add    %r13,%rsi
    112a:	add    0x18(%rsp),%rdi
    112f:	sub    %r13,%rax
    1132:	cmp    %rdx,%r10
    1135:	jne    f90 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x420>
    113b:	mov    %rbx,%rbp
    113e:	mov    %r12,%r9
    1141:	mov    0x90(%rsp),%rbx
    1149:	jmp    1840 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xcd0>
    114e:	mov    0x110(%rsp),%rbx
    1156:	mov    0x118(%rsp),%rdi
    115e:	mov    0x120(%rsp),%rbp
    1166:	mov    0x128(%rsp),%r15
    116e:	cmp    %rbx,0x20(%rsp)
    1173:	jb     203d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14cd>
    1179:	mov    %r12,%rax
    117c:	mov    %rdi,%r14
    117f:	mov    %r13,%r12
    1182:	mov    0x8(%rsp),%rdi
    1187:	mov    0x108(%rsp),%rdx
    118f:	mov    %rax,%r13
    1192:	cmp    %rdi,0x18(%rsp)
    1197:	jb     1fb5 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1445>
    119d:	mov    %rbp,%r14
    11a0:	mov    %r12,%r10
    11a3:	mov    %rbx,%rbp
    11a6:	mov    %rax,%r12
    11a9:	mov    %rdx,%r13
    11ac:	cmp    %r12,0x28(%rsp)
    11b1:	jb     1f6f <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x13ff>
    11b7:	mov    %r10,%r11
    11ba:	mov    %r12,%r10
    11bd:	mov    %r15,%r12
    11c0:	mov    %rbp,%r15
    11c3:	cmp    %r12,%r15
    11c6:	jb     1f3b <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x13cb>
    11cc:	add    $0x158,%rsp
    11d3:	pop    %rbx
    11d4:	pop    %rbp
    11d5:	pop    %r12
    11d7:	pop    %r13
    11d9:	pop    %r14
    11db:	pop    %r15
    11dd:	ret
    11de:	mov    %rcx,%rdx
    11e1:	imul   %r8,%rdx
    11e5:	shl    $0x2,%rdx
    11e9:	lea    0x0(%r13,%rdx,1),%rax
    11ee:	cmp    %rax,%r13
    11f1:	je     11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
    11f3:	add    $0x158,%rsp
    11fa:	mov    %r13,%rdi
    11fd:	xor    %esi,%esi
    11ff:	pop    %rbx
    1200:	pop    %rbp
    1201:	pop    %r12
    1203:	pop    %r13
    1205:	pop    %r14
    1207:	pop    %r15
    1209:	jmp    120e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x69e>
    120e:	mov    0x8(%rsp),%rax
    1213:	mov    %r13,0x120(%rsp)
    121b:	mov    %r14,%rbp
    121e:	mov    %r15,%r11
    1221:	xor    %r14d,%r14d
    1224:	lea    0x0(,%r15,4),%r13
    122c:	shl    $0x2,%rax
    1230:	mov    %rax,0xe0(%rsp)
    1238:	mov    %r12,%rax
    123b:	mov    %r14,%r15
    123e:	sub    %r14,%rax
    1241:	cmp    %rbp,%rax
    1244:	cmova  %rbp,%rax
    1248:	add    %rax,%r14
    124b:	cmp    %r14,%r15
    124e:	jae    1801 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc91>
    1254:	movq   $0x0,0x28(%rsp)
    125d:	mov    0x28(%rsp),%rdi
    1262:	mov    0x48(%rsp),%rbx
    1267:	mov    %r11,%rax
    126a:	sub    %rdi,%rax
    126d:	mov    %rdi,%rcx
    1270:	cmp    %rbx,%rax
    1273:	cmova  %rbx,%rax
    1277:	add    %rax,%rdi
    127a:	mov    %rdi,0x28(%rsp)
    127f:	cmp    %rdi,%rcx
    1282:	jae    17f6 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc86>
    1288:	mov    %rbp,0x128(%rsp)
    1290:	mov    0x38(%rsp),%rbp
    1295:	xor    %r9d,%r9d
    1298:	mov    %rcx,%rbx
    129b:	mov    0x8(%rsp),%rax
    12a0:	mov    0x50(%rsp),%rdi
    12a5:	mov    %r9,%rsi
    12a8:	mov    %r9,0x68(%rsp)
    12ad:	mov    %r15,0x20(%rsp)
    12b2:	sub    %r9,%rax
    12b5:	mov    %r11,0x18(%rsp)
    12ba:	cmp    %rdi,%rax
    12bd:	mov    %r12,0x130(%rsp)
    12c5:	mov    %r13,%r12
    12c8:	cmova  %rdi,%rax
    12cc:	mov    0x10(%rsp),%rdi
    12d1:	add    %rax,%r9
    12d4:	mov    %rax,0xa8(%rsp)
    12dc:	mov    %rsi,%rax
    12df:	imul   %r11,%rsi
    12e3:	mov    %r9,0x60(%rsp)
    12e8:	mov    %rsi,0x30(%rsp)
    12ed:	mov    %rax,%rsi
    12f0:	sub    %r9,%rax
    12f3:	lea    0x0(,%rax,4),%rax
    12fb:	mov    %rax,0xf0(%rsp)
    1303:	mov    %rsi,%rax
    1306:	imul   %r13,%rax
    130a:	add    %rdi,%rax
    130d:	mov    %rax,0x118(%rsp)
    1315:	mov    0x20(%rsp),%rsi
    131a:	mov    %r14,%rdx
    131d:	mov    $0x4,%eax
    1322:	mov    %rbx,%r10
    1325:	mov    %r14,0x140(%rsp)
    132d:	mov    0x28(%rsp),%r13
    1332:	sub    %rsi,%rdx
    1335:	mov    %rsi,%rcx
    1338:	mov    %rsi,0xd0(%rsp)
    1340:	mov    0x120(%rsp),%r14
    1348:	cmp    %rax,%rdx
    134b:	mov    %rbx,0x138(%rsp)
    1353:	cmovbe %rdx,%rax
    1357:	mov    %r15,0x148(%rsp)
    135f:	add    %rax,%rsi
    1362:	mov    0x18(%rsp),%rax
    1367:	cmp    $0x3,%rdx
    136b:	seta   0xb0(%rsp)
    1373:	imul   %rcx,%rax
    1377:	mov    %rsi,0x20(%rsp)
    137c:	mov    0x68(%rsp),%rsi
    1381:	mov    %rax,0x70(%rsp)
    1386:	mov    0x8(%rsp),%rax
    138b:	imul   %rcx,%rax
    138f:	lea    (%rax,%rsi,1),%rdx
    1393:	add    0x60(%rsp),%rax
    1398:	lea    0x0(%rbp,%rdx,4),%rdi
    139d:	lea    0x0(%rbp,%rax,4),%rax
    13a2:	mov    %rdi,0xb8(%rsp)
    13aa:	mov    %rax,0xe8(%rsp)
    13b2:	jmp    140f <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x89f>
    13b4:	cmpb   $0x0,0xb0(%rsp)
    13bc:	je     142d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x8bd>
    13be:	mov    0x70(%rsp),%rax
    13c3:	mov    0xa8(%rsp),%r9
    13cb:	mov    0x8(%rsp),%r8
    13d0:	mov    0x18(%rsp),%rcx
    13d5:	add    %r10,%rax
    13d8:	mov    0xb8(%rsp),%rdi
    13e0:	add    0x30(%rsp),%r10
    13e5:	lea    (%r14,%rax,4),%rdx
    13e9:	mov    0x10(%rsp),%rax
    13ee:	lea    (%rax,%r10,4),%rsi
    13f2:	call   1c0 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    13f7:	mov    0x28(%rsp),%rdi
    13fc:	cmp    %rdi,0x58(%rsp)
    1401:	jae    17ab <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc3b>
    1407:	mov    0x58(%rsp),%r10
    140c:	mov    %rdi,%r13
    140f:	sub    %r10,%r13
    1412:	mov    $0x10,%eax
    1417:	cmp    %rax,%r13
    141a:	cmovbe %r13,%rax
    141e:	lea    (%rax,%r10,1),%rbx
    1422:	mov    %rbx,0x58(%rsp)
    1427:	cmp    $0xf,%r13
    142b:	ja     13b4 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x844>
    142d:	mov    0xd0(%rsp),%rcx
    1435:	cmp    0x20(%rsp),%rcx
    143a:	jae    13f7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x887>
    143c:	mov    0x60(%rsp),%rdi
    1441:	cmp    %rdi,0x68(%rsp)
    1446:	jae    13f7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x887>
    1448:	mov    0x58(%rsp),%rbx
    144d:	cmp    %rbx,%r10
    1450:	jae    13f7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x887>
    1452:	mov    0x70(%rsp),%rdx
    1457:	mov    %rcx,0x40(%rsp)
    145c:	mov    %rax,%rcx
    145f:	mov    %r13,%r15
    1462:	and    $0xfffffffffffffffc,%rcx
    1466:	lea    (%rdx,%r10,1),%rdi
    146a:	add    %rbx,%rdx
    146d:	mov    %rcx,0x100(%rsp)
    1475:	lea    (%r14,%rdx,4),%rbx
    1479:	lea    0x0(,%rdi,4),%rsi
    1481:	mov    %rbx,0x80(%rsp)
    1489:	mov    0x30(%rsp),%rbx
    148e:	lea    (%r14,%rsi,1),%r11
    1492:	lea    (%rbx,%r10,1),%rdx
    1496:	mov    0x10(%rsp),%rbx
    149b:	lea    (%rbx,%rdx,4),%rbx
    149f:	mov    %rax,%rdx
    14a2:	shr    $0x2,%rdx
    14a6:	mov    %rbx,0xd8(%rsp)
    14ae:	mov    0x118(%rsp),%rbx
    14b6:	shl    $0x4,%rdx
    14ba:	mov    %rdx,0xf8(%rsp)
    14c2:	lea    (%rcx,%r10,1),%rdx
    14c6:	lea    (%rbx,%r10,4),%rbx
    14ca:	mov    %rdx,0x108(%rsp)
    14d2:	mov    %rax,%rdx
    14d5:	sub    %rcx,%rdx
    14d8:	mov    %rbx,0x98(%rsp)
    14e0:	lea    -0x1(%rax),%rbx
    14e4:	mov    %rdx,0x110(%rsp)
    14ec:	mov    %rbx,0xc8(%rsp)
    14f4:	mov    0xe8(%rsp),%rbx
    14fc:	nopl   0x0(%rax)
    1500:	mov    %rdi,%rcx
    1503:	add    %r14,%rsi
    1506:	mov    0x30(%rsp),%r9
    150b:	mov    0xd8(%rsp),%r8
    1513:	sub    %r10,%rcx
    1516:	mov    %rsi,0xa0(%rsp)
    151e:	mov    %rcx,0xc0(%rsp)
    1526:	mov    0xf0(%rsp),%rcx
    152e:	lea    (%rbx,%rcx,1),%rdx
    1532:	mov    $0xfffffffffffffffc,%rcx
    1539:	sub    0x98(%rsp),%rcx
    1541:	add    %r11,%rcx
    1544:	movss  (%rdx),%xmm0
    1548:	cmp    $0x1,%r15
    154c:	je     16b4 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb44>
    1552:	mov    %r15,0x88(%rsp)
    155a:	mov    %rbp,0x90(%rsp)
    1562:	cmp    $0x8,%rcx
    1566:	jbe    16a4 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb34>
    156c:	cmpq   $0x2,0xc8(%rsp)
    1575:	jbe    1748 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xbd8>
    157b:	movaps %xmm0,%xmm2
    157e:	xor    %esi,%esi
    1580:	shufps $0x0,%xmm2,%xmm2
    1584:	nopl   0x0(%rax,%rax,1)
    1589:	data16 cs nopw 0x0(%rax,%rax,1)
    1594:	data16 cs nopw 0x0(%rax,%rax,1)
    159f:	data16 cs nopw 0x0(%rax,%rax,1)
    15aa:	data16 cs nopw 0x0(%rax,%rax,1)
    15b5:	data16 cs nopw 0x0(%rax,%rax,1)
    15c0:	movups (%r8,%rsi,1),%xmm1
    15c5:	movups (%r11,%rsi,1),%xmm5
    15ca:	mulps  %xmm2,%xmm1
    15cd:	addps  %xmm5,%xmm1
    15d0:	movups %xmm1,(%r11,%rsi,1)
    15d5:	add    $0x10,%rsi
    15d9:	cmp    0xf8(%rsp),%rsi
    15e1:	jne    15c0 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xa50>
    15e3:	test   $0x3,%al
    15e5:	je     167e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb0e>
    15eb:	mov    0x108(%rsp),%rsi
    15f3:	mov    0x110(%rsp),%rbp
    15fb:	mov    0x100(%rsp),%r15
    1603:	mov    %rbp,0x78(%rsp)
    1608:	mov    %rsi,%r13
    160b:	cmp    $0x1,%rbp
    160f:	je     1658 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xae8>
    1611:	mov    0x10(%rsp),%rbp
    1616:	add    %r9,%r13
    1619:	movaps %xmm0,%xmm2
    161c:	add    %rdi,%r15
    161f:	shufps $0xe0,%xmm2,%xmm2
    1623:	movq   %xmm2,%xmm2
    1627:	movq   0x0(%rbp,%r13,4),%xmm1
    162e:	mulps  %xmm2,%xmm1
    1631:	movq   (%r14,%r15,4),%xmm2
    1637:	movq   %xmm1,%xmm1
    163b:	addps  %xmm2,%xmm1
    163e:	movlps %xmm1,(%r14,%r15,4)
    1643:	mov    0x78(%rsp),%r15
    1648:	test   $0x1,%r15b
    164c:	je     167e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb0e>
    164e:	mov    %r15,%rbp
    1651:	and    $0xfffffffffffffffe,%rbp
    1655:	add    %rbp,%rsi
    1658:	mov    0xc0(%rsp),%r15
    1660:	lea    (%r15,%rsi,1),%r13
    1664:	mov    0x10(%rsp),%r15
    1669:	add    %r9,%rsi
    166c:	mulss  (%r15,%rsi,4),%xmm0
    1672:	addss  (%r14,%r13,4),%xmm0
    1678:	movss  %xmm0,(%r14,%r13,4)
    167e:	add    $0x4,%rdx
    1682:	cmp    %rbx,%rdx
    1685:	je     1760 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xbf0>
    168b:	sub    %r12,%rcx
    168e:	movss  (%rdx),%xmm0
    1692:	add    %r12,%r8
    1695:	add    0x18(%rsp),%r9
    169a:	cmp    $0x8,%rcx
    169e:	ja     156c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x9fc>
    16a4:	mov    0x88(%rsp),%r15
    16ac:	mov    0x90(%rsp),%rbp
    16b4:	mov    %rax,0x78(%rsp)
    16b9:	mov    0xa0(%rsp),%r13
    16c1:	mov    %r8,%rsi
    16c4:	nopl   0x0(%rax,%rax,1)
    16c9:	data16 cs nopw 0x0(%rax,%rax,1)
    16d4:	data16 cs nopw 0x0(%rax,%rax,1)
    16df:	data16 cs nopw 0x0(%rax,%rax,1)
    16ea:	data16 cs nopw 0x0(%rax,%rax,1)
    16f5:	data16 cs nopw 0x0(%rax,%rax,1)
    1700:	movss  (%rsi),%xmm1
    1704:	add    $0x4,%r13
    1708:	add    $0x4,%rsi
    170c:	mulss  %xmm0,%xmm1
    1710:	addss  -0x4(%r13),%xmm1
    1716:	movss  %xmm1,-0x4(%r13)
    171c:	cmp    0x80(%rsp),%r13
    1724:	jne    1700 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xb90>
    1726:	add    $0x4,%rdx
    172a:	mov    0x78(%rsp),%rax
    172f:	add    %r12,%r8
    1732:	sub    %r12,%rcx
    1735:	add    0x18(%rsp),%r9
    173a:	cmp    %rbx,%rdx
    173d:	jne    1544 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x9d4>
    1743:	jmp    1770 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xc00>
    1745:	nopl   (%rax)
    1748:	mov    %rax,0x78(%rsp)
    174d:	mov    %r10,%rsi
    1750:	xor    %r15d,%r15d
    1753:	mov    %r10,%r13
    1756:	jmp    1611 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xaa1>
    175b:	nopl   0x0(%rax,%rax,1)
    1760:	mov    0x88(%rsp),%r15
    1768:	mov    0x90(%rsp),%rbp
    1770:	addq   $0x1,0x40(%rsp)
    1776:	add    0xe0(%rsp),%rbx
    177e:	add    %r12,%r11
    1781:	add    %r12,0x80(%rsp)
    1789:	mov    0x40(%rsp),%rsi
    178e:	add    0x18(%rsp),%rdi
    1793:	cmp    0x20(%rsp),%rsi
    1798:	je     13f7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x887>
    179e:	lea    0x0(,%rdi,4),%rsi
    17a6:	jmp    1500 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x990>
    17ab:	mov    0x138(%rsp),%rbx
    17b3:	mov    0x140(%rsp),%r14
    17bb:	mov    0x148(%rsp),%r15
    17c3:	cmp    %r14,0x20(%rsp)
    17c8:	jb     1315 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x7a5>
    17ce:	mov    %r12,%r13
    17d1:	mov    0x60(%rsp),%r9
    17d6:	mov    0x18(%rsp),%r11
    17db:	mov    0x130(%rsp),%r12
    17e3:	cmp    0x8(%rsp),%r9
    17e8:	jb     129b <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x72b>
    17ee:	mov    0x128(%rsp),%rbp
    17f6:	cmp    %r11,0x28(%rsp)
    17fb:	jb     125d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6ed>
    1801:	cmp    %r12,%r14
    1804:	jb     1238 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x6c8>
    180a:	jmp    11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
    180f:	nop
    1810:	mov    0x88(%rsp),%rbp
    1818:	mov    %r11,%rcx
    181b:	xor    %ebx,%ebx
    181d:	jmp    104a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x4da>
    1822:	nopw   0x0(%rax,%rax,1)
    1828:	mov    0x98(%rsp),%rbp
    1830:	mov    0xa0(%rsp),%r9
    1838:	mov    0x90(%rsp),%rbx
    1840:	addq   $0x1,0x60(%rsp)
    1846:	add    0xc0(%rsp),%r10
    184e:	add    %r13,%r8
    1851:	add    %r13,0x70(%rsp)
    1856:	mov    0x60(%rsp),%rax
    185b:	add    0x18(%rsp),%r15
    1860:	cmp    0x40(%rsp),%rax
    1865:	je     18b2 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd42>
    1867:	lea    0x0(,%r15,4),%rsi
    186f:	jmp    f50 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x3e0>
    1874:	mov    0x108(%rsp),%rbp
    187c:	mov    0x110(%rsp),%r12
    1884:	mov    0x120(%rsp),%r13
    188c:	mov    0x128(%rsp),%r15
    1894:	mov    0x130(%rsp),%rbx
    189c:	cmp    %rbp,0x40(%rsp)
    18a1:	jae    18ba <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xd4a>
    18a3:	mov    0x40(%rsp),%rax
    18a8:	mov    %rax,0x30(%rsp)
    18ad:	jmp    d65 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1f5>
    18b2:	mov    %r9,%rbp
    18b5:	jmp    e5d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x2ed>
    18ba:	mov    0x8(%rsp),%rsi
    18bf:	mov    %r14,%r10
    18c2:	cmp    %rsi,0x28(%rsp)
    18c7:	jb     cf3 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x183>
    18cd:	mov    %r12,%r13
    18d0:	mov    %r15,%r14
    18d3:	mov    %rbx,%r12
    18d6:	mov    0x18(%rsp),%rbx
    18db:	cmp    %rbx,0x20(%rsp)
    18e0:	jb     cba <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x14a>
    18e6:	mov    %rbp,%r15
    18e9:	mov    %r10,%r11
    18ec:	mov    %r12,%rbp
    18ef:	cmp    %rbp,%r15
    18f2:	jb     c89 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x119>
    18f8:	jmp    11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
    18fd:	cmp    $0x1,%ebx
    1900:	jne    24c7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1957>
    1906:	mov    0x8(%rsp),%rax
    190b:	lea    0x0(,%r15,4),%r10
    1913:	mov    %r15,%r11
    1916:	xor    %r15d,%r15d
    1919:	shl    $0x2,%rax
    191d:	mov    %rax,0xe0(%rsp)
    1925:	mov    %r12,%rax
    1928:	mov    %r15,%rdx
    192b:	sub    %r15,%rax
    192e:	cmp    %r14,%rax
    1931:	cmova  %r14,%rax
    1935:	add    %rax,%r15
    1938:	cmp    %r15,%rdx
    193b:	jae    1ee8 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1378>
    1941:	movq   $0x0,0x18(%rsp)
    194a:	mov    %rdx,%rbp
    194d:	mov    0x18(%rsp),%rbx
    1952:	mov    0x48(%rsp),%rsi
    1957:	mov    %r11,%rax
    195a:	sub    %rbx,%rax
    195d:	mov    %rbx,%rcx
    1960:	cmp    %rsi,%rax
    1963:	cmova  %rsi,%rax
    1967:	add    %rax,%rbx
    196a:	mov    %rbx,0x18(%rsp)
    196f:	cmp    %rbx,%rcx
    1972:	jae    1edd <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x136d>
    1978:	movq   $0x0,0x20(%rsp)
    1981:	mov    %r12,%rdx
    1984:	mov    %rcx,%rbx
    1987:	mov    %r14,%r12
    198a:	mov    %r13,%r14
    198d:	mov    %r10,%r13
    1990:	mov    %r11,%r10
    1993:	mov    0x20(%rsp),%rcx
    1998:	mov    0x8(%rsp),%rax
    199d:	mov    %r12,%rdi
    19a0:	mov    %rbp,0x28(%rsp)
    19a5:	mov    0x50(%rsp),%rsi
    19aa:	mov    %rbp,0x128(%rsp)
    19b2:	mov    %r10,%r12
    19b5:	mov    %r14,%rbp
    19b8:	sub    %rcx,%rax
    19bb:	mov    %rcx,0x88(%rsp)
    19c3:	mov    %r13,%r14
    19c6:	cmp    %rsi,%rax
    19c9:	cmova  %rsi,%rax
    19cd:	mov    %rax,%r9
    19d0:	mov    %rcx,%rax
    19d3:	lea    (%rcx,%r9,1),%rsi
    19d7:	mov    %r9,0x120(%rsp)
    19df:	imul   %r10,%rcx
    19e3:	mov    %rsi,0x20(%rsp)
    19e8:	mov    %rcx,0x58(%rsp)
    19ed:	mov    %rax,%rcx
    19f0:	sub    %rsi,%rax
    19f3:	imul   %r13,%rcx
    19f7:	lea    0x0(,%rax,4),%rax
    19ff:	mov    %rdx,%r13
    1a02:	mov    %rax,0xe8(%rsp)
    1a0a:	mov    %rcx,0xf8(%rsp)
    1a12:	mov    0x28(%rsp),%rsi
    1a17:	mov    %r15,%rdx
    1a1a:	mov    $0x4,%eax
    1a1f:	mov    %rbx,%r9
    1a22:	mov    0x38(%rsp),%rcx
    1a27:	mov    %rbx,0x138(%rsp)
    1a2f:	sub    %rsi,%rdx
    1a32:	mov    %rsi,%r11
    1a35:	mov    0x18(%rsp),%r10
    1a3a:	mov    %r15,0x130(%rsp)
    1a42:	cmp    %rax,%rdx
    1a45:	mov    %r11,%rbx
    1a48:	cmovbe %rdx,%rax
    1a4c:	add    %rax,%rsi
    1a4f:	cmp    $0x3,%rdx
    1a53:	mov    %r12,%rax
    1a56:	seta   0xb0(%rsp)
    1a5e:	imul   %r11,%rax
    1a62:	mov    %rsi,0x28(%rsp)
    1a67:	mov    0x88(%rsp),%rsi
    1a6f:	mov    %rax,0x78(%rsp)
    1a74:	mov    0x8(%rsp),%rax
    1a79:	imul   %r11,%rax
    1a7d:	lea    (%rax,%rsi,1),%rdx
    1a81:	add    0x20(%rsp),%rax
    1a86:	lea    (%rcx,%rax,4),%rax
    1a8a:	lea    (%rcx,%rdx,4),%rsi
    1a8e:	mov    %rax,0xd8(%rsp)
    1a96:	mov    %r13,%rax
    1a99:	mov    %rdi,%r13
    1a9c:	mov    %rsi,0xb8(%rsp)
    1aa4:	jmp    1b0f <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf9f>
    1aa6:	cmpb   $0x0,0xb0(%rsp)
    1aae:	je     1b34 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xfc4>
    1ab4:	mov    %rax,0x30(%rsp)
    1ab9:	mov    0x78(%rsp),%rax
    1abe:	mov    %r12,%rcx
    1ac1:	mov    0x8(%rsp),%r8
    1ac6:	mov    0xb8(%rsp),%rdi
    1ace:	lea    (%rax,%r9,1),%rdx
    1ad2:	mov    0x10(%rsp),%rax
    1ad7:	add    0x58(%rsp),%r9
    1adc:	lea    0x0(%rbp,%rdx,4),%rdx
    1ae1:	lea    (%rax,%r9,4),%rsi
    1ae5:	mov    0x120(%rsp),%r9
    1aed:	call   90 <void mini_gpu::(anonymous namespace)::microkernel<4ul, 8ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    1af2:	mov    0x30(%rsp),%rax
    1af7:	mov    0x18(%rsp),%rsi
    1afc:	cmp    %rsi,0x60(%rsp)
    1b01:	jae    1e86 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1316>
    1b07:	mov    0x60(%rsp),%r9
    1b0c:	mov    %rsi,%r10
    1b0f:	sub    %r9,%r10
    1b12:	mov    $0x8,%edx
    1b17:	cmp    %rdx,%r10
    1b1a:	cmovbe %r10,%rdx
    1b1e:	lea    (%rdx,%r9,1),%rdi
    1b22:	mov    %rdx,%r15
    1b25:	mov    %rdi,0x60(%rsp)
    1b2a:	cmp    $0x7,%r10
    1b2e:	ja     1aa6 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf36>
    1b34:	cmp    0x28(%rsp),%rbx
    1b39:	jae    1af7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf87>
    1b3b:	mov    0x20(%rsp),%rdx
    1b40:	cmp    %rdx,0x88(%rsp)
    1b48:	jae    1af7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf87>
    1b4a:	mov    0x60(%rsp),%rdx
    1b4f:	cmp    %rdx,%r9
    1b52:	jae    1af7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf87>
    1b54:	mov    0x78(%rsp),%rcx
    1b59:	mov    %rbx,0x68(%rsp)
    1b5e:	mov    %rbx,%rsi
    1b61:	mov    %rax,%rbx
    1b64:	add    %rcx,%rdx
    1b67:	lea    (%rcx,%r9,1),%r11
    1b6b:	lea    0x0(%rbp,%rdx,4),%rcx
    1b70:	mov    0x58(%rsp),%rdx
    1b75:	lea    0x0(%rbp,%r11,4),%rdi
    1b7a:	mov    %rcx,0x70(%rsp)
    1b7f:	mov    0x10(%rsp),%rcx
    1b84:	add    %r9,%rdx
    1b87:	lea    (%rcx,%rdx,4),%rdx
    1b8b:	mov    %rdx,0xf0(%rsp)
    1b93:	mov    0xf8(%rsp),%rdx
    1b9b:	add    %rcx,%rdx
    1b9e:	lea    -0x1(%r15),%rcx
    1ba2:	mov    %rcx,0xd0(%rsp)
    1baa:	mov    0xd8(%rsp),%rcx
    1bb2:	lea    (%rdx,%r9,4),%rdx
    1bb6:	mov    %rcx,0x30(%rsp)
    1bbb:	mov    $0xfffffffffffffffc,%rcx
    1bc2:	sub    %rdx,%rcx
    1bc5:	mov    %r15,%rdx
    1bc8:	mov    %rcx,0x100(%rsp)
    1bd0:	mov    %r15,%rcx
    1bd3:	shr    $0x2,%rdx
    1bd7:	and    $0xfffffffffffffffc,%rcx
    1bdb:	mov    %rdx,0x110(%rsp)
    1be3:	lea    0x0(,%r11,4),%rdx
    1beb:	mov    %rcx,0x90(%rsp)
    1bf3:	add    %r9,%rcx
    1bf6:	mov    %rcx,0x118(%rsp)
    1bfe:	xchg   %ax,%ax
    1c00:	mov    0x100(%rsp),%rcx
    1c08:	add    %rbp,%rdx
    1c0b:	mov    %r11,%rax
    1c0e:	mov    0x58(%rsp),%r8
    1c13:	mov    %rdx,0xc8(%rsp)
    1c1b:	sub    %r9,%rax
    1c1e:	add    %rdi,%rcx
    1c21:	mov    %rax,0xc0(%rsp)
    1c29:	mov    0x30(%rsp),%rax
    1c2e:	mov    %rcx,0x40(%rsp)
    1c33:	mov    0xf0(%rsp),%rcx
    1c3b:	mov    %r13,0x98(%rsp)
    1c43:	add    0xe8(%rsp),%rax
    1c4b:	mov    %rbx,%r13
    1c4e:	mov    %rsi,%rbx
    1c51:	movss  (%rax),%xmm0
    1c55:	cmp    $0x1,%r10
    1c59:	je     1db3 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1243>
    1c5f:	mov    %r15,%rsi
    1c62:	sub    0x90(%rsp),%rsi
    1c6a:	mov    %r10,0xa0(%rsp)
    1c72:	mov    %rsi,0x108(%rsp)
    1c7a:	mov    %rbx,0xa8(%rsp)
    1c82:	cmpq   $0x8,0x40(%rsp)
    1c88:	jbe    1da3 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1233>
    1c8e:	cmpq   $0x2,0xd0(%rsp)
    1c97:	jbe    1e10 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12a0>
    1c9d:	mov    $0x20,%esi
    1ca2:	mov    $0x10,%ebx
    1ca7:	movaps %xmm0,%xmm2
    1caa:	cmpq   $0x1,0x110(%rsp)
    1cb3:	cmove  %rbx,%rsi
    1cb7:	xor    %edx,%edx
    1cb9:	shufps $0x0,%xmm2,%xmm2
    1cbd:	nopl   (%rax)
    1cc0:	movups (%rcx,%rdx,1),%xmm1
    1cc4:	movups (%rdi,%rdx,1),%xmm4
    1cc8:	mulps  %xmm2,%xmm1
    1ccb:	addps  %xmm4,%xmm1
    1cce:	movups %xmm1,(%rdi,%rdx,1)
    1cd2:	add    $0x10,%rdx
    1cd6:	cmp    %rsi,%rdx
    1cd9:	jne    1cc0 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1150>
    1cdb:	test   $0x3,%r15b
    1cdf:	je     1d79 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1209>
    1ce5:	mov    0x118(%rsp),%rdx
    1ced:	mov    0x108(%rsp),%rbx
    1cf5:	mov    0x90(%rsp),%r10
    1cfd:	mov    %rbx,0x80(%rsp)
    1d05:	mov    %rdx,%rsi
    1d08:	cmp    $0x1,%rbx
    1d0c:	je     1d54 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x11e4>
    1d0e:	mov    0x10(%rsp),%rbx
    1d13:	add    %r8,%rsi
    1d16:	movaps %xmm0,%xmm2
    1d19:	add    %r11,%r10
    1d1c:	shufps $0xe0,%xmm2,%xmm2
    1d20:	movq   %xmm2,%xmm2
    1d24:	movq   (%rbx,%rsi,4),%xmm1
    1d29:	mov    0x80(%rsp),%rbx
    1d31:	mulps  %xmm2,%xmm1
    1d34:	movq   0x0(%rbp,%r10,4),%xmm2
    1d3b:	movq   %xmm1,%xmm1
    1d3f:	addps  %xmm2,%xmm1
    1d42:	movlps %xmm1,0x0(%rbp,%r10,4)
    1d48:	test   $0x1,%bl
    1d4b:	je     1d79 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1209>
    1d4d:	and    $0xfffffffffffffffe,%rbx
    1d51:	add    %rbx,%rdx
    1d54:	mov    0xc0(%rsp),%rbx
    1d5c:	lea    (%rbx,%rdx,1),%rsi
    1d60:	mov    0x10(%rsp),%rbx
    1d65:	add    %r8,%rdx
    1d68:	mulss  (%rbx,%rdx,4),%xmm0
    1d6d:	addss  0x0(%rbp,%rsi,4),%xmm0
    1d73:	movss  %xmm0,0x0(%rbp,%rsi,4)
    1d79:	add    $0x4,%rax
    1d7d:	cmp    %rax,0x30(%rsp)
    1d82:	je     1e30 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12c0>
    1d88:	sub    %r14,0x40(%rsp)
    1d8d:	movss  (%rax),%xmm0
    1d91:	add    %r14,%rcx
    1d94:	add    %r12,%r8
    1d97:	cmpq   $0x8,0x40(%rsp)
    1d9d:	ja     1c8e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x111e>
    1da3:	mov    0xa0(%rsp),%r10
    1dab:	mov    0xa8(%rsp),%rbx
    1db3:	mov    0xc8(%rsp),%rsi
    1dbb:	mov    %rcx,%rdx
    1dbe:	xchg   %ax,%ax
    1dc0:	movss  (%rdx),%xmm1
    1dc4:	add    $0x4,%rsi
    1dc8:	add    $0x4,%rdx
    1dcc:	mulss  %xmm0,%xmm1
    1dd0:	addss  -0x4(%rsi),%xmm1
    1dd5:	movss  %xmm1,-0x4(%rsi)
    1dda:	cmp    %rsi,0x70(%rsp)
    1ddf:	jne    1dc0 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1250>
    1de1:	sub    %r14,0x40(%rsp)
    1de6:	add    $0x4,%rax
    1dea:	add    %r14,%rcx
    1ded:	add    %r12,%r8
    1df0:	cmp    0x30(%rsp),%rax
    1df5:	jne    1c51 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x10e1>
    1dfb:	mov    %rbx,%rsi
    1dfe:	mov    %r13,%rbx
    1e01:	mov    0x98(%rsp),%r13
    1e09:	jmp    1e4b <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x12db>
    1e0b:	nopl   0x0(%rax,%rax,1)
    1e10:	mov    %r15,0x80(%rsp)
    1e18:	mov    %r9,%rdx
    1e1b:	xor    %r10d,%r10d
    1e1e:	mov    %r9,%rsi
    1e21:	jmp    1d0e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x119e>
    1e26:	cs nopw 0x0(%rax,%rax,1)
    1e30:	mov    %r13,%rbx
    1e33:	mov    0xa0(%rsp),%r10
    1e3b:	mov    0xa8(%rsp),%rsi
    1e43:	mov    0x98(%rsp),%r13
    1e4b:	addq   $0x1,0x68(%rsp)
    1e51:	add    %r14,%rdi
    1e54:	mov    0x68(%rsp),%rax
    1e59:	add    %r12,%r11
    1e5c:	mov    0xe0(%rsp),%rcx
    1e64:	add    %r14,0x70(%rsp)
    1e69:	add    %rcx,0x30(%rsp)
    1e6e:	cmp    0x28(%rsp),%rax
    1e73:	je     1f00 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1390>
    1e79:	lea    0x0(,%r11,4),%rdx
    1e81:	jmp    1c00 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1090>
    1e86:	mov    %r13,%rdi
    1e89:	mov    0x130(%rsp),%r15
    1e91:	mov    %rax,%r13
    1e94:	mov    0x138(%rsp),%rbx
    1e9c:	cmp    %r15,0x28(%rsp)
    1ea1:	jb     1a12 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xea2>
    1ea7:	mov    %r13,%rdx
    1eaa:	mov    %r12,%r10
    1ead:	mov    %r14,%r13
    1eb0:	mov    %rdi,%r12
    1eb3:	mov    %rbp,%r14
    1eb6:	mov    0x8(%rsp),%rdi
    1ebb:	mov    0x128(%rsp),%rbp
    1ec3:	cmp    %rdi,0x20(%rsp)
    1ec8:	jb     1993 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xe23>
    1ece:	mov    %r10,%r11
    1ed1:	mov    %r13,%r10
    1ed4:	mov    %r14,%r13
    1ed7:	mov    %r12,%r14
    1eda:	mov    %rdx,%r12
    1edd:	cmp    %r11,0x18(%rsp)
    1ee2:	jb     194d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xddd>
    1ee8:	cmp    %r12,%r15
    1eeb:	jb     1925 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xdb5>
    1ef1:	jmp    11cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x65c>
    1ef6:	cs nopw 0x0(%rax,%rax,1)
    1f00:	mov    %rbx,%rax
    1f03:	mov    %rsi,%rbx
    1f06:	jmp    1af7 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0xf87>
    1f0b:	cmp    $0x3,%ebx
    1f0e:	jne    24cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x195c>
    1f14:	mov    0x8(%rsp),%rax
    1f19:	lea    0x0(,%r15,4),%r10
    1f21:	mov    %r13,%r11
    1f24:	mov    %r10,0x30(%rsp)
    1f29:	mov    %r15,%r10
    1f2c:	xor    %r15d,%r15d
    1f2f:	shl    $0x2,%rax
    1f33:	mov    %rax,0xc8(%rsp)
    1f3b:	mov    %r12,%rax
    1f3e:	mov    %r15,%rdx
    1f41:	sub    %r15,%rax
    1f44:	cmp    %r14,%rax
    1f47:	cmova  %r14,%rax
    1f4b:	add    %rax,%r15
    1f4e:	cmp    %r15,%rdx
    1f51:	jae    11c3 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x653>
    1f57:	movq   $0x0,0x28(%rsp)
    1f60:	mov    %r15,%rbp
    1f63:	mov    %rdx,%r13
    1f66:	mov    %r12,%r15
    1f69:	mov    %r10,%r12
    1f6c:	mov    %r11,%r10
    1f6f:	mov    0x28(%rsp),%rsi
    1f74:	mov    0x48(%rsp),%rbx
    1f79:	mov    %r12,%rax
    1f7c:	sub    %rsi,%rax
    1f7f:	mov    %rsi,%rcx
    1f82:	cmp    %rbx,%rax
    1f85:	cmova  %rbx,%rax
    1f89:	add    %rax,%rsi
    1f8c:	mov    %rsi,0x28(%rsp)
    1f91:	cmp    %rsi,%rcx
    1f94:	jae    11ac <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x63c>
    1f9a:	movq   $0x0,0x18(%rsp)
    1fa3:	mov    %rbp,%rbx
    1fa6:	mov    %r13,%rdx
    1fa9:	mov    %r14,%rbp
    1fac:	mov    %r12,%r13
    1faf:	mov    %rcx,%r14
    1fb2:	mov    %r10,%r12
    1fb5:	mov    0x18(%rsp),%rcx
    1fba:	mov    0x8(%rsp),%rax
    1fbf:	mov    %rdx,0x20(%rsp)
    1fc4:	mov    0x50(%rsp),%rdi
    1fc9:	mov    %rdx,0x108(%rsp)
    1fd1:	sub    %rcx,%rax
    1fd4:	mov    %rcx,%r8
    1fd7:	cmp    %rdi,%rax
    1fda:	mov    %r8,0x78(%rsp)
    1fdf:	cmova  %rdi,%rax
    1fe3:	mov    0x10(%rsp),%rdi
    1fe8:	add    %rax,%rcx
    1feb:	mov    %rax,%r9
    1fee:	mov    %r13,%rax
    1ff1:	imul   %r8,%rax
    1ff5:	mov    %rcx,0x18(%rsp)
    1ffa:	mov    %r9,0x100(%rsp)
    2002:	mov    %rax,0x40(%rsp)
    2007:	mov    %r8,%rax
    200a:	sub    %rcx,%rax
    200d:	lea    0x0(,%rax,4),%rax
    2015:	mov    %rax,0xd8(%rsp)
    201d:	mov    0x30(%rsp),%rax
    2022:	imul   %r8,%rax
    2026:	add    %rdi,%rax
    2029:	mov    %r14,%rdi
    202c:	mov    %rax,0xf8(%rsp)
    2034:	mov    %r13,%rax
    2037:	mov    %r12,%r13
    203a:	mov    %rax,%r12
    203d:	mov    0x20(%rsp),%rsi
    2042:	mov    %rbx,%rdx
    2045:	mov    $0x8,%eax
    204a:	mov    %rdi,%r9
    204d:	mov    %rbx,0x110(%rsp)
    2055:	mov    0x28(%rsp),%r11
    205a:	sub    %rsi,%rdx
    205d:	mov    %rsi,%r8
    2060:	mov    %rdi,0x118(%rsp)
    2068:	cmp    %rax,%rdx
    206b:	mov    %rbp,0x120(%rsp)
    2073:	mov    %r8,%rbx
    2076:	cmovbe %rdx,%rax
    207a:	mov    %r15,0x128(%rsp)
    2082:	add    %rax,%rsi
    2085:	cmp    $0x7,%rdx
    2089:	mov    %r12,%rax
    208c:	seta   0xa0(%rsp)
    2094:	imul   %r8,%rax
    2098:	mov    %rsi,0x20(%rsp)
    209d:	mov    0x78(%rsp),%rsi
    20a2:	mov    %rax,0x68(%rsp)
    20a7:	mov    0x8(%rsp),%rax
    20ac:	imul   %r8,%rax
    20b0:	lea    (%rax,%rsi,1),%rdx
    20b4:	mov    0x38(%rsp),%rsi
    20b9:	add    0x18(%rsp),%rax
    20be:	lea    (%rsi,%rdx,4),%rdx
    20c2:	lea    (%rsi,%rax,4),%rax
    20c6:	mov    %rdx,0xa8(%rsp)
    20ce:	mov    %rax,0xd0(%rsp)
    20d6:	jmp    2132 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15c2>
    20d8:	cmpb   $0x0,0xa0(%rsp)
    20e0:	je     2150 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15e0>
    20e2:	mov    0x68(%rsp),%rax
    20e7:	mov    0x8(%rsp),%r8
    20ec:	mov    %r12,%rcx
    20ef:	mov    0xa8(%rsp),%rdi
    20f7:	add    %r9,%rax
    20fa:	add    0x40(%rsp),%r9
    20ff:	lea    0x0(%r13,%rax,4),%rdx
    2104:	mov    0x10(%rsp),%rax
    2109:	lea    (%rax,%r9,4),%rsi
    210d:	mov    0x100(%rsp),%r9
    2115:	call   450 <void mini_gpu::(anonymous namespace)::microkernel<8ul, 16ul>(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>
    211a:	mov    0x28(%rsp),%rdi
    211f:	cmp    %rdi,0x60(%rsp)
    2124:	jae    114e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x5de>
    212a:	mov    0x60(%rsp),%r9
    212f:	mov    %rdi,%r11
    2132:	sub    %r9,%r11
    2135:	mov    $0x10,%eax
    213a:	cmp    %rax,%r11
    213d:	cmovbe %r11,%rax
    2141:	lea    (%rax,%r9,1),%rdi
    2145:	mov    %rdi,0x60(%rsp)
    214a:	cmp    $0xf,%r11
    214e:	ja     20d8 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1568>
    2150:	cmp    0x20(%rsp),%rbx
    2155:	jae    211a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15aa>
    2157:	mov    0x18(%rsp),%rsi
    215c:	cmp    %rsi,0x78(%rsp)
    2161:	jae    211a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15aa>
    2163:	mov    0x60(%rsp),%rdi
    2168:	cmp    %rdi,%r9
    216b:	jae    211a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15aa>
    216d:	mov    0x68(%rsp),%rsi
    2172:	mov    %rbx,0x58(%rsp)
    2177:	mov    %rbx,%r8
    217a:	mov    $0xfffffffffffffffc,%rbp
    2181:	mov    %rax,0x80(%rsp)
    2189:	mov    0xd0(%rsp),%r10
    2191:	mov    %r11,%rbx
    2194:	lea    (%rsi,%rdi,1),%rdx
    2198:	lea    (%rsi,%r9,1),%r14
    219c:	mov    0x10(%rsp),%rsi
    21a1:	lea    0x0(%r13,%rdx,4),%rdi
    21a6:	mov    0x40(%rsp),%rdx
    21ab:	lea    0x0(,%r14,4),%rcx
    21b3:	mov    %rdi,0x70(%rsp)
    21b8:	lea    0x0(%r13,%rcx,1),%r15
    21bd:	add    %r9,%rdx
    21c0:	lea    (%rsi,%rdx,4),%rdi
    21c4:	mov    0xf8(%rsp),%rdx
    21cc:	lea    -0x1(%rax),%rsi
    21d0:	mov    %rdi,0xc0(%rsp)
    21d8:	mov    %rax,%rdi
    21db:	lea    (%rdx,%r9,4),%rdx
    21df:	and    $0xfffffffffffffffc,%rdi
    21e3:	mov    %rsi,0xb8(%rsp)
    21eb:	sub    %rdx,%rbp
    21ee:	mov    %rax,%rdx
    21f1:	mov    %rdi,0xe8(%rsp)
    21f9:	mov    %rax,%rdi
    21fc:	shr    $0x2,%rdx
    2200:	and    $0x3,%edi
    2203:	mov    %rbp,%r11
    2206:	shl    $0x4,%rdx
    220a:	mov    %rdi,0xf0(%rsp)
    2212:	mov    %rdx,0xe0(%rsp)
    221a:	nopw   0x0(%rax,%rax,1)
    2220:	mov    %r14,%rax
    2223:	lea    0x0(%r13,%rcx,1),%rbp
    2228:	mov    0x40(%rsp),%rdi
    222d:	mov    0xc0(%rsp),%rsi
    2235:	sub    %r9,%rax
    2238:	mov    %r11,0x88(%rsp)
    2240:	mov    %rax,0xb0(%rsp)
    2248:	mov    0xd8(%rsp),%rax
    2250:	lea    (%r10,%rax,1),%rdx
    2254:	lea    (%r11,%r15,1),%rax
    2258:	mov    %rbx,%r11
    225b:	mov    %rbp,%rbx
    225e:	movss  (%rdx),%xmm0
    2262:	cmp    $0x1,%r11
    2266:	je     23be <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x184e>
    226c:	mov    %r11,0x90(%rsp)
    2274:	mov    %r8,0x98(%rsp)
    227c:	mov    %rbx,0x130(%rsp)
    2284:	cmp    $0x8,%rax
    2288:	jbe    23a6 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1836>
    228e:	cmpq   $0x2,0xb8(%rsp)
    2297:	jbe    2458 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x18e8>
    229d:	movaps %xmm0,%xmm2
    22a0:	xor    %ecx,%ecx
    22a2:	shufps $0x0,%xmm2,%xmm2
    22a6:	nopl   0x0(%rax)
    22aa:	data16 cs nopw 0x0(%rax,%rax,1)
    22b5:	data16 cs nopw 0x0(%rax,%rax,1)
    22c0:	movups (%rsi,%rcx,1),%xmm1
    22c4:	movups (%r15,%rcx,1),%xmm6
    22c9:	mulps  %xmm2,%xmm1
    22cc:	addps  %xmm6,%xmm1
    22cf:	movups %xmm1,(%r15,%rcx,1)
    22d4:	add    $0x10,%rcx
    22d8:	cmp    0xe0(%rsp),%rcx
    22e0:	jne    22c0 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1750>
    22e2:	testb  $0x3,0x80(%rsp)
    22ea:	je     237d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x180d>
    22f0:	mov    0xe8(%rsp),%rbx
    22f8:	mov    %rbx,%rbp
    22fb:	lea    (%r9,%rbx,1),%rcx
    22ff:	mov    0xf0(%rsp),%rbx
    2307:	mov    %rbx,%r8
    230a:	cmp    $0x1,%rbx
    230e:	je     2356 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x17e6>
    2310:	lea    (%rdi,%r9,1),%r11
    2314:	lea    (%r14,%rbp,1),%rbx
    2318:	movaps %xmm0,%xmm2
    231b:	add    %rbp,%r11
    231e:	mov    0x10(%rsp),%rbp
    2323:	shufps $0xe0,%xmm2,%xmm2
    2327:	movq   %xmm2,%xmm2
    232b:	movq   0x0(%rbp,%r11,4),%xmm1
    2332:	mulps  %xmm2,%xmm1
    2335:	movq   0x0(%r13,%rbx,4),%xmm2
    233c:	movq   %xmm1,%xmm1
    2340:	addps  %xmm2,%xmm1
    2343:	movlps %xmm1,0x0(%r13,%rbx,4)
    2349:	test   $0x1,%r8b
    234d:	je     237d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x180d>
    234f:	and    $0xfffffffffffffffe,%r8
    2353:	add    %r8,%rcx
    2356:	mov    0xb0(%rsp),%rbx
    235e:	lea    (%rbx,%rcx,1),%r11
    2362:	mov    0x10(%rsp),%rbx
    2367:	add    %rdi,%rcx
    236a:	mulss  (%rbx,%rcx,4),%xmm0
    236f:	addss  0x0(%r13,%r11,4),%xmm0
    2376:	movss  %xmm0,0x0(%r13,%r11,4)
    237d:	add    $0x4,%rdx
    2381:	cmp    %r10,%rdx
    2384:	je     2470 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1900>
    238a:	mov    0x30(%rsp),%rbx
    238f:	movss  (%rdx),%xmm0
    2393:	add    %r12,%rdi
    2396:	sub    %rbx,%rax
    2399:	add    %rbx,%rsi
    239c:	cmp    $0x8,%rax
    23a0:	ja     228e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x171e>
    23a6:	mov    0x90(%rsp),%r11
    23ae:	mov    0x98(%rsp),%r8
    23b6:	mov    0x130(%rsp),%rbx
    23be:	mov    %rax,0x90(%rsp)
    23c6:	mov    %rsi,%rcx
    23c9:	mov    %rbx,%rbp
    23cc:	nopl   0x0(%rax,%rax,1)
    23d4:	data16 cs nopw 0x0(%rax,%rax,1)
    23df:	data16 cs nopw 0x0(%rax,%rax,1)
    23ea:	data16 cs nopw 0x0(%rax,%rax,1)
    23f5:	data16 cs nopw 0x0(%rax,%rax,1)
    2400:	movss  (%rcx),%xmm1
    2404:	add    $0x4,%rbp
    2408:	add    $0x4,%rcx
    240c:	mulss  %xmm0,%xmm1
    2410:	addss  -0x4(%rbp),%xmm1
    2415:	movss  %xmm1,-0x4(%rbp)
    241a:	cmp    0x70(%rsp),%rbp
    241f:	jne    2400 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1890>
    2421:	mov    0x30(%rsp),%rcx
    2426:	mov    0x90(%rsp),%rax
    242e:	add    $0x4,%rdx
    2432:	add    %r12,%rdi
    2435:	add    %rcx,%rsi
    2438:	sub    %rcx,%rax
    243b:	cmp    %r10,%rdx
    243e:	jne    225e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x16ee>
    2444:	mov    %r11,%rbx
    2447:	mov    0x88(%rsp),%r11
    244f:	jmp    2488 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1918>
    2451:	nopl   0x0(%rax)
    2458:	mov    0x80(%rsp),%r8
    2460:	mov    %r9,%rcx
    2463:	xor    %ebp,%ebp
    2465:	jmp    2310 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x17a0>
    246a:	nopw   0x0(%rax,%rax,1)
    2470:	mov    0x90(%rsp),%rbx
    2478:	mov    0x98(%rsp),%r8
    2480:	mov    0x88(%rsp),%r11
    2488:	mov    0x30(%rsp),%rdi
    248d:	addq   $0x1,0x58(%rsp)
    2493:	add    %r12,%r14
    2496:	add    %rdi,0x70(%rsp)
    249b:	mov    0x58(%rsp),%rax
    24a0:	add    0xc8(%rsp),%r10
    24a8:	add    %rdi,%r15
    24ab:	cmp    0x20(%rsp),%rax
    24b0:	je     24bf <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x194f>
    24b2:	lea    0x0(,%r14,4),%rcx
    24ba:	jmp    2220 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x16b0>
    24bf:	mov    %r8,%rbx
    24c2:	jmp    211a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x15aa>
    24c7:	jmp    24cc <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x195c>
    24cc:	jmp    24d1 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile)+0x1961>

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x4e>
  4e:	jmp    1c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  50:	mov    $0x10,%edi
  55:	call   5a <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x5a>
  5a:	lea    0x0(%rip),%rsi        # 61 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x61>
  61:	mov    %rax,%rdi
  64:	mov    %rax,%rbx
  67:	call   6c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x6c>
  6c:	jmp    1c <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x1c>
  6e:	endbr64
  72:	mov    %rax,%rbp
  75:	mov    %rbx,%rdi
  78:	call   7d <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x7d>
  7d:	mov    %rbp,%rdi
  80:	call   85 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x85>
  85:	endbr64
  89:	jmp    72 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x72>
  8b:	endbr64
  8f:	jmp    72 <mini_gpu::matmul_cpu_register_blocked_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, mini_gpu::RegisterTile) [clone .cold]+0x72>
