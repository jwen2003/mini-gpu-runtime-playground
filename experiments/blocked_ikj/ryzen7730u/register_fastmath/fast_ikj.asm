<REPO>/build-register/CMakeFiles/matmul_register_fast.dir/src/cpu/ikj.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
   0:	endbr64
   4:	test   %rcx,%rcx
   7:	je     2c3 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2c3>
   d:	test   %r8,%r8
  10:	je     2c3 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2c3>
  16:	push   %r15
  18:	mov    %r9,%r15
  1b:	push   %r14
  1d:	push   %r13
  1f:	push   %r12
  21:	push   %rbp
  22:	mov    %rsi,%rbp
  25:	push   %rbx
  26:	sub    $0x58,%rsp
  2a:	mov    %rcx,0x38(%rsp)
  2f:	mov    %rdx,0x8(%rsp)
  34:	mov    %rdi,0x30(%rsp)
  39:	test   %rdx,%rdx
  3c:	je     42 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x42>
  42:	test   %r9,%r9
  45:	je     270 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x270>
  4b:	cmpq   $0x0,0x30(%rsp)
  51:	je     57 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x57>
  57:	test   %rsi,%rsi
  5a:	je     60 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x60>
  60:	mov    %rcx,%rdx
  63:	lea    0x0(,%r8,4),%rbx
  6b:	imul   %rbx,%rdx
  6f:	test   %rdx,%rdx
  72:	je     88 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x88>
  74:	mov    0x8(%rsp),%rdi
  79:	xor    %esi,%esi
  7b:	mov    %r8,(%rsp)
  7f:	call   84 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x84>
  84:	mov    (%rsp),%r8
  88:	mov    0x30(%rsp),%rdi
  8d:	mov    %r8,%rcx
  90:	lea    -0x1(%r8),%r13
  94:	xor    %r11d,%r11d
  97:	lea    0x0(,%r15,4),%rax
  9f:	mov    $0xfffffffffffffffc,%rdx
  a6:	xor    %r14d,%r14d
  a9:	xor    %r12d,%r12d
  ac:	mov    %rax,0x40(%rsp)
  b1:	add    %rdi,%rax
  b4:	mov    %r8,%rdi
  b7:	sub    %rbp,%rdx
  ba:	and    $0xfffffffffffffffc,%rdi
  be:	mov    %rdx,0x48(%rsp)
  c3:	shr    $0x2,%rcx
  c7:	mov    %rdi,0x10(%rsp)
  cc:	shl    $0x4,%rcx
  d0:	mov    %rax,(%rsp)
  d4:	mov    0x8(%rsp),%rax
  d9:	nopl   0x0(%rax)
  e0:	mov    0x30(%rsp),%rdi
  e5:	mov    0x48(%rsp),%rsi
  ea:	mov    %rbp,%rdx
  ed:	xor    %r9d,%r9d
  f0:	lea    (%rdi,%r11,4),%rdi
  f4:	lea    (%rsi,%rax,1),%r10
  f8:	movss  (%rdi),%xmm2
  fc:	cmp    $0x1,%r8
 100:	je     1fc <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1fc>
 106:	mov    %r12,0x18(%rsp)
 10b:	mov    %r11,0x20(%rsp)
 110:	mov    %r15,0x28(%rsp)
 115:	cmp    $0x8,%r10
 119:	jbe    1ed <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1ed>
 11f:	cmp    $0x2,%r13
 123:	jbe    2b1 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2b1>
 129:	movaps %xmm2,%xmm1
 12c:	xor    %esi,%esi
 12e:	shufps $0x0,%xmm1,%xmm1
 132:	nopl   (%rax)
 135:	data16 cs nopw 0x0(%rax,%rax,1)
 140:	movups (%rdx,%rsi,1),%xmm0
 144:	movups (%rax,%rsi,1),%xmm3
 148:	mulps  %xmm1,%xmm0
 14b:	addps  %xmm3,%xmm0
 14e:	movups %xmm0,(%rax,%rsi,1)
 152:	add    $0x10,%rsi
 156:	cmp    %rsi,%rcx
 159:	jne    140 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x140>
 15b:	test   $0x3,%r8b
 15f:	je     1c8 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1c8>
 161:	mov    0x10(%rsp),%rsi
 166:	mov    %rsi,%r11
 169:	cmp    %r13,%rsi
 16c:	je     1aa <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1aa>
 16e:	mov    %r8,%rsi
 171:	and    $0x3,%esi
 174:	mov    0x8(%rsp),%r15
 179:	lea    (%r11,%r14,1),%r12
 17d:	lea    (%r15,%r12,4),%r12
 181:	lea    (%r9,%r11,1),%r15
 185:	movq   0x0(%rbp,%r15,4),%xmm0
 18c:	mulps  %xmm0,%xmm1
 18f:	movq   (%r12),%xmm0
 195:	addps  %xmm0,%xmm1
 198:	movlps %xmm1,(%r12)
 19d:	test   $0x1,%sil
 1a1:	je     1c8 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1c8>
 1a3:	and    $0xfffffffffffffffe,%rsi
 1a7:	add    %r11,%rsi
 1aa:	lea    (%r14,%rsi,1),%r11
 1ae:	mov    0x8(%rsp),%r15
 1b3:	add    %r9,%rsi
 1b6:	mulss  0x0(%rbp,%rsi,4),%xmm2
 1bc:	addss  (%r15,%r11,4),%xmm2
 1c2:	movss  %xmm2,(%r15,%r11,4)
 1c8:	add    $0x4,%rdi
 1cc:	cmp    %rdi,(%rsp)
 1d0:	je     2a0 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2a0>
 1d6:	sub    %rbx,%r10
 1d9:	movss  (%rdi),%xmm2
 1dd:	add    %r8,%r9
 1e0:	add    %rbx,%rdx
 1e3:	cmp    $0x8,%r10
 1e7:	ja     11f <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x11f>
 1ed:	mov    0x18(%rsp),%r12
 1f2:	mov    0x20(%rsp),%r11
 1f7:	mov    0x28(%rsp),%r15
 1fc:	xor    %esi,%esi
 1fe:	xchg   %ax,%ax
 200:	movss  (%rdx,%rsi,4),%xmm0
 205:	mulss  %xmm2,%xmm0
 209:	addss  (%rax,%rsi,4),%xmm0
 20e:	movss  %xmm0,(%rax,%rsi,4)
 213:	add    $0x1,%rsi
 217:	cmp    %r8,%rsi
 21a:	jb     200 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x200>
 21c:	add    $0x4,%rdi
 220:	add    %r8,%r9
 223:	add    %rbx,%rdx
 226:	sub    %rbx,%r10
 229:	cmp    %rdi,(%rsp)
 22d:	jne    f8 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0xf8>
 233:	xchg   %ax,%ax
 235:	data16 cs nopw 0x0(%rax,%rax,1)
 240:	mov    0x40(%rsp),%rdx
 245:	add    $0x1,%r12
 249:	add    %rdx,(%rsp)
 24d:	add    %r8,%r14
 250:	add    %rbx,%rax
 253:	add    %r15,%r11
 256:	cmp    0x38(%rsp),%r12
 25b:	jb     e0 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0xe0>
 261:	add    $0x58,%rsp
 265:	pop    %rbx
 266:	pop    %rbp
 267:	pop    %r12
 269:	pop    %r13
 26b:	pop    %r14
 26d:	pop    %r15
 26f:	ret
 270:	mov    %rcx,%rax
 273:	imul   %r8,%rax
 277:	mov    %rax,%rdx
 27a:	shl    $0x2,%rdx
 27e:	je     261 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x261>
 280:	mov    0x8(%rsp),%rdi
 285:	add    $0x58,%rsp
 289:	xor    %esi,%esi
 28b:	pop    %rbx
 28c:	pop    %rbp
 28d:	pop    %r12
 28f:	pop    %r13
 291:	pop    %r14
 293:	pop    %r15
 295:	jmp    29a <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x29a>
 29a:	nopw   0x0(%rax,%rax,1)
 2a0:	mov    0x18(%rsp),%r12
 2a5:	mov    0x20(%rsp),%r11
 2aa:	mov    0x28(%rsp),%r15
 2af:	jmp    240 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x240>
 2b1:	movaps %xmm2,%xmm1
 2b4:	mov    %r8,%rsi
 2b7:	xor    %r11d,%r11d
 2ba:	shufps $0x0,%xmm1,%xmm1
 2be:	jmp    174 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x174>
 2c3:	ret

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x4e>
  4e:	mov    0x0(%rip),%rdx        # 55 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x55>
  55:	lea    0x0(%rip),%rsi        # 5c <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x5c>
  5c:	mov    %rbx,%rdi
  5f:	call   64 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x64>
  64:	endbr64
  68:	mov    %rax,%rbp
  6b:	mov    %rbx,%rdi
  6e:	call   73 <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x73>
  73:	mov    %rbp,%rdi
  76:	call   7b <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x7b>
  7b:	endbr64
  7f:	mov    %rax,%rbp
  82:	mov    %rbx,%rdi
  85:	call   8a <mini_gpu::matmul_cpu_ikj_fast(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x8a>
  8a:	mov    %rbp,%rdi
  8d:	call   92 <.LC1+0x52>
