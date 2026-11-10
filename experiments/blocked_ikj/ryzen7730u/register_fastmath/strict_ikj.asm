<REPO>/build-register/CMakeFiles/matmul_cpu.dir/src/cpu/ikj.cpp.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)>:
   0:	endbr64
   4:	test   %rcx,%rcx
   7:	je     2de <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2de>
   d:	test   %r8,%r8
  10:	je     2de <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2de>
  16:	push   %r15
  18:	mov    %r9,%r15
  1b:	push   %r14
  1d:	push   %r13
  1f:	push   %r12
  21:	mov    %rdx,%r12
  24:	push   %rbp
  25:	push   %rbx
  26:	sub    $0x68,%rsp
  2a:	mov    %rcx,0x48(%rsp)
  2f:	mov    %rsi,0x8(%rsp)
  34:	mov    %rdi,0x40(%rsp)
  39:	test   %rdx,%rdx
  3c:	je     42 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x42>
  42:	test   %r9,%r9
  45:	je     291 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x291>
  4b:	cmpq   $0x0,0x40(%rsp)
  51:	je     57 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x57>
  57:	cmpq   $0x0,0x8(%rsp)
  5d:	je     63 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x63>
  63:	mov    %rcx,%rdx
  66:	lea    0x0(,%r8,4),%rbx
  6e:	imul   %rbx,%rdx
  72:	test   %rdx,%rdx
  75:	je     8b <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x8b>
  77:	xor    %esi,%esi
  79:	mov    %r12,%rdi
  7c:	mov    %r8,0x10(%rsp)
  81:	call   86 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x86>
  86:	mov    0x10(%rsp),%r8
  8b:	mov    0x40(%rsp),%rdi
  90:	mov    %r8,%rcx
  93:	lea    -0x1(%r8),%r13
  97:	xor    %r11d,%r11d
  9a:	mov    $0xfffffffffffffffc,%rdx
  a1:	shr    $0x2,%rcx
  a5:	xor    %r14d,%r14d
  a8:	xor    %ebp,%ebp
  aa:	lea    0x0(,%r15,4),%rax
  b2:	sub    0x8(%rsp),%rdx
  b7:	shl    $0x4,%rcx
  bb:	mov    %rax,0x50(%rsp)
  c0:	add    %rdi,%rax
  c3:	mov    %r8,%rdi
  c6:	and    $0xfffffffffffffffc,%rdi
  ca:	mov    %rdx,0x58(%rsp)
  cf:	mov    %rdi,0x20(%rsp)
  d4:	mov    %rax,0x10(%rsp)
  d9:	mov    %r12,%rax
  dc:	nopl   0x0(%rax)
  e0:	mov    0x40(%rsp),%rdi
  e5:	mov    0x58(%rsp),%rsi
  ea:	xor    %r9d,%r9d
  ed:	mov    0x8(%rsp),%rdx
  f2:	lea    (%rdi,%r11,4),%rdi
  f6:	lea    (%rsi,%rax,1),%r10
  fa:	movss  (%rdi),%xmm2
  fe:	cmp    $0x1,%r8
 102:	je     211 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x211>
 108:	mov    %rbp,0x28(%rsp)
 10d:	mov    %r11,0x30(%rsp)
 112:	mov    %r15,0x38(%rsp)
 117:	cmp    $0x8,%r10
 11b:	jbe    202 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x202>
 121:	cmp    $0x2,%r13
 125:	jbe    2d1 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2d1>
 12b:	movaps %xmm2,%xmm1
 12e:	xor    %esi,%esi
 130:	shufps $0x0,%xmm1,%xmm1
 134:	nop
 135:	data16 cs nopw 0x0(%rax,%rax,1)
 140:	movups (%rdx,%rsi,1),%xmm0
 144:	movups (%rax,%rsi,1),%xmm3
 148:	mulps  %xmm1,%xmm0
 14b:	addps  %xmm3,%xmm0
 14e:	movups %xmm0,(%rax,%rsi,1)
 152:	add    $0x10,%rsi
 156:	cmp    %rsi,%rcx
 159:	jne    140 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x140>
 15b:	test   $0x3,%r8b
 15f:	je     1dc <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1dc>
 161:	mov    0x20(%rsp),%rsi
 166:	mov    %rsi,%r11
 169:	cmp    %r13,%rsi
 16c:	je     1be <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1be>
 16e:	mov    %r8,%rsi
 171:	and    $0x3,%esi
 174:	mov    %rsi,0x18(%rsp)
 179:	mov    0x8(%rsp),%rsi
 17e:	lea    (%r9,%r11,1),%r15
 182:	movaps %xmm2,%xmm1
 185:	lea    (%r11,%r14,1),%rbp
 189:	shufps $0xe0,%xmm1,%xmm1
 18d:	movq   %xmm1,%xmm1
 191:	movq   (%rsi,%r15,4),%xmm0
 197:	mov    0x18(%rsp),%rsi
 19c:	mulps  %xmm1,%xmm0
 19f:	movq   (%r12,%rbp,4),%xmm1
 1a5:	movq   %xmm0,%xmm0
 1a9:	addps  %xmm1,%xmm0
 1ac:	movlps %xmm0,(%r12,%rbp,4)
 1b1:	test   $0x1,%sil
 1b5:	je     1dc <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x1dc>
 1b7:	and    $0xfffffffffffffffe,%rsi
 1bb:	add    %r11,%rsi
 1be:	mov    0x8(%rsp),%r15
 1c3:	lea    (%r14,%rsi,1),%r11
 1c7:	add    %r9,%rsi
 1ca:	mulss  (%r15,%rsi,4),%xmm2
 1d0:	addss  (%r12,%r11,4),%xmm2
 1d6:	movss  %xmm2,(%r12,%r11,4)
 1dc:	add    $0x4,%rdi
 1e0:	cmp    %rdi,0x10(%rsp)
 1e5:	je     2c0 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2c0>
 1eb:	sub    %rbx,%r10
 1ee:	movss  (%rdi),%xmm2
 1f2:	add    %r8,%r9
 1f5:	add    %rbx,%rdx
 1f8:	cmp    $0x8,%r10
 1fc:	ja     121 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x121>
 202:	mov    0x28(%rsp),%rbp
 207:	mov    0x30(%rsp),%r11
 20c:	mov    0x38(%rsp),%r15
 211:	xor    %esi,%esi
 213:	xchg   %ax,%ax
 215:	data16 cs nopw 0x0(%rax,%rax,1)
 220:	movss  (%rdx,%rsi,4),%xmm0
 225:	mulss  %xmm2,%xmm0
 229:	addss  (%rax,%rsi,4),%xmm0
 22e:	movss  %xmm0,(%rax,%rsi,4)
 233:	add    $0x1,%rsi
 237:	cmp    %r8,%rsi
 23a:	jb     220 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x220>
 23c:	add    $0x4,%rdi
 240:	add    %r8,%r9
 243:	add    %rbx,%rdx
 246:	sub    %rbx,%r10
 249:	cmp    %rdi,0x10(%rsp)
 24e:	jne    fa <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0xfa>
 254:	nop
 255:	data16 cs nopw 0x0(%rax,%rax,1)
 260:	mov    0x50(%rsp),%rdx
 265:	add    $0x1,%rbp
 269:	add    %r8,%r14
 26c:	add    %rbx,%rax
 26f:	add    %rdx,0x10(%rsp)
 274:	add    %r15,%r11
 277:	cmp    0x48(%rsp),%rbp
 27c:	jb     e0 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0xe0>
 282:	add    $0x68,%rsp
 286:	pop    %rbx
 287:	pop    %rbp
 288:	pop    %r12
 28a:	pop    %r13
 28c:	pop    %r14
 28e:	pop    %r15
 290:	ret
 291:	mov    %rcx,%rax
 294:	imul   %r8,%rax
 298:	mov    %rax,%rdx
 29b:	shl    $0x2,%rdx
 29f:	je     282 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x282>
 2a1:	add    $0x68,%rsp
 2a5:	mov    %r12,%rdi
 2a8:	xor    %esi,%esi
 2aa:	pop    %rbx
 2ab:	pop    %rbp
 2ac:	pop    %r12
 2ae:	pop    %r13
 2b0:	pop    %r14
 2b2:	pop    %r15
 2b4:	jmp    2b9 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x2b9>
 2b9:	nopl   0x0(%rax)
 2c0:	mov    0x28(%rsp),%rbp
 2c5:	mov    0x30(%rsp),%r11
 2ca:	mov    0x38(%rsp),%r15
 2cf:	jmp    260 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x260>
 2d1:	mov    %r8,0x18(%rsp)
 2d6:	xor    %r11d,%r11d
 2d9:	jmp    179 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long)+0x179>
 2de:	ret

Disassembly of section .text.unlikely:

0000000000000000 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]>:
   0:	mov    $0x10,%edi
   5:	call   a <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0xa>
   a:	lea    0x0(%rip),%rsi        # 11 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x11>
  11:	mov    %rax,%rdi
  14:	mov    %rax,%rbx
  17:	call   1c <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x1c>
  1c:	mov    0x0(%rip),%rdx        # 23 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x23>
  23:	lea    0x0(%rip),%rsi        # 2a <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x2a>
  2a:	mov    %rbx,%rdi
  2d:	call   32 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x32>
  32:	mov    $0x10,%edi
  37:	call   3c <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x3c>
  3c:	lea    0x0(%rip),%rsi        # 43 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x43>
  43:	mov    %rax,%rdi
  46:	mov    %rax,%rbx
  49:	call   4e <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x4e>
  4e:	mov    0x0(%rip),%rdx        # 55 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x55>
  55:	lea    0x0(%rip),%rsi        # 5c <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x5c>
  5c:	mov    %rbx,%rdi
  5f:	call   64 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x64>
  64:	endbr64
  68:	mov    %rax,%rbp
  6b:	mov    %rbx,%rdi
  6e:	call   73 <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x73>
  73:	mov    %rbp,%rdi
  76:	call   7b <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x7b>
  7b:	endbr64
  7f:	mov    %rax,%rbp
  82:	mov    %rbx,%rdi
  85:	call   8a <mini_gpu::matmul_cpu_ikj(float const*, float const*, float*, unsigned long, unsigned long, unsigned long) [clone .cold]+0x8a>
  8a:	mov    %rbp,%rdi
  8d:	call   92 <.LC1+0x52>
