	.file	"thttpd.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.type	handle_hup, @function
handle_hup:
.LASANPC4:
.LFB4:
	.cfi_startproc
	movl	$1, got_hup(%rip)
	ret
	.cfi_endproc
.LFE4:
	.size	handle_hup, .-handle_hup
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.rodata
	.align 32
.LC1:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.zero	56
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.type	thttpd_logstats, @function
thttpd_logstats:
.LASANPC35:
.LFB35:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	testq	%rdi, %rdi
	jle	.L3
	movq	stats_bytes(%rip), %r8
	pxor	%xmm2, %xmm2
	movq	stats_connections(%rip), %rdx
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	movl	httpd_conn_count(%rip), %r9d
	cvtsi2ssq	%rdi, %xmm2
	movl	stats_simultaneous(%rip), %ecx
	movl	$.LC1, %esi
	movl	$6, %edi
	cvtsi2ssq	%r8, %xmm1
	movl	$2, %eax
	cvtsi2ssq	%rdx, %xmm0
	divss	%xmm2, %xmm1
	divss	%xmm2, %xmm0
	cvtss2sd	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm0
	call	syslog
.L3:
	movq	$0, stats_connections(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE35:
	.size	thttpd_logstats, .-thttpd_logstats
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata
	.align 32
.LC3:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.zero	58
	.align 32
.LC4:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.zero	34
	.align 32
.LC5:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.zero	63
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.type	update_throttles, @function
update_throttles:
.LASANPC25:
.LFB25:
	.cfi_startproc
	movl	numthrottles(%rip), %r11d
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	movabsq	$6148914691236517206, %rbp
	testl	%r11d, %r11d
	jg	.L65
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L93:
	leaq	(%r9,%r9), %rdx
	cmpq	%rdx, %r8
	movq	%rcx, %rdx
	jle	.L16
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L84
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	$5, %edi
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	%ebx, %edx
	xorl	%eax, %eax
	movl	$.LC3, %esi
	call	syslog
	movq	%r12, %rcx
	addq	throttles(%rip), %rcx
	popq	%r9
	.cfi_def_cfa_offset 40
	popq	%r10
	.cfi_def_cfa_offset 32
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L85
.L20:
	movq	24(%rcx), %r8
.L13:
	leaq	16(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L86
	movq	16(%rcx), %r9
	cmpq	%r8, %r9
	jle	.L22
	leaq	40(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L23
	cmpb	$3, %al
	jle	.L87
.L23:
	movl	40(%rcx), %eax
	testl	%eax, %eax
	jne	.L88
.L22:
	addl	$1, %ebx
	cmpl	%ebx, numthrottles(%rip)
	jle	.L26
.L65:
	movslq	%ebx, %rax
	leaq	(%rax,%rax,2), %r12
	salq	$4, %r12
	movq	%r12, %rcx
	addq	throttles(%rip), %rcx
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L89
	leaq	32(%rcx), %rdi
	movq	24(%rcx), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	addq	%rax, %rax
	cmpb	$0, 2147450880(%rdx)
	jne	.L90
	movq	32(%rcx), %rdx
	leaq	8(%rcx), %rdi
	movq	$0, 32(%rcx)
	movq	%rdx, %rsi
	shrq	$63, %rsi
	addq	%rsi, %rdx
	sarq	%rdx
	leaq	(%rdx,%rax), %rsi
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%rbp
	movq	%rdi, %rax
	shrq	$3, %rax
	subq	%rsi, %rdx
	cmpb	$0, 2147450880(%rax)
	movq	%rdx, %r8
	movq	%rdx, 24(%rcx)
	jne	.L91
	movq	8(%rcx), %r9
	cmpq	%r9, %rdx
	jle	.L13
	leaq	40(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L14
	cmpb	$3, %al
	jle	.L92
.L14:
	movl	40(%rcx), %eax
	testl	%eax, %eax
	jne	.L93
	leaq	16(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L22
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L88:
	movq	%rcx, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L94
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC5, %esi
	xorl	%eax, %eax
	movl	$5, %edi
	addl	$1, %ebx
	call	syslog
	cmpl	%ebx, numthrottles(%rip)
	popq	%rax
	.cfi_def_cfa_offset 40
	popq	%rdx
	.cfi_def_cfa_offset 32
	jg	.L65
	.p2align 4,,10
	.p2align 3
.L26:
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L6
	subl	$1, %eax
	movq	connects(%rip), %r9
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	64(%r9), %r8
	leaq	208(%r9,%rax), %rdi
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L32:
	addq	$144, %r8
	addq	$144, %r9
	cmpq	%rdi, %r8
	je	.L6
.L29:
	movq	%r9, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L27
	cmpb	$3, %al
	jle	.L95
.L27:
	movl	(%r9), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L32
	movq	%r8, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L96
	leaq	-8(%r8), %rdx
	movq	$-1, (%r8)
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L31
	cmpb	$3, %al
	jle	.L97
.L31:
	movl	-8(%r8), %eax
	testl	%eax, %eax
	jle	.L32
	subl	$1, %eax
	movq	throttles(%rip), %r11
	leaq	-48(%r8), %rsi
	leaq	20(%r9,%rax,4), %r10
	movq	$-1, %rbx
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L33:
	movslq	(%rsi), %rax
	leaq	(%rax,%rax,2), %rcx
	salq	$4, %rcx
	addq	%r11, %rcx
	leaq	8(%rcx), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L98
	leaq	40(%rcx), %rbp
	movq	8(%rcx), %rax
	movq	%rbp, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L35
	cmpb	$3, %dl
	jle	.L99
.L35:
	movslq	40(%rcx), %rcx
	cqto
	idivq	%rcx
	cmpq	$-1, %rbx
	je	.L83
	cmpq	%rbx, %rax
	cmovg	%rbx, %rax
.L83:
	addq	$4, %rsi
	movq	%rax, (%r8)
	cmpq	%r10, %rsi
	je	.L32
	movq	(%r8), %rbx
.L38:
	movq	%rsi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rsi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L33
	testb	%dl, %dl
	je	.L33
	movq	%rsi, %rdi
	call	__asan_report_load4
	.p2align 4,,10
	.p2align 3
.L16:
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L100
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	$.LC4, %esi
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$6, %edi
	xorl	%eax, %eax
	movl	%ebx, %edx
	call	syslog
	movq	%r12, %rcx
	addq	throttles(%rip), %rcx
	popq	%rsi
	.cfi_def_cfa_offset 40
	popq	%r8
	.cfi_def_cfa_offset 32
	leaq	24(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L20
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L6:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L97:
	.cfi_restore_state
	movq	%rdx, %rdi
	call	__asan_report_load4
.L96:
	movq	%r8, %rdi
	call	__asan_report_store8
.L95:
	movq	%r9, %rdi
	call	__asan_report_load4
.L100:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L94:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L87:
	call	__asan_report_load4
.L86:
	call	__asan_report_load8
.L85:
	call	__asan_report_load8
.L84:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L92:
	call	__asan_report_load4
.L91:
	call	__asan_report_load8
.L90:
	call	__asan_report_load8
.L89:
	call	__asan_report_load8
.L99:
	movq	%rbp, %rdi
	call	__asan_report_load4
.L98:
	movq	%rax, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE25:
	.size	update_throttles, .-update_throttles
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata
	.align 32
.LC7:
	.string	"%s: no value required for %s option\n"
	.zero	59
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.type	no_value_required, @function
no_value_required:
.LASANPC14:
.LFB14:
	.cfi_startproc
	testq	%rsi, %rsi
	jne	.L106
	rep ret
.L106:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	%rdi, %rcx
	shrq	$3, %rax
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rax)
	jne	.L107
	movq	stderr(%rip), %rdi
	movl	$.LC7, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L107:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE14:
	.size	no_value_required, .-no_value_required
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata
	.align 32
.LC9:
	.string	"%s: value required for %s option\n"
	.zero	62
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.type	value_required, @function
value_required:
.LASANPC13:
.LFB13:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L113
	rep ret
.L113:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	%rdi, %rcx
	shrq	$3, %rax
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rax)
	jne	.L114
	movq	stderr(%rip), %rdi
	movl	$.LC9, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L114:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE13:
	.size	value_required, .-value_required
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata
	.align 32
.LC11:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir]
     [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host]
      [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.zero	37
	.section	.text.unlikely
.LCOLDB12:
.LHOTB12:
	.type	usage, @function
usage:
.LASANPC11:
.LFB11:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L116
	movl	$stderr, %edi
	call	__asan_report_load8
.L116:
	movq	stderr(%rip), %rdi
	movl	$.LC11, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE11:
	.size	usage, .-usage
.LCOLDE12:
.LHOTE12:
.LCOLDB13:
	.text
.LHOTB13:
	.p2align 4,,15
	.type	wakeup_connection, @function
wakeup_connection:
.LASANPC30:
.LFB30:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsp, %rax
	movq	%rdi, (%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L138
	movq	(%rsp), %rsi
	leaq	96(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L139
	movq	%rsi, %rax
	movq	$0, 96(%rsi)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L121
	cmpb	$3, %al
	jle	.L140
.L121:
	cmpl	$3, (%rsi)
	je	.L141
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L141:
	.cfi_restore_state
	leaq	8(%rsi), %rdi
	movl	$2, (%rsi)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L142
	movq	8(%rsi), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L124
	cmpb	$3, %dl
	jle	.L143
.L124:
	movl	704(%rax), %edi
	movl	$1, %edx
	call	fdwatch_add_fd
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L140:
	.cfi_restore_state
	movq	%rsi, %rdi
	call	__asan_report_load4
.L139:
	call	__asan_report_store8
.L138:
	movq	%rsp, %rdi
	call	__asan_report_load8
.L143:
	call	__asan_report_load4
.L142:
	call	__asan_report_load8
	.cfi_endproc
.LFE30:
	.size	wakeup_connection, .-wakeup_connection
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.globl	__asan_stack_malloc_1
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC14:
	.string	"1 32 16 2 tv "
	.section	.rodata
	.align 32
.LC15:
	.string	"up %ld seconds, stats for %ld seconds:"
	.zero	57
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.type	logstats, @function
logstats:
.LASANPC34:
.LFB34:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 144
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsp, %rbp
	movq	%rsp, %r13
	testl	%eax, %eax
	jne	.L152
.L144:
	movq	%rbp, %r12
	movq	$1102416563, 0(%rbp)
	movq	$.LC14, 8(%rbp)
	shrq	$3, %r12
	testq	%rbx, %rbx
	movq	$.LASANPC34, 16(%rbp)
	movl	$-235802127, 2147450880(%r12)
	movl	$-185335808, 2147450884(%r12)
	movl	$-202116109, 2147450888(%r12)
	je	.L153
.L148:
	movq	%rbx, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L154
	movq	(%rbx), %rax
	movl	$1, %ecx
	movl	$.LC15, %esi
	movl	$6, %edi
	movq	%rax, %rdx
	movq	%rax, %rbx
	subq	start_time(%rip), %rdx
	subq	stats_time(%rip), %rbx
	movq	%rax, stats_time(%rip)
	cmove	%rcx, %rbx
	xorl	%eax, %eax
	movq	%rbx, %rcx
	call	syslog
	movq	%rbx, %rdi
	call	thttpd_logstats
	movq	%rbx, %rdi
	call	httpd_logstats
	movq	%rbx, %rdi
	call	mmc_logstats
	movq	%rbx, %rdi
	call	fdwatch_logstats
	movq	%rbx, %rdi
	call	tmr_logstats
	cmpq	%rbp, %r13
	jne	.L155
	movq	$0, 2147450880(%r12)
	movl	$0, 2147450888(%r12)
.L146:
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L153:
	.cfi_restore_state
	leaq	32(%rbp), %rbx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	gettimeofday
	jmp	.L148
.L155:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, 0(%rbp)
	movl	$-168430091, 2147450888(%r12)
	movq	%rax, 2147450880(%r12)
	jmp	.L146
.L152:
	movq	%rsp, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %rbp
	jmp	.L144
.L154:
	movq	%rbx, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE34:
	.size	logstats, .-logstats
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.type	show_stats, @function
show_stats:
.LASANPC33:
.LFB33:
	.cfi_startproc
	movq	%rsi, %rdi
	jmp	logstats
	.cfi_endproc
.LFE33:
	.size	show_stats, .-show_stats
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.type	handle_usr2, @function
handle_usr2:
.LASANPC6:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L158
	testb	%dl, %dl
	jne	.L173
.L158:
	xorl	%edi, %edi
	movl	(%rbx), %ebp
	call	logstats
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L159
	testb	%dl, %dl
	jne	.L174
.L159:
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L174:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_store4
.L173:
	movq	%rbx, %rdi
	call	__asan_report_load4
	.cfi_endproc
.LFE6:
	.size	handle_usr2, .-handle_usr2
	.section	.text.unlikely
.LCOLDE18:
	.text
.LHOTE18:
	.section	.text.unlikely
.LCOLDB19:
	.text
.LHOTB19:
	.p2align 4,,15
	.type	occasional, @function
occasional:
.LASANPC32:
.LFB32:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rsi, %rdi
	call	mmc_cleanup
	call	tmr_cleanup
	movl	$1, watchdog_flag(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE32:
	.size	occasional, .-occasional
	.section	.text.unlikely
.LCOLDE19:
	.text
.LHOTE19:
	.section	.rodata
	.align 32
.LC20:
	.string	"/tmp"
	.zero	59
	.section	.text.unlikely
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.type	handle_alrm, @function
handle_alrm:
.LASANPC7:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L178
	testb	%dl, %dl
	jne	.L194
.L178:
	movl	watchdog_flag(%rip), %eax
	movl	(%rbx), %ebp
	testl	%eax, %eax
	je	.L195
	movl	$360, %edi
	movl	$0, watchdog_flag(%rip)
	call	alarm
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L180
	testb	%dl, %dl
	jne	.L196
.L180:
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L196:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_store4
.L194:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L195:
	movl	$.LC20, %edi
	call	chdir
	call	__asan_handle_no_return
	call	abort
	.cfi_endproc
.LFE7:
	.size	handle_alrm, .-handle_alrm
	.section	.text.unlikely
.LCOLDE21:
	.text
.LHOTE21:
	.section	.rodata.str1.1
.LC22:
	.string	"1 32 4 6 status "
	.section	.rodata
	.align 32
.LC23:
	.string	"child wait - %m"
	.zero	48
	.section	.text.unlikely
.LCOLDB24:
	.text
.LHOTB24:
	.p2align 4,,15
	.type	handle_chld, @function
handle_chld:
.LASANPC3:
.LFB3:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	leaq	16(%rsp), %rbp
	testl	%eax, %eax
	jne	.L246
.L197:
	movq	%rbp, %r13
	movq	$1102416563, 0(%rbp)
	movq	$.LC22, 8(%rbp)
	shrq	$3, %r13
	movq	$.LASANPC3, 16(%rbp)
	leaq	96(%rbp), %r12
	movl	$-235802127, 2147450880(%r13)
	movl	$-185273340, 2147450884(%r13)
	movl	$-202116109, 2147450888(%r13)
	call	__errno_location
	movq	%rax, %rbx
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L201
	testb	%dl, %dl
	jne	.L247
.L201:
	movl	(%rbx), %eax
	movq	%rbx, %r15
	subq	$64, %r12
	xorl	%r14d, %r14d
	shrq	$3, %r15
	movl	%eax, 12(%rsp)
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	movb	%al, 11(%rsp)
	.p2align 4,,10
	.p2align 3
.L202:
	movl	$1, %edx
	movq	%r12, %rsi
	movl	$-1, %edi
	call	waitpid
	testl	%eax, %eax
	je	.L207
	js	.L248
	movq	hs(%rip), %rdx
	testq	%rdx, %rdx
	je	.L202
	leaq	36(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	jl	.L208
	testb	%cl, %cl
	jne	.L249
.L208:
	movl	36(%rdx), %eax
	subl	$1, %eax
	cmovs	%r14d, %eax
	movl	%eax, 36(%rdx)
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L248:
	movzbl	2147450880(%r15), %eax
	cmpb	%al, 11(%rsp)
	jl	.L205
	testb	%al, %al
	jne	.L250
.L205:
	movl	(%rbx), %eax
	cmpl	$4, %eax
	je	.L202
	cmpl	$11, %eax
	je	.L202
	cmpl	$10, %eax
	je	.L207
	movl	$.LC23, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L207:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rbx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L211
	testb	%dl, %dl
	jne	.L251
.L211:
	movl	12(%rsp), %eax
	movl	%eax, (%rbx)
	leaq	16(%rsp), %rax
	cmpq	%rbp, %rax
	jne	.L252
	movq	$0, 2147450880(%r13)
	movl	$0, 2147450888(%r13)
.L199:
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L246:
	.cfi_restore_state
	movq	%rbp, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %rbp
	jmp	.L197
.L252:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, 0(%rbp)
	movl	$-168430091, 2147450888(%r13)
	movq	%rax, 2147450880(%r13)
	jmp	.L199
.L251:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L249:
	call	__asan_report_load4
.L250:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L247:
	movq	%rbx, %rdi
	call	__asan_report_load4
	.cfi_endproc
.LFE3:
	.size	handle_chld, .-handle_chld
	.section	.text.unlikely
.LCOLDE24:
	.text
.LHOTE24:
	.section	.rodata
	.align 32
.LC25:
	.string	"out of memory copying a string"
	.zero	33
	.align 32
.LC26:
	.string	"%s: out of memory copying a string\n"
	.zero	60
	.section	.text.unlikely
.LCOLDB27:
	.text
.LHOTB27:
	.p2align 4,,15
	.type	e_strdup, @function
e_strdup:
.LASANPC15:
.LFB15:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	strdup
	testq	%rax, %rax
	je	.L257
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L257:
	.cfi_restore_state
	movl	$.LC25, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L258
	movq	stderr(%rip), %rdi
	movl	$.LC26, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L258:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE15:
	.size	e_strdup, .-e_strdup
	.section	.text.unlikely
.LCOLDE27:
	.text
.LHOTE27:
	.globl	__asan_stack_malloc_2
	.section	.rodata.str1.1
.LC28:
	.string	"1 32 100 4 line "
	.section	.rodata
	.align 32
.LC29:
	.string	"r"
	.zero	62
	.align 32
.LC30:
	.string	" \t\n\r"
	.zero	59
	.align 32
.LC31:
	.string	"debug"
	.zero	58
	.align 32
.LC32:
	.string	"port"
	.zero	59
	.align 32
.LC33:
	.string	"dir"
	.zero	60
	.align 32
.LC34:
	.string	"chroot"
	.zero	57
	.align 32
.LC35:
	.string	"nochroot"
	.zero	55
	.align 32
.LC36:
	.string	"data_dir"
	.zero	55
	.align 32
.LC37:
	.string	"symlink"
	.zero	56
	.align 32
.LC38:
	.string	"nosymlink"
	.zero	54
	.align 32
.LC39:
	.string	"symlinks"
	.zero	55
	.align 32
.LC40:
	.string	"nosymlinks"
	.zero	53
	.align 32
.LC41:
	.string	"user"
	.zero	59
	.align 32
.LC42:
	.string	"cgipat"
	.zero	57
	.align 32
.LC43:
	.string	"cgilimit"
	.zero	55
	.align 32
.LC44:
	.string	"urlpat"
	.zero	57
	.align 32
.LC45:
	.string	"noemptyreferers"
	.zero	48
	.align 32
.LC46:
	.string	"localpat"
	.zero	55
	.align 32
.LC47:
	.string	"throttles"
	.zero	54
	.align 32
.LC48:
	.string	"host"
	.zero	59
	.align 32
.LC49:
	.string	"logfile"
	.zero	56
	.align 32
.LC50:
	.string	"vhost"
	.zero	58
	.align 32
.LC51:
	.string	"novhost"
	.zero	56
	.align 32
.LC52:
	.string	"globalpasswd"
	.zero	51
	.align 32
.LC53:
	.string	"noglobalpasswd"
	.zero	49
	.align 32
.LC54:
	.string	"pidfile"
	.zero	56
	.align 32
.LC55:
	.string	"charset"
	.zero	56
	.align 32
.LC56:
	.string	"p3p"
	.zero	60
	.align 32
.LC57:
	.string	"max_age"
	.zero	56
	.align 32
.LC58:
	.string	"%s: unknown config option '%s'\n"
	.zero	32
	.section	.text.unlikely
.LCOLDB59:
	.text
.LHOTB59:
	.p2align 4,,15
	.type	read_config, @function
read_config:
.LASANPC12:
.LFB12:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$216, %rsp
	.cfi_def_cfa_offset 272
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	leaq	16(%rsp), %r12
	testl	%eax, %eax
	jne	.L363
.L259:
	movq	%r12, %r13
	movq	$1102416563, (%r12)
	movq	$.LC28, 8(%r12)
	shrq	$3, %r13
	movq	$.LASANPC12, 16(%r12)
	movl	$.LC29, %esi
	movl	$-235802127, 2147450880(%r13)
	movl	$-185273340, 2147450896(%r13)
	movq	%rbx, %rdi
	movl	$-202116109, 2147450900(%r13)
	call	fopen
	testq	%rax, %rax
	movq	%rax, 8(%rsp)
	je	.L359
	leaq	32(%r12), %rax
	movabsq	$4294977024, %r14
	movq	%rax, (%rsp)
.L263:
	movq	8(%rsp), %rdx
	movq	(%rsp), %rdi
	movl	$1000, %esi
	call	fgets
	testq	%rax, %rax
	je	.L364
	movq	(%rsp), %rdi
	movl	$35, %esi
	call	strchr
	testq	%rax, %rax
	je	.L264
	movq	%rax, %rdx
	movq	%rax, %rsi
	shrq	$3, %rdx
	andl	$7, %esi
	movzbl	2147450880(%rdx), %edx
	cmpb	%sil, %dl
	jg	.L265
	testb	%dl, %dl
	jne	.L365
.L265:
	movb	$0, (%rax)
.L264:
	movq	(%rsp), %rbx
	movl	$.LC30, %esi
	movq	%rbx, %rdi
	call	strspn
	leaq	(%rbx,%rax), %rbx
	movq	%rbx, %rax
	movq	%rbx, %rdx
	shrq	$3, %rax
	andl	$7, %edx
	movzbl	2147450880(%rax), %eax
	cmpb	%dl, %al
	jg	.L266
	testb	%al, %al
	jne	.L366
	.p2align 4,,10
	.p2align 3
.L266:
	cmpb	$0, (%rbx)
	je	.L263
	movl	$.LC30, %esi
	movq	%rbx, %rdi
	call	strcspn
	leaq	(%rbx,%rax), %r15
	movq	%r15, %rax
	movq	%r15, %rsi
	shrq	$3, %rax
	andl	$7, %esi
	movzbl	2147450880(%rax), %eax
	cmpb	%sil, %al
	jg	.L268
	testb	%al, %al
	jne	.L367
.L268:
	movzbl	(%r15), %eax
	cmpb	$32, %al
	ja	.L269
	btq	%rax, %r14
	jnc	.L269
	movq	%r15, %rdi
	.p2align 4,,10
	.p2align 3
.L272:
	movq	%rdi, %rax
	movq	%rdi, %rsi
	addq	$1, %r15
	shrq	$3, %rax
	andl	$7, %esi
	movzbl	2147450880(%rax), %eax
	cmpb	%sil, %al
	jg	.L270
	testb	%al, %al
	jne	.L368
.L270:
	movq	%r15, %rax
	movb	$0, -1(%r15)
	movq	%r15, %rsi
	shrq	$3, %rax
	andl	$7, %esi
	movzbl	2147450880(%rax), %eax
	cmpb	%sil, %al
	jg	.L271
	testb	%al, %al
	jne	.L369
.L271:
	movzbl	(%r15), %eax
	cmpb	$32, %al
	jbe	.L370
.L269:
	movl	$61, %esi
	movq	%rbx, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L308
	movq	%rax, %rsi
	movq	%rax, %rdi
	leaq	1(%rax), %rbp
	shrq	$3, %rsi
	andl	$7, %edi
	movzbl	2147450880(%rsi), %esi
	cmpb	%dil, %sil
	jg	.L274
	testb	%sil, %sil
	jne	.L371
.L274:
	movb	$0, (%rax)
.L273:
	movl	$.LC31, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L372
	movl	$.LC32, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L373
	movl	$.LC33, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L374
	movl	$.LC34, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L375
	movl	$.LC35, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L376
	movl	$.LC36, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L377
	movl	$.LC37, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L361
	movl	$.LC38, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L362
	movl	$.LC39, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L361
	movl	$.LC40, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L362
	movl	$.LC41, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L378
	movl	$.LC42, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L379
	movl	$.LC43, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L380
	movl	$.LC44, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L381
	movl	$.LC45, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L382
	movl	$.LC46, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L383
	movl	$.LC47, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L384
	movl	$.LC48, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L385
	movl	$.LC49, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L386
	movl	$.LC50, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L387
	movl	$.LC51, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L388
	movl	$.LC52, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L389
	movl	$.LC53, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L390
	movl	$.LC54, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L391
	movl	$.LC55, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L392
	movl	$.LC56, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L393
	movl	$.LC57, %esi
	movq	%rbx, %rdi
	call	strcasecmp
	testl	%eax, %eax
	jne	.L302
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movl	%eax, max_age(%rip)
	.p2align 4,,10
	.p2align 3
.L276:
	movl	$.LC30, %esi
	movq	%r15, %rdi
	call	strspn
	leaq	(%r15,%rax), %rbx
	movq	%rbx, %rax
	movq	%rbx, %rdx
	shrq	$3, %rax
	andl	$7, %edx
	movzbl	2147450880(%rax), %eax
	cmpb	%dl, %al
	jg	.L266
	testb	%al, %al
	je	.L266
	movq	%rbx, %rdi
	call	__asan_report_load1
	.p2align 4,,10
	.p2align 3
.L370:
	btq	%rax, %r14
	movq	%r15, %rdi
	jc	.L272
	jmp	.L269
	.p2align 4,,10
	.p2align 3
.L372:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, debug(%rip)
	jmp	.L276
.L373:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movw	%ax, port(%rip)
	jmp	.L276
.L308:
	xorl	%ebp, %ebp
	jmp	.L273
.L374:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, dir(%rip)
	jmp	.L276
.L375:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L276
.L376:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L276
.L361:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, no_symlink_check(%rip)
	jmp	.L276
.L377:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, data_dir(%rip)
	jmp	.L276
.L362:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, no_symlink_check(%rip)
	jmp	.L276
.L378:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, user(%rip)
	jmp	.L276
.L379:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, cgi_pattern(%rip)
	jmp	.L276
.L380:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	atoi
	movl	%eax, cgi_limit(%rip)
	jmp	.L276
.L381:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, url_pattern(%rip)
	jmp	.L276
.L383:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, local_pattern(%rip)
	jmp	.L276
.L382:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, no_empty_referers(%rip)
	jmp	.L276
.L364:
	movq	8(%rsp), %rdi
	call	fclose
	leaq	16(%rsp), %rax
	cmpq	%r12, %rax
	jne	.L394
	movl	$0, 2147450880(%r13)
	movq	$0, 2147450896(%r13)
.L261:
	addq	$216, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L369:
	.cfi_restore_state
	movq	%r15, %rdi
	call	__asan_report_load1
.L385:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, hostname(%rip)
	jmp	.L276
.L384:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, throttlefile(%rip)
	jmp	.L276
.L371:
	movq	%rax, %rdi
	call	__asan_report_store1
.L394:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%r12)
	movq	%rax, 2147450880(%r13)
	movq	%rax, 2147450888(%r13)
	movq	%rax, 2147450896(%r13)
	jmp	.L261
.L368:
	call	__asan_report_store1
.L359:
	movq	%rbx, %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L363:
	movq	%r12, %rsi
	movl	$192, %edi
	call	__asan_stack_malloc_2
	movq	%rax, %r12
	jmp	.L259
.L365:
	movq	%rax, %rdi
	call	__asan_report_store1
.L366:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L367:
	movq	%r15, %rdi
	call	__asan_report_load1
.L302:
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L395
	movq	stderr(%rip), %rdi
	movq	%rbx, %rcx
	movl	$.LC58, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L393:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, p3p(%rip)
	jmp	.L276
.L389:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_global_passwd(%rip)
	jmp	.L276
.L388:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_vhost(%rip)
	jmp	.L276
.L387:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$1, do_vhost(%rip)
	jmp	.L276
.L386:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, logfile(%rip)
	jmp	.L276
.L391:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, pidfile(%rip)
	jmp	.L276
.L390:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	no_value_required
	movl	$0, do_global_passwd(%rip)
	jmp	.L276
.L392:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	value_required
	movq	%rbp, %rdi
	call	e_strdup
	movq	%rax, charset(%rip)
	jmp	.L276
.L395:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE12:
	.size	read_config, .-read_config
	.section	.text.unlikely
.LCOLDE59:
	.text
.LHOTE59:
	.section	.rodata
	.align 32
.LC60:
	.string	"nobody"
	.zero	57
	.align 32
.LC61:
	.string	"iso-8859-1"
	.zero	53
	.align 32
.LC62:
	.string	""
	.zero	63
	.align 32
.LC63:
	.string	"-V"
	.zero	61
	.align 32
.LC64:
	.string	"thttpd/2.27.0 Oct 3, 2014"
	.zero	38
	.align 32
.LC65:
	.string	"-C"
	.zero	61
	.align 32
.LC66:
	.string	"-p"
	.zero	61
	.align 32
.LC67:
	.string	"-d"
	.zero	61
	.align 32
.LC68:
	.string	"-r"
	.zero	61
	.align 32
.LC69:
	.string	"-nor"
	.zero	59
	.align 32
.LC70:
	.string	"-dd"
	.zero	60
	.align 32
.LC71:
	.string	"-s"
	.zero	61
	.align 32
.LC72:
	.string	"-nos"
	.zero	59
	.align 32
.LC73:
	.string	"-u"
	.zero	61
	.align 32
.LC74:
	.string	"-c"
	.zero	61
	.align 32
.LC75:
	.string	"-t"
	.zero	61
	.align 32
.LC76:
	.string	"-h"
	.zero	61
	.align 32
.LC77:
	.string	"-l"
	.zero	61
	.align 32
.LC78:
	.string	"-v"
	.zero	61
	.align 32
.LC79:
	.string	"-nov"
	.zero	59
	.align 32
.LC80:
	.string	"-g"
	.zero	61
	.align 32
.LC81:
	.string	"-nog"
	.zero	59
	.align 32
.LC82:
	.string	"-i"
	.zero	61
	.align 32
.LC83:
	.string	"-T"
	.zero	61
	.align 32
.LC84:
	.string	"-P"
	.zero	61
	.align 32
.LC85:
	.string	"-M"
	.zero	61
	.align 32
.LC86:
	.string	"-D"
	.zero	61
	.section	.text.unlikely
.LCOLDB87:
	.text
.LHOTB87:
	.p2align 4,,15
	.type	parse_args, @function
parse_args:
.LASANPC10:
.LFB10:
	.cfi_startproc
	movl	$80, %eax
	cmpl	$1, %edi
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$0, debug(%rip)
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movw	%ax, port(%rip)
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	$0, dir(%rip)
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	$0, data_dir(%rip)
	movl	$0, do_chroot(%rip)
	movl	$0, no_log(%rip)
	movl	$0, no_symlink_check(%rip)
	movl	$0, do_vhost(%rip)
	movl	$0, do_global_passwd(%rip)
	movq	$0, cgi_pattern(%rip)
	movl	$0, cgi_limit(%rip)
	movq	$0, url_pattern(%rip)
	movl	$0, no_empty_referers(%rip)
	movq	$0, local_pattern(%rip)
	movq	$0, throttlefile(%rip)
	movq	$0, hostname(%rip)
	movq	$0, logfile(%rip)
	movq	$0, pidfile(%rip)
	movq	$.LC60, user(%rip)
	movq	$.LC61, charset(%rip)
	movq	$.LC62, p3p(%rip)
	movl	$-1, max_age(%rip)
	jle	.L445
	leaq	8(%rsi), %rdi
	movq	%rsi, %r13
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L470
	movq	8(%rsi), %rbx
	movq	%rbx, %rax
	movq	%rbx, %rdx
	shrq	$3, %rax
	andl	$7, %edx
	movzbl	2147450880(%rax), %eax
	cmpb	%dl, %al
	jg	.L399
	testb	%al, %al
	jne	.L471
.L399:
	cmpb	$45, (%rbx)
	jne	.L440
	movl	$1, %ebp
	jmp	.L443
	.p2align 4,,10
	.p2align 3
.L477:
	leal	1(%rbp), %r14d
	cmpl	%r14d, %r12d
	jg	.L472
	movl	$.LC66, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L407
.L406:
	movl	$.LC67, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L407
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L407
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L473
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, dir(%rip)
.L405:
	addl	$1, %ebp
	cmpl	%ebp, %r12d
	jle	.L397
.L479:
	movslq	%ebp, %rax
	leaq	0(%r13,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L474
	movq	(%rdi), %rbx
	movq	%rbx, %rax
	movq	%rbx, %rdx
	shrq	$3, %rax
	andl	$7, %edx
	movzbl	2147450880(%rax), %eax
	cmpb	%dl, %al
	jg	.L442
	testb	%al, %al
	jne	.L475
.L442:
	cmpb	$45, (%rbx)
	jne	.L440
.L443:
	movl	$.LC63, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L476
	movl	$.LC65, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L477
	movl	$.LC66, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L406
	leal	1(%rbp), %r14d
	cmpl	%r14d, %r12d
	jle	.L407
	movslq	%r14d, %rax
	leaq	0(%r13,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L478
	movq	(%rdi), %rdi
	movl	%r14d, %ebp
	addl	$1, %ebp
	call	atoi
	cmpl	%ebp, %r12d
	movw	%ax, port(%rip)
	jg	.L479
.L397:
	cmpl	%ebp, %r12d
	jne	.L440
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L407:
	.cfi_restore_state
	movl	$.LC68, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L410
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L410:
	movl	$.LC69, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L411
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L472:
	movslq	%r14d, %rax
	leaq	0(%r13,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L480
	movq	(%rdi), %rdi
	movl	%r14d, %ebp
	call	read_config
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L411:
	movl	$.LC70, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L412
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L412
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L481
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, data_dir(%rip)
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L412:
	movl	$.LC71, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L414
	movl	$0, no_symlink_check(%rip)
	jmp	.L405
	.p2align 4,,10
	.p2align 3
.L414:
	movl	$.LC72, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L482
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L416
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L416
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L483
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, user(%rip)
	jmp	.L405
.L482:
	movl	$1, no_symlink_check(%rip)
	jmp	.L405
.L416:
	movl	$.LC74, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L418
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L418
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L484
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, cgi_pattern(%rip)
	jmp	.L405
.L418:
	movl	$.LC75, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L485
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L423
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L424
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L486
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, hostname(%rip)
	jmp	.L405
.L485:
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L421
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L487
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, throttlefile(%rip)
	jmp	.L405
.L421:
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L423
.L424:
	movl	$.LC78, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L427
	movl	$1, do_vhost(%rip)
	jmp	.L405
.L423:
	movl	$.LC77, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L424
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L424
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L488
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, logfile(%rip)
	jmp	.L405
.L427:
	movl	$.LC79, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L489
	movl	$.LC80, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L429
	movl	$1, do_global_passwd(%rip)
	jmp	.L405
.L489:
	movl	$0, do_vhost(%rip)
	jmp	.L405
.L445:
	movl	$1, %ebp
	jmp	.L397
.L429:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L430
	movl	$0, do_global_passwd(%rip)
	jmp	.L405
.L476:
	movl	$.LC64, %edi
	call	puts
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
.L430:
	movl	$.LC82, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L431
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L431
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L490
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, pidfile(%rip)
	jmp	.L405
.L431:
	movl	$.LC83, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L433
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L434
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L491
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, charset(%rip)
	jmp	.L405
.L433:
	movl	$.LC84, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L436
	leal	1(%rbp), %eax
	cmpl	%eax, %r12d
	jle	.L437
	movslq	%eax, %rdx
	leaq	0(%r13,%rdx,8), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L492
	movq	(%rdi), %rdx
	movl	%eax, %ebp
	movq	%rdx, p3p(%rip)
	jmp	.L405
.L434:
	movl	$.LC84, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L437
.L436:
	movl	$.LC85, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L437
	leal	1(%rbp), %r14d
	cmpl	%r14d, %r12d
	jle	.L437
	movslq	%r14d, %rax
	leaq	0(%r13,%rax,8), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L493
	movq	(%rdi), %rdi
	movl	%r14d, %ebp
	call	atoi
	movl	%eax, max_age(%rip)
	jmp	.L405
.L437:
	movl	$.LC86, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L440
	movl	$1, debug(%rip)
	jmp	.L405
.L488:
	call	__asan_report_load8
.L483:
	call	__asan_report_load8
.L490:
	call	__asan_report_load8
.L493:
	call	__asan_report_load8
.L491:
	call	__asan_report_load8
.L492:
	call	__asan_report_load8
.L480:
	call	__asan_report_load8
.L478:
	call	__asan_report_load8
.L475:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L471:
	movq	%rbx, %rdi
	call	__asan_report_load1
.L486:
	call	__asan_report_load8
.L487:
	call	__asan_report_load8
.L484:
	call	__asan_report_load8
.L470:
	call	__asan_report_load8
.L440:
	call	__asan_handle_no_return
	call	usage
.L474:
	call	__asan_report_load8
.L473:
	call	__asan_report_load8
.L481:
	call	__asan_report_load8
	.cfi_endproc
.LFE10:
	.size	parse_args, .-parse_args
	.section	.text.unlikely
.LCOLDE87:
	.text
.LHOTE87:
	.globl	__asan_stack_malloc_8
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC88:
	.string	"5 32 8 9 max_limit 96 8 9 min_limit 160 16 2 tv 224 5000 3 buf 5280 5000 7 pattern "
	.globl	__asan_stack_free_8
	.section	.rodata
	.align 32
.LC89:
	.string	"%.80s - %m"
	.zero	53
	.align 32
.LC90:
	.string	" %4900[^ \t] %ld-%ld"
	.zero	44
	.align 32
.LC91:
	.string	" %4900[^ \t] %ld"
	.zero	48
	.align 32
.LC92:
	.string	"unparsable line in %.80s - %.80s"
	.zero	63
	.align 32
.LC93:
	.string	"%s: unparsable line in %.80s - %.80s\n"
	.zero	58
	.align 32
.LC94:
	.string	"|/"
	.zero	61
	.align 32
.LC95:
	.string	"out of memory allocating a throttletab"
	.zero	57
	.align 32
.LC96:
	.string	"%s: out of memory allocating a throttletab\n"
	.zero	52
	.section	.text.unlikely
.LCOLDB97:
	.text
.LHOTB97:
	.p2align 4,,15
	.type	read_throttlefile, @function
read_throttlefile:
.LASANPC17:
.LFB17:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$10392, %rsp
	.cfi_def_cfa_offset 10448
	movl	__asan_option_detect_stack_use_after_return(%rip), %edx
	leaq	48(%rsp), %rax
	movq	%rdi, 16(%rsp)
	testl	%edx, %edx
	movq	%rax, 24(%rsp)
	jne	.L577
.L494:
	movq	24(%rsp), %rax
	movl	$.LC29, %esi
	movq	$1102416563, (%rax)
	movq	$.LC88, 8(%rax)
	leaq	10336(%rax), %r14
	movq	$.LASANPC17, 16(%rax)
	movq	16(%rsp), %rdi
	shrq	$3, %rax
	movq	%rax, 32(%rsp)
	movl	$-235802127, 2147450880(%rax)
	movl	$-185273344, 2147450884(%rax)
	movl	$-218959118, 2147450888(%rax)
	movl	$-185273344, 2147450892(%rax)
	movl	$-218959118, 2147450896(%rax)
	movl	$-185335808, 2147450900(%rax)
	movl	$-218959118, 2147450904(%rax)
	movl	$-185273344, 2147451532(%rax)
	movl	$-218959118, 2147451536(%rax)
	movl	$-185273344, 2147452164(%rax)
	movl	$-202116109, 2147452168(%rax)
	call	fopen
	testq	%rax, %rax
	movq	%rax, %rbp
	je	.L578
	movq	24(%rsp), %rbx
	xorl	%esi, %esi
	leaq	160(%rbx), %rdi
	leaq	224(%rbx), %r15
	leaq	32(%rbx), %r12
	leaq	96(%rbx), %r13
	call	gettimeofday
	movq	%rbx, %rax
	leaq	5280(%rbx), %rbx
	addq	$5281, %rax
	movq	%rax, 40(%rsp)
	.p2align 4,,10
	.p2align 3
.L499:
	movq	%rbp, %rdx
	movl	$5000, %esi
	movq	%r15, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L579
	movl	$35, %esi
	movq	%r15, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L500
	movq	%rax, %rdx
	movq	%rax, %rcx
	shrq	$3, %rdx
	andl	$7, %ecx
	movzbl	2147450880(%rdx), %edx
	cmpb	%cl, %dl
	jg	.L501
	testb	%dl, %dl
	jne	.L580
.L501:
	movb	$0, (%rax)
.L500:
	movq	%r15, %rdi
	call	strlen
	cmpl	$0, %eax
	jle	.L502
	subl	$1, %eax
	movslq	%eax, %rdx
	leaq	(%r15,%rdx), %rdi
	movq	%rdi, %rcx
	movq	%rdi, %rsi
	shrq	$3, %rcx
	andl	$7, %esi
	movzbl	2147450880(%rcx), %ecx
	cmpb	%sil, %cl
	jg	.L503
	testb	%cl, %cl
	jne	.L581
.L503:
	movzbl	-10112(%r14,%rdx), %ecx
	cmpb	$32, %cl
	jbe	.L582
	.p2align 4,,10
	.p2align 3
.L504:
	xorl	%eax, %eax
	movq	%r12, %r8
	movq	%r13, %rcx
	movq	%rbx, %rdx
	movl	$.LC90, %esi
	movq	%r15, %rdi
	call	__isoc99_sscanf
	cmpl	$3, %eax
	je	.L506
	xorl	%eax, %eax
	movq	%r12, %rcx
	movq	%rbx, %rdx
	movl	$.LC91, %esi
	movq	%r15, %rdi
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L512
	movq	$0, -10240(%r14)
	.p2align 4,,10
	.p2align 3
.L506:
	cmpb	$47, -5056(%r14)
	jne	.L515
	jmp	.L583
	.p2align 4,,10
	.p2align 3
.L516:
	leaq	2(%rax), %rsi
	leaq	1(%rax), %rdi
	call	strcpy
.L515:
	movl	$.LC94, %esi
	movq	%rbx, %rdi
	call	strstr
	testq	%rax, %rax
	jne	.L516
	movslq	numthrottles(%rip), %rcx
	movl	maxthrottles(%rip), %eax
	cmpl	%eax, %ecx
	jl	.L517
	testl	%eax, %eax
	jne	.L518
	movl	$4800, %edi
	movl	$100, maxthrottles(%rip)
	call	malloc
	movq	%rax, throttles(%rip)
.L519:
	testq	%rax, %rax
	je	.L520
	movslq	numthrottles(%rip), %rcx
.L521:
	leaq	(%rcx,%rcx,2), %rdx
	movq	%rbx, %rdi
	salq	$4, %rdx
	addq	%rax, %rdx
	movq	%rdx, 8(%rsp)
	call	e_strdup
	movq	8(%rsp), %rdx
	movq	%rdx, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L584
	movq	%rax, (%rdx)
	movslq	numthrottles(%rip), %rax
	movq	-10304(%r14), %rcx
	movq	%rax, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	throttles(%rip), %rax
	leaq	8(%rax), %rdi
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L585
	leaq	16(%rax), %rdi
	movq	%rcx, 8(%rax)
	movq	-10240(%r14), %rcx
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L586
	leaq	24(%rax), %rdi
	movq	%rcx, 16(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L587
	leaq	32(%rax), %rdi
	movq	$0, 24(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L588
	leaq	40(%rax), %rdi
	movq	$0, 32(%rax)
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L528
	cmpb	$3, %cl
	jle	.L589
.L528:
	movl	$0, 40(%rax)
	leal	1(%rdx), %eax
	movl	%eax, numthrottles(%rip)
	jmp	.L499
	.p2align 4,,10
	.p2align 3
.L582:
	movabsq	$4294977024, %r8
	.p2align 4,,10
	.p2align 3
.L576:
	btq	%rcx, %r8
	jnc	.L504
	leaq	(%r15,%rdx), %rdi
	movq	%rdi, %rcx
	movq	%rdi, %rsi
	shrq	$3, %rcx
	andl	$7, %esi
	movzbl	2147450880(%rcx), %ecx
	cmpb	%sil, %cl
	jg	.L508
	testb	%cl, %cl
	jne	.L590
.L508:
	testl	%eax, %eax
	movb	$0, -10112(%r14,%rdx)
	je	.L499
	subl	$1, %eax
	movslq	%eax, %rdx
	leaq	(%r15,%rdx), %rdi
	movq	%rdi, %rcx
	movq	%rdi, %rsi
	shrq	$3, %rcx
	andl	$7, %esi
	movzbl	2147450880(%rcx), %ecx
	cmpb	%sil, %cl
	jg	.L510
	testb	%cl, %cl
	jne	.L591
.L510:
	movzbl	-10112(%r14,%rdx), %ecx
	cmpb	$32, %cl
	ja	.L504
	jmp	.L576
.L518:
	addl	%eax, %eax
	movq	throttles(%rip), %rdi
	movl	%eax, maxthrottles(%rip)
	cltq
	leaq	(%rax,%rax,2), %rsi
	salq	$4, %rsi
	call	realloc
	movq	%rax, throttles(%rip)
	jmp	.L519
.L512:
	movq	16(%rsp), %rdx
	xorl	%eax, %eax
	movq	%r15, %rcx
	movl	$.LC92, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L592
	movq	16(%rsp), %rcx
	movq	stderr(%rip), %rdi
	movq	%r15, %r8
	movl	$.LC93, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L499
.L517:
	movq	throttles(%rip), %rax
	jmp	.L521
.L579:
	movq	%rbp, %rdi
	call	fclose
	leaq	48(%rsp), %rax
	cmpq	24(%rsp), %rax
	jne	.L593
	movq	32(%rsp), %rax
	movq	$0, 2147450880(%rax)
	movq	$0, 2147450888(%rax)
	movq	$0, 2147450896(%rax)
	movl	$0, 2147450904(%rax)
	movq	$0, 2147451532(%rax)
	movq	$0, 2147452164(%rax)
.L496:
	addq	$10392, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L502:
	.cfi_restore_state
	jne	.L504
	jmp	.L499
.L583:
	movq	40(%rsp), %rsi
	movq	%rbx, %rdi
	call	strcpy
	jmp	.L515
.L577:
	movq	%rax, %rsi
	movl	$10336, %edi
	call	__asan_stack_malloc_8
	movq	%rax, 24(%rsp)
	jmp	.L494
.L593:
	movq	24(%rsp), %rax
	leaq	48(%rsp), %rdx
	movl	$10336, %esi
	movq	%rax, %rdi
	movq	$1172321806, (%rax)
	call	__asan_stack_free_8
	jmp	.L496
.L592:
	movl	$stderr, %edi
	call	__asan_report_load8
.L591:
	call	__asan_report_load1
.L590:
	call	__asan_report_store1
.L589:
	call	__asan_report_store4
.L588:
	call	__asan_report_store8
.L587:
	call	__asan_report_store8
.L586:
	call	__asan_report_store8
.L585:
	call	__asan_report_store8
.L584:
	movq	%rdx, %rdi
	call	__asan_report_store8
.L520:
	xorl	%eax, %eax
	movl	$.LC95, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L594
	movq	stderr(%rip), %rdi
	movl	$.LC96, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L581:
	call	__asan_report_load1
.L594:
	movl	$stderr, %edi
	call	__asan_report_load8
.L580:
	movq	%rax, %rdi
	call	__asan_report_store1
.L578:
	movq	16(%rsp), %rbx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	movq	%rbx, %rdx
	call	syslog
	movq	%rbx, %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE17:
	.size	read_throttlefile, .-read_throttlefile
	.section	.text.unlikely
.LCOLDE97:
	.text
.LHOTE97:
	.section	.rodata
	.align 32
.LC98:
	.string	"-"
	.zero	62
	.align 32
.LC99:
	.string	"re-opening logfile"
	.zero	45
	.align 32
.LC100:
	.string	"a"
	.zero	62
	.align 32
.LC101:
	.string	"re-opening %.80s - %m"
	.zero	42
	.section	.text.unlikely
.LCOLDB102:
	.text
.LHOTB102:
	.p2align 4,,15
	.type	re_open_logfile, @function
re_open_logfile:
.LASANPC8:
.LFB8:
	.cfi_startproc
	movl	no_log(%rip), %eax
	testl	%eax, %eax
	jne	.L608
	cmpq	$0, hs(%rip)
	je	.L608
	movq	logfile(%rip), %rdi
	testq	%rdi, %rdi
	je	.L608
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	$.LC98, %esi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strcmp
	testl	%eax, %eax
	jne	.L609
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
.L608:
	rep ret
	.p2align 4,,10
	.p2align 3
.L609:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	xorl	%eax, %eax
	movl	$.LC99, %esi
	movl	$5, %edi
	call	syslog
	movq	logfile(%rip), %rdi
	movl	$.LC100, %esi
	call	fopen
	movq	logfile(%rip), %rbp
	movq	%rax, %rbx
	movl	$384, %esi
	movq	%rbp, %rdi
	call	chmod
	testq	%rbx, %rbx
	je	.L599
	testl	%eax, %eax
	jne	.L599
	movq	%rbx, %rdi
	call	fileno
	movl	$2, %esi
	movl	%eax, %edi
	movl	$1, %edx
	xorl	%eax, %eax
	call	fcntl
	movq	hs(%rip), %rdi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	httpd_set_logfp
	.p2align 4,,10
	.p2align 3
.L599:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movl	$.LC101, %esi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	syslog
	.cfi_endproc
.LFE8:
	.size	re_open_logfile, .-re_open_logfile
	.section	.text.unlikely
.LCOLDE102:
	.text
.LHOTE102:
	.section	.rodata
	.align 32
.LC103:
	.string	"too many connections!"
	.zero	42
	.align 32
.LC104:
	.string	"the connects free list is messed up"
	.zero	60
	.align 32
.LC105:
	.string	"out of memory allocating an httpd_conn"
	.zero	57
	.section	.text.unlikely
.LCOLDB106:
	.text
.LHOTB106:
	.p2align 4,,15
	.type	handle_newconnect, @function
handle_newconnect:
.LASANPC19:
.LFB19:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	%esi, %r12d
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbp
	shrq	$3, %r13
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	movl	num_connects(%rip), %eax
.L634:
	cmpl	%eax, max_connects(%rip)
	jle	.L686
	movslq	first_free_connect(%rip), %rax
	cmpl	$-1, %eax
	je	.L613
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	connects(%rip), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L614
	cmpb	$3, %al
	jle	.L687
.L614:
	movl	(%rbx), %eax
	testl	%eax, %eax
	jne	.L613
	leaq	8(%rbx), %r14
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L688
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L689
.L617:
	movq	hs(%rip), %rdi
	movl	%r12d, %esi
	call	httpd_get_conn
	testl	%eax, %eax
	je	.L621
	cmpl	$2, %eax
	je	.L636
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L622
	cmpb	$3, %al
	jle	.L690
.L622:
	leaq	4(%rbx), %rdi
	movl	$1, (%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L623
	testb	%dl, %dl
	jne	.L691
.L623:
	addl	$1, num_connects(%rip)
	cmpb	$0, 2147450880(%r13)
	movl	4(%rbx), %eax
	movl	$-1, 4(%rbx)
	movl	%eax, first_free_connect(%rip)
	jne	.L692
	leaq	88(%rbx), %rdi
	movq	0(%rbp), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L693
	leaq	96(%rbx), %rdi
	movq	%rax, 88(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L694
	leaq	104(%rbx), %rdi
	movq	$0, 96(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L695
	leaq	136(%rbx), %rdi
	movq	$0, 104(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L696
	leaq	56(%rbx), %rdi
	movq	$0, 136(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L629
	cmpb	$3, %al
	jle	.L697
.L629:
	movq	%r14, %rax
	movl	$0, 56(%rbx)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L698
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L631
	cmpb	$3, %dl
	jle	.L699
.L631:
	movl	704(%rax), %edi
	call	httpd_set_ndelay
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L700
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L633
	cmpb	$3, %dl
	jle	.L701
.L633:
	movl	704(%rax), %edi
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	fdwatch_add_fd
	addq	$1, stats_connections(%rip)
	movl	num_connects(%rip), %eax
	cmpl	stats_simultaneous(%rip), %eax
	jle	.L634
	movl	%eax, stats_simultaneous(%rip)
	jmp	.L634
	.p2align 4,,10
	.p2align 3
.L636:
	movl	$1, %eax
.L612:
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L621:
	.cfi_restore_state
	movq	%rbp, %rdi
	movl	%eax, 12(%rsp)
	call	tmr_run
	movl	12(%rsp), %eax
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L689:
	.cfi_restore_state
	movl	$720, %edi
	call	malloc
	testq	%rax, %rax
	movq	%rax, 8(%rbx)
	je	.L702
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L619
	cmpb	$3, %dl
	jle	.L703
.L619:
	movl	$0, (%rax)
	addl	$1, httpd_conn_count(%rip)
	movq	%rax, %rdx
	jmp	.L617
.L703:
	movq	%rax, %rdi
	call	__asan_report_store4
	.p2align 4,,10
	.p2align 3
.L686:
	xorl	%eax, %eax
	movl	$.LC103, %esi
	movl	$4, %edi
	call	syslog
	movq	%rbp, %rdi
	call	tmr_run
	xorl	%eax, %eax
	jmp	.L612
.L613:
	movl	$2, %edi
	movl	$.LC104, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L702:
	movl	$2, %edi
	movl	$.LC105, %esi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L694:
	call	__asan_report_store8
.L687:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L691:
	call	__asan_report_load4
.L692:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L693:
	call	__asan_report_store8
.L688:
	movq	%r14, %rdi
	call	__asan_report_load8
.L695:
	call	__asan_report_store8
.L696:
	call	__asan_report_store8
.L697:
	call	__asan_report_store4
.L698:
	movq	%r14, %rdi
	call	__asan_report_load8
.L699:
	call	__asan_report_load4
.L700:
	movq	%r14, %rdi
	call	__asan_report_load8
.L701:
	call	__asan_report_load4
.L690:
	movq	%rbx, %rdi
	call	__asan_report_store4
	.cfi_endproc
.LFE19:
	.size	handle_newconnect, .-handle_newconnect
	.section	.text.unlikely
.LCOLDE106:
	.text
.LHOTE106:
	.section	.rodata
	.align 32
.LC107:
	.string	"throttle sending count was negative - shouldn't happen!"
	.zero	40
	.section	.text.unlikely
.LCOLDB108:
	.text
.LHOTB108:
	.p2align 4,,15
	.type	check_throttles, @function
check_throttles:
.LASANPC23:
.LFB23:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	56(%rdi), %rax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%rax, 16(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L705
	cmpb	$3, %al
	jle	.L786
.L705:
	leaq	72(%rbx), %rax
	movl	$0, 56(%rbx)
	movq	%rax, 32(%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L787
	leaq	64(%rbx), %rcx
	movq	$-1, 72(%rbx)
	movq	%rcx, %r13
	movq	%rcx, 24(%rsp)
	shrq	$3, %r13
	cmpb	$0, 2147450880(%r13)
	jne	.L788
	movl	numthrottles(%rip), %edx
	leaq	8(%rbx), %rcx
	xorl	%r14d, %r14d
	movq	$-1, 64(%rbx)
	movq	%rcx, 40(%rsp)
	testl	%edx, %edx
	jle	.L731
	movq	16(%rsp), %rbp
	leaq	8(%rbx), %r12
	movq	%rax, 8(%rsp)
	shrq	$3, %r12
	shrq	$3, %rbp
	jmp	.L766
	.p2align 4,,10
	.p2align 3
.L802:
	addl	$1, %ecx
	movslq	%ecx, %r11
.L719:
	movzbl	2147450880(%rbp), %edx
	testb	%dl, %dl
	je	.L723
	cmpb	$3, %dl
	jle	.L789
.L723:
	movslq	56(%rbx), %rdx
	leal	1(%rdx), %r8d
	leaq	16(%rbx,%rdx,4), %r10
	movl	%r8d, 56(%rbx)
	movq	%r10, %r8
	shrq	$3, %r8
	movzbl	2147450880(%r8), %r15d
	movq	%r10, %r8
	andl	$7, %r8d
	addl	$3, %r8d
	cmpb	%r15b, %r8b
	jl	.L724
	testb	%r15b, %r15b
	jne	.L790
.L724:
	movl	%r14d, 16(%rbx,%rdx,4)
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L725
	cmpb	$3, %dl
	jle	.L791
.L725:
	cqto
	movl	%ecx, 40(%rsi)
	idivq	%r11
	cmpb	$0, 2147450880(%r13)
	jne	.L792
	movq	64(%rbx), %rdx
	cmpq	$-1, %rdx
	je	.L784
	cmpq	%rdx, %rax
	cmovg	%rdx, %rax
.L784:
	movq	%rax, 64(%rbx)
	movq	8(%rsp), %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L793
	movq	72(%rbx), %rax
	cmpq	$-1, %rax
	je	.L785
	cmpq	%r9, %rax
	cmovge	%rax, %r9
.L785:
	movq	%r9, 72(%rbx)
.L713:
	addl	$1, %r14d
	cmpl	%r14d, numthrottles(%rip)
	jle	.L731
	movzbl	2147450880(%rbp), %eax
	testb	%al, %al
	je	.L732
	cmpb	$3, %al
	jle	.L794
.L732:
	cmpl	$9, 56(%rbx)
	jg	.L731
.L766:
	cmpb	$0, 2147450880(%r12)
	jne	.L795
	movq	8(%rbx), %rax
	leaq	240(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L796
	movq	240(%rax), %rsi
	movslq	%r14d, %rax
	leaq	(%rax,%rax,2), %r15
	salq	$4, %r15
	movq	%r15, %rdi
	addq	throttles(%rip), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L797
	movq	(%rdi), %rdi
	call	match
	testl	%eax, %eax
	je	.L713
	movq	%r15, %rsi
	addq	throttles(%rip), %rsi
	leaq	24(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L798
	leaq	8(%rsi), %rdi
	movq	24(%rsi), %rdx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L799
	movq	8(%rsi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rcx, %rdx
	jg	.L735
	leaq	16(%rsi), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L800
	movq	16(%rsi), %r9
	cmpq	%r9, %rdx
	jl	.L735
	leaq	40(%rsi), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L717
	cmpb	$3, %dl
	jle	.L801
.L717:
	movl	40(%rsi), %ecx
	testl	%ecx, %ecx
	jns	.L802
	xorl	%eax, %eax
	movl	$.LC107, %esi
	movl	$3, %edi
	call	syslog
	movq	%r15, %rsi
	addq	throttles(%rip), %rsi
	leaq	40(%rsi), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L720
	cmpb	$3, %al
	jle	.L803
.L720:
	leaq	8(%rsi), %rax
	movl	$0, 40(%rsi)
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L804
	leaq	16(%rsi), %rcx
	movq	8(%rsi), %rax
	movq	%rcx, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L805
	movq	16(%rsi), %r9
	movl	$1, %r11d
	movl	$1, %ecx
	jmp	.L719
	.p2align 4,,10
	.p2align 3
.L731:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L735:
	.cfi_restore_state
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L803:
	.cfi_restore_state
	call	__asan_report_store4
.L793:
	movq	32(%rsp), %rdi
	call	__asan_report_load8
.L792:
	movq	24(%rsp), %rdi
	call	__asan_report_load8
.L794:
	movq	16(%rsp), %rdi
	call	__asan_report_load4
.L800:
	call	__asan_report_load8
.L799:
	call	__asan_report_load8
.L798:
	call	__asan_report_load8
.L791:
	call	__asan_report_store4
.L790:
	movq	%r10, %rdi
	call	__asan_report_store4
.L789:
	movq	16(%rsp), %rdi
	call	__asan_report_load4
.L801:
	call	__asan_report_load4
.L797:
	call	__asan_report_load8
.L796:
	call	__asan_report_load8
.L795:
	movq	40(%rsp), %rdi
	call	__asan_report_load8
.L788:
	movq	%rcx, %rdi
	call	__asan_report_store8
.L787:
	movq	32(%rsp), %rdi
	call	__asan_report_store8
.L786:
	movq	16(%rsp), %rdi
	call	__asan_report_store4
.L805:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L804:
	movq	%rax, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE23:
	.size	check_throttles, .-check_throttles
	.section	.text.unlikely
.LCOLDE108:
	.text
.LHOTE108:
	.section	.text.unlikely
.LCOLDB109:
	.text
.LHOTB109:
	.p2align 4,,15
	.type	shut_down, @function
shut_down:
.LASANPC18:
.LFB18:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movl	__asan_option_detect_stack_use_after_return(%rip), %esi
	leaq	16(%rsp), %r12
	testl	%esi, %esi
	jne	.L860
.L806:
	leaq	32(%r12), %rbx
	movq	%r12, %r13
	movq	$1102416563, (%r12)
	shrq	$3, %r13
	movq	$.LC14, 8(%r12)
	movq	$.LASANPC18, 16(%r12)
	xorl	%esi, %esi
	movq	%rbx, %rdi
	movl	$-235802127, 2147450880(%r13)
	movl	$-185335808, 2147450884(%r13)
	movl	$-202116109, 2147450888(%r13)
	xorl	%ebp, %ebp
	call	gettimeofday
	movq	%rbx, %rdi
	call	logstats
	movl	max_connects(%rip), %ecx
	movq	%rbx, 8(%rsp)
	testl	%ecx, %ecx
	jg	.L847
	jmp	.L821
	.p2align 4,,10
	.p2align 3
.L814:
	leaq	8(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L861
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L817
	call	httpd_destroy_conn
	addq	connects(%rip), %rbx
	leaq	8(%rbx), %r15
	movq	%r15, %r14
	shrq	$3, %r14
	cmpb	$0, 2147450880(%r14)
	jne	.L862
	movq	8(%rbx), %rdi
	call	free
	subl	$1, httpd_conn_count(%rip)
	cmpb	$0, 2147450880(%r14)
	jne	.L863
	movq	$0, 8(%rbx)
.L817:
	addl	$1, %ebp
	cmpl	%ebp, max_connects(%rip)
	jle	.L821
.L847:
	movslq	%ebp, %rax
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L813
	cmpb	$3, %dl
	jle	.L864
.L813:
	movl	(%rax), %edx
	testl	%edx, %edx
	je	.L814
	leaq	8(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L865
	movq	8(%rax), %rdi
	movq	8(%rsp), %rsi
	call	httpd_close_conn
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	jmp	.L814
	.p2align 4,,10
	.p2align 3
.L821:
	movq	hs(%rip), %rbx
	testq	%rbx, %rbx
	je	.L812
	leaq	72(%rbx), %rdi
	movq	$0, hs(%rip)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L822
	cmpb	$3, %al
	jle	.L866
.L822:
	movl	72(%rbx), %edi
	cmpl	$-1, %edi
	je	.L823
	call	fdwatch_del_fd
.L823:
	leaq	76(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L824
	testb	%dl, %dl
	jne	.L867
.L824:
	movl	76(%rbx), %edi
	cmpl	$-1, %edi
	je	.L825
	call	fdwatch_del_fd
.L825:
	movq	%rbx, %rdi
	call	httpd_terminate
.L812:
	call	mmc_destroy
	call	tmr_destroy
	movq	connects(%rip), %rdi
	call	free
	movq	throttles(%rip), %rdi
	testq	%rdi, %rdi
	je	.L809
	call	free
.L809:
	leaq	16(%rsp), %rax
	cmpq	%r12, %rax
	jne	.L868
	movq	$0, 2147450880(%r13)
	movl	$0, 2147450888(%r13)
.L808:
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L867:
	.cfi_restore_state
	call	__asan_report_load4
.L866:
	call	__asan_report_load4
.L865:
	call	__asan_report_load8
.L863:
	movq	%r15, %rdi
	call	__asan_report_store8
.L862:
	movq	%r15, %rdi
	call	__asan_report_load8
.L861:
	call	__asan_report_load8
.L864:
	movq	%rax, %rdi
	call	__asan_report_load4
.L860:
	movq	%r12, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %r12
	jmp	.L806
.L868:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%r12)
	movl	$-168430091, 2147450888(%r13)
	movq	%rax, 2147450880(%r13)
	jmp	.L808
	.cfi_endproc
.LFE18:
	.size	shut_down, .-shut_down
	.section	.text.unlikely
.LCOLDE109:
	.text
.LHOTE109:
	.section	.rodata
	.align 32
.LC110:
	.string	"exiting"
	.zero	56
	.section	.text.unlikely
.LCOLDB111:
	.text
.LHOTB111:
	.p2align 4,,15
	.type	handle_usr1, @function
handle_usr1:
.LASANPC5:
.LFB5:
	.cfi_startproc
	movl	num_connects(%rip), %edx
	testl	%edx, %edx
	je	.L872
	movl	$1, got_usr1(%rip)
	ret
.L872:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	shut_down
	movl	$5, %edi
	movl	$.LC110, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
	.cfi_endproc
.LFE5:
	.size	handle_usr1, .-handle_usr1
	.section	.text.unlikely
.LCOLDE111:
	.text
.LHOTE111:
	.section	.rodata
	.align 32
.LC112:
	.string	"exiting due to signal %d"
	.zero	39
	.section	.text.unlikely
.LCOLDB113:
	.text
.LHOTB113:
	.p2align 4,,15
	.type	handle_term, @function
handle_term:
.LASANPC2:
.LFB2:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	call	shut_down
	movl	$5, %edi
	movl	%ebx, %edx
	movl	$.LC112, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE2:
	.size	handle_term, .-handle_term
	.section	.text.unlikely
.LCOLDE113:
	.text
.LHOTE113:
	.section	.text.unlikely
.LCOLDB114:
	.text
.LHOTB114:
	.p2align 4,,15
	.type	clear_throttles.isra.0, @function
clear_throttles.isra.0:
.LASANPC36:
.LFB36:
	.cfi_startproc
	leaq	56(%rdi), %rdx
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L876
	cmpb	$3, %al
	jle	.L902
.L876:
	movl	56(%rdi), %eax
	testl	%eax, %eax
	jle	.L875
	subl	$1, %eax
	movq	throttles(%rip), %r8
	leaq	16(%rdi), %rdx
	leaq	20(%rdi,%rax,4), %rsi
	.p2align 4,,10
	.p2align 3
.L880:
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	movq	%rdx, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	jl	.L878
	testb	%cl, %cl
	jne	.L903
.L878:
	movslq	(%rdx), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r8, %rax
	leaq	40(%rax), %rdi
	movq	%rdi, %rcx
	shrq	$3, %rcx
	movzbl	2147450880(%rcx), %ecx
	testb	%cl, %cl
	je	.L879
	cmpb	$3, %cl
	jle	.L904
.L879:
	addq	$4, %rdx
	subl	$1, 40(%rax)
	cmpq	%rsi, %rdx
	jne	.L880
.L875:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L902:
	.cfi_restore_state
	movq	%rdx, %rdi
	call	__asan_report_load4
.L904:
	call	__asan_report_load4
.L903:
	movq	%rdx, %rdi
	call	__asan_report_load4
	.cfi_endproc
.LFE36:
	.size	clear_throttles.isra.0, .-clear_throttles.isra.0
	.section	.text.unlikely
.LCOLDE114:
	.text
.LHOTE114:
	.section	.text.unlikely
.LCOLDB115:
	.text
.LHOTB115:
	.p2align 4,,15
	.type	really_clear_connection, @function
really_clear_connection:
.LASANPC28:
.LFB28:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	8(%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rbp, %rax
	shrq	$3, %rax
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	cmpb	$0, 2147450880(%rax)
	jne	.L945
	movq	%rdi, %rbx
	movq	8(%rdi), %rdi
	leaq	200(%rdi), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L946
	movq	200(%rdi), %rax
	addq	%rax, stats_bytes(%rip)
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L908
	cmpb	$3, %al
	jle	.L947
.L908:
	cmpl	$3, (%rbx)
	je	.L909
	leaq	704(%rdi), %rdx
	movq	%rdx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L910
	cmpb	$3, %al
	jle	.L948
.L910:
	movl	704(%rdi), %edi
	movq	%rsi, 8(%rsp)
	call	fdwatch_del_fd
	movq	%rbp, %rax
	movq	8(%rsp), %rsi
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L949
	movq	8(%rbx), %rdi
.L909:
	leaq	104(%rbx), %r12
	call	httpd_close_conn
	movq	%r12, %rbp
	movq	%rbx, %rdi
	shrq	$3, %rbp
	call	clear_throttles.isra.0
	cmpb	$0, 2147450880(%rbp)
	jne	.L950
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L913
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L951
	movq	$0, 104(%rbx)
.L913:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L915
	cmpb	$3, %al
	jle	.L952
.L915:
	leaq	4(%rbx), %rdi
	movl	$0, (%rbx)
	movl	first_free_connect(%rip), %ecx
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L916
	testb	%dl, %dl
	jne	.L953
.L916:
	movl	%ecx, 4(%rbx)
	subq	connects(%rip), %rbx
	movabsq	$-8198552921648689607, %rax
	subl	$1, num_connects(%rip)
	sarq	$4, %rbx
	imulq	%rax, %rbx
	movl	%ebx, first_free_connect(%rip)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L947:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_load4
.L953:
	call	__asan_report_store4
.L952:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L948:
	movq	%rdx, %rdi
	call	__asan_report_load4
.L949:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L945:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L950:
	movq	%r12, %rdi
	call	__asan_report_load8
.L951:
	movq	%r12, %rdi
	call	__asan_report_store8
.L946:
	movq	%rax, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE28:
	.size	really_clear_connection, .-really_clear_connection
	.section	.text.unlikely
.LCOLDE115:
	.text
.LHOTE115:
	.section	.rodata
	.align 32
.LC116:
	.string	"replacing non-null linger_timer!"
	.zero	63
	.align 32
.LC117:
	.string	"tmr_create(linger_clear_connection) failed"
	.zero	53
	.section	.text.unlikely
.LCOLDB118:
	.text
.LHOTB118:
	.p2align 4,,15
	.type	clear_connection, @function
clear_connection:
.LASANPC27:
.LFB27:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	96(%rdi), %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%r13, %rbp
	shrq	$3, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	cmpb	$0, 2147450880(%rbp)
	jne	.L1027
	movq	%rdi, %rbx
	movq	96(%rdi), %rdi
	movq	%rsi, %r12
	testq	%rdi, %rdi
	je	.L956
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L1028
	movq	$0, 96(%rbx)
.L956:
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L958
	cmpb	$3, %al
	jle	.L1029
.L958:
	movl	(%rbx), %ecx
	cmpl	$4, %ecx
	je	.L1030
	leaq	8(%rbx), %rbp
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1031
	movq	8(%rbx), %rax
	leaq	556(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %esi
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%sil, %dl
	jl	.L966
	testb	%sil, %sil
	jne	.L1032
.L966:
	movl	556(%rax), %edx
	testl	%edx, %edx
	je	.L964
	cmpl	$3, %ecx
	je	.L967
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L968
	cmpb	$3, %dl
	jle	.L1033
.L968:
	movl	704(%rax), %edi
	call	fdwatch_del_fd
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1034
	movq	8(%rbx), %rax
.L967:
	movq	%rbx, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L970
	cmpb	$3, %dl
	jle	.L1035
.L970:
	leaq	704(%rax), %rdi
	movl	$4, (%rbx)
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L971
	cmpb	$3, %dl
	jle	.L1036
.L971:
	movl	704(%rax), %edi
	movl	$1, %esi
	call	shutdown
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1037
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L973
	cmpb	$3, %dl
	jle	.L1038
.L973:
	movl	704(%rax), %edi
	leaq	104(%rbx), %rbp
	xorl	%edx, %edx
	movq	%rbx, %rsi
	call	fdwatch_add_fd
	movq	%rbp, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1039
	cmpq	$0, 104(%rbx)
	je	.L975
	movl	$.LC116, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L975:
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$500, %ecx
	movl	$linger_clear_connection, %esi
	movq	%r12, %rdi
	call	tmr_create
	movq	%rbp, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1040
	testq	%rax, %rax
	movq	%rax, 104(%rbx)
	je	.L1041
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1030:
	.cfi_restore_state
	leaq	104(%rbx), %r13
	movq	%r13, %rbp
	shrq	$3, %rbp
	cmpb	$0, 2147450880(%rbp)
	jne	.L1042
	movq	104(%rbx), %rdi
	call	tmr_cancel
	cmpb	$0, 2147450880(%rbp)
	jne	.L1043
	leaq	8(%rbx), %rdi
	movq	$0, 104(%rbx)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1044
	movq	8(%rbx), %rdx
	leaq	556(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	jl	.L963
	testb	%cl, %cl
	jne	.L1045
.L963:
	movl	$0, 556(%rdx)
.L964:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r12, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	really_clear_connection
.L1029:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1038:
	call	__asan_report_load4
.L1036:
	call	__asan_report_load4
.L1035:
	movq	%rbx, %rdi
	call	__asan_report_store4
.L1032:
	call	__asan_report_load4
.L1033:
	call	__asan_report_load4
.L1041:
	movl	$2, %edi
	movl	$.LC117, %esi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1039:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1027:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1034:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1045:
	call	__asan_report_store4
.L1044:
	call	__asan_report_load8
.L1043:
	movq	%r13, %rdi
	call	__asan_report_store8
.L1042:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1031:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1037:
	movq	%rbp, %rdi
	call	__asan_report_load8
.L1040:
	movq	%rbp, %rdi
	call	__asan_report_store8
.L1028:
	movq	%r13, %rdi
	call	__asan_report_store8
	.cfi_endproc
.LFE27:
	.size	clear_connection, .-clear_connection
	.section	.text.unlikely
.LCOLDE118:
	.text
.LHOTE118:
	.section	.text.unlikely
.LCOLDB119:
	.text
.LHOTB119:
	.p2align 4,,15
	.type	finish_connection, @function
finish_connection:
.LASANPC26:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	addq	$8, %rdi
	movq	%rdi, %rax
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1049
	movq	8(%rbx), %rdi
	movq	%rsi, %rbp
	call	httpd_write_response
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	clear_connection
.L1049:
	.cfi_restore_state
	call	__asan_report_load8
	.cfi_endproc
.LFE26:
	.size	finish_connection, .-finish_connection
	.section	.text.unlikely
.LCOLDE119:
	.text
.LHOTE119:
	.section	.text.unlikely
.LCOLDB120:
	.text
.LHOTB120:
	.p2align 4,,15
	.type	handle_read, @function
handle_read:
.LASANPC20:
.LFB20:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	addq	$8, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rax
	shrq	$3, %rax
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	cmpb	$0, 2147450880(%rax)
	jne	.L1170
	movq	8(%rbp), %rbx
	leaq	160(%rbx), %r13
	movq	%r13, %r15
	shrq	$3, %r15
	cmpb	$0, 2147450880(%r15)
	jne	.L1171
	leaq	152(%rbx), %r14
	movq	%rsi, %r12
	movq	160(%rbx), %rsi
	movq	%r14, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1172
	movq	152(%rbx), %rdx
	leaq	144(%rbx), %rcx
	cmpq	%rdx, %rsi
	jb	.L1054
	cmpq	$5000, %rdx
	jbe	.L1055
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1173
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1174
.L1076:
	movq	httpd_err400title(%rip), %rdx
	movl	$.LC62, %r9d
	movl	$400, %esi
	movq	%r9, %rcx
	movq	%rbx, %rdi
	call	httpd_send_err
.L1169:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rsi
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	finish_connection
	.p2align 4,,10
	.p2align 3
.L1055:
	.cfi_restore_state
	leaq	144(%rbx), %rcx
	addq	$1000, %rdx
	movq	%r14, %rsi
	movq	%rax, 8(%rsp)
	movq	%rcx, %rdi
	movq	%rcx, (%rsp)
	call	httpd_realloc_str
	movq	8(%rsp), %rax
	movq	(%rsp), %rcx
	cmpb	$0, 2147450880(%rax)
	jne	.L1175
	cmpb	$0, 2147450880(%r15)
	movq	152(%rbx), %rdx
	jne	.L1176
	movq	160(%rbx), %rsi
.L1054:
	movq	%rcx, %rax
	subq	%rsi, %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1177
	leaq	704(%rbx), %r14
	addq	144(%rbx), %rsi
	movq	%r14, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1061
	cmpb	$3, %al
	jle	.L1178
.L1061:
	movl	704(%rbx), %edi
	call	read
	testl	%eax, %eax
	je	.L1179
	js	.L1180
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1181
	cltq
	addq	%rax, 160(%rbx)
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1182
	leaq	88(%rbp), %rdi
	movq	(%r12), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1183
	movq	%rax, 88(%rbp)
	movq	%rbx, %rdi
	call	httpd_got_request
	testl	%eax, %eax
	je	.L1050
	cmpl	$2, %eax
	jne	.L1167
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1184
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1076
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1180:
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rax, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1066
	testb	%cl, %cl
	jne	.L1185
.L1066:
	movl	(%rax), %eax
	cmpl	$4, %eax
	jne	.L1186
.L1050:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1179:
	.cfi_restore_state
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1187
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1076
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1186:
	cmpl	$11, %eax
	je	.L1050
	movl	$httpd_err400form, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1188
	movl	$httpd_err400title, %eax
	movq	httpd_err400form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	je	.L1076
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
	.p2align 4,,10
	.p2align 3
.L1167:
	movq	%rbx, %rdi
	call	httpd_parse_request
	testl	%eax, %eax
	js	.L1169
	movq	%rbp, %rdi
	call	check_throttles
	testl	%eax, %eax
	je	.L1189
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	httpd_start_request
	testl	%eax, %eax
	js	.L1169
	leaq	528(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1083
	cmpb	$3, %al
	jle	.L1190
.L1083:
	movl	528(%rbx), %eax
	testl	%eax, %eax
	je	.L1084
	leaq	536(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1191
	leaq	136(%rbp), %rdi
	movq	536(%rbx), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1192
	leaq	544(%rbx), %rdi
	movq	%rax, 136(%rbp)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1193
	leaq	128(%rbp), %rdi
	movq	544(%rbx), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	addq	$1, %rax
	cmpb	$0, 2147450880(%rdx)
	jne	.L1194
.L1093:
	movq	%rax, 128(%rbp)
.L1089:
	leaq	712(%rbx), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1195
	cmpq	$0, 712(%rbx)
	je	.L1196
	leaq	136(%rbp), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1197
	movq	%rdi, %rdx
	movq	136(%rbp), %rax
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1198
	cmpq	128(%rbp), %rax
	jge	.L1169
	movq	%rbp, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1107
	cmpb	$3, %al
	jle	.L1199
.L1107:
	movq	%r12, %rax
	movl	$2, 0(%rbp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1200
	leaq	80(%rbp), %rdi
	movq	(%r12), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1201
	leaq	112(%rbp), %rdi
	movq	%rax, 80(%rbp)
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1202
	movq	%r14, %rax
	movq	$0, 112(%rbp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1111
	cmpb	$3, %al
	jle	.L1203
.L1111:
	movl	704(%rbx), %edi
	call	fdwatch_del_fd
	movq	%r14, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1112
	cmpb	$3, %al
	jle	.L1204
.L1112:
	movl	704(%rbx), %edi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	movl	$1, %edx
	jmp	fdwatch_add_fd
	.p2align 4,,10
	.p2align 3
.L1189:
	.cfi_restore_state
	leaq	208(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1205
	movl	$httpd_err503form, %eax
	movq	208(%rbx), %r9
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1206
	movl	$httpd_err503title, %eax
	movq	httpd_err503form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1207
	movq	httpd_err503title(%rip), %rdx
	movl	$.LC62, %ecx
	movl	$503, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
	jmp	.L1169
.L1178:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1185:
	movq	%rax, %rdi
	call	__asan_report_load4
	.p2align 4,,10
	.p2align 3
.L1084:
	leaq	192(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1208
	movq	192(%rbx), %rax
	leaq	128(%rbp), %rdi
	testq	%rax, %rax
	js	.L1209
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	je	.L1093
	call	__asan_report_store8
	.p2align 4,,10
	.p2align 3
.L1196:
	leaq	56(%rbp), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1096
	cmpb	$3, %al
	jle	.L1210
.L1096:
	movl	56(%rbp), %eax
	testl	%eax, %eax
	jle	.L1211
	leaq	200(%rbx), %rdi
	movq	throttles(%rip), %r8
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1212
	subl	$1, %eax
	movq	200(%rbx), %rsi
	leaq	16(%rbp), %rdi
	leaq	20(%rbp,%rax,4), %r9
	.p2align 4,,10
	.p2align 3
.L1103:
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L1101
	testb	%dl, %dl
	jne	.L1213
.L1101:
	movslq	(%rdi), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r8, %rax
	leaq	32(%rax), %rdx
	movq	%rdx, %rcx
	shrq	$3, %rcx
	cmpb	$0, 2147450880(%rcx)
	jne	.L1214
	addq	$4, %rdi
	addq	%rsi, 32(%rax)
	cmpq	%r9, %rdi
	jne	.L1103
.L1099:
	leaq	136(%rbp), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1215
	movq	%rsi, 136(%rbp)
	jmp	.L1169
.L1209:
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1216
	movq	$0, 128(%rbp)
	jmp	.L1089
.L1211:
	leaq	200(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1217
	movq	200(%rbx), %rsi
	jmp	.L1099
.L1184:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1214:
	movq	%rdx, %rdi
	call	__asan_report_load8
.L1212:
	call	__asan_report_load8
.L1213:
	call	__asan_report_load4
.L1216:
	call	__asan_report_store8
.L1197:
	movq	%rax, %rdi
	call	__asan_report_load8
.L1210:
	call	__asan_report_load4
.L1217:
	call	__asan_report_load8
.L1207:
	movl	$httpd_err503title, %edi
	call	__asan_report_load8
.L1206:
	movl	$httpd_err503form, %edi
	call	__asan_report_load8
.L1205:
	call	__asan_report_load8
.L1187:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1171:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1170:
	call	__asan_report_load8
.L1181:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1182:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1175:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1176:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1173:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1174:
	movl	$httpd_err400title, %edi
	call	__asan_report_load8
.L1177:
	movq	%rcx, %rdi
	call	__asan_report_load8
.L1172:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1183:
	call	__asan_report_store8
.L1188:
	movl	$httpd_err400form, %edi
	call	__asan_report_load8
.L1191:
	call	__asan_report_load8
.L1190:
	call	__asan_report_load4
.L1199:
	movq	%rbp, %rdi
	call	__asan_report_store4
.L1201:
	call	__asan_report_store8
.L1200:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1202:
	call	__asan_report_store8
.L1204:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1195:
	movq	%rax, %rdi
	call	__asan_report_load8
.L1194:
	call	__asan_report_store8
.L1193:
	call	__asan_report_load8
.L1192:
	call	__asan_report_store8
.L1198:
	call	__asan_report_load8
.L1203:
	movq	%r14, %rdi
	call	__asan_report_load4
.L1208:
	call	__asan_report_load8
.L1215:
	call	__asan_report_store8
	.cfi_endproc
.LFE20:
	.size	handle_read, .-handle_read
	.section	.text.unlikely
.LCOLDE120:
	.text
.LHOTE120:
	.section	.rodata
	.align 32
.LC121:
	.string	"%.80s connection timed out reading"
	.zero	61
	.align 32
.LC122:
	.string	"%.80s connection timed out sending"
	.zero	61
	.section	.text.unlikely
.LCOLDB123:
	.text
.LHOTB123:
	.p2align 4,,15
	.type	idle, @function
idle:
.LASANPC29:
.LFB29:
	.cfi_startproc
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L1248
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %r15
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	$httpd_err408form, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	shrq	$3, %r12
	xorl	%ebp, %ebp
	movq	%rsi, %r14
	shrq	$3, %r15
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%r12, 8(%rsp)
	jmp	.L1241
	.p2align 4,,10
	.p2align 3
.L1254:
	jl	.L1221
	cmpl	$3, %eax
	jg	.L1221
	cmpb	$0, 2147450880(%r15)
	jne	.L1249
	leaq	88(%rbx), %rdi
	movq	(%r14), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1250
	subq	88(%rbx), %rax
	cmpq	$299, %rax
	jg	.L1251
.L1221:
	addl	$1, %ebp
	cmpl	%ebp, max_connects(%rip)
	jle	.L1252
.L1241:
	movslq	%ebp, %rax
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	connects(%rip), %rbx
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1220
	cmpb	$3, %al
	jle	.L1253
.L1220:
	movl	(%rbx), %eax
	cmpl	$1, %eax
	jne	.L1254
	cmpb	$0, 2147450880(%r15)
	jne	.L1255
	leaq	88(%rbx), %rdi
	movq	(%r14), %rax
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1256
	subq	88(%rbx), %rax
	cmpq	$59, %rax
	jle	.L1221
	leaq	8(%rbx), %r13
	movq	%r13, %r12
	shrq	$3, %r12
	cmpb	$0, 2147450880(%r12)
	jne	.L1257
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC121, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	8(%rsp), %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1258
	movl	$httpd_err408title, %eax
	movq	httpd_err408form(%rip), %r8
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1259
	cmpb	$0, 2147450880(%r12)
	movq	httpd_err408title(%rip), %rdx
	jne	.L1260
	movq	8(%rbx), %rdi
	movl	$.LC62, %r9d
	movl	$408, %esi
	movq	%r9, %rcx
	addl	$1, %ebp
	call	httpd_send_err
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	cmpl	%ebp, max_connects(%rip)
	jg	.L1241
	.p2align 4,,10
	.p2align 3
.L1252:
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_restore 14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_restore 15
	.cfi_def_cfa_offset 8
.L1248:
	rep ret
	.p2align 4,,10
	.p2align 3
.L1251:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	leaq	8(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1261
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC122, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r14, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L1221
.L1253:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1261:
	call	__asan_report_load8
.L1260:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1259:
	movl	$httpd_err408title, %edi
	call	__asan_report_load8
.L1258:
	movl	$httpd_err408form, %edi
	call	__asan_report_load8
.L1257:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1256:
	call	__asan_report_load8
.L1255:
	movq	%r14, %rdi
	call	__asan_report_load8
.L1250:
	call	__asan_report_load8
.L1249:
	movq	%r14, %rdi
	call	__asan_report_load8
	.cfi_endproc
.LFE29:
	.size	idle, .-idle
	.section	.text.unlikely
.LCOLDE123:
	.text
.LHOTE123:
	.section	.rodata.str1.1
.LC124:
	.string	"1 32 32 2 iv "
	.section	.rodata
	.align 32
.LC125:
	.string	"replacing non-null wakeup_timer!"
	.zero	63
	.align 32
.LC126:
	.string	"tmr_create(wakeup_connection) failed"
	.zero	59
	.align 32
.LC127:
	.string	"write - %m sending %.80s"
	.zero	39
	.section	.text.unlikely
.LCOLDB128:
	.text
.LHOTB128:
	.p2align 4,,15
	.type	handle_send, @function
handle_send:
.LASANPC21:
.LFB21:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbp
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsi, 8(%rsp)
	leaq	48(%rsp), %r14
	testl	%eax, %eax
	jne	.L1417
.L1262:
	leaq	8(%rbp), %r12
	movq	%r14, %rbx
	movq	$1102416563, (%r14)
	shrq	$3, %rbx
	movq	$.LC124, 8(%r14)
	movq	$.LASANPC21, 16(%r14)
	movq	%r12, %rax
	movl	$-235802127, 2147450880(%rbx)
	movl	$-202116109, 2147450888(%rbx)
	shrq	$3, %rax
	leaq	96(%r14), %rsi
	cmpb	$0, 2147450880(%rax)
	jne	.L1418
	leaq	64(%rbp), %rax
	movq	8(%rbp), %rcx
	movq	%rax, 24(%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1419
	movq	64(%rbp), %rdx
	movl	$1000000000, %eax
	cmpq	$-1, %rdx
	je	.L1268
	leaq	3(%rdx), %rax
	testq	%rdx, %rdx
	cmovns	%rdx, %rax
	sarq	$2, %rax
.L1268:
	leaq	472(%rcx), %r8
	movq	%r8, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1420
	movq	472(%rcx), %rdx
	testq	%rdx, %rdx
	jne	.L1270
	leaq	128(%rbp), %r13
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1421
	leaq	136(%rbp), %r15
	movq	128(%rbp), %rdx
	movq	%r15, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1422
	movq	136(%rbp), %rsi
	leaq	712(%rcx), %rdi
	subq	%rsi, %rdx
	cmpq	%rax, %rdx
	cmova	%rax, %rdx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1423
	leaq	704(%rcx), %rax
	addq	712(%rcx), %rsi
	movq	%rax, 16(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edi
	testb	%dil, %dil
	je	.L1274
	cmpb	$3, %dil
	jle	.L1424
.L1274:
	movl	704(%rcx), %edi
	movq	%r8, 40(%rsp)
	movq	%rcx, 32(%rsp)
	call	write
	testl	%eax, %eax
	movq	32(%rsp), %rcx
	movq	40(%rsp), %r8
	js	.L1425
.L1281:
	je	.L1285
	movq	8(%rsp), %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1426
	movq	8(%rsp), %rsi
	leaq	88(%rbp), %rdi
	movq	(%rsi), %rdx
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1427
	movq	%rdx, 88(%rbp)
	movq	%r8, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1428
	movq	472(%rcx), %rdx
	testq	%rdx, %rdx
	je	.L1415
	movslq	%eax, %rsi
	cmpq	%rsi, %rdx
	ja	.L1429
	subl	%edx, %eax
	movq	$0, 472(%rcx)
.L1415:
	movslq	%eax, %rdx
.L1302:
	movq	%r15, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1430
	movq	%r12, %rax
	movq	%rdx, %r10
	addq	136(%rbp), %r10
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	movq	%r10, 136(%rbp)
	jne	.L1431
	movq	8(%rbp), %rax
	leaq	200(%rax), %rdi
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1432
	movq	%rdx, %r9
	addq	200(%rax), %r9
	leaq	56(%rbp), %rdi
	movq	%r9, 200(%rax)
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1308
	cmpb	$3, %al
	jle	.L1433
.L1308:
	movl	56(%rbp), %eax
	testl	%eax, %eax
	jle	.L1316
	subl	$1, %eax
	movq	throttles(%rip), %r15
	leaq	16(%rbp), %rdi
	leaq	20(%rbp,%rax,4), %r11
	.p2align 4,,10
	.p2align 3
.L1315:
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %esi
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%sil, %al
	jl	.L1313
	testb	%sil, %sil
	jne	.L1434
.L1313:
	movslq	(%rdi), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r15, %rax
	leaq	32(%rax), %rsi
	movq	%rsi, %r8
	shrq	$3, %r8
	cmpb	$0, 2147450880(%r8)
	jne	.L1435
	addq	$4, %rdi
	addq	%rdx, 32(%rax)
	cmpq	%r11, %rdi
	jne	.L1315
.L1316:
	movq	%r13, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1436
	cmpq	128(%rbp), %r10
	jge	.L1437
	leaq	112(%rbp), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1438
	movq	112(%rbp), %rax
	cmpq	$100, %rax
	jg	.L1439
.L1318:
	movq	24(%rsp), %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1440
	movq	64(%rbp), %rsi
	cmpq	$-1, %rsi
	je	.L1265
	movq	8(%rsp), %rax
	leaq	80(%rbp), %rdi
	movq	(%rax), %r13
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1441
	subq	80(%rbp), %r13
	movl	$1, %eax
	cmove	%rax, %r13
	movq	%r9, %rax
	cqto
	idivq	%r13
	cmpq	%rax, %rsi
	jge	.L1265
	movq	%rbp, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1323
	cmpb	$3, %al
	jg	.L1323
	movq	%rbp, %rdi
	call	__asan_report_store4
	.p2align 4,,10
	.p2align 3
.L1270:
	leaq	368(%rcx), %rdi
	movq	%rdi, %r11
	shrq	$3, %r11
	cmpb	$0, 2147450880(%r11)
	jne	.L1442
	movq	368(%rcx), %rdi
	movq	%rdx, -56(%rsi)
	movq	%rdi, -64(%rsi)
	leaq	712(%rcx), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1443
	leaq	136(%rbp), %r15
	movq	712(%rcx), %rdx
	movq	%r15, %rdi
	shrq	$3, %rdi
	cmpb	$0, 2147450880(%rdi)
	jne	.L1444
	movq	136(%rbp), %rdi
	leaq	128(%rbp), %r13
	addq	%rdi, %rdx
	movq	%rdx, -48(%rsi)
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1445
	movq	128(%rbp), %rdx
	subq	%rdi, %rdx
	cmpq	%rax, %rdx
	cmova	%rax, %rdx
	leaq	704(%rcx), %rax
	movq	%rdx, -40(%rsi)
	movq	%rax, 16(%rsp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1280
	cmpb	$3, %al
	jle	.L1446
.L1280:
	movl	704(%rcx), %edi
	subq	$64, %rsi
	movl	$2, %edx
	movq	%r8, 40(%rsp)
	movq	%rcx, 32(%rsp)
	call	writev
	testl	%eax, %eax
	movq	40(%rsp), %r8
	movq	32(%rsp), %rcx
	jns	.L1281
.L1425:
	movq	%rcx, 24(%rsp)
	call	__errno_location
	movq	%rax, %rdx
	movq	24(%rsp), %rcx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %esi
	movq	%rax, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%sil, %dl
	jl	.L1282
	testb	%sil, %sil
	jne	.L1447
.L1282:
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L1265
	cmpl	$11, %eax
	je	.L1285
	cmpl	$32, %eax
	setne	%sil
	cmpl	$22, %eax
	setne	%dl
	testb	%dl, %sil
	je	.L1295
	cmpl	$104, %eax
	je	.L1295
	leaq	208(%rcx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1448
	movq	208(%rcx), %rdx
	movl	$.LC127, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1295:
	movq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	clear_connection
	jmp	.L1265
	.p2align 4,,10
	.p2align 3
.L1285:
	leaq	112(%rbp), %r12
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1449
	movq	%rbp, %rax
	addq	$100, 112(%rbp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1289
	cmpb	$3, %al
	jle	.L1450
.L1289:
	movq	16(%rsp), %rax
	movl	$3, 0(%rbp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1290
	cmpb	$3, %al
	jle	.L1451
.L1290:
	movl	704(%rcx), %edi
	leaq	96(%rbp), %r13
	call	fdwatch_del_fd
	movq	%r13, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1452
	cmpq	$0, 96(%rbp)
	je	.L1292
	movl	$.LC125, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1292:
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1453
	movq	112(%rbp), %rcx
	movq	8(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	%rbp, %rdx
	movl	$wakeup_connection, %esi
	call	tmr_create
	movq	%r13, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1454
.L1294:
	testq	%rax, %rax
	movq	%rax, 96(%rbp)
	je	.L1455
.L1265:
	leaq	48(%rsp), %rax
	cmpq	%r14, %rax
	jne	.L1456
	movl	$0, 2147450880(%rbx)
	movl	$0, 2147450888(%rbx)
.L1264:
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1439:
	.cfi_restore_state
	subq	$100, %rax
	movq	%rax, 112(%rbp)
	jmp	.L1318
	.p2align 4,,10
	.p2align 3
.L1429:
	leaq	368(%rcx), %rdi
	subl	%eax, %edx
	movslq	%edx, %r8
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1457
	movq	368(%rcx), %rdi
	movq	%r8, %rdx
	movq	%rcx, 40(%rsp)
	movq	%r8, 32(%rsp)
	addq	%rdi, %rsi
	call	memmove
	movq	32(%rsp), %r8
	movq	40(%rsp), %rcx
	xorl	%edx, %edx
	movq	%r8, 472(%rcx)
	jmp	.L1302
	.p2align 4,,10
	.p2align 3
.L1323:
	movq	16(%rsp), %rax
	movl	$3, 0(%rbp)
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1324
	cmpb	$3, %al
	jg	.L1324
	movq	16(%rsp), %rdi
	call	__asan_report_load4
	.p2align 4,,10
	.p2align 3
.L1324:
	movl	704(%rcx), %edi
	call	fdwatch_del_fd
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1458
	movq	8(%rbp), %rax
	leaq	200(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1459
	movq	24(%rsp), %rdx
	movq	200(%rax), %rax
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1460
	cqto
	leaq	96(%rbp), %r12
	idivq	64(%rbp)
	subl	%r13d, %eax
	movslq	%eax, %r13
	movq	%r12, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1461
	cmpq	$0, 96(%rbp)
	je	.L1329
	movl	$.LC125, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L1329:
	testl	%r13d, %r13d
	movl	$500, %ecx
	jle	.L1330
	imulq	$1000, %r13, %rcx
.L1330:
	movq	8(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	%rbp, %rdx
	movl	$wakeup_connection, %esi
	call	tmr_create
	movq	%r12, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	je	.L1294
	movq	%r12, %rdi
	call	__asan_report_store8
	.p2align 4,,10
	.p2align 3
.L1437:
	movq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	finish_connection
	jmp	.L1265
.L1417:
	movq	%r14, %rsi
	movl	$96, %edi
	call	__asan_stack_malloc_1
	movq	%rax, %r14
	jmp	.L1262
.L1456:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%r14)
	movl	$-168430091, 2147450888(%rbx)
	movq	%rax, 2147450880(%rbx)
	jmp	.L1264
.L1457:
	call	__asan_report_load8
.L1444:
	movq	%r15, %rdi
	call	__asan_report_load8
.L1451:
	movq	16(%rsp), %rdi
	call	__asan_report_load4
.L1448:
	call	__asan_report_load8
.L1443:
	call	__asan_report_load8
.L1442:
	call	__asan_report_load8
.L1426:
	movq	8(%rsp), %rdi
	call	__asan_report_load8
.L1427:
	call	__asan_report_store8
.L1431:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1447:
	movq	%rax, %rdi
	call	__asan_report_load4
.L1450:
	movq	%rbp, %rdi
	call	__asan_report_store4
.L1461:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1460:
	movq	24(%rsp), %rdi
	call	__asan_report_load8
.L1459:
	call	__asan_report_load8
.L1458:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1449:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1436:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1452:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1432:
	call	__asan_report_load8
.L1433:
	call	__asan_report_load4
.L1434:
	call	__asan_report_load4
.L1435:
	movq	%rsi, %rdi
	call	__asan_report_load8
.L1430:
	movq	%r15, %rdi
	call	__asan_report_load8
.L1428:
	movq	%r8, %rdi
	call	__asan_report_load8
.L1424:
	movq	16(%rsp), %rdi
	call	__asan_report_load4
.L1446:
	movq	16(%rsp), %rdi
	call	__asan_report_load4
.L1422:
	movq	%r15, %rdi
	call	__asan_report_load8
.L1421:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1420:
	movq	%r8, %rdi
	call	__asan_report_load8
.L1445:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1418:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1423:
	call	__asan_report_load8
.L1419:
	movq	24(%rsp), %rdi
	call	__asan_report_load8
.L1455:
	movl	$2, %edi
	movl	$.LC126, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1453:
	movq	%r12, %rdi
	call	__asan_report_load8
.L1454:
	movq	%r13, %rdi
	call	__asan_report_store8
.L1440:
	movq	24(%rsp), %rdi
	call	__asan_report_load8
.L1441:
	call	__asan_report_load8
.L1438:
	call	__asan_report_load8
	.cfi_endproc
.LFE21:
	.size	handle_send, .-handle_send
	.section	.text.unlikely
.LCOLDE128:
	.text
.LHOTE128:
	.section	.text.unlikely
.LCOLDB129:
	.text
.LHOTB129:
	.p2align 4,,15
	.type	linger_clear_connection, @function
linger_clear_connection:
.LASANPC31:
.LFB31:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsp, %rax
	movq	%rdi, (%rsp)
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1466
	movq	(%rsp), %rdi
	leaq	104(%rdi), %rax
	movq	%rax, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1467
	movq	$0, 104(%rdi)
	call	really_clear_connection
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1466:
	.cfi_restore_state
	movq	%rsp, %rdi
	call	__asan_report_load8
.L1467:
	movq	%rax, %rdi
	call	__asan_report_store8
	.cfi_endproc
.LFE31:
	.size	linger_clear_connection, .-linger_clear_connection
	.section	.text.unlikely
.LCOLDE129:
	.text
.LHOTE129:
	.globl	__asan_stack_malloc_7
	.section	.rodata.str1.1
.LC130:
	.string	"1 32 4096 3 buf "
	.globl	__asan_stack_free_7
	.section	.text.unlikely
.LCOLDB131:
	.text
.LHOTB131:
	.p2align 4,,15
	.type	handle_linger, @function
handle_linger:
.LASANPC22:
.LFB22:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r14
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$4160, %rsp
	.cfi_def_cfa_offset 4208
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rsp, %rbx
	movq	%rsp, %r12
	testl	%eax, %eax
	jne	.L1493
.L1468:
	leaq	8(%r14), %rdi
	movq	%rbx, %rbp
	movq	$1102416563, (%rbx)
	shrq	$3, %rbp
	movq	$.LC130, 8(%rbx)
	movq	$.LASANPC22, 16(%rbx)
	movq	%rdi, %rax
	movl	$-235802127, 2147450880(%rbp)
	movl	$-202116109, 2147451396(%rbp)
	shrq	$3, %rax
	leaq	4160(%rbx), %rsi
	cmpb	$0, 2147450880(%rax)
	jne	.L1494
	movq	8(%r14), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1473
	cmpb	$3, %dl
	jle	.L1495
.L1473:
	movl	704(%rax), %edi
	subq	$4128, %rsi
	movl	$4096, %edx
	call	read
	testl	%eax, %eax
	js	.L1496
	je	.L1478
.L1471:
	cmpq	%rbx, %r12
	jne	.L1497
	movl	$0, 2147450880(%rbp)
	movl	$0, 2147451396(%rbp)
.L1470:
	addq	$4160, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1496:
	.cfi_restore_state
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rax, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1475
	testb	%cl, %cl
	jne	.L1498
.L1475:
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L1471
	cmpl	$11, %eax
	je	.L1471
.L1478:
	movq	%r13, %rsi
	movq	%r14, %rdi
	call	really_clear_connection
	jmp	.L1471
.L1495:
	call	__asan_report_load4
.L1498:
	movq	%rax, %rdi
	call	__asan_report_load4
.L1493:
	movq	%rsp, %rsi
	movl	$4160, %edi
	call	__asan_stack_malloc_7
	movq	%rax, %rbx
	jmp	.L1468
.L1497:
	movq	$1172321806, (%rbx)
	movq	%r12, %rdx
	movl	$4160, %esi
	movq	%rbx, %rdi
	call	__asan_stack_free_7
	jmp	.L1470
.L1494:
	call	__asan_report_load8
	.cfi_endproc
.LFE22:
	.size	handle_linger, .-handle_linger
	.section	.text.unlikely
.LCOLDE131:
	.text
.LHOTE131:
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"3 32 8 2 ai 96 10 7 portstr 160 48 5 hints "
	.section	.rodata
	.align 32
.LC133:
	.string	"%d"
	.zero	61
	.align 32
.LC134:
	.string	"getaddrinfo %.80s - %.80s"
	.zero	38
	.align 32
.LC135:
	.string	"%s: getaddrinfo %s - %s\n"
	.zero	39
	.align 32
.LC136:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.zero	57
	.section	.text.unlikely
.LCOLDB137:
	.text
.LHOTB137:
	.p2align 4,,15
	.type	lookup_hostname.constprop.1, @function
lookup_hostname.constprop.1:
.LASANPC37:
.LFB37:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rcx, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %r12
	subq	$296, %rsp
	.cfi_def_cfa_offset 352
	movl	__asan_option_detect_stack_use_after_return(%rip), %eax
	movq	%rdi, 8(%rsp)
	movq	%rdx, 16(%rsp)
	leaq	32(%rsp), %rbx
	testl	%eax, %eax
	jne	.L1574
.L1499:
	leaq	160(%rbx), %r10
	movq	%rbx, %r15
	movq	$1102416563, (%rbx)
	shrq	$3, %r15
	movq	$.LC132, 8(%rbx)
	movq	$.LASANPC37, 16(%rbx)
	movq	%r10, %rdi
	xorl	%esi, %esi
	movl	$-235802127, 2147450880(%r15)
	movl	$-185273344, 2147450884(%r15)
	movl	$-218959118, 2147450888(%r15)
	movl	$48, %edx
	movl	$-185335296, 2147450892(%r15)
	movl	$-218959118, 2147450896(%r15)
	leaq	96(%rbx), %r14
	movl	$-185335808, 2147450904(%r15)
	movl	$-202116109, 2147450908(%r15)
	leaq	256(%rbx), %rbp
	movq	%r10, 24(%rsp)
	call	memset
	movzwl	port(%rip), %ecx
	movq	%r14, %rdi
	movl	$.LC133, %edx
	movl	$10, %esi
	xorl	%eax, %eax
	movl	$1, -96(%rbp)
	movl	$1, -88(%rbp)
	call	snprintf
	movq	24(%rsp), %r10
	movq	hostname(%rip), %rdi
	leaq	32(%rbx), %rcx
	movq	%r14, %rsi
	movq	%r10, %rdx
	call	getaddrinfo
	testl	%eax, %eax
	movl	%eax, %r14d
	jne	.L1575
	movq	-224(%rbp), %rax
	testq	%rax, %rax
	je	.L1505
	xorl	%r14d, %r14d
	xorl	%r10d, %r10d
	jmp	.L1511
	.p2align 4,,10
	.p2align 3
.L1579:
	cmpl	$10, %edx
	jne	.L1507
	testq	%r10, %r10
	cmove	%rax, %r10
.L1507:
	leaq	40(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	cmpb	$0, 2147450880(%rdx)
	jne	.L1576
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L1577
.L1511:
	leaq	4(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %esi
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%sil, %dl
	jl	.L1506
	testb	%sil, %sil
	jne	.L1578
.L1506:
	movl	4(%rax), %edx
	cmpl	$2, %edx
	jne	.L1579
	testq	%r14, %r14
	cmove	%rax, %r14
	jmp	.L1507
	.p2align 4,,10
	.p2align 3
.L1577:
	testq	%r10, %r10
	je	.L1580
	leaq	16(%r10), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1515
	cmpb	$3, %al
	jle	.L1581
.L1515:
	movl	16(%r10), %r8d
	cmpq	$128, %r8
	ja	.L1573
	movq	16(%rsp), %rdi
	movl	$128, %edx
	xorl	%esi, %esi
	movq	%r10, 24(%rsp)
	call	memset
	movq	24(%rsp), %r10
	leaq	24(%r10), %rdi
	movl	16(%r10), %edx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1582
	movq	24(%r10), %rsi
	movq	16(%rsp), %rdi
	call	memmove
	movq	%r13, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%r13, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L1518
	testb	%dl, %dl
	jne	.L1583
.L1518:
	movl	$1, 0(%r13)
.L1514:
	testq	%r14, %r14
	je	.L1584
	leaq	16(%r14), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1522
	cmpb	$3, %al
	jle	.L1585
.L1522:
	movl	16(%r14), %r8d
	cmpq	$128, %r8
	ja	.L1573
	movq	8(%rsp), %rdi
	movl	$128, %edx
	xorl	%esi, %esi
	call	memset
	leaq	24(%r14), %rdi
	movl	16(%r14), %edx
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1586
	movq	24(%r14), %rsi
	movq	8(%rsp), %rdi
	call	memmove
	movq	%r12, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%r12, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L1525
	testb	%dl, %dl
	jne	.L1587
.L1525:
	movl	$1, (%r12)
.L1521:
	movq	-224(%rbp), %rdi
	call	freeaddrinfo
	leaq	32(%rsp), %rax
	cmpq	%rbx, %rax
	jne	.L1588
	movq	$0, 2147450880(%r15)
	movq	$0, 2147450888(%r15)
	movl	$0, 2147450896(%r15)
	movq	$0, 2147450904(%r15)
.L1501:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L1580:
	.cfi_restore_state
	movq	%r14, %rax
.L1505:
	movq	%r13, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%r13, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1513
	testb	%cl, %cl
	jne	.L1589
.L1513:
	movl	$0, 0(%r13)
	movq	%rax, %r14
	jmp	.L1514
.L1584:
	movq	%r12, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %edx
	movq	%r12, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	jl	.L1520
	testb	%dl, %dl
	jne	.L1590
.L1520:
	movl	$0, (%r12)
	jmp	.L1521
.L1589:
	movq	%r13, %rdi
	call	__asan_report_store4
.L1574:
	movq	%rbx, %rsi
	movl	$256, %edi
	call	__asan_stack_malloc_2
	movq	%rax, %rbx
	jmp	.L1499
.L1588:
	movabsq	$-723401728380766731, %rax
	movq	$1172321806, (%rbx)
	movq	%rax, 2147450880(%r15)
	movq	%rax, 2147450888(%r15)
	movq	%rax, 2147450896(%r15)
	movq	%rax, 2147450904(%r15)
	jmp	.L1501
.L1576:
	call	__asan_report_load8
.L1578:
	call	__asan_report_load4
.L1586:
	call	__asan_report_load8
.L1575:
	movl	%eax, %edi
	call	gai_strerror
	movq	hostname(%rip), %rdx
	movq	%rax, %rcx
	movl	$.LC134, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	%r14d, %edi
	call	gai_strerror
	movl	$stderr, %esi
	movq	%rax, %r8
	movq	hostname(%rip), %rcx
	shrq	$3, %rsi
	movq	argv0(%rip), %rdx
	cmpb	$0, 2147450880(%rsi)
	jne	.L1591
	movq	stderr(%rip), %rdi
	movl	$.LC135, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1583:
	movq	%r13, %rdi
	call	__asan_report_store4
.L1591:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1581:
	call	__asan_report_load4
.L1582:
	call	__asan_report_load8
.L1573:
	movq	hostname(%rip), %rdx
	movl	$2, %edi
	movl	$128, %ecx
	movl	$.LC136, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1587:
	movq	%r12, %rdi
	call	__asan_report_store4
.L1585:
	call	__asan_report_load4
.L1590:
	movq	%r12, %rdi
	call	__asan_report_store4
	.cfi_endproc
.LFE37:
	.size	lookup_hostname.constprop.1, .-lookup_hostname.constprop.1
	.section	.text.unlikely
.LCOLDE137:
	.text
.LHOTE137:
	.section	.rodata.str1.8
	.align 8
.LC138:
	.string	"6 32 4 5 gotv4 96 4 5 gotv6 160 16 2 tv 224 128 3 sa4 384 128 3 sa6 544 4097 3 cwd "
	.section	.rodata
	.align 32
.LC139:
	.string	"can't find any valid address"
	.zero	35
	.align 32
.LC140:
	.string	"%s: can't find any valid address\n"
	.zero	62
	.align 32
.LC141:
	.string	"unknown user - '%.80s'"
	.zero	41
	.align 32
.LC142:
	.string	"%s: unknown user - '%s'\n"
	.zero	39
	.align 32
.LC143:
	.string	"/dev/null"
	.zero	54
	.align 32
.LC144:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.zero	61
	.align 32
.LC145:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
	.zero	56
	.align 32
.LC146:
	.string	"fchown logfile - %m"
	.zero	44
	.align 32
.LC147:
	.string	"fchown logfile"
	.zero	49
	.align 32
.LC148:
	.string	"chdir - %m"
	.zero	53
	.align 32
.LC149:
	.string	"chdir"
	.zero	58
	.align 32
.LC150:
	.string	"/"
	.zero	62
	.align 32
.LC151:
	.string	"daemon - %m"
	.zero	52
	.align 32
.LC152:
	.string	"w"
	.zero	62
	.align 32
.LC153:
	.string	"%d\n"
	.zero	60
	.align 32
.LC154:
	.string	"fdwatch initialization failure"
	.zero	33
	.align 32
.LC155:
	.string	"chroot - %m"
	.zero	52
	.align 32
.LC156:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.zero	54
	.align 32
.LC157:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
	.zero	49
	.align 32
.LC158:
	.string	"chroot chdir - %m"
	.zero	46
	.align 32
.LC159:
	.string	"chroot chdir"
	.zero	51
	.align 32
.LC160:
	.string	"data_dir chdir - %m"
	.zero	44
	.align 32
.LC161:
	.string	"data_dir chdir"
	.zero	49
	.align 32
.LC162:
	.string	"tmr_create(occasional) failed"
	.zero	34
	.align 32
.LC163:
	.string	"tmr_create(idle) failed"
	.zero	40
	.align 32
.LC164:
	.string	"tmr_create(update_throttles) failed"
	.zero	60
	.align 32
.LC165:
	.string	"tmr_create(show_stats) failed"
	.zero	34
	.align 32
.LC166:
	.string	"setgroups - %m"
	.zero	49
	.align 32
.LC167:
	.string	"setgid - %m"
	.zero	52
	.align 32
.LC168:
	.string	"initgroups - %m"
	.zero	48
	.align 32
.LC169:
	.string	"setuid - %m"
	.zero	52
	.align 32
.LC170:
	.string	"started as root without requesting chroot(), warning only"
	.zero	38
	.align 32
.LC171:
	.string	"out of memory allocating a connecttab"
	.zero	58
	.align 32
.LC172:
	.string	"fdwatch - %m"
	.zero	51
	.section	.text.unlikely
.LCOLDB173:
	.section	.text.startup,"ax",@progbits
.LHOTB173:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LASANPC9:
.LFB9:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$4728, %rsp
	.cfi_def_cfa_offset 4784
	movl	__asan_option_detect_stack_use_after_return(%rip), %esi
	leaq	16(%rsp), %rbx
	testl	%esi, %esi
	jne	.L1867
.L1592:
	movq	%rbx, %rax
	movq	$1102416563, (%rbx)
	movq	$.LC138, 8(%rbx)
	shrq	$3, %rax
	movq	$.LASANPC9, 16(%rbx)
	leaq	4704(%rbx), %rbp
	movl	$-235802127, 2147450880(%rax)
	movl	$-185273340, 2147450884(%rax)
	movl	$-218959118, 2147450888(%rax)
	movl	$-185273340, 2147450892(%rax)
	movl	$-218959118, 2147450896(%rax)
	movl	$-185335808, 2147450900(%rax)
	movl	$-218959118, 2147450904(%rax)
	movl	$-218959118, 2147450924(%rax)
	movl	$-218959118, 2147450944(%rax)
	movl	$-185273343, 2147451460(%rax)
	movl	$-202116109, 2147451464(%rax)
	movq	%r13, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1868
	movq	0(%r13), %r12
	movl	$47, %esi
	movq	%r12, %rdi
	movq	%r12, argv0(%rip)
	call	strrchr
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	movl	$9, %esi
	cmovne	%rdx, %r12
	movl	$24, %edx
	movq	%r12, %rdi
	call	openlog
	movq	%r13, %rsi
	movl	%r14d, %edi
	leaq	384(%rbx), %r13
	call	parse_args
	call	tzset
	leaq	96(%rbx), %rcx
	leaq	32(%rbx), %rsi
	addq	$224, %rbx
	movq	%r13, %rdx
	movq	%rbx, %rdi
	call	lookup_hostname.constprop.1
	movl	-4672(%rbp), %ecx
	testl	%ecx, %ecx
	jne	.L1598
	cmpl	$0, -4608(%rbp)
	je	.L1869
.L1598:
	movq	throttlefile(%rip), %rdi
	movl	$0, numthrottles(%rip)
	movl	$0, maxthrottles(%rip)
	movq	$0, throttles(%rip)
	testq	%rdi, %rdi
	je	.L1600
	call	read_throttlefile
.L1600:
	call	getuid
	testl	%eax, %eax
	movl	$32767, (%rsp)
	movl	$32767, 4(%rsp)
	je	.L1870
.L1601:
	movq	logfile(%rip), %r12
	testq	%r12, %r12
	je	.L1696
	movl	$.LC143, %esi
	movq	%r12, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L1871
	movl	$.LC98, %esi
	movq	%r12, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L1608
	movl	$stdout, %eax
	movq	stdout(%rip), %r15
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1872
.L1606:
	movq	dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1615
	call	chdir
	testl	%eax, %eax
	js	.L1873
.L1615:
	leaq	-4160(%rbp), %r12
	movl	$4096, %esi
	movq	%r12, %rdi
	call	getcwd
	movq	%r12, %rdi
	call	strlen
	leaq	-1(%rax), %rdx
	leaq	(%r12,%rdx), %rdi
	movq	%rdi, %rcx
	movq	%rdi, %rsi
	shrq	$3, %rcx
	andl	$7, %esi
	movzbl	2147450880(%rcx), %ecx
	cmpb	%sil, %cl
	jg	.L1616
	testb	%cl, %cl
	jne	.L1874
.L1616:
	cmpb	$47, -4160(%rdx,%rbp)
	je	.L1617
	leaq	(%r12,%rax), %rdi
	movl	$2, %edx
	movl	$.LC150, %esi
	call	memcpy
.L1617:
	movl	debug(%rip), %edx
	testl	%edx, %edx
	jne	.L1618
	movl	$stdin, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1875
	movq	stdin(%rip), %rdi
	call	fclose
	movl	$stdout, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1876
	movq	stdout(%rip), %rdi
	cmpq	%rdi, %r15
	je	.L1621
	call	fclose
.L1621:
	movl	$stderr, %eax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1877
	movq	stderr(%rip), %rdi
	call	fclose
	movl	$1, %esi
	movl	$1, %edi
	call	daemon
	testl	%eax, %eax
	movl	$.LC151, %esi
	js	.L1863
.L1623:
	movq	pidfile(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1624
	movl	$.LC152, %esi
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r14
	je	.L1878
	call	getpid
	movq	%r14, %rdi
	movl	%eax, %edx
	movl	$.LC153, %esi
	xorl	%eax, %eax
	call	fprintf
	movq	%r14, %rdi
	call	fclose
.L1624:
	call	fdwatch_get_nfiles
	testl	%eax, %eax
	movl	%eax, max_connects(%rip)
	js	.L1879
	subl	$10, %eax
	cmpl	$0, do_chroot(%rip)
	movl	%eax, max_connects(%rip)
	jne	.L1880
.L1627:
	movq	data_dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L1632
	call	chdir
	testl	%eax, %eax
	js	.L1881
.L1632:
	movl	$handle_term, %esi
	movl	$15, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_term, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_chld, %esi
	movl	$17, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$1, %esi
	movl	$13, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_hup, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_usr1, %esi
	movl	$10, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_usr2, %esi
	movl	$12, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$handle_alrm, %esi
	movl	$14, %edi
	xorl	%eax, %eax
	call	sigset
	movl	$360, %edi
	movl	$0, got_hup(%rip)
	movl	$0, got_usr1(%rip)
	movl	$0, watchdog_flag(%rip)
	call	alarm
	call	tmr_init
	xorl	%esi, %esi
	cmpl	$0, -4608(%rbp)
	movl	no_empty_referers(%rip), %eax
	movq	%r13, %rdx
	movzwl	port(%rip), %ecx
	movl	cgi_limit(%rip), %r9d
	movq	cgi_pattern(%rip), %r8
	movq	hostname(%rip), %rdi
	cmove	%rsi, %rdx
	cmpl	$0, -4672(%rbp)
	pushq	%rax
	.cfi_def_cfa_offset 4792
	movl	do_global_passwd(%rip), %eax
	pushq	local_pattern(%rip)
	.cfi_def_cfa_offset 4800
	pushq	url_pattern(%rip)
	.cfi_def_cfa_offset 4808
	pushq	%rax
	.cfi_def_cfa_offset 4816
	movl	do_vhost(%rip), %eax
	cmovne	%rbx, %rsi
	pushq	%rax
	.cfi_def_cfa_offset 4824
	movl	no_symlink_check(%rip), %eax
	pushq	%rax
	.cfi_def_cfa_offset 4832
	movl	no_log(%rip), %eax
	pushq	%r15
	.cfi_def_cfa_offset 4840
	pushq	%rax
	.cfi_def_cfa_offset 4848
	movl	max_age(%rip), %eax
	pushq	%r12
	.cfi_def_cfa_offset 4856
	pushq	%rax
	.cfi_def_cfa_offset 4864
	pushq	p3p(%rip)
	.cfi_def_cfa_offset 4872
	pushq	charset(%rip)
	.cfi_def_cfa_offset 4880
	call	httpd_initialize
	addq	$96, %rsp
	.cfi_def_cfa_offset 4784
	testq	%rax, %rax
	movq	%rax, hs(%rip)
	je	.L1864
	movq	JunkClientData(%rip), %rdx
	movl	$occasional, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$120000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC162, %esi
	je	.L1865
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$5000, %ecx
	movl	$idle, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L1882
	cmpl	$0, numthrottles(%rip)
	jle	.L1638
	movq	JunkClientData(%rip), %rdx
	movl	$update_throttles, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$2000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC164, %esi
	je	.L1865
.L1638:
	movq	JunkClientData(%rip), %rdx
	movl	$show_stats, %esi
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$3600000, %ecx
	call	tmr_create
	testq	%rax, %rax
	movl	$.LC165, %esi
	je	.L1865
	xorl	%edi, %edi
	call	time
	movq	$0, stats_connections(%rip)
	movq	%rax, stats_time(%rip)
	movq	%rax, start_time(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	call	getuid
	testl	%eax, %eax
	je	.L1883
.L1641:
	movslq	max_connects(%rip), %r12
	movq	%r12, %rbx
	imulq	$144, %r12, %r12
	movq	%r12, %rdi
	call	malloc
	testq	%rax, %rax
	movq	%rax, connects(%rip)
	je	.L1647
	xorl	%ecx, %ecx
	testl	%ebx, %ebx
	movq	%rax, %rdx
	jle	.L1656
	.p2align 4,,10
	.p2align 3
.L1807:
	movq	%rdx, %rsi
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %esi
	testb	%sil, %sil
	je	.L1652
	cmpb	$3, %sil
	jle	.L1884
.L1652:
	leaq	4(%rdx), %rdi
	addl	$1, %ecx
	movl	$0, (%rdx)
	movq	%rdi, %rsi
	shrq	$3, %rsi
	movzbl	2147450880(%rsi), %r8d
	movq	%rdi, %rsi
	andl	$7, %esi
	addl	$3, %esi
	cmpb	%r8b, %sil
	jl	.L1653
	testb	%r8b, %r8b
	jne	.L1885
.L1653:
	leaq	8(%rdx), %rdi
	movl	%ecx, 4(%rdx)
	movq	%rdi, %rsi
	shrq	$3, %rsi
	cmpb	$0, 2147450880(%rsi)
	jne	.L1886
	movq	$0, 8(%rdx)
	addq	$144, %rdx
	cmpl	%ecx, %ebx
	jne	.L1807
.L1656:
	leaq	-144(%rax,%r12), %rdx
	leaq	4(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	jl	.L1649
	testb	%cl, %cl
	jne	.L1887
.L1649:
	movq	hs(%rip), %rax
	movl	$-1, 4(%rdx)
	movl	$0, first_free_connect(%rip)
	movl	$0, num_connects(%rip)
	movl	$0, httpd_conn_count(%rip)
	testq	%rax, %rax
	je	.L1657
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1658
	cmpb	$3, %dl
	jle	.L1888
.L1658:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1659
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
	movq	hs(%rip), %rax
.L1659:
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1660
	testb	%cl, %cl
	jne	.L1889
.L1660:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1657
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
.L1657:
	subq	$4544, %rbp
	movq	%rbp, %rdi
	call	tmr_prepare_timeval
	.p2align 4,,10
	.p2align 3
.L1661:
	movl	terminate(%rip), %eax
	testl	%eax, %eax
	je	.L1694
	cmpl	$0, num_connects(%rip)
	jle	.L1890
.L1694:
	movl	got_hup(%rip), %eax
	testl	%eax, %eax
	jne	.L1891
.L1662:
	movq	%rbp, %rdi
	call	tmr_mstimeout
	movq	%rax, %rdi
	call	fdwatch
	testl	%eax, %eax
	movl	%eax, %ebx
	js	.L1892
	movq	%rbp, %rdi
	call	tmr_prepare_timeval
	testl	%ebx, %ebx
	je	.L1893
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L1680
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1671
	testb	%cl, %cl
	jne	.L1894
.L1671:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1672
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L1673
.L1677:
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L1680
.L1672:
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1678
	cmpb	$3, %dl
	jle	.L1895
.L1678:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1680
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L1896
	.p2align 4,,10
	.p2align 3
.L1680:
	call	fdwatch_get_next_client_data
	cmpq	$-1, %rax
	movq	%rax, %rbx
	je	.L1897
	testq	%rbx, %rbx
	je	.L1680
	leaq	8(%rbx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1898
	movq	8(%rbx), %rax
	leaq	704(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1682
	cmpb	$3, %dl
	jle	.L1899
.L1682:
	movl	704(%rax), %edi
	call	fdwatch_check_fd
	testl	%eax, %eax
	je	.L1900
	movq	%rbx, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %eax
	testb	%al, %al
	je	.L1685
	cmpb	$3, %al
	jle	.L1901
.L1685:
	movl	(%rbx), %eax
	cmpl	$2, %eax
	je	.L1686
	cmpl	$4, %eax
	je	.L1687
	cmpl	$1, %eax
	jne	.L1680
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_read
	jmp	.L1680
.L1871:
	movl	$1, no_log(%rip)
	xorl	%r15d, %r15d
	jmp	.L1606
.L1892:
	call	__errno_location
	movq	%rax, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rax, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1664
	testb	%cl, %cl
	jne	.L1902
.L1664:
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L1661
	cmpl	$11, %eax
	je	.L1661
	movl	$.LC172, %esi
	movl	$3, %edi
.L1866:
	xorl	%eax, %eax
	call	syslog
.L1864:
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1618:
	call	setsid
	jmp	.L1623
.L1870:
	movq	user(%rip), %rdi
	call	getpwnam
	testq	%rax, %rax
	je	.L1903
	leaq	16(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1604
	cmpb	$3, %dl
	jle	.L1904
.L1604:
	leaq	20(%rax), %rdi
	movl	16(%rax), %ecx
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movl	%ecx, 4(%rsp)
	movzbl	2147450880(%rdx), %ecx
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1605
	testb	%cl, %cl
	jne	.L1905
.L1605:
	movl	20(%rax), %eax
	movl	%eax, (%rsp)
	jmp	.L1601
.L1869:
	xorl	%eax, %eax
	movl	$.LC139, %esi
	movl	$3, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1906
	movq	stderr(%rip), %rdi
	movl	$.LC140, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1883:
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	setgroups
	testl	%eax, %eax
	movl	$.LC166, %esi
	js	.L1863
	movl	(%rsp), %edi
	call	setgid
	testl	%eax, %eax
	movl	$.LC167, %esi
	js	.L1863
	movl	(%rsp), %esi
	movq	user(%rip), %rdi
	call	initgroups
	testl	%eax, %eax
	js	.L1907
.L1644:
	movl	4(%rsp), %edi
	call	setuid
	testl	%eax, %eax
	movl	$.LC169, %esi
	js	.L1863
	cmpl	$0, do_chroot(%rip)
	jne	.L1641
	movl	$.LC170, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L1641
.L1882:
	movl	$.LC163, %esi
.L1865:
	movl	$2, %edi
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1900:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L1680
.L1686:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_send
	jmp	.L1680
.L1687:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	handle_linger
	jmp	.L1680
.L1897:
	movq	%rbp, %rdi
	call	tmr_run
	movl	got_usr1(%rip), %eax
	testl	%eax, %eax
	je	.L1661
	cmpl	$0, terminate(%rip)
	jne	.L1661
	movq	hs(%rip), %rax
	movl	$1, terminate(%rip)
	testq	%rax, %rax
	je	.L1661
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1690
	cmpb	$3, %dl
	jg	.L1690
	call	__asan_report_load4
.L1690:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L1691
	call	fdwatch_del_fd
	movq	hs(%rip), %rax
.L1691:
	leaq	76(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %ecx
	movq	%rdi, %rdx
	andl	$7, %edx
	addl	$3, %edx
	cmpb	%cl, %dl
	jl	.L1692
	testb	%cl, %cl
	je	.L1692
	call	__asan_report_load4
.L1692:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L1693
	call	fdwatch_del_fd
.L1693:
	movq	hs(%rip), %rdi
	call	httpd_unlisten
	jmp	.L1661
.L1891:
	call	re_open_logfile
	movl	$0, got_hup(%rip)
	jmp	.L1662
.L1879:
	movl	$.LC154, %esi
.L1863:
	movl	$2, %edi
	jmp	.L1866
.L1893:
	movq	%rbp, %rdi
	call	tmr_run
	jmp	.L1661
.L1880:
	movq	%r12, %rdi
	call	chroot
	testl	%eax, %eax
	js	.L1908
	movq	logfile(%rip), %r14
	testq	%r14, %r14
	je	.L1629
	movl	$.LC98, %esi
	movq	%r14, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L1629
	movq	%r12, %rdi
	call	strlen
	movq	%r12, %rsi
	movq	%rax, %rdx
	movq	%r14, %rdi
	movq	%rax, 8(%rsp)
	call	strncmp
	testl	%eax, %eax
	je	.L1909
	xorl	%eax, %eax
	movl	$.LC156, %esi
	movl	$4, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1910
	movq	stderr(%rip), %rdi
	movl	$.LC157, %esi
	xorl	%eax, %eax
	call	fprintf
.L1629:
	movl	$2, %edx
	movl	$.LC150, %esi
	movq	%r12, %rdi
	call	memcpy
	movq	%r12, %rdi
	call	chdir
	testl	%eax, %eax
	jns	.L1627
	movl	$.LC158, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC159, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1696:
	xorl	%r15d, %r15d
	jmp	.L1606
.L1608:
	movq	%r12, %rdi
	movl	$.LC100, %esi
	call	fopen
	movq	logfile(%rip), %r12
	movq	%rax, %r15
	movl	$384, %esi
	movq	%r12, %rdi
	call	chmod
	testq	%r15, %r15
	je	.L1699
	testl	%eax, %eax
	jne	.L1699
	movq	%r12, %rax
	movq	%r12, %rdx
	shrq	$3, %rax
	andl	$7, %edx
	movzbl	2147450880(%rax), %eax
	cmpb	%dl, %al
	jg	.L1612
	testb	%al, %al
	je	.L1612
	movq	%r12, %rdi
	call	__asan_report_load1
.L1612:
	cmpb	$47, (%r12)
	je	.L1613
	xorl	%eax, %eax
	movl	$.LC144, %esi
	movl	$4, %edi
	call	syslog
	movl	$stderr, %eax
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1911
	movq	stderr(%rip), %rdi
	movl	$.LC145, %esi
	xorl	%eax, %eax
	call	fprintf
.L1613:
	movq	%r15, %rdi
	call	fileno
	movl	$1, %edx
	movl	%eax, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	call	fcntl
	call	getuid
	testl	%eax, %eax
	jne	.L1606
	movq	%r15, %rdi
	call	fileno
	movl	(%rsp), %edx
	movl	4(%rsp), %esi
	movl	%eax, %edi
	call	fchown
	testl	%eax, %eax
	jns	.L1606
	movl	$.LC146, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC147, %edi
	call	perror
	jmp	.L1606
.L1873:
	movl	$.LC148, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC149, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1878:
	movq	pidfile(%rip), %rdx
	movl	$2, %edi
	movl	$.LC89, %esi
	xorl	%eax, %eax
	call	syslog
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1881:
	movl	$.LC160, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC161, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1909:
	movq	8(%rsp), %rcx
	movq	%r14, %rdi
	leaq	-1(%r14,%rcx), %rsi
	call	strcpy
	jmp	.L1629
.L1673:
	movq	hs(%rip), %rdx
	leaq	76(%rdx), %rdi
	movq	%rdi, %rax
	shrq	$3, %rax
	movzbl	2147450880(%rax), %ecx
	movq	%rdi, %rax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	jl	.L1675
	testb	%cl, %cl
	jne	.L1912
.L1675:
	movl	76(%rdx), %esi
	movq	%rbp, %rdi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L1661
	jmp	.L1677
.L1896:
	movq	hs(%rip), %rax
	leaq	72(%rax), %rdi
	movq	%rdi, %rdx
	shrq	$3, %rdx
	movzbl	2147450880(%rdx), %edx
	testb	%dl, %dl
	je	.L1679
	cmpb	$3, %dl
	jle	.L1913
.L1679:
	movl	72(%rax), %esi
	movq	%rbp, %rdi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L1661
	jmp	.L1680
.L1699:
	movq	%r12, %rdx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movq	logfile(%rip), %rdi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1890:
	call	shut_down
	movl	$5, %edi
	movl	$.LC110, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	call	__asan_handle_no_return
	xorl	%edi, %edi
	call	exit
.L1908:
	movl	$.LC155, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	call	syslog
	movl	$.LC34, %edi
	call	perror
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1903:
	movq	user(%rip), %rdx
	movl	$.LC141, %esi
	movl	$2, %edi
	call	syslog
	movl	$stderr, %eax
	movq	user(%rip), %rcx
	movq	argv0(%rip), %rdx
	shrq	$3, %rax
	cmpb	$0, 2147450880(%rax)
	jne	.L1914
	movq	stderr(%rip), %rdi
	movl	$.LC142, %esi
	xorl	%eax, %eax
	call	fprintf
	call	__asan_handle_no_return
	movl	$1, %edi
	call	exit
.L1647:
	movl	$.LC171, %esi
	jmp	.L1863
.L1907:
	movl	$.LC168, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L1644
.L1867:
	movq	%rbx, %rsi
	movl	$4704, %edi
	call	__asan_stack_malloc_7
	movq	%rax, %rbx
	jmp	.L1592
.L1895:
	call	__asan_report_load4
.L1911:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1889:
	call	__asan_report_load4
.L1888:
	call	__asan_report_load4
.L1887:
	call	__asan_report_store4
.L1886:
	call	__asan_report_store8
.L1912:
	call	__asan_report_load4
.L1898:
	call	__asan_report_load8
.L1901:
	movq	%rbx, %rdi
	call	__asan_report_load4
.L1899:
	call	__asan_report_load4
.L1894:
	call	__asan_report_load4
.L1913:
	call	__asan_report_load4
.L1902:
	movq	%rax, %rdi
	call	__asan_report_load4
.L1910:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1874:
	call	__asan_report_load1
.L1872:
	movl	$stdout, %edi
	call	__asan_report_load8
.L1868:
	movq	%r13, %rdi
	call	__asan_report_load8
.L1877:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1905:
	call	__asan_report_load4
.L1906:
	movl	$stderr, %edi
	call	__asan_report_load8
.L1875:
	movl	$stdin, %edi
	call	__asan_report_load8
.L1876:
	movl	$stdout, %edi
	call	__asan_report_load8
.L1885:
	call	__asan_report_store4
.L1884:
	movq	%rdx, %rdi
	call	__asan_report_store4
.L1904:
	call	__asan_report_load4
.L1914:
	movl	$stderr, %edi
	call	__asan_report_load8
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE173:
	.section	.text.startup
.LHOTE173:
	.bss
	.align 32
	.type	watchdog_flag, @object
	.size	watchdog_flag, 4
watchdog_flag:
	.zero	64
	.align 32
	.type	got_usr1, @object
	.size	got_usr1, 4
got_usr1:
	.zero	64
	.align 32
	.type	got_hup, @object
	.size	got_hup, 4
got_hup:
	.zero	64
	.comm	stats_simultaneous,4,4
	.comm	stats_bytes,8,8
	.comm	stats_connections,8,8
	.comm	stats_time,8,8
	.comm	start_time,8,8
	.globl	terminate
	.align 32
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	64
	.align 32
	.type	hs, @object
	.size	hs, 8
hs:
	.zero	64
	.align 32
	.type	httpd_conn_count, @object
	.size	httpd_conn_count, 4
httpd_conn_count:
	.zero	64
	.align 32
	.type	first_free_connect, @object
	.size	first_free_connect, 4
first_free_connect:
	.zero	64
	.align 32
	.type	max_connects, @object
	.size	max_connects, 4
max_connects:
	.zero	64
	.align 32
	.type	num_connects, @object
	.size	num_connects, 4
num_connects:
	.zero	64
	.align 32
	.type	connects, @object
	.size	connects, 8
connects:
	.zero	64
	.align 32
	.type	maxthrottles, @object
	.size	maxthrottles, 4
maxthrottles:
	.zero	64
	.align 32
	.type	numthrottles, @object
	.size	numthrottles, 4
numthrottles:
	.zero	64
	.align 32
	.type	throttles, @object
	.size	throttles, 8
throttles:
	.zero	64
	.align 32
	.type	max_age, @object
	.size	max_age, 4
max_age:
	.zero	64
	.align 32
	.type	p3p, @object
	.size	p3p, 8
p3p:
	.zero	64
	.align 32
	.type	charset, @object
	.size	charset, 8
charset:
	.zero	64
	.align 32
	.type	user, @object
	.size	user, 8
user:
	.zero	64
	.align 32
	.type	pidfile, @object
	.size	pidfile, 8
pidfile:
	.zero	64
	.align 32
	.type	hostname, @object
	.size	hostname, 8
hostname:
	.zero	64
	.align 32
	.type	throttlefile, @object
	.size	throttlefile, 8
throttlefile:
	.zero	64
	.align 32
	.type	logfile, @object
	.size	logfile, 8
logfile:
	.zero	64
	.align 32
	.type	local_pattern, @object
	.size	local_pattern, 8
local_pattern:
	.zero	64
	.align 32
	.type	no_empty_referers, @object
	.size	no_empty_referers, 4
no_empty_referers:
	.zero	64
	.align 32
	.type	url_pattern, @object
	.size	url_pattern, 8
url_pattern:
	.zero	64
	.align 32
	.type	cgi_limit, @object
	.size	cgi_limit, 4
cgi_limit:
	.zero	64
	.align 32
	.type	cgi_pattern, @object
	.size	cgi_pattern, 8
cgi_pattern:
	.zero	64
	.align 32
	.type	do_global_passwd, @object
	.size	do_global_passwd, 4
do_global_passwd:
	.zero	64
	.align 32
	.type	do_vhost, @object
	.size	do_vhost, 4
do_vhost:
	.zero	64
	.align 32
	.type	no_symlink_check, @object
	.size	no_symlink_check, 4
no_symlink_check:
	.zero	64
	.align 32
	.type	no_log, @object
	.size	no_log, 4
no_log:
	.zero	64
	.align 32
	.type	do_chroot, @object
	.size	do_chroot, 4
do_chroot:
	.zero	64
	.align 32
	.type	data_dir, @object
	.size	data_dir, 8
data_dir:
	.zero	64
	.align 32
	.type	dir, @object
	.size	dir, 8
dir:
	.zero	64
	.align 32
	.type	port, @object
	.size	port, 2
port:
	.zero	64
	.align 32
	.type	debug, @object
	.size	debug, 4
debug:
	.zero	64
	.align 32
	.type	argv0, @object
	.size	argv0, 8
argv0:
	.zero	64
	.section	.rodata.str1.1
.LC174:
	.string	"thttpd.c"
	.data
	.align 16
	.type	.LASANLOC1, @object
	.size	.LASANLOC1, 16
.LASANLOC1:
	.quad	.LC174
	.long	135
	.long	40
	.align 16
	.type	.LASANLOC2, @object
	.size	.LASANLOC2, 16
.LASANLOC2:
	.quad	.LC174
	.long	135
	.long	30
	.align 16
	.type	.LASANLOC3, @object
	.size	.LASANLOC3, 16
.LASANLOC3:
	.quad	.LC174
	.long	135
	.long	21
	.align 16
	.type	.LASANLOC4, @object
	.size	.LASANLOC4, 16
.LASANLOC4:
	.quad	.LC174
	.long	129
	.long	5
	.align 16
	.type	.LASANLOC5, @object
	.size	.LASANLOC5, 16
.LASANLOC5:
	.quad	.LC174
	.long	128
	.long	22
	.align 16
	.type	.LASANLOC6, @object
	.size	.LASANLOC6, 16
.LASANLOC6:
	.quad	.LC174
	.long	118
	.long	12
	.align 16
	.type	.LASANLOC7, @object
	.size	.LASANLOC7, 16
.LASANLOC7:
	.quad	.LC174
	.long	117
	.long	40
	.align 16
	.type	.LASANLOC8, @object
	.size	.LASANLOC8, 16
.LASANLOC8:
	.quad	.LC174
	.long	117
	.long	26
	.align 16
	.type	.LASANLOC9, @object
	.size	.LASANLOC9, 16
.LASANLOC9:
	.quad	.LC174
	.long	117
	.long	12
	.align 16
	.type	.LASANLOC10, @object
	.size	.LASANLOC10, 16
.LASANLOC10:
	.quad	.LC174
	.long	116
	.long	20
	.align 16
	.type	.LASANLOC11, @object
	.size	.LASANLOC11, 16
.LASANLOC11:
	.quad	.LC174
	.long	96
	.long	26
	.align 16
	.type	.LASANLOC12, @object
	.size	.LASANLOC12, 16
.LASANLOC12:
	.quad	.LC174
	.long	96
	.long	12
	.align 16
	.type	.LASANLOC13, @object
	.size	.LASANLOC13, 16
.LASANLOC13:
	.quad	.LC174
	.long	95
	.long	21
	.align 16
	.type	.LASANLOC14, @object
	.size	.LASANLOC14, 16
.LASANLOC14:
	.quad	.LC174
	.long	85
	.long	12
	.align 16
	.type	.LASANLOC15, @object
	.size	.LASANLOC15, 16
.LASANLOC15:
	.quad	.LC174
	.long	84
	.long	14
	.align 16
	.type	.LASANLOC16, @object
	.size	.LASANLOC16, 16
.LASANLOC16:
	.quad	.LC174
	.long	83
	.long	14
	.align 16
	.type	.LASANLOC17, @object
	.size	.LASANLOC17, 16
.LASANLOC17:
	.quad	.LC174
	.long	82
	.long	14
	.align 16
	.type	.LASANLOC18, @object
	.size	.LASANLOC18, 16
.LASANLOC18:
	.quad	.LC174
	.long	81
	.long	14
	.align 16
	.type	.LASANLOC19, @object
	.size	.LASANLOC19, 16
.LASANLOC19:
	.quad	.LC174
	.long	80
	.long	14
	.align 16
	.type	.LASANLOC20, @object
	.size	.LASANLOC20, 16
.LASANLOC20:
	.quad	.LC174
	.long	79
	.long	14
	.align 16
	.type	.LASANLOC21, @object
	.size	.LASANLOC21, 16
.LASANLOC21:
	.quad	.LC174
	.long	78
	.long	14
	.align 16
	.type	.LASANLOC22, @object
	.size	.LASANLOC22, 16
.LASANLOC22:
	.quad	.LC174
	.long	77
	.long	14
	.align 16
	.type	.LASANLOC23, @object
	.size	.LASANLOC23, 16
.LASANLOC23:
	.quad	.LC174
	.long	76
	.long	12
	.align 16
	.type	.LASANLOC24, @object
	.size	.LASANLOC24, 16
.LASANLOC24:
	.quad	.LC174
	.long	75
	.long	14
	.align 16
	.type	.LASANLOC25, @object
	.size	.LASANLOC25, 16
.LASANLOC25:
	.quad	.LC174
	.long	74
	.long	12
	.align 16
	.type	.LASANLOC26, @object
	.size	.LASANLOC26, 16
.LASANLOC26:
	.quad	.LC174
	.long	73
	.long	14
	.align 16
	.type	.LASANLOC27, @object
	.size	.LASANLOC27, 16
.LASANLOC27:
	.quad	.LC174
	.long	72
	.long	59
	.align 16
	.type	.LASANLOC28, @object
	.size	.LASANLOC28, 16
.LASANLOC28:
	.quad	.LC174
	.long	72
	.long	49
	.align 16
	.type	.LASANLOC29, @object
	.size	.LASANLOC29, 16
.LASANLOC29:
	.quad	.LC174
	.long	72
	.long	31
	.align 16
	.type	.LASANLOC30, @object
	.size	.LASANLOC30, 16
.LASANLOC30:
	.quad	.LC174
	.long	72
	.long	23
	.align 16
	.type	.LASANLOC31, @object
	.size	.LASANLOC31, 16
.LASANLOC31:
	.quad	.LC174
	.long	72
	.long	12
	.align 16
	.type	.LASANLOC32, @object
	.size	.LASANLOC32, 16
.LASANLOC32:
	.quad	.LC174
	.long	71
	.long	14
	.align 16
	.type	.LASANLOC33, @object
	.size	.LASANLOC33, 16
.LASANLOC33:
	.quad	.LC174
	.long	70
	.long	14
	.align 16
	.type	.LASANLOC34, @object
	.size	.LASANLOC34, 16
.LASANLOC34:
	.quad	.LC174
	.long	69
	.long	23
	.align 16
	.type	.LASANLOC35, @object
	.size	.LASANLOC35, 16
.LASANLOC35:
	.quad	.LC174
	.long	68
	.long	12
	.align 16
	.type	.LASANLOC36, @object
	.size	.LASANLOC36, 16
.LASANLOC36:
	.quad	.LC174
	.long	67
	.long	14
	.section	.rodata.str1.1
.LC175:
	.string	"watchdog_flag"
.LC176:
	.string	"got_usr1"
.LC177:
	.string	"got_hup"
.LC178:
	.string	"terminate"
.LC179:
	.string	"hs"
.LC180:
	.string	"httpd_conn_count"
.LC181:
	.string	"first_free_connect"
.LC182:
	.string	"max_connects"
.LC183:
	.string	"num_connects"
.LC184:
	.string	"connects"
.LC185:
	.string	"maxthrottles"
.LC186:
	.string	"numthrottles"
.LC187:
	.string	"hostname"
.LC188:
	.string	"throttlefile"
.LC189:
	.string	"local_pattern"
.LC190:
	.string	"no_empty_referers"
.LC191:
	.string	"url_pattern"
.LC192:
	.string	"cgi_limit"
.LC193:
	.string	"cgi_pattern"
.LC194:
	.string	"do_global_passwd"
.LC195:
	.string	"do_vhost"
.LC196:
	.string	"no_symlink_check"
.LC197:
	.string	"no_log"
.LC198:
	.string	"do_chroot"
.LC199:
	.string	"argv0"
.LC200:
	.string	"*.LC122"
.LC201:
	.string	"*.LC148"
.LC202:
	.string	"*.LC52"
.LC203:
	.string	"*.LC99"
.LC204:
	.string	"*.LC168"
.LC205:
	.string	"*.LC94"
.LC206:
	.string	"*.LC95"
.LC207:
	.string	"*.LC3"
.LC208:
	.string	"*.LC160"
.LC209:
	.string	"*.LC163"
.LC210:
	.string	"*.LC83"
.LC211:
	.string	"*.LC48"
.LC212:
	.string	"*.LC74"
.LC213:
	.string	"*.LC91"
.LC214:
	.string	"*.LC76"
.LC215:
	.string	"*.LC98"
.LC216:
	.string	"*.LC68"
.LC217:
	.string	"*.LC155"
.LC218:
	.string	"*.LC161"
.LC219:
	.string	"*.LC49"
.LC220:
	.string	"*.LC34"
.LC221:
	.string	"*.LC45"
.LC222:
	.string	"*.LC167"
.LC223:
	.string	"*.LC69"
.LC224:
	.string	"*.LC58"
.LC225:
	.string	"*.LC134"
.LC226:
	.string	"*.LC42"
.LC227:
	.string	"*.LC11"
.LC228:
	.string	"*.LC5"
.LC229:
	.string	"*.LC139"
.LC230:
	.string	"*.LC136"
.LC231:
	.string	"*.LC90"
.LC232:
	.string	"*.LC92"
.LC233:
	.string	"*.LC147"
.LC234:
	.string	"*.LC44"
.LC235:
	.string	"*.LC53"
.LC236:
	.string	"*.LC63"
.LC237:
	.string	"*.LC70"
.LC238:
	.string	"*.LC54"
.LC239:
	.string	"*.LC150"
.LC240:
	.string	"*.LC75"
.LC241:
	.string	"*.LC43"
.LC242:
	.string	"*.LC1"
.LC243:
	.string	"*.LC100"
.LC244:
	.string	"*.LC169"
.LC245:
	.string	"*.LC153"
.LC246:
	.string	"*.LC23"
.LC247:
	.string	"*.LC60"
.LC248:
	.string	"*.LC61"
.LC249:
	.string	"*.LC133"
.LC250:
	.string	"*.LC159"
.LC251:
	.string	"*.LC56"
.LC252:
	.string	"*.LC126"
.LC253:
	.string	"*.LC32"
.LC254:
	.string	"*.LC38"
.LC255:
	.string	"*.LC158"
.LC256:
	.string	"*.LC141"
.LC257:
	.string	"*.LC142"
.LC258:
	.string	"*.LC172"
.LC259:
	.string	"*.LC33"
.LC260:
	.string	"*.LC64"
.LC261:
	.string	"*.LC86"
.LC262:
	.string	"*.LC105"
.LC263:
	.string	"*.LC80"
.LC264:
	.string	"*.LC77"
.LC265:
	.string	"*.LC78"
.LC266:
	.string	"*.LC145"
.LC267:
	.string	"*.LC29"
.LC268:
	.string	"*.LC152"
.LC269:
	.string	"*.LC151"
.LC270:
	.string	"*.LC93"
.LC271:
	.string	"*.LC154"
.LC272:
	.string	"*.LC7"
.LC273:
	.string	"*.LC156"
.LC274:
	.string	"*.LC30"
.LC275:
	.string	"*.LC81"
.LC276:
	.string	"*.LC35"
.LC277:
	.string	"*.LC55"
.LC278:
	.string	"*.LC79"
.LC279:
	.string	"*.LC39"
.LC280:
	.string	"*.LC101"
.LC281:
	.string	"*.LC46"
.LC282:
	.string	"*.LC62"
.LC283:
	.string	"*.LC149"
.LC284:
	.string	"*.LC157"
.LC285:
	.string	"*.LC135"
.LC286:
	.string	"*.LC127"
.LC287:
	.string	"*.LC170"
.LC288:
	.string	"*.LC121"
.LC289:
	.string	"*.LC89"
.LC290:
	.string	"*.LC15"
.LC291:
	.string	"*.LC165"
.LC292:
	.string	"*.LC84"
.LC293:
	.string	"*.LC96"
.LC294:
	.string	"*.LC67"
.LC295:
	.string	"*.LC82"
.LC296:
	.string	"*.LC71"
.LC297:
	.string	"*.LC166"
.LC298:
	.string	"*.LC107"
.LC299:
	.string	"*.LC171"
.LC300:
	.string	"*.LC4"
.LC301:
	.string	"*.LC116"
.LC302:
	.string	"*.LC9"
.LC303:
	.string	"*.LC117"
.LC304:
	.string	"*.LC164"
.LC305:
	.string	"*.LC125"
.LC306:
	.string	"*.LC110"
.LC307:
	.string	"*.LC36"
.LC308:
	.string	"*.LC72"
.LC309:
	.string	"*.LC20"
.LC310:
	.string	"*.LC146"
.LC311:
	.string	"*.LC143"
.LC312:
	.string	"*.LC103"
.LC313:
	.string	"*.LC47"
.LC314:
	.string	"*.LC162"
.LC315:
	.string	"*.LC57"
.LC316:
	.string	"*.LC40"
.LC317:
	.string	"*.LC104"
.LC318:
	.string	"*.LC112"
.LC319:
	.string	"*.LC65"
.LC320:
	.string	"*.LC85"
.LC321:
	.string	"*.LC51"
.LC322:
	.string	"*.LC66"
.LC323:
	.string	"*.LC73"
.LC324:
	.string	"*.LC50"
.LC325:
	.string	"*.LC41"
.LC326:
	.string	"*.LC25"
.LC327:
	.string	"*.LC26"
.LC328:
	.string	"*.LC140"
.LC329:
	.string	"*.LC37"
.LC330:
	.string	"*.LC144"
.LC331:
	.string	"*.LC31"
	.data
	.align 32
	.type	.LASAN0, @object
	.size	.LASAN0, 9408
.LASAN0:
	.quad	watchdog_flag
	.quad	4
	.quad	64
	.quad	.LC175
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC1
	.quad	got_usr1
	.quad	4
	.quad	64
	.quad	.LC176
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC2
	.quad	got_hup
	.quad	4
	.quad	64
	.quad	.LC177
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC3
	.quad	terminate
	.quad	4
	.quad	64
	.quad	.LC178
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC4
	.quad	hs
	.quad	8
	.quad	64
	.quad	.LC179
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC5
	.quad	httpd_conn_count
	.quad	4
	.quad	64
	.quad	.LC180
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC6
	.quad	first_free_connect
	.quad	4
	.quad	64
	.quad	.LC181
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC7
	.quad	max_connects
	.quad	4
	.quad	64
	.quad	.LC182
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC8
	.quad	num_connects
	.quad	4
	.quad	64
	.quad	.LC183
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC9
	.quad	connects
	.quad	8
	.quad	64
	.quad	.LC184
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC10
	.quad	maxthrottles
	.quad	4
	.quad	64
	.quad	.LC185
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC11
	.quad	numthrottles
	.quad	4
	.quad	64
	.quad	.LC186
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC12
	.quad	throttles
	.quad	8
	.quad	64
	.quad	.LC47
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC13
	.quad	max_age
	.quad	4
	.quad	64
	.quad	.LC57
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC14
	.quad	p3p
	.quad	8
	.quad	64
	.quad	.LC56
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC15
	.quad	charset
	.quad	8
	.quad	64
	.quad	.LC55
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC16
	.quad	user
	.quad	8
	.quad	64
	.quad	.LC41
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC17
	.quad	pidfile
	.quad	8
	.quad	64
	.quad	.LC54
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC18
	.quad	hostname
	.quad	8
	.quad	64
	.quad	.LC187
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC19
	.quad	throttlefile
	.quad	8
	.quad	64
	.quad	.LC188
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC20
	.quad	logfile
	.quad	8
	.quad	64
	.quad	.LC49
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC21
	.quad	local_pattern
	.quad	8
	.quad	64
	.quad	.LC189
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC22
	.quad	no_empty_referers
	.quad	4
	.quad	64
	.quad	.LC190
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC23
	.quad	url_pattern
	.quad	8
	.quad	64
	.quad	.LC191
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC24
	.quad	cgi_limit
	.quad	4
	.quad	64
	.quad	.LC192
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC25
	.quad	cgi_pattern
	.quad	8
	.quad	64
	.quad	.LC193
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC26
	.quad	do_global_passwd
	.quad	4
	.quad	64
	.quad	.LC194
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC27
	.quad	do_vhost
	.quad	4
	.quad	64
	.quad	.LC195
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC28
	.quad	no_symlink_check
	.quad	4
	.quad	64
	.quad	.LC196
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC29
	.quad	no_log
	.quad	4
	.quad	64
	.quad	.LC197
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC30
	.quad	do_chroot
	.quad	4
	.quad	64
	.quad	.LC198
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC31
	.quad	data_dir
	.quad	8
	.quad	64
	.quad	.LC36
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC32
	.quad	dir
	.quad	8
	.quad	64
	.quad	.LC33
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC33
	.quad	port
	.quad	2
	.quad	64
	.quad	.LC32
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC34
	.quad	debug
	.quad	4
	.quad	64
	.quad	.LC31
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC35
	.quad	argv0
	.quad	8
	.quad	64
	.quad	.LC199
	.quad	.LC174
	.quad	0
	.quad	.LASANLOC36
	.quad	.LC122
	.quad	35
	.quad	96
	.quad	.LC200
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC148
	.quad	11
	.quad	64
	.quad	.LC201
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC52
	.quad	13
	.quad	64
	.quad	.LC202
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC99
	.quad	19
	.quad	64
	.quad	.LC203
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC168
	.quad	16
	.quad	64
	.quad	.LC204
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC94
	.quad	3
	.quad	64
	.quad	.LC205
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC95
	.quad	39
	.quad	96
	.quad	.LC206
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC3
	.quad	70
	.quad	128
	.quad	.LC207
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC160
	.quad	20
	.quad	64
	.quad	.LC208
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC163
	.quad	24
	.quad	64
	.quad	.LC209
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC83
	.quad	3
	.quad	64
	.quad	.LC210
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC48
	.quad	5
	.quad	64
	.quad	.LC211
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC74
	.quad	3
	.quad	64
	.quad	.LC212
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC91
	.quad	16
	.quad	64
	.quad	.LC213
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC76
	.quad	3
	.quad	64
	.quad	.LC214
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC98
	.quad	2
	.quad	64
	.quad	.LC215
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC68
	.quad	3
	.quad	64
	.quad	.LC216
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC155
	.quad	12
	.quad	64
	.quad	.LC217
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC161
	.quad	15
	.quad	64
	.quad	.LC218
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC49
	.quad	8
	.quad	64
	.quad	.LC219
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC34
	.quad	7
	.quad	64
	.quad	.LC220
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC45
	.quad	16
	.quad	64
	.quad	.LC221
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC167
	.quad	12
	.quad	64
	.quad	.LC222
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC69
	.quad	5
	.quad	64
	.quad	.LC223
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC58
	.quad	32
	.quad	64
	.quad	.LC224
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC134
	.quad	26
	.quad	64
	.quad	.LC225
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC42
	.quad	7
	.quad	64
	.quad	.LC226
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC11
	.quad	219
	.quad	256
	.quad	.LC227
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC5
	.quad	65
	.quad	128
	.quad	.LC228
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC139
	.quad	29
	.quad	64
	.quad	.LC229
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC136
	.quad	39
	.quad	96
	.quad	.LC230
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC90
	.quad	20
	.quad	64
	.quad	.LC231
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC92
	.quad	33
	.quad	96
	.quad	.LC232
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC147
	.quad	15
	.quad	64
	.quad	.LC233
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC44
	.quad	7
	.quad	64
	.quad	.LC234
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC53
	.quad	15
	.quad	64
	.quad	.LC235
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC63
	.quad	3
	.quad	64
	.quad	.LC236
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC70
	.quad	4
	.quad	64
	.quad	.LC237
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC54
	.quad	8
	.quad	64
	.quad	.LC238
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC150
	.quad	2
	.quad	64
	.quad	.LC239
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC75
	.quad	3
	.quad	64
	.quad	.LC240
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC43
	.quad	9
	.quad	64
	.quad	.LC241
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC1
	.quad	104
	.quad	160
	.quad	.LC242
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC100
	.quad	2
	.quad	64
	.quad	.LC243
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC169
	.quad	12
	.quad	64
	.quad	.LC244
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC153
	.quad	4
	.quad	64
	.quad	.LC245
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC23
	.quad	16
	.quad	64
	.quad	.LC246
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC60
	.quad	7
	.quad	64
	.quad	.LC247
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC61
	.quad	11
	.quad	64
	.quad	.LC248
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC133
	.quad	3
	.quad	64
	.quad	.LC249
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC159
	.quad	13
	.quad	64
	.quad	.LC250
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC56
	.quad	4
	.quad	64
	.quad	.LC251
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC126
	.quad	37
	.quad	96
	.quad	.LC252
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC32
	.quad	5
	.quad	64
	.quad	.LC253
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC38
	.quad	10
	.quad	64
	.quad	.LC254
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC158
	.quad	18
	.quad	64
	.quad	.LC255
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC141
	.quad	23
	.quad	64
	.quad	.LC256
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC142
	.quad	25
	.quad	64
	.quad	.LC257
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC172
	.quad	13
	.quad	64
	.quad	.LC258
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC33
	.quad	4
	.quad	64
	.quad	.LC259
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC64
	.quad	26
	.quad	64
	.quad	.LC260
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC86
	.quad	3
	.quad	64
	.quad	.LC261
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC105
	.quad	39
	.quad	96
	.quad	.LC262
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC80
	.quad	3
	.quad	64
	.quad	.LC263
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC77
	.quad	3
	.quad	64
	.quad	.LC264
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC78
	.quad	3
	.quad	64
	.quad	.LC265
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC145
	.quad	72
	.quad	128
	.quad	.LC266
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC29
	.quad	2
	.quad	64
	.quad	.LC267
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC152
	.quad	2
	.quad	64
	.quad	.LC268
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC151
	.quad	12
	.quad	64
	.quad	.LC269
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC93
	.quad	38
	.quad	96
	.quad	.LC270
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC154
	.quad	31
	.quad	64
	.quad	.LC271
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC7
	.quad	37
	.quad	96
	.quad	.LC272
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC156
	.quad	74
	.quad	128
	.quad	.LC273
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC30
	.quad	5
	.quad	64
	.quad	.LC274
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC81
	.quad	5
	.quad	64
	.quad	.LC275
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC35
	.quad	9
	.quad	64
	.quad	.LC276
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC55
	.quad	8
	.quad	64
	.quad	.LC277
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC79
	.quad	5
	.quad	64
	.quad	.LC278
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC39
	.quad	9
	.quad	64
	.quad	.LC279
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC101
	.quad	22
	.quad	64
	.quad	.LC280
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC46
	.quad	9
	.quad	64
	.quad	.LC281
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC62
	.quad	1
	.quad	64
	.quad	.LC282
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC149
	.quad	6
	.quad	64
	.quad	.LC283
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC157
	.quad	79
	.quad	128
	.quad	.LC284
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC135
	.quad	25
	.quad	64
	.quad	.LC285
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC127
	.quad	25
	.quad	64
	.quad	.LC286
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC170
	.quad	58
	.quad	96
	.quad	.LC287
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC121
	.quad	35
	.quad	96
	.quad	.LC288
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC89
	.quad	11
	.quad	64
	.quad	.LC289
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC15
	.quad	39
	.quad	96
	.quad	.LC290
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC165
	.quad	30
	.quad	64
	.quad	.LC291
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC84
	.quad	3
	.quad	64
	.quad	.LC292
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC96
	.quad	44
	.quad	96
	.quad	.LC293
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC67
	.quad	3
	.quad	64
	.quad	.LC294
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC82
	.quad	3
	.quad	64
	.quad	.LC295
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC71
	.quad	3
	.quad	64
	.quad	.LC296
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC166
	.quad	15
	.quad	64
	.quad	.LC297
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC107
	.quad	56
	.quad	96
	.quad	.LC298
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC171
	.quad	38
	.quad	96
	.quad	.LC299
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC4
	.quad	62
	.quad	96
	.quad	.LC300
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC116
	.quad	33
	.quad	96
	.quad	.LC301
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC9
	.quad	34
	.quad	96
	.quad	.LC302
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC117
	.quad	43
	.quad	96
	.quad	.LC303
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC164
	.quad	36
	.quad	96
	.quad	.LC304
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC125
	.quad	33
	.quad	96
	.quad	.LC305
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC110
	.quad	8
	.quad	64
	.quad	.LC306
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC36
	.quad	9
	.quad	64
	.quad	.LC307
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC72
	.quad	5
	.quad	64
	.quad	.LC308
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC20
	.quad	5
	.quad	64
	.quad	.LC309
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC146
	.quad	20
	.quad	64
	.quad	.LC310
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC143
	.quad	10
	.quad	64
	.quad	.LC311
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC103
	.quad	22
	.quad	64
	.quad	.LC312
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC47
	.quad	10
	.quad	64
	.quad	.LC313
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC162
	.quad	30
	.quad	64
	.quad	.LC314
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC57
	.quad	8
	.quad	64
	.quad	.LC315
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC40
	.quad	11
	.quad	64
	.quad	.LC316
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC104
	.quad	36
	.quad	96
	.quad	.LC317
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC112
	.quad	25
	.quad	64
	.quad	.LC318
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC65
	.quad	3
	.quad	64
	.quad	.LC319
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC85
	.quad	3
	.quad	64
	.quad	.LC320
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC51
	.quad	8
	.quad	64
	.quad	.LC321
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC66
	.quad	3
	.quad	64
	.quad	.LC322
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC73
	.quad	3
	.quad	64
	.quad	.LC323
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC50
	.quad	6
	.quad	64
	.quad	.LC324
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC41
	.quad	5
	.quad	64
	.quad	.LC325
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC25
	.quad	31
	.quad	64
	.quad	.LC326
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC26
	.quad	36
	.quad	96
	.quad	.LC327
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC140
	.quad	34
	.quad	96
	.quad	.LC328
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC37
	.quad	8
	.quad	64
	.quad	.LC329
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC144
	.quad	67
	.quad	128
	.quad	.LC330
	.quad	.LC174
	.quad	0
	.quad	0
	.quad	.LC31
	.quad	6
	.quad	64
	.quad	.LC331
	.quad	.LC174
	.quad	0
	.quad	0
	.section	.text.unlikely
.LCOLDB332:
	.section	.text.exit,"ax",@progbits
.LHOTB332:
	.p2align 4,,15
	.type	_GLOBAL__sub_D_00099_0_terminate, @function
_GLOBAL__sub_D_00099_0_terminate:
.LFB38:
	.cfi_startproc
	movl	$168, %esi
	movl	$.LASAN0, %edi
	jmp	__asan_unregister_globals
	.cfi_endproc
.LFE38:
	.size	_GLOBAL__sub_D_00099_0_terminate, .-_GLOBAL__sub_D_00099_0_terminate
	.section	.text.unlikely
.LCOLDE332:
	.section	.text.exit
.LHOTE332:
	.section	.fini_array.00099,"aw"
	.align 8
	.quad	_GLOBAL__sub_D_00099_0_terminate
	.section	.text.unlikely
.LCOLDB333:
	.section	.text.startup
.LHOTB333:
	.p2align 4,,15
	.type	_GLOBAL__sub_I_00099_1_terminate, @function
_GLOBAL__sub_I_00099_1_terminate:
.LFB39:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	__asan_init_v4
	movl	$168, %esi
	movl	$.LASAN0, %edi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	__asan_register_globals
	.cfi_endproc
.LFE39:
	.size	_GLOBAL__sub_I_00099_1_terminate, .-_GLOBAL__sub_I_00099_1_terminate
	.section	.text.unlikely
.LCOLDE333:
	.section	.text.startup
.LHOTE333:
	.section	.init_array.00099,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_00099_1_terminate
	.ident	"GCC: (GNU) 5.2.0"
	.section	.note.GNU-stack,"",@progbits
