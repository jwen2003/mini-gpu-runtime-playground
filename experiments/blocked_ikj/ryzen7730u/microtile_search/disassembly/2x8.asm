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
