	.file	"thttpd.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.type	handle_hup, @function
handle_hup:
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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.type	thttpd_logstats, @function
thttpd_logstats:
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
	.section	.rodata.str1.8
	.align 8
.LC3:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.align 8
.LC4:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.align 8
.LC5:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.section	.text.unlikely
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4,,15
	.type	update_throttles, @function
update_throttles:
.LFB25:
	.cfi_startproc
	movl	numthrottles(%rip), %r8d
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movabsq	$6148914691236517206, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebx, %ebx
	testl	%r8d, %r8d
	jg	.L25
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L35:
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC3, %esi
	movl	$5, %edi
.L32:
	xorl	%eax, %eax
	call	syslog
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	popq	%rsi
	.cfi_def_cfa_offset 40
	popq	%rdi
	.cfi_def_cfa_offset 32
	movq	24(%rcx), %r8
.L10:
	movq	16(%rcx), %r9
	cmpq	%r8, %r9
	jle	.L11
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L11
	subq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC5, %esi
	xorl	%eax, %eax
	movl	$5, %edi
	call	syslog
	popq	%rax
	.cfi_def_cfa_offset 40
	popq	%rdx
	.cfi_def_cfa_offset 32
	.p2align 4,,10
	.p2align 3
.L11:
	addl	$1, %ebx
	addq	$48, %rbp
	cmpl	%ebx, numthrottles(%rip)
	jle	.L14
.L25:
	movq	%rbp, %rcx
	addq	throttles(%rip), %rcx
	movq	32(%rcx), %rax
	movq	24(%rcx), %rdx
	movq	8(%rcx), %r9
	movq	$0, 32(%rcx)
	movq	%rax, %rsi
	shrq	$63, %rsi
	addq	%rsi, %rax
	sarq	%rax
	leaq	(%rax,%rdx,2), %rsi
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%r12
	subq	%rsi, %rdx
	cmpq	%r9, %rdx
	movq	%rdx, %r8
	movq	%rdx, 24(%rcx)
	jle	.L10
	movl	40(%rcx), %eax
	testl	%eax, %eax
	je	.L11
	leaq	(%r9,%r9), %rdx
	cmpq	%rdx, %r8
	jg	.L35
	subq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	(%rcx), %rcx
	movl	%ebx, %edx
	pushq	%rax
	.cfi_def_cfa_offset 48
	movl	$.LC4, %esi
	movl	$6, %edi
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L14:
	.cfi_restore_state
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L6
	subl	$1, %eax
	movq	connects(%rip), %rsi
	movq	throttles(%rip), %r10
	leaq	9(%rax,%rax,8), %r11
	salq	$4, %r11
	addq	%rsi, %r11
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L17:
	addq	$144, %rsi
	cmpq	%r11, %rsi
	je	.L6
.L16:
	movl	(%rsi), %eax
	subl	$2, %eax
	cmpl	$1, %eax
	ja	.L17
	movl	56(%rsi), %eax
	movq	$-1, 64(%rsi)
	testl	%eax, %eax
	jle	.L17
	subl	$1, %eax
	leaq	16(%rsi), %rcx
	movq	$-1, %rdi
	leaq	20(%rsi,%rax,4), %r9
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L36:
	movq	64(%rsi), %rdi
.L20:
	movslq	(%rcx), %rax
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%r10, %rax
	movslq	40(%rax), %r8
	movq	8(%rax), %rax
	cqto
	idivq	%r8
	cmpq	$-1, %rdi
	je	.L33
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
.L33:
	addq	$4, %rcx
	movq	%rax, 64(%rsi)
	cmpq	%r9, %rcx
	jne	.L36
	addq	$144, %rsi
	cmpq	%r11, %rsi
	jne	.L16
.L6:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE25:
	.size	update_throttles, .-update_throttles
	.section	.text.unlikely
.LCOLDE6:
	.text
.LHOTE6:
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"%s: no value required for %s option\n"
	.section	.text.unlikely
.LCOLDB8:
	.text
.LHOTB8:
	.p2align 4,,15
	.type	no_value_required, @function
no_value_required:
.LFB14:
	.cfi_startproc
	testq	%rsi, %rsi
	jne	.L41
	rep ret
.L41:
	movq	%rdi, %rcx
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC7, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE14:
	.size	no_value_required, .-no_value_required
	.section	.text.unlikely
.LCOLDE8:
	.text
.LHOTE8:
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"%s: value required for %s option\n"
	.section	.text.unlikely
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4,,15
	.type	value_required, @function
value_required:
.LFB13:
	.cfi_startproc
	testq	%rsi, %rsi
	je	.L46
	rep ret
.L46:
	movq	%rdi, %rcx
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC9, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE13:
	.size	value_required, .-value_required
	.section	.text.unlikely
.LCOLDE10:
	.text
.LHOTE10:
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir]
     [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host]
      [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.section	.text.unlikely
.LCOLDB12:
.LHOTB12:
	.type	usage, @function
usage:
.LFB11:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	stderr(%rip), %rdi
	movl	$.LC11, %esi
	movq	argv0(%rip), %rdx
	xorl	%eax, %eax
	call	fprintf
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
.LFB30:
	.cfi_startproc
	cmpl	$3, (%rdi)
	movq	$0, 96(%rdi)
	je	.L51
	rep ret
	.p2align 4,,10
	.p2align 3
.L51:
	movq	8(%rdi), %rax
	movl	$2, (%rdi)
	movq	%rdi, %rsi
	movl	$1, %edx
	movl	704(%rax), %eax
	movl	%eax, %edi
	jmp	fdwatch_add_fd
	.cfi_endproc
.LFE30:
	.size	wakeup_connection, .-wakeup_connection
	.section	.text.unlikely
.LCOLDE13:
	.text
.LHOTE13:
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"up %ld seconds, stats for %ld seconds:"
	.section	.text.unlikely
.LCOLDB15:
	.text
.LHOTB15:
	.p2align 4,,15
	.type	logstats, @function
logstats:
.LFB34:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L57
.L53:
	movq	(%rdi), %rax
	movl	$1, %ecx
	movl	$.LC14, %esi
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
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L58
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L57:
	.cfi_restore_state
	movq	%rsp, %rdi
	xorl	%esi, %esi
	call	gettimeofday
	movq	%rsp, %rdi
	jmp	.L53
.L58:
	call	__stack_chk_fail
	.cfi_endproc
.LFE34:
	.size	logstats, .-logstats
	.section	.text.unlikely
.LCOLDE15:
	.text
.LHOTE15:
	.section	.text.unlikely
.LCOLDB16:
	.text
.LHOTB16:
	.p2align 4,,15
	.type	show_stats, @function
show_stats:
.LFB33:
	.cfi_startproc
	movq	%rsi, %rdi
	jmp	logstats
	.cfi_endproc
.LFE33:
	.size	show_stats, .-show_stats
	.section	.text.unlikely
.LCOLDE16:
	.text
.LHOTE16:
	.section	.text.unlikely
.LCOLDB17:
	.text
.LHOTB17:
	.p2align 4,,15
	.type	handle_usr2, @function
handle_usr2:
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
	movl	(%rax), %ebp
	movq	%rax, %rbx
	xorl	%edi, %edi
	call	logstats
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE6:
	.size	handle_usr2, .-handle_usr2
	.section	.text.unlikely
.LCOLDE17:
	.text
.LHOTE17:
	.section	.text.unlikely
.LCOLDB18:
	.text
.LHOTB18:
	.p2align 4,,15
	.type	occasional, @function
occasional:
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
.LCOLDE18:
	.text
.LHOTE18:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC19:
	.string	"/tmp"
	.section	.text.unlikely
.LCOLDB20:
	.text
.LHOTB20:
	.p2align 4,,15
	.type	handle_alrm, @function
handle_alrm:
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
	movl	(%rax), %ebp
	movl	watchdog_flag(%rip), %eax
	testl	%eax, %eax
	je	.L67
	movl	$360, %edi
	movl	$0, watchdog_flag(%rip)
	call	alarm
	movl	%ebp, (%rbx)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L67:
	.cfi_restore_state
	movl	$.LC19, %edi
	call	chdir
	call	abort
	.cfi_endproc
.LFE7:
	.size	handle_alrm, .-handle_alrm
	.section	.text.unlikely
.LCOLDE20:
	.text
.LHOTE20:
	.section	.rodata.str1.1
.LC21:
	.string	"child wait - %m"
	.section	.text.unlikely
.LCOLDB22:
	.text
.LHOTB22:
	.p2align 4,,15
	.type	handle_chld, @function
handle_chld:
.LFB3:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	__errno_location
	movl	(%rax), %r12d
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L69:
	leaq	4(%rsp), %rsi
	movl	$1, %edx
	movl	$-1, %edi
	call	waitpid
	testl	%eax, %eax
	je	.L70
	js	.L86
	movq	hs(%rip), %rdx
	testq	%rdx, %rdx
	je	.L69
	movl	36(%rdx), %eax
	subl	$1, %eax
	cmovs	%ebp, %eax
	movl	%eax, 36(%rdx)
	jmp	.L69
	.p2align 4,,10
	.p2align 3
.L86:
	movl	(%rbx), %eax
	cmpl	$4, %eax
	je	.L69
	cmpl	$11, %eax
	je	.L69
	cmpl	$10, %eax
	je	.L70
	movl	$.LC21, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L70:
	movq	8(%rsp), %rax
	xorq	%fs:40, %rax
	movl	%r12d, (%rbx)
	jne	.L87
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
.L87:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE3:
	.size	handle_chld, .-handle_chld
	.section	.text.unlikely
.LCOLDE22:
	.text
.LHOTE22:
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"out of memory copying a string"
	.align 8
.LC24:
	.string	"%s: out of memory copying a string\n"
	.section	.text.unlikely
.LCOLDB25:
	.text
.LHOTB25:
	.p2align 4,,15
	.type	e_strdup, @function
e_strdup:
.LFB15:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	strdup
	testq	%rax, %rax
	je	.L91
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L91:
	.cfi_restore_state
	movl	$.LC23, %esi
	movl	$2, %edi
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC24, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE15:
	.size	e_strdup, .-e_strdup
	.section	.text.unlikely
.LCOLDE25:
	.text
.LHOTE25:
	.section	.rodata.str1.1
.LC26:
	.string	"r"
.LC27:
	.string	" \t\n\r"
.LC28:
	.string	"debug"
.LC29:
	.string	"port"
.LC30:
	.string	"dir"
.LC31:
	.string	"chroot"
.LC32:
	.string	"nochroot"
.LC33:
	.string	"data_dir"
.LC34:
	.string	"symlink"
.LC35:
	.string	"nosymlink"
.LC36:
	.string	"symlinks"
.LC37:
	.string	"nosymlinks"
.LC38:
	.string	"user"
.LC39:
	.string	"cgipat"
.LC40:
	.string	"cgilimit"
.LC41:
	.string	"urlpat"
.LC42:
	.string	"noemptyreferers"
.LC43:
	.string	"localpat"
.LC44:
	.string	"throttles"
.LC45:
	.string	"host"
.LC46:
	.string	"logfile"
.LC47:
	.string	"vhost"
.LC48:
	.string	"novhost"
.LC49:
	.string	"globalpasswd"
.LC50:
	.string	"noglobalpasswd"
.LC51:
	.string	"pidfile"
.LC52:
	.string	"charset"
.LC53:
	.string	"p3p"
.LC54:
	.string	"max_age"
	.section	.rodata.str1.8
	.align 8
.LC55:
	.string	"%s: unknown config option '%s'\n"
	.section	.text.unlikely
.LCOLDB56:
	.text
.LHOTB56:
	.p2align 4,,15
	.type	read_config, @function
read_config:
.LFB12:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	$.LC26, %esi
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	subq	$112, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	call	fopen
	testq	%rax, %rax
	je	.L140
	movq	%rax, %r12
	movabsq	$4294977024, %r14
.L93:
	movq	%r12, %rdx
	movl	$1000, %esi
	movq	%rsp, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L144
	movl	$35, %esi
	movq	%rsp, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L94
	movb	$0, (%rax)
.L94:
	movl	$.LC27, %esi
	movq	%rsp, %rdi
	call	strspn
	leaq	(%rsp,%rax), %rbp
	cmpb	$0, 0(%rbp)
	jne	.L136
	jmp	.L93
	.p2align 4,,10
	.p2align 3
.L96:
	movl	$61, %esi
	movq	%rbp, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L131
	leaq	1(%rax), %r13
	movb	$0, (%rax)
.L98:
	movl	$.LC28, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L145
	movl	$.LC29, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L146
	movl	$.LC30, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L147
	movl	$.LC31, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L148
	movl	$.LC32, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L149
	movl	$.LC33, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L150
	movl	$.LC34, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L142
	movl	$.LC35, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L143
	movl	$.LC36, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L142
	movl	$.LC37, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L143
	movl	$.LC38, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L151
	movl	$.LC39, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L152
	movl	$.LC40, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L153
	movl	$.LC41, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L154
	movl	$.LC42, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L155
	movl	$.LC43, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L156
	movl	$.LC44, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L157
	movl	$.LC45, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L158
	movl	$.LC46, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L159
	movl	$.LC47, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L160
	movl	$.LC48, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L161
	movl	$.LC49, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L162
	movl	$.LC50, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L163
	movl	$.LC51, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L164
	movl	$.LC52, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L165
	movl	$.LC53, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	je	.L166
	movl	$.LC54, %esi
	movq	%rbp, %rdi
	call	strcasecmp
	testl	%eax, %eax
	jne	.L126
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movl	%eax, max_age(%rip)
	.p2align 4,,10
	.p2align 3
.L100:
	movl	$.LC27, %esi
	movq	%rbx, %rdi
	call	strspn
	leaq	(%rbx,%rax), %rbp
	cmpb	$0, 0(%rbp)
	je	.L93
.L136:
	movl	$.LC27, %esi
	movq	%rbp, %rdi
	call	strcspn
	leaq	0(%rbp,%rax), %rbx
	movzbl	(%rbx), %eax
	cmpb	$32, %al
	ja	.L96
	btq	%rax, %r14
	jnc	.L96
	.p2align 4,,10
	.p2align 3
.L97:
	addq	$1, %rbx
	movzbl	(%rbx), %edx
	movb	$0, -1(%rbx)
	cmpb	$32, %dl
	ja	.L96
	btq	%rdx, %r14
	jc	.L97
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L145:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, debug(%rip)
	jmp	.L100
.L146:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movw	%ax, port(%rip)
	jmp	.L100
.L131:
	xorl	%r13d, %r13d
	jmp	.L98
.L147:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, dir(%rip)
	jmp	.L100
.L148:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L100
.L149:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L100
.L142:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, no_symlink_check(%rip)
	jmp	.L100
.L150:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, data_dir(%rip)
	jmp	.L100
.L143:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, no_symlink_check(%rip)
	jmp	.L100
.L151:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, user(%rip)
	jmp	.L100
.L153:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	atoi
	movl	%eax, cgi_limit(%rip)
	jmp	.L100
.L152:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, cgi_pattern(%rip)
	jmp	.L100
.L144:
	movq	%r12, %rdi
	call	fclose
	movq	104(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L167
	addq	$112, %rsp
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
.L155:
	.cfi_restore_state
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, no_empty_referers(%rip)
	jmp	.L100
.L154:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, url_pattern(%rip)
	jmp	.L100
.L156:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, local_pattern(%rip)
	jmp	.L100
.L157:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, throttlefile(%rip)
	jmp	.L100
.L126:
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movq	%rbp, %rcx
	movl	$.LC55, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L166:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, p3p(%rip)
	jmp	.L100
.L165:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, charset(%rip)
	jmp	.L100
.L164:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, pidfile(%rip)
	jmp	.L100
.L140:
	movq	%rbx, %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L167:
	call	__stack_chk_fail
.L159:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, logfile(%rip)
	jmp	.L100
.L158:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	value_required
	movq	%r13, %rdi
	call	e_strdup
	movq	%rax, hostname(%rip)
	jmp	.L100
.L163:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_global_passwd(%rip)
	jmp	.L100
.L162:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_global_passwd(%rip)
	jmp	.L100
.L161:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$0, do_vhost(%rip)
	jmp	.L100
.L160:
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	no_value_required
	movl	$1, do_vhost(%rip)
	jmp	.L100
	.cfi_endproc
.LFE12:
	.size	read_config, .-read_config
	.section	.text.unlikely
.LCOLDE56:
	.text
.LHOTE56:
	.section	.rodata.str1.1
.LC57:
	.string	"nobody"
.LC58:
	.string	"iso-8859-1"
.LC59:
	.string	""
.LC60:
	.string	"-V"
.LC61:
	.string	"thttpd/2.27.0 Oct 3, 2014"
.LC62:
	.string	"-C"
.LC63:
	.string	"-p"
.LC64:
	.string	"-d"
.LC65:
	.string	"-r"
.LC66:
	.string	"-nor"
.LC67:
	.string	"-dd"
.LC68:
	.string	"-s"
.LC69:
	.string	"-nos"
.LC70:
	.string	"-u"
.LC71:
	.string	"-c"
.LC72:
	.string	"-t"
.LC73:
	.string	"-h"
.LC74:
	.string	"-l"
.LC75:
	.string	"-v"
.LC76:
	.string	"-nov"
.LC77:
	.string	"-g"
.LC78:
	.string	"-nog"
.LC79:
	.string	"-i"
.LC80:
	.string	"-T"
.LC81:
	.string	"-P"
.LC82:
	.string	"-M"
.LC83:
	.string	"-D"
	.section	.text.unlikely
.LCOLDB84:
	.text
.LHOTB84:
	.p2align 4,,15
	.type	parse_args, @function
parse_args:
.LFB10:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	$80, %eax
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r13d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	cmpl	$1, %edi
	movl	$0, debug(%rip)
	movw	%ax, port(%rip)
	movq	$0, dir(%rip)
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
	movq	$.LC57, user(%rip)
	movq	$.LC58, charset(%rip)
	movq	$.LC59, p3p(%rip)
	movl	$-1, max_age(%rip)
	jle	.L200
	movq	8(%rsi), %rbx
	movq	%rsi, %r14
	movl	$1, %ebp
	movl	$.LC60, %r12d
	cmpb	$45, (%rbx)
	je	.L207
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L216:
	leal	1(%rbp), %r15d
	cmpl	%r15d, %r13d
	jg	.L214
	movl	$.LC63, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	je	.L177
.L176:
	movl	$.LC64, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L177
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L177
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, dir(%rip)
.L175:
	addl	$1, %ebp
	cmpl	%ebp, %r13d
	jle	.L169
.L217:
	movslq	%ebp, %rax
	movq	(%r14,%rax,8), %rbx
	cmpb	$45, (%rbx)
	jne	.L171
.L207:
	movl	$3, %ecx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	repz cmpsb
	je	.L215
	movl	$.LC62, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	je	.L216
	movl	$.LC63, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L176
	leal	1(%rbp), %r15d
	cmpl	%r15d, %r13d
	jle	.L177
	movslq	%r15d, %rax
	movl	%r15d, %ebp
	movq	(%r14,%rax,8), %rdi
	addl	$1, %ebp
	call	atoi
	cmpl	%ebp, %r13d
	movw	%ax, port(%rip)
	jg	.L217
.L169:
	cmpl	%ebp, %r13d
	jne	.L171
	addq	$8, %rsp
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
.L177:
	.cfi_restore_state
	movl	$.LC65, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L178
	movl	$1, do_chroot(%rip)
	movl	$1, no_symlink_check(%rip)
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L178:
	movl	$.LC66, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L179
	movl	$0, do_chroot(%rip)
	movl	$0, no_symlink_check(%rip)
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L214:
	movslq	%r15d, %rax
	movl	%r15d, %ebp
	movq	(%r14,%rax,8), %rdi
	call	read_config
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L179:
	movl	$.LC67, %edi
	movl	$4, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L180
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L180
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, data_dir(%rip)
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L180:
	movl	$.LC68, %edi
	movl	$3, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	jne	.L181
	movl	$0, no_symlink_check(%rip)
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L181:
	movl	$.LC69, %edi
	movl	$5, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	je	.L218
	movl	$.LC70, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L183
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L183
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, user(%rip)
	jmp	.L175
.L218:
	movl	$1, no_symlink_check(%rip)
	jmp	.L175
.L183:
	movl	$.LC71, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L184
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L184
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, cgi_pattern(%rip)
	jmp	.L175
.L184:
	movl	$.LC72, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L219
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L187
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L188
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, hostname(%rip)
	jmp	.L175
.L219:
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L186
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, throttlefile(%rip)
	jmp	.L175
.L186:
	movl	$.LC73, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L187
.L188:
	movl	$.LC75, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L189
	movl	$1, do_vhost(%rip)
	jmp	.L175
.L187:
	movl	$.LC74, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L188
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L188
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, logfile(%rip)
	jmp	.L175
.L189:
	movl	$.LC76, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L220
	movl	$.LC77, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L191
	movl	$1, do_global_passwd(%rip)
	jmp	.L175
.L220:
	movl	$0, do_vhost(%rip)
	jmp	.L175
.L200:
	movl	$1, %ebp
	jmp	.L169
.L191:
	movl	$.LC78, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L192
	movl	$0, do_global_passwd(%rip)
	jmp	.L175
.L215:
	movl	$.LC61, %edi
	call	puts
	xorl	%edi, %edi
	call	exit
.L192:
	movl	$.LC79, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L193
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L193
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, pidfile(%rip)
	jmp	.L175
.L193:
	movl	$.LC80, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L194
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L195
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, charset(%rip)
	jmp	.L175
.L194:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L196
	leal	1(%rbp), %eax
	cmpl	%eax, %r13d
	jle	.L197
	movslq	%eax, %rdx
	movl	%eax, %ebp
	movq	(%r14,%rdx,8), %rdx
	movq	%rdx, p3p(%rip)
	jmp	.L175
.L195:
	movl	$.LC81, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L197
.L196:
	movl	$.LC82, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L197
	leal	1(%rbp), %r15d
	cmpl	%r15d, %r13d
	jle	.L197
	movslq	%r15d, %rax
	movl	%r15d, %ebp
	movq	(%r14,%rax,8), %rdi
	call	atoi
	movl	%eax, max_age(%rip)
	jmp	.L175
.L197:
	movl	$.LC83, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L171
	movl	$1, debug(%rip)
	jmp	.L175
.L171:
	call	usage
	.cfi_endproc
.LFE10:
	.size	parse_args, .-parse_args
	.section	.text.unlikely
.LCOLDE84:
	.text
.LHOTE84:
	.section	.rodata.str1.1
.LC85:
	.string	"%.80s - %m"
.LC86:
	.string	" %4900[^ \t] %ld-%ld"
.LC87:
	.string	" %4900[^ \t] %ld"
	.section	.rodata.str1.8
	.align 8
.LC88:
	.string	"unparsable line in %.80s - %.80s"
	.align 8
.LC89:
	.string	"%s: unparsable line in %.80s - %.80s\n"
	.section	.rodata.str1.1
.LC90:
	.string	"|/"
	.section	.rodata.str1.8
	.align 8
.LC91:
	.string	"out of memory allocating a throttletab"
	.align 8
.LC92:
	.string	"%s: out of memory allocating a throttletab\n"
	.section	.text.unlikely
.LCOLDB93:
	.text
.LHOTB93:
	.p2align 4,,15
	.type	read_throttlefile, @function
read_throttlefile:
.LFB17:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	$.LC26, %esi
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$10048, %rsp
	.cfi_def_cfa_offset 10096
	movq	%fs:40, %rax
	movq	%rax, 10040(%rsp)
	xorl	%eax, %eax
	call	fopen
	testq	%rax, %rax
	je	.L261
	leaq	16(%rsp), %rdi
	leaq	32(%rsp), %rbx
	leaq	5041(%rsp), %r13
	xorl	%esi, %esi
	movq	%rax, %rbp
	call	gettimeofday
	.p2align 4,,10
	.p2align 3
.L223:
	movq	%rbp, %rdx
	movl	$5000, %esi
	movq	%rbx, %rdi
	call	fgets
	testq	%rax, %rax
	je	.L262
	movl	$35, %esi
	movq	%rbx, %rdi
	call	strchr
	testq	%rax, %rax
	je	.L224
	movb	$0, (%rax)
.L224:
	movq	%rbx, %rax
.L225:
	movl	(%rax), %ecx
	addq	$4, %rax
	leal	-16843009(%rcx), %edx
	notl	%ecx
	andl	%ecx, %edx
	andl	$-2139062144, %edx
	je	.L225
	movl	%edx, %ecx
	shrl	$16, %ecx
	testl	$32896, %edx
	cmove	%ecx, %edx
	leaq	2(%rax), %rcx
	cmove	%rcx, %rax
	addb	%dl, %dl
	sbbq	$3, %rax
	subq	%rbx, %rax
	cmpl	$0, %eax
	jle	.L227
	subl	$1, %eax
	movslq	%eax, %rdx
	movzbl	32(%rsp,%rdx), %ecx
	cmpb	$32, %cl
	jbe	.L263
	.p2align 4,,10
	.p2align 3
.L228:
	leaq	8(%rsp), %rcx
	leaq	5040(%rsp), %rdx
	xorl	%eax, %eax
	movq	%rsp, %r8
	movl	$.LC86, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$3, %eax
	je	.L230
	leaq	5040(%rsp), %rdx
	xorl	%eax, %eax
	movq	%rsp, %rcx
	movl	$.LC87, %esi
	movq	%rbx, %rdi
	call	__isoc99_sscanf
	cmpl	$2, %eax
	jne	.L234
	movq	$0, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L230:
	cmpb	$47, 5040(%rsp)
	jne	.L236
	jmp	.L264
	.p2align 4,,10
	.p2align 3
.L237:
	leaq	2(%rax), %rsi
	leaq	1(%rax), %rdi
	call	strcpy
.L236:
	leaq	5040(%rsp), %rdi
	movl	$.LC90, %esi
	call	strstr
	testq	%rax, %rax
	jne	.L237
	movslq	numthrottles(%rip), %rdx
	movl	maxthrottles(%rip), %eax
	cmpl	%eax, %edx
	jl	.L238
	testl	%eax, %eax
	jne	.L239
	movl	$4800, %edi
	movl	$100, maxthrottles(%rip)
	call	malloc
	movq	%rax, throttles(%rip)
.L240:
	testq	%rax, %rax
	je	.L241
	movslq	numthrottles(%rip), %rdx
.L242:
	leaq	(%rdx,%rdx,2), %r14
	leaq	5040(%rsp), %rdi
	movq	%r14, %rdx
	salq	$4, %rdx
	leaq	(%rax,%rdx), %r14
	call	e_strdup
	movq	%rax, (%r14)
	movslq	numthrottles(%rip), %rax
	movq	(%rsp), %rcx
	movq	%rax, %rdx
	leaq	(%rax,%rax,2), %rax
	addl	$1, %edx
	salq	$4, %rax
	addq	throttles(%rip), %rax
	movl	%edx, numthrottles(%rip)
	movq	%rcx, 8(%rax)
	movq	8(%rsp), %rcx
	movq	$0, 24(%rax)
	movq	$0, 32(%rax)
	movl	$0, 40(%rax)
	movq	%rcx, 16(%rax)
	jmp	.L223
	.p2align 4,,10
	.p2align 3
.L263:
	movabsq	$4294977024, %rsi
	.p2align 4,,10
	.p2align 3
.L260:
	btq	%rcx, %rsi
	jnc	.L228
	testl	%eax, %eax
	movb	$0, 32(%rsp,%rdx)
	je	.L223
	subl	$1, %eax
	movslq	%eax, %rdx
	movzbl	32(%rsp,%rdx), %ecx
	cmpb	$32, %cl
	ja	.L228
	jmp	.L260
.L234:
	movq	%rbx, %rcx
	movq	%r12, %rdx
	xorl	%eax, %eax
	movl	$.LC88, %esi
	movl	$2, %edi
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movq	%rbx, %r8
	movq	%r12, %rcx
	movl	$.LC89, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L223
.L239:
	addl	%eax, %eax
	movq	throttles(%rip), %rdi
	movl	%eax, maxthrottles(%rip)
	cltq
	leaq	(%rax,%rax,2), %rsi
	salq	$4, %rsi
	call	realloc
	movq	%rax, throttles(%rip)
	jmp	.L240
.L238:
	movq	throttles(%rip), %rax
	jmp	.L242
.L262:
	movq	%rbp, %rdi
	call	fclose
	movq	10040(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L265
	addq	$10048, %rsp
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
.L227:
	.cfi_restore_state
	jne	.L228
	jmp	.L223
.L264:
	leaq	5040(%rsp), %rdi
	movq	%r13, %rsi
	call	strcpy
	jmp	.L236
.L261:
	movq	%r12, %rdx
	movl	$.LC85, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r12, %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L265:
	call	__stack_chk_fail
.L241:
	movl	$.LC91, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC92, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE17:
	.size	read_throttlefile, .-read_throttlefile
	.section	.text.unlikely
.LCOLDE93:
	.text
.LHOTE93:
	.section	.rodata.str1.1
.LC94:
	.string	"-"
.LC95:
	.string	"re-opening logfile"
.LC96:
	.string	"a"
.LC97:
	.string	"re-opening %.80s - %m"
	.section	.text.unlikely
.LCOLDB98:
	.text
.LHOTB98:
	.p2align 4,,15
	.type	re_open_logfile, @function
re_open_logfile:
.LFB8:
	.cfi_startproc
	movl	no_log(%rip), %eax
	testl	%eax, %eax
	jne	.L278
	cmpq	$0, hs(%rip)
	je	.L278
	movq	logfile(%rip), %rsi
	testq	%rsi, %rsi
	je	.L278
	movl	$.LC94, %edi
	movl	$2, %ecx
	repz cmpsb
	jne	.L279
.L278:
	rep ret
	.p2align 4,,10
	.p2align 3
.L279:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%eax, %eax
	movl	$.LC95, %esi
	movl	$5, %edi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	syslog
	movq	logfile(%rip), %rdi
	movl	$.LC96, %esi
	call	fopen
	movq	logfile(%rip), %rbp
	movq	%rax, %rbx
	movl	$384, %esi
	movq	%rbp, %rdi
	call	chmod
	testq	%rbx, %rbx
	je	.L270
	testl	%eax, %eax
	jne	.L270
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
.L270:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdx
	movl	$.LC97, %esi
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
.LCOLDE98:
	.text
.LHOTE98:
	.section	.rodata.str1.1
.LC99:
	.string	"too many connections!"
	.section	.rodata.str1.8
	.align 8
.LC100:
	.string	"the connects free list is messed up"
	.align 8
.LC101:
	.string	"out of memory allocating an httpd_conn"
	.section	.text.unlikely
.LCOLDB102:
	.text
.LHOTB102:
	.p2align 4,,15
	.type	handle_newconnect, @function
handle_newconnect:
.LFB19:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%esi, %ebp
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movl	num_connects(%rip), %eax
.L289:
	cmpl	%eax, max_connects(%rip)
	jle	.L299
	movslq	first_free_connect(%rip), %rax
	cmpl	$-1, %eax
	je	.L283
	leaq	(%rax,%rax,8), %rbx
	salq	$4, %rbx
	addq	connects(%rip), %rbx
	movl	(%rbx), %eax
	testl	%eax, %eax
	jne	.L283
	movq	8(%rbx), %rdx
	testq	%rdx, %rdx
	je	.L300
.L285:
	movq	hs(%rip), %rdi
	movl	%ebp, %esi
	call	httpd_get_conn
	testl	%eax, %eax
	je	.L288
	cmpl	$2, %eax
	jne	.L301
	movl	$1, %eax
.L282:
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
	.p2align 4,,10
	.p2align 3
.L301:
	.cfi_restore_state
	movl	4(%rbx), %eax
	movl	$1, (%rbx)
	movl	$-1, 4(%rbx)
	addl	$1, num_connects(%rip)
	movl	%eax, first_free_connect(%rip)
	movq	(%r12), %rax
	movq	$0, 96(%rbx)
	movq	$0, 104(%rbx)
	movq	%rax, 88(%rbx)
	movq	8(%rbx), %rax
	movq	$0, 136(%rbx)
	movl	$0, 56(%rbx)
	movl	704(%rax), %edi
	call	httpd_set_ndelay
	movq	8(%rbx), %rax
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movl	704(%rax), %edi
	call	fdwatch_add_fd
	addq	$1, stats_connections(%rip)
	movl	num_connects(%rip), %eax
	cmpl	stats_simultaneous(%rip), %eax
	jle	.L289
	movl	%eax, stats_simultaneous(%rip)
	jmp	.L289
	.p2align 4,,10
	.p2align 3
.L288:
	movq	%r12, %rdi
	movl	%eax, 12(%rsp)
	call	tmr_run
	movl	12(%rsp), %eax
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
	.p2align 4,,10
	.p2align 3
.L300:
	.cfi_restore_state
	movl	$720, %edi
	call	malloc
	testq	%rax, %rax
	movq	%rax, 8(%rbx)
	je	.L302
	movl	$0, (%rax)
	addl	$1, httpd_conn_count(%rip)
	movq	%rax, %rdx
	jmp	.L285
	.p2align 4,,10
	.p2align 3
.L299:
	xorl	%eax, %eax
	movl	$.LC99, %esi
	movl	$4, %edi
	call	syslog
	movq	%r12, %rdi
	call	tmr_run
	xorl	%eax, %eax
	jmp	.L282
.L283:
	movl	$2, %edi
	movl	$.LC100, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L302:
	movl	$2, %edi
	movl	$.LC101, %esi
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE19:
	.size	handle_newconnect, .-handle_newconnect
	.section	.text.unlikely
.LCOLDE102:
	.text
.LHOTE102:
	.section	.rodata.str1.8
	.align 8
.LC103:
	.string	"throttle sending count was negative - shouldn't happen!"
	.section	.text.unlikely
.LCOLDB104:
	.text
.LHOTB104:
	.p2align 4,,15
	.type	check_throttles, @function
check_throttles:
.LFB23:
	.cfi_startproc
	movl	numthrottles(%rip), %eax
	movl	$0, 56(%rdi)
	movq	$-1, 72(%rdi)
	movq	$-1, 64(%rdi)
	testl	%eax, %eax
	jle	.L326
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	jmp	.L318
	.p2align 4,,10
	.p2align 3
.L311:
	cmpq	%rdi, %rax
	cmovl	%rdi, %rax
	movq	%rax, 72(%rbx)
.L306:
	addl	$1, %r12d
	cmpl	%r12d, numthrottles(%rip)
	jle	.L312
.L327:
	addq	$48, %rbp
	cmpl	$9, 56(%rbx)
	jg	.L312
.L318:
	movq	8(%rbx), %rax
	movq	240(%rax), %rsi
	movq	throttles(%rip), %rax
	movq	(%rax,%rbp), %rdi
	call	match
	testl	%eax, %eax
	je	.L306
	movq	%rbp, %rdx
	addq	throttles(%rip), %rdx
	movq	8(%rdx), %rax
	movq	24(%rdx), %rcx
	leaq	(%rax,%rax), %rsi
	cmpq	%rsi, %rcx
	jg	.L315
	movq	16(%rdx), %rdi
	cmpq	%rdi, %rcx
	jl	.L315
	movl	40(%rdx), %ecx
	testl	%ecx, %ecx
	js	.L307
	addl	$1, %ecx
	movslq	%ecx, %r8
.L308:
	movslq	56(%rbx), %rsi
	leal	1(%rsi), %r9d
	movl	%r9d, 56(%rbx)
	movl	%r12d, 16(%rbx,%rsi,4)
	movl	%ecx, 40(%rdx)
	cqto
	idivq	%r8
	movq	64(%rbx), %rdx
	cmpq	$-1, %rdx
	je	.L324
	cmpq	%rdx, %rax
	cmovg	%rdx, %rax
.L324:
	movq	%rax, 64(%rbx)
	movq	72(%rbx), %rax
	cmpq	$-1, %rax
	jne	.L311
	addl	$1, %r12d
	cmpl	%r12d, numthrottles(%rip)
	movq	%rdi, 72(%rbx)
	jg	.L327
.L312:
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L307:
	.cfi_restore_state
	movl	$3, %edi
	xorl	%eax, %eax
	movl	$.LC103, %esi
	call	syslog
	movq	%rbp, %rdx
	addq	throttles(%rip), %rdx
	movl	$1, %r8d
	movl	$1, %ecx
	movl	$0, 40(%rdx)
	movq	8(%rdx), %rax
	movq	16(%rdx), %rdi
	jmp	.L308
	.p2align 4,,10
	.p2align 3
.L315:
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 8
	ret
.L326:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	check_throttles, .-check_throttles
	.section	.text.unlikely
.LCOLDE104:
	.text
.LHOTE104:
	.section	.text.unlikely
.LCOLDB105:
	.text
.LHOTB105:
	.p2align 4,,15
	.type	shut_down, @function
shut_down:
.LFB18:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%esi, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsp, %rdi
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	gettimeofday
	movq	%rsp, %rdi
	call	logstats
	movl	max_connects(%rip), %ecx
	testl	%ecx, %ecx
	jg	.L348
	jmp	.L335
	.p2align 4,,10
	.p2align 3
.L332:
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L333
	call	httpd_destroy_conn
	movq	%rbx, %r12
	addq	connects(%rip), %r12
	movq	8(%r12), %rdi
	call	free
	subl	$1, httpd_conn_count(%rip)
	movq	$0, 8(%r12)
.L333:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, max_connects(%rip)
	jle	.L335
.L348:
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	je	.L332
	movq	8(%rax), %rdi
	movq	%rsp, %rsi
	call	httpd_close_conn
	movq	%rbx, %rax
	addq	connects(%rip), %rax
	jmp	.L332
	.p2align 4,,10
	.p2align 3
.L335:
	movq	hs(%rip), %rbx
	testq	%rbx, %rbx
	je	.L331
	movl	72(%rbx), %edi
	movq	$0, hs(%rip)
	cmpl	$-1, %edi
	je	.L336
	call	fdwatch_del_fd
.L336:
	movl	76(%rbx), %edi
	cmpl	$-1, %edi
	je	.L337
	call	fdwatch_del_fd
.L337:
	movq	%rbx, %rdi
	call	httpd_terminate
.L331:
	call	mmc_destroy
	call	tmr_destroy
	movq	connects(%rip), %rdi
	call	free
	movq	throttles(%rip), %rdi
	testq	%rdi, %rdi
	je	.L328
	call	free
.L328:
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L356
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L356:
	.cfi_restore_state
	call	__stack_chk_fail
	.cfi_endproc
.LFE18:
	.size	shut_down, .-shut_down
	.section	.text.unlikely
.LCOLDE105:
	.text
.LHOTE105:
	.section	.rodata.str1.1
.LC106:
	.string	"exiting"
	.section	.text.unlikely
.LCOLDB107:
	.text
.LHOTB107:
	.p2align 4,,15
	.type	handle_usr1, @function
handle_usr1:
.LFB5:
	.cfi_startproc
	movl	num_connects(%rip), %edx
	testl	%edx, %edx
	je	.L360
	movl	$1, got_usr1(%rip)
	ret
.L360:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	shut_down
	movl	$5, %edi
	movl	$.LC106, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	xorl	%edi, %edi
	call	exit
	.cfi_endproc
.LFE5:
	.size	handle_usr1, .-handle_usr1
	.section	.text.unlikely
.LCOLDE107:
	.text
.LHOTE107:
	.section	.rodata.str1.1
.LC108:
	.string	"exiting due to signal %d"
	.section	.text.unlikely
.LCOLDB109:
	.text
.LHOTB109:
	.p2align 4,,15
	.type	handle_term, @function
handle_term:
.LFB2:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	call	shut_down
	movl	$5, %edi
	movl	%ebx, %edx
	movl	$.LC108, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE2:
	.size	handle_term, .-handle_term
	.section	.text.unlikely
.LCOLDE109:
	.text
.LHOTE109:
	.section	.text.unlikely
.LCOLDB110:
	.text
.LHOTB110:
	.p2align 4,,15
	.type	clear_throttles.isra.0, @function
clear_throttles.isra.0:
.LFB36:
	.cfi_startproc
	movl	56(%rdi), %eax
	testl	%eax, %eax
	jle	.L363
	subl	$1, %eax
	movq	throttles(%rip), %rcx
	leaq	16(%rdi), %rdx
	leaq	20(%rdi,%rax,4), %rsi
	.p2align 4,,10
	.p2align 3
.L365:
	movslq	(%rdx), %rax
	addq	$4, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	subl	$1, 40(%rcx,%rax)
	cmpq	%rsi, %rdx
	jne	.L365
.L363:
	rep ret
	.cfi_endproc
.LFE36:
	.size	clear_throttles.isra.0, .-clear_throttles.isra.0
	.section	.text.unlikely
.LCOLDE110:
	.text
.LHOTE110:
	.section	.text.unlikely
.LCOLDB111:
	.text
.LHOTB111:
	.p2align 4,,15
	.type	really_clear_connection, @function
really_clear_connection:
.LFB28:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdi
	movq	200(%rdi), %rax
	addq	%rax, stats_bytes(%rip)
	cmpl	$3, (%rbx)
	je	.L369
	movl	704(%rdi), %edi
	movq	%rsi, 8(%rsp)
	call	fdwatch_del_fd
	movq	8(%rbx), %rdi
	movq	8(%rsp), %rsi
.L369:
	call	httpd_close_conn
	movq	%rbx, %rdi
	call	clear_throttles.isra.0
	movq	104(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L370
	call	tmr_cancel
	movq	$0, 104(%rbx)
.L370:
	movl	first_free_connect(%rip), %eax
	movl	$0, (%rbx)
	subl	$1, num_connects(%rip)
	movl	%eax, 4(%rbx)
	subq	connects(%rip), %rbx
	movabsq	$-8198552921648689607, %rax
	sarq	$4, %rbx
	imulq	%rax, %rbx
	movl	%ebx, first_free_connect(%rip)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE28:
	.size	really_clear_connection, .-really_clear_connection
	.section	.text.unlikely
.LCOLDE111:
	.text
.LHOTE111:
	.section	.rodata.str1.8
	.align 8
.LC112:
	.string	"replacing non-null linger_timer!"
	.align 8
.LC113:
	.string	"tmr_create(linger_clear_connection) failed"
	.section	.text.unlikely
.LCOLDB114:
	.text
.LHOTB114:
	.p2align 4,,15
	.type	clear_connection, @function
clear_connection:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	96(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L376
	call	tmr_cancel
	movq	$0, 96(%rbx)
.L376:
	movl	(%rbx), %edx
	cmpl	$4, %edx
	je	.L389
	movq	8(%rbx), %rax
	movl	556(%rax), %ecx
	testl	%ecx, %ecx
	je	.L378
	cmpl	$3, %edx
	je	.L379
	movl	704(%rax), %edi
	call	fdwatch_del_fd
	movq	8(%rbx), %rax
.L379:
	movl	704(%rax), %edi
	movl	$1, %esi
	movl	$4, (%rbx)
	call	shutdown
	movq	8(%rbx), %rax
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movl	704(%rax), %edi
	call	fdwatch_add_fd
	cmpq	$0, 104(%rbx)
	je	.L380
	movl	$.LC112, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L380:
	xorl	%r8d, %r8d
	movl	$500, %ecx
	movq	%rbx, %rdx
	movl	$linger_clear_connection, %esi
	movq	%rbp, %rdi
	call	tmr_create
	testq	%rax, %rax
	movq	%rax, 104(%rbx)
	je	.L390
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L389:
	.cfi_restore_state
	movq	104(%rbx), %rdi
	call	tmr_cancel
	movq	8(%rbx), %rax
	movq	$0, 104(%rbx)
	movl	$0, 556(%rax)
.L378:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	really_clear_connection
.L390:
	.cfi_restore_state
	movl	$2, %edi
	movl	$.LC113, %esi
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE27:
	.size	clear_connection, .-clear_connection
	.section	.text.unlikely
.LCOLDE114:
	.text
.LHOTE114:
	.section	.text.unlikely
.LCOLDB115:
	.text
.LHOTB115:
	.p2align 4,,15
	.type	finish_connection, @function
finish_connection:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdi
	call	httpd_write_response
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	clear_connection
	.cfi_endproc
.LFE26:
	.size	finish_connection, .-finish_connection
	.section	.text.unlikely
.LCOLDE115:
	.text
.LHOTE115:
	.section	.text.unlikely
.LCOLDB116:
	.text
.LHOTB116:
	.p2align 4,,15
	.type	handle_read, @function
handle_read:
.LFB20:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	8(%rdi), %rbx
	movq	%rdi, %rbp
	movq	160(%rbx), %rsi
	movq	152(%rbx), %rdx
	cmpq	%rdx, %rsi
	jb	.L394
	cmpq	$5000, %rdx
	jbe	.L421
.L420:
	movq	httpd_err400form(%rip), %r8
	movq	httpd_err400title(%rip), %rdx
	movl	$.LC59, %r9d
	movq	%r9, %rcx
	movl	$400, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
.L419:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%r12, %rsi
	movq	%rbp, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	finish_connection
	.p2align 4,,10
	.p2align 3
.L421:
	.cfi_restore_state
	leaq	152(%rbx), %rsi
	leaq	144(%rbx), %rdi
	addq	$1000, %rdx
	call	httpd_realloc_str
	movq	152(%rbx), %rdx
	movq	160(%rbx), %rsi
.L394:
	subq	%rsi, %rdx
	addq	144(%rbx), %rsi
	movl	704(%rbx), %edi
	call	read
	testl	%eax, %eax
	je	.L420
	js	.L422
	cltq
	addq	%rax, 160(%rbx)
	movq	(%r12), %rax
	movq	%rbx, %rdi
	movq	%rax, 88(%rbp)
	call	httpd_got_request
	testl	%eax, %eax
	je	.L393
	cmpl	$2, %eax
	je	.L420
	movq	%rbx, %rdi
	call	httpd_parse_request
	testl	%eax, %eax
	js	.L419
	movq	%rbp, %rdi
	call	check_throttles
	testl	%eax, %eax
	je	.L423
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	httpd_start_request
	testl	%eax, %eax
	js	.L419
	movl	528(%rbx), %eax
	testl	%eax, %eax
	je	.L404
	movq	536(%rbx), %rax
	movq	%rax, 136(%rbp)
	movq	544(%rbx), %rax
	addq	$1, %rax
	movq	%rax, 128(%rbp)
.L405:
	cmpq	$0, 712(%rbx)
	je	.L424
	movq	128(%rbp), %rax
	cmpq	%rax, 136(%rbp)
	jge	.L419
	movq	(%r12), %rax
	movl	704(%rbx), %edi
	movl	$2, 0(%rbp)
	movq	$0, 112(%rbp)
	movq	%rax, 80(%rbp)
	call	fdwatch_del_fd
	movl	704(%rbx), %edi
	movq	%rbp, %rsi
	movl	$1, %edx
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	fdwatch_add_fd
	.p2align 4,,10
	.p2align 3
.L422:
	.cfi_restore_state
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L393
	cmpl	$11, %eax
	jne	.L420
.L393:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L423:
	.cfi_restore_state
	movq	208(%rbx), %r9
	movq	httpd_err503form(%rip), %r8
	movl	$.LC59, %ecx
	movq	httpd_err503title(%rip), %rdx
	movl	$503, %esi
	movq	%rbx, %rdi
	call	httpd_send_err
	jmp	.L419
	.p2align 4,,10
	.p2align 3
.L404:
	movq	192(%rbx), %rax
	movl	$0, %edx
	testq	%rax, %rax
	cmovs	%rdx, %rax
	movq	%rax, 128(%rbp)
	jmp	.L405
.L424:
	movl	56(%rbp), %eax
	testl	%eax, %eax
	jle	.L425
	subl	$1, %eax
	movq	throttles(%rip), %rcx
	movq	200(%rbx), %rsi
	leaq	16(%rbp), %rdx
	leaq	20(%rbp,%rax,4), %rdi
	.p2align 4,,10
	.p2align 3
.L410:
	movslq	(%rdx), %rax
	addq	$4, %rdx
	leaq	(%rax,%rax,2), %rax
	salq	$4, %rax
	addq	%rsi, 32(%rcx,%rax)
	cmpq	%rdx, %rdi
	jne	.L410
.L409:
	movq	%rsi, 136(%rbp)
	jmp	.L419
.L425:
	movq	200(%rbx), %rsi
	jmp	.L409
	.cfi_endproc
.LFE20:
	.size	handle_read, .-handle_read
	.section	.text.unlikely
.LCOLDE116:
	.text
.LHOTE116:
	.section	.rodata.str1.8
	.align 8
.LC117:
	.string	"%.80s connection timed out reading"
	.align 8
.LC118:
	.string	"%.80s connection timed out sending"
	.section	.text.unlikely
.LCOLDB119:
	.text
.LHOTB119:
	.p2align 4,,15
	.type	idle, @function
idle:
.LFB29:
	.cfi_startproc
	movl	max_connects(%rip), %eax
	testl	%eax, %eax
	jle	.L438
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%r12d, %r12d
	xorl	%ebp, %ebp
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	jmp	.L433
	.p2align 4,,10
	.p2align 3
.L441:
	jl	.L428
	cmpl	$3, %eax
	jg	.L428
	movq	0(%r13), %rax
	subq	88(%rbx), %rax
	cmpq	$299, %rax
	jg	.L439
.L428:
	addl	$1, %ebp
	addq	$144, %r12
	cmpl	%ebp, max_connects(%rip)
	jle	.L440
.L433:
	movq	%r12, %rbx
	addq	connects(%rip), %rbx
	movl	(%rbx), %eax
	cmpl	$1, %eax
	jne	.L441
	movq	0(%r13), %rax
	subq	88(%rbx), %rax
	cmpq	$59, %rax
	jle	.L428
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC117, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	8(%rbx), %rdi
	movq	httpd_err408form(%rip), %r8
	movl	$.LC59, %r9d
	movq	httpd_err408title(%rip), %rdx
	movq	%r9, %rcx
	movl	$408, %esi
	call	httpd_send_err
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L439:
	movq	8(%rbx), %rax
	leaq	16(%rax), %rdi
	call	httpd_ntoa
	movl	$.LC118, %esi
	movq	%rax, %rdx
	movl	$6, %edi
	xorl	%eax, %eax
	call	syslog
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L428
	.p2align 4,,10
	.p2align 3
.L440:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_restore 12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_restore 13
	.cfi_def_cfa_offset 8
.L438:
	rep ret
	.cfi_endproc
.LFE29:
	.size	idle, .-idle
	.section	.text.unlikely
.LCOLDE119:
	.text
.LHOTE119:
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"replacing non-null wakeup_timer!"
	.align 8
.LC121:
	.string	"tmr_create(wakeup_connection) failed"
	.section	.rodata.str1.1
.LC122:
	.string	"write - %m sending %.80s"
	.section	.text.unlikely
.LCOLDB123:
	.text
.LHOTB123:
	.p2align 4,,15
	.type	handle_send, @function
handle_send:
.LFB21:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	$1000000000, %edx
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbp
	movq	%rdi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movq	64(%rdi), %rcx
	movq	8(%rdi), %r12
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	cmpq	$-1, %rcx
	je	.L443
	leaq	3(%rcx), %rax
	testq	%rcx, %rcx
	movq	%rcx, %rdx
	cmovs	%rax, %rdx
	sarq	$2, %rdx
.L443:
	movq	472(%r12), %rax
	testq	%rax, %rax
	jne	.L444
	movq	136(%rbx), %rsi
	movq	128(%rbx), %rax
	movl	704(%r12), %edi
	subq	%rsi, %rax
	cmpq	%rdx, %rax
	cmovbe	%rax, %rdx
	addq	712(%r12), %rsi
	call	write
	testl	%eax, %eax
	js	.L502
.L446:
	je	.L449
	movq	0(%rbp), %rdx
	movq	%rdx, 88(%rbx)
	movq	472(%r12), %rdx
	testq	%rdx, %rdx
	je	.L500
	movslq	%eax, %rcx
	cmpq	%rcx, %rdx
	ja	.L503
	subl	%edx, %eax
	movq	$0, 472(%r12)
.L500:
	movslq	%eax, %rdi
.L456:
	movq	8(%rbx), %rdx
	movq	%rdi, %r10
	movq	%rdi, %rax
	addq	136(%rbx), %r10
	addq	200(%rdx), %rax
	movq	%r10, 136(%rbx)
	movq	%rax, 200(%rdx)
	movl	56(%rbx), %edx
	testl	%edx, %edx
	jle	.L462
	subl	$1, %edx
	movq	throttles(%rip), %r8
	leaq	16(%rbx), %rsi
	leaq	20(%rbx,%rdx,4), %r9
	.p2align 4,,10
	.p2align 3
.L461:
	movslq	(%rsi), %rcx
	addq	$4, %rsi
	leaq	(%rcx,%rcx,2), %rcx
	salq	$4, %rcx
	addq	%rdi, 32(%r8,%rcx)
	cmpq	%rsi, %r9
	jne	.L461
.L462:
	cmpq	128(%rbx), %r10
	jge	.L504
	movq	112(%rbx), %rdx
	cmpq	$100, %rdx
	jg	.L505
.L463:
	movq	64(%rbx), %rcx
	cmpq	$-1, %rcx
	je	.L442
	movq	0(%rbp), %r13
	subq	80(%rbx), %r13
	movl	$1, %edx
	cmove	%rdx, %r13
	cqto
	idivq	%r13
	cmpq	%rax, %rcx
	jge	.L442
	movl	704(%r12), %edi
	movl	$3, (%rbx)
	call	fdwatch_del_fd
	movq	8(%rbx), %rax
	movq	200(%rax), %rax
	cqto
	idivq	64(%rbx)
	movl	%eax, %r12d
	subl	%r13d, %r12d
	cmpq	$0, 96(%rbx)
	je	.L466
	movl	$.LC120, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L466:
	testl	%r12d, %r12d
	movl	$500, %ecx
	jle	.L499
	movslq	%r12d, %r12
	imulq	$1000, %r12, %rcx
	jmp	.L499
	.p2align 4,,10
	.p2align 3
.L444:
	movq	%rax, 8(%rsp)
	movq	128(%rbx), %rdi
	movq	%rsp, %rsi
	movq	136(%rbx), %rax
	movq	368(%r12), %rcx
	subq	%rax, %rdi
	movq	%rcx, (%rsp)
	movq	%rax, %rcx
	addq	712(%r12), %rcx
	cmpq	%rdx, %rdi
	cmovbe	%rdi, %rdx
	movl	704(%r12), %edi
	movq	%rdx, 24(%rsp)
	movl	$2, %edx
	movq	%rcx, 16(%rsp)
	call	writev
	testl	%eax, %eax
	jns	.L446
.L502:
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L442
	cmpl	$11, %eax
	je	.L449
	cmpl	$32, %eax
	setne	%cl
	cmpl	$22, %eax
	setne	%dl
	testb	%dl, %cl
	je	.L453
	cmpl	$104, %eax
	je	.L453
	movq	208(%r12), %rdx
	movl	$.LC122, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L453:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L449:
	addq	$100, 112(%rbx)
	movl	704(%r12), %edi
	movl	$3, (%rbx)
	call	fdwatch_del_fd
	cmpq	$0, 96(%rbx)
	je	.L452
	movl	$.LC120, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
.L452:
	movq	112(%rbx), %rcx
.L499:
	xorl	%r8d, %r8d
	movq	%rbx, %rdx
	movl	$wakeup_connection, %esi
	movq	%rbp, %rdi
	call	tmr_create
	testq	%rax, %rax
	movq	%rax, 96(%rbx)
	je	.L506
.L442:
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L507
	addq	$56, %rsp
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
.L505:
	.cfi_restore_state
	subq	$100, %rdx
	movq	%rdx, 112(%rbx)
	jmp	.L463
	.p2align 4,,10
	.p2align 3
.L503:
	movq	368(%r12), %rdi
	subl	%eax, %edx
	movslq	%edx, %r13
	movq	%r13, %rdx
	leaq	(%rdi,%rcx), %rsi
	call	memmove
	movq	%r13, 472(%r12)
	xorl	%edi, %edi
	jmp	.L456
	.p2align 4,,10
	.p2align 3
.L504:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	finish_connection
	jmp	.L442
.L507:
	call	__stack_chk_fail
.L506:
	movl	$2, %edi
	movl	$.LC121, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE21:
	.size	handle_send, .-handle_send
	.section	.text.unlikely
.LCOLDE123:
	.text
.LHOTE123:
	.section	.text.unlikely
.LCOLDB124:
	.text
.LHOTB124:
	.p2align 4,,15
	.type	linger_clear_connection, @function
linger_clear_connection:
.LFB31:
	.cfi_startproc
	movq	$0, 104(%rdi)
	jmp	really_clear_connection
	.cfi_endproc
.LFE31:
	.size	linger_clear_connection, .-linger_clear_connection
	.section	.text.unlikely
.LCOLDE124:
	.text
.LHOTE124:
	.section	.text.unlikely
.LCOLDB125:
	.text
.LHOTB125:
	.p2align 4,,15
	.type	handle_linger, @function
handle_linger:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rsi, %rbp
	movl	$4096, %edx
	subq	$4120, %rsp
	.cfi_def_cfa_offset 4144
	movq	%fs:40, %rax
	movq	%rax, 4104(%rsp)
	xorl	%eax, %eax
	movq	8(%rdi), %rax
	movq	%rsp, %rsi
	movl	704(%rax), %edi
	call	read
	testl	%eax, %eax
	js	.L517
	je	.L512
.L509:
	movq	4104(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L518
	addq	$4120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L517:
	.cfi_restore_state
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L509
	cmpl	$11, %eax
	je	.L509
.L512:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	really_clear_connection
	jmp	.L509
.L518:
	call	__stack_chk_fail
	.cfi_endproc
.LFE22:
	.size	handle_linger, .-handle_linger
	.section	.text.unlikely
.LCOLDE125:
	.text
.LHOTE125:
	.section	.rodata.str1.1
.LC126:
	.string	"%d"
.LC127:
	.string	"getaddrinfo %.80s - %.80s"
.LC128:
	.string	"%s: getaddrinfo %s - %s\n"
	.section	.rodata.str1.8
	.align 8
.LC129:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.section	.text.unlikely
.LCOLDB130:
	.text
.LHOTB130:
	.p2align 4,,15
	.type	lookup_hostname.constprop.1, @function
lookup_hostname.constprop.1:
.LFB37:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rcx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movl	$6, %ecx
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbp
	movq	%rsi, %r12
	movq	%rdx, %r14
	movl	$10, %esi
	movl	$.LC126, %edx
	subq	$96, %rsp
	.cfi_def_cfa_offset 144
	leaq	16(%rsp), %rbx
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	movq	%rbx, %rdi
	rep stosq
	movzwl	port(%rip), %ecx
	leaq	64(%rsp), %rdi
	movl	$1, 16(%rsp)
	movl	$1, 24(%rsp)
	call	snprintf
	movq	hostname(%rip), %rdi
	leaq	8(%rsp), %rcx
	leaq	64(%rsp), %rsi
	movq	%rbx, %rdx
	call	getaddrinfo
	testl	%eax, %eax
	jne	.L539
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.L521
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	jmp	.L525
	.p2align 4,,10
	.p2align 3
.L541:
	cmpl	$10, %edx
	jne	.L522
	testq	%rsi, %rsi
	cmove	%rax, %rsi
.L522:
	movq	40(%rax), %rax
	testq	%rax, %rax
	je	.L540
.L525:
	movl	4(%rax), %edx
	cmpl	$2, %edx
	jne	.L541
	testq	%rbx, %rbx
	cmove	%rax, %rbx
	movq	40(%rax), %rax
	testq	%rax, %rax
	jne	.L525
.L540:
	testq	%rsi, %rsi
	je	.L542
	movl	16(%rsi), %r8d
	cmpq	$128, %r8
	ja	.L538
	movl	$16, %ecx
	movq	%r14, %rdi
	rep stosq
	movq	%r14, %rdi
	movl	16(%rsi), %edx
	movq	24(%rsi), %rsi
	call	memmove
	movl	$1, 0(%r13)
.L527:
	testq	%rbx, %rbx
	je	.L543
	movl	16(%rbx), %r8d
	cmpq	$128, %r8
	ja	.L538
	xorl	%eax, %eax
	movl	$16, %ecx
	movq	%rbp, %rdi
	rep stosq
	movq	%rbp, %rdi
	movl	16(%rbx), %edx
	movq	24(%rbx), %rsi
	call	memmove
	movl	$1, (%r12)
.L530:
	movq	8(%rsp), %rdi
	call	freeaddrinfo
	movq	88(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L544
	addq	$96, %rsp
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
.L542:
	.cfi_restore_state
	movq	%rbx, %rax
.L521:
	movl	$0, 0(%r13)
	movq	%rax, %rbx
	jmp	.L527
.L543:
	movl	$0, (%r12)
	jmp	.L530
.L544:
	call	__stack_chk_fail
.L538:
	movq	hostname(%rip), %rdx
	movl	$2, %edi
	movl	$128, %ecx
	movl	$.LC129, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L539:
	movl	%eax, %edi
	movl	%eax, %ebx
	call	gai_strerror
	movq	hostname(%rip), %rdx
	movq	%rax, %rcx
	movl	$.LC127, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	%ebx, %edi
	call	gai_strerror
	movq	stderr(%rip), %rdi
	movq	hostname(%rip), %rcx
	movq	%rax, %r8
	movq	argv0(%rip), %rdx
	movl	$.LC128, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE37:
	.size	lookup_hostname.constprop.1, .-lookup_hostname.constprop.1
	.section	.text.unlikely
.LCOLDE130:
	.text
.LHOTE130:
	.section	.rodata.str1.1
.LC131:
	.string	"can't find any valid address"
	.section	.rodata.str1.8
	.align 8
.LC132:
	.string	"%s: can't find any valid address\n"
	.section	.rodata.str1.1
.LC133:
	.string	"unknown user - '%.80s'"
.LC134:
	.string	"%s: unknown user - '%s'\n"
.LC135:
	.string	"/dev/null"
	.section	.rodata.str1.8
	.align 8
.LC136:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.align 8
.LC137:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
	.section	.rodata.str1.1
.LC138:
	.string	"fchown logfile - %m"
.LC139:
	.string	"fchown logfile"
.LC140:
	.string	"chdir - %m"
.LC141:
	.string	"chdir"
.LC142:
	.string	"daemon - %m"
.LC143:
	.string	"w"
.LC144:
	.string	"%d\n"
	.section	.rodata.str1.8
	.align 8
.LC145:
	.string	"fdwatch initialization failure"
	.section	.rodata.str1.1
.LC146:
	.string	"chroot - %m"
	.section	.rodata.str1.8
	.align 8
.LC147:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.align 8
.LC148:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
	.section	.rodata.str1.1
.LC149:
	.string	"chroot chdir - %m"
.LC150:
	.string	"chroot chdir"
.LC151:
	.string	"data_dir chdir - %m"
.LC152:
	.string	"data_dir chdir"
.LC153:
	.string	"tmr_create(occasional) failed"
.LC154:
	.string	"tmr_create(idle) failed"
	.section	.rodata.str1.8
	.align 8
.LC155:
	.string	"tmr_create(update_throttles) failed"
	.section	.rodata.str1.1
.LC156:
	.string	"tmr_create(show_stats) failed"
.LC157:
	.string	"setgroups - %m"
.LC158:
	.string	"setgid - %m"
.LC159:
	.string	"initgroups - %m"
.LC160:
	.string	"setuid - %m"
	.section	.rodata.str1.8
	.align 8
.LC161:
	.string	"started as root without requesting chroot(), warning only"
	.align 8
.LC162:
	.string	"out of memory allocating a connecttab"
	.section	.rodata.str1.1
.LC163:
	.string	"fdwatch - %m"
	.section	.text.unlikely
.LCOLDB164:
	.section	.text.startup,"ax",@progbits
.LHOTB164:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB9:
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
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbp
	subq	$4424, %rsp
	.cfi_def_cfa_offset 4480
	movq	(%rsi), %rbx
	movl	$47, %esi
	movq	%fs:40, %rax
	movq	%rax, 4408(%rsp)
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movq	%rbx, argv0(%rip)
	call	strrchr
	leaq	1(%rax), %rdx
	testq	%rax, %rax
	movl	$9, %esi
	cmovne	%rdx, %rbx
	movl	$24, %edx
	movq	%rbx, %rdi
	call	openlog
	movq	%rbp, %rsi
	movl	%r12d, %edi
	leaq	176(%rsp), %rbp
	leaq	48(%rsp), %r12
	call	parse_args
	call	tzset
	leaq	28(%rsp), %rcx
	leaq	24(%rsp), %rsi
	movq	%rbp, %rdx
	movq	%r12, %rdi
	call	lookup_hostname.constprop.1
	movl	24(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L547
	cmpl	$0, 28(%rsp)
	je	.L683
.L547:
	movq	throttlefile(%rip), %rdi
	movl	$0, numthrottles(%rip)
	movl	$0, maxthrottles(%rip)
	movq	$0, throttles(%rip)
	testq	%rdi, %rdi
	je	.L548
	call	read_throttlefile
.L548:
	call	getuid
	testl	%eax, %eax
	movl	$32767, %r15d
	movl	$32767, 4(%rsp)
	je	.L684
.L549:
	movq	logfile(%rip), %rbx
	testq	%rbx, %rbx
	je	.L620
	movl	$.LC135, %edi
	movl	$10, %ecx
	movq	%rbx, %rsi
	repz cmpsb
	je	.L685
	movl	$.LC94, %esi
	movq	%rbx, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L553
	movq	stdout(%rip), %r14
.L551:
	movq	dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L557
	call	chdir
	testl	%eax, %eax
	js	.L686
.L557:
	leaq	304(%rsp), %rbx
	movl	$4096, %esi
	movq	%rbx, %rdi
	call	getcwd
	movq	%rbx, %rdx
.L558:
	movl	(%rdx), %ecx
	addq	$4, %rdx
	leal	-16843009(%rcx), %eax
	notl	%ecx
	andl	%ecx, %eax
	andl	$-2139062144, %eax
	je	.L558
	movl	%eax, %ecx
	shrl	$16, %ecx
	testl	$32896, %eax
	cmove	%ecx, %eax
	leaq	2(%rdx), %rcx
	cmove	%rcx, %rdx
	addb	%al, %al
	sbbq	$3, %rdx
	subq	%rbx, %rdx
	cmpb	$47, 303(%rsp,%rdx)
	je	.L560
	movw	$47, (%rbx,%rdx)
.L560:
	movl	debug(%rip), %edx
	testl	%edx, %edx
	jne	.L561
	movq	stdin(%rip), %rdi
	call	fclose
	movq	stdout(%rip), %rdi
	cmpq	%rdi, %r14
	je	.L562
	call	fclose
.L562:
	movq	stderr(%rip), %rdi
	call	fclose
	movl	$1, %esi
	movl	$1, %edi
	call	daemon
	testl	%eax, %eax
	movl	$.LC142, %esi
	js	.L681
.L563:
	movq	pidfile(%rip), %rdi
	testq	%rdi, %rdi
	je	.L564
	movl	$.LC143, %esi
	call	fopen
	testq	%rax, %rax
	movq	%rax, %r13
	je	.L687
	call	getpid
	movq	%r13, %rdi
	movl	%eax, %edx
	movl	$.LC144, %esi
	xorl	%eax, %eax
	call	fprintf
	movq	%r13, %rdi
	call	fclose
.L564:
	call	fdwatch_get_nfiles
	testl	%eax, %eax
	movl	%eax, max_connects(%rip)
	js	.L688
	subl	$10, %eax
	cmpl	$0, do_chroot(%rip)
	movl	%eax, max_connects(%rip)
	jne	.L689
.L567:
	movq	data_dir(%rip), %rdi
	testq	%rdi, %rdi
	je	.L571
	call	chdir
	testl	%eax, %eax
	js	.L690
.L571:
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
	cmpl	$0, 28(%rsp)
	movl	no_empty_referers(%rip), %eax
	movq	%rbp, %rdx
	movzwl	port(%rip), %ecx
	movl	cgi_limit(%rip), %r9d
	movq	cgi_pattern(%rip), %r8
	movq	hostname(%rip), %rdi
	cmove	%rsi, %rdx
	cmpl	$0, 24(%rsp)
	pushq	%rax
	.cfi_def_cfa_offset 4488
	movl	do_global_passwd(%rip), %eax
	pushq	local_pattern(%rip)
	.cfi_def_cfa_offset 4496
	pushq	url_pattern(%rip)
	.cfi_def_cfa_offset 4504
	pushq	%rax
	.cfi_def_cfa_offset 4512
	movl	do_vhost(%rip), %eax
	cmovne	%r12, %rsi
	pushq	%rax
	.cfi_def_cfa_offset 4520
	movl	no_symlink_check(%rip), %eax
	pushq	%rax
	.cfi_def_cfa_offset 4528
	movl	no_log(%rip), %eax
	pushq	%r14
	.cfi_def_cfa_offset 4536
	pushq	%rax
	.cfi_def_cfa_offset 4544
	movl	max_age(%rip), %eax
	pushq	%rbx
	.cfi_def_cfa_offset 4552
	pushq	%rax
	.cfi_def_cfa_offset 4560
	pushq	p3p(%rip)
	.cfi_def_cfa_offset 4568
	pushq	charset(%rip)
	.cfi_def_cfa_offset 4576
	call	httpd_initialize
	addq	$96, %rsp
	.cfi_def_cfa_offset 4480
	testq	%rax, %rax
	movq	%rax, hs(%rip)
	je	.L682
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$120000, %ecx
	movl	$occasional, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L691
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$5000, %ecx
	movl	$idle, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L692
	cmpl	$0, numthrottles(%rip)
	jle	.L577
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$2000, %ecx
	movl	$update_throttles, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L693
.L577:
	movq	JunkClientData(%rip), %rdx
	xorl	%edi, %edi
	movl	$1, %r8d
	movl	$3600000, %ecx
	movl	$show_stats, %esi
	call	tmr_create
	testq	%rax, %rax
	je	.L694
	xorl	%edi, %edi
	call	time
	movq	$0, stats_connections(%rip)
	movq	%rax, stats_time(%rip)
	movq	%rax, start_time(%rip)
	movq	$0, stats_bytes(%rip)
	movl	$0, stats_simultaneous(%rip)
	call	getuid
	testl	%eax, %eax
	jne	.L580
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	setgroups
	testl	%eax, %eax
	movl	$.LC157, %esi
	js	.L681
	movl	%r15d, %edi
	call	setgid
	testl	%eax, %eax
	movl	$.LC158, %esi
	js	.L681
	movq	user(%rip), %rdi
	movl	%r15d, %esi
	call	initgroups
	testl	%eax, %eax
	js	.L695
.L583:
	movl	4(%rsp), %edi
	call	setuid
	testl	%eax, %eax
	movl	$.LC160, %esi
	js	.L681
	cmpl	$0, do_chroot(%rip)
	je	.L696
.L580:
	movslq	max_connects(%rip), %rbp
	movq	%rbp, %rbx
	imulq	$144, %rbp, %rbp
	movq	%rbp, %rdi
	call	malloc
	testq	%rax, %rax
	movq	%rax, connects(%rip)
	je	.L586
	xorl	%ecx, %ecx
	testl	%ebx, %ebx
	movq	%rax, %rdx
	jle	.L591
	.p2align 4,,10
	.p2align 3
.L660:
	addl	$1, %ecx
	movl	$0, (%rdx)
	movq	$0, 8(%rdx)
	movl	%ecx, 4(%rdx)
	addq	$144, %rdx
	cmpl	%ecx, %ebx
	jne	.L660
.L591:
	movl	$-1, -140(%rax,%rbp)
	movq	hs(%rip), %rax
	movl	$0, first_free_connect(%rip)
	movl	$0, num_connects(%rip)
	movl	$0, httpd_conn_count(%rip)
	testq	%rax, %rax
	je	.L592
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L593
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
	movq	hs(%rip), %rax
.L593:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L592
	xorl	%edx, %edx
	xorl	%esi, %esi
	call	fdwatch_add_fd
.L592:
	leaq	32(%rsp), %rdi
	call	tmr_prepare_timeval
	.p2align 4,,10
	.p2align 3
.L594:
	movl	terminate(%rip), %eax
	testl	%eax, %eax
	je	.L617
	cmpl	$0, num_connects(%rip)
	jle	.L697
.L617:
	movl	got_hup(%rip), %eax
	testl	%eax, %eax
	jne	.L698
.L595:
	leaq	32(%rsp), %rdi
	call	tmr_mstimeout
	movq	%rax, %rdi
	call	fdwatch
	testl	%eax, %eax
	movl	%eax, %ebx
	js	.L699
	leaq	32(%rsp), %rdi
	call	tmr_prepare_timeval
	testl	%ebx, %ebx
	je	.L700
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L608
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L603
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L604
.L607:
	movq	hs(%rip), %rax
	testq	%rax, %rax
	je	.L608
.L603:
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L608
	call	fdwatch_check_fd
	testl	%eax, %eax
	jne	.L701
	.p2align 4,,10
	.p2align 3
.L608:
	call	fdwatch_get_next_client_data
	cmpq	$-1, %rax
	movq	%rax, %rbx
	je	.L702
	testq	%rbx, %rbx
	je	.L608
	movq	8(%rbx), %rax
	movl	704(%rax), %edi
	call	fdwatch_check_fd
	testl	%eax, %eax
	je	.L703
	movl	(%rbx), %eax
	cmpl	$2, %eax
	je	.L611
	cmpl	$4, %eax
	je	.L612
	cmpl	$1, %eax
	jne	.L608
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_read
	jmp	.L608
.L685:
	movl	$1, no_log(%rip)
	xorl	%r14d, %r14d
	jmp	.L551
.L561:
	call	setsid
	jmp	.L563
.L688:
	movl	$.LC145, %esi
.L681:
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
.L682:
	movl	$1, %edi
	call	exit
.L684:
	movq	user(%rip), %rdi
	call	getpwnam
	testq	%rax, %rax
	je	.L704
	movl	16(%rax), %ecx
	movl	20(%rax), %r15d
	movl	%ecx, 4(%rsp)
	jmp	.L549
.L683:
	movl	$.LC131, %esi
	movl	$3, %edi
	xorl	%eax, %eax
	call	syslog
	movq	stderr(%rip), %rdi
	movq	argv0(%rip), %rdx
	movl	$.LC132, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L703:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	clear_connection
	jmp	.L608
.L699:
	call	__errno_location
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L594
	cmpl	$11, %eax
	je	.L594
	movl	$3, %edi
	movl	$.LC163, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L612:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_linger
	jmp	.L608
.L611:
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	handle_send
	jmp	.L608
.L702:
	leaq	32(%rsp), %rdi
	call	tmr_run
	movl	got_usr1(%rip), %eax
	testl	%eax, %eax
	je	.L594
	cmpl	$0, terminate(%rip)
	jne	.L594
	movq	hs(%rip), %rax
	movl	$1, terminate(%rip)
	testq	%rax, %rax
	je	.L594
	movl	72(%rax), %edi
	cmpl	$-1, %edi
	je	.L615
	call	fdwatch_del_fd
	movq	hs(%rip), %rax
.L615:
	movl	76(%rax), %edi
	cmpl	$-1, %edi
	je	.L616
	call	fdwatch_del_fd
.L616:
	movq	hs(%rip), %rdi
	call	httpd_unlisten
	jmp	.L594
.L698:
	call	re_open_logfile
	movl	$0, got_hup(%rip)
	jmp	.L595
.L700:
	leaq	32(%rsp), %rdi
	call	tmr_run
	jmp	.L594
.L689:
	movq	%rbx, %rdi
	call	chroot
	testl	%eax, %eax
	js	.L705
	movq	logfile(%rip), %r13
	testq	%r13, %r13
	je	.L569
	movl	$.LC94, %esi
	movq	%r13, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L569
	xorl	%eax, %eax
	orq	$-1, %rcx
	movq	%rbx, %rdi
	repnz scasb
	movq	%rbx, %rsi
	movq	%r13, %rdi
	notq	%rcx
	leaq	-1(%rcx), %rdx
	movq	%rcx, 8(%rsp)
	call	strncmp
	testl	%eax, %eax
	jne	.L570
	movq	8(%rsp), %rcx
	movq	%r13, %rdi
	leaq	-2(%r13,%rcx), %rsi
	call	strcpy
.L569:
	movq	%rbx, %rdi
	movw	$47, 304(%rsp)
	call	chdir
	testl	%eax, %eax
	jns	.L567
	movl	$.LC149, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC150, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L620:
	xorl	%r14d, %r14d
	jmp	.L551
.L553:
	movq	%rbx, %rdi
	movl	$.LC96, %esi
	call	fopen
	movq	logfile(%rip), %rbx
	movq	%rax, %r14
	movl	$384, %esi
	movq	%rbx, %rdi
	call	chmod
	testq	%r14, %r14
	je	.L623
	testl	%eax, %eax
	jne	.L623
	cmpb	$47, (%rbx)
	je	.L556
	movl	$.LC136, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$.LC137, %esi
	xorl	%eax, %eax
	call	fprintf
.L556:
	movq	%r14, %rdi
	call	fileno
	movl	$1, %edx
	movl	%eax, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	call	fcntl
	call	getuid
	testl	%eax, %eax
	jne	.L551
	movq	%r14, %rdi
	call	fileno
	movl	4(%rsp), %esi
	movl	%r15d, %edx
	movl	%eax, %edi
	call	fchown
	testl	%eax, %eax
	jns	.L551
	movl	$.LC138, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC139, %edi
	call	perror
	jmp	.L551
.L686:
	movl	$.LC140, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC141, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L687:
	movq	pidfile(%rip), %rdx
	movl	$2, %edi
	movl	$.LC85, %esi
	xorl	%eax, %eax
	call	syslog
	movl	$1, %edi
	call	exit
.L691:
	movl	$2, %edi
	movl	$.LC153, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L690:
	movl	$.LC151, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC152, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L570:
	xorl	%eax, %eax
	movl	$.LC147, %esi
	movl	$4, %edi
	call	syslog
	movq	argv0(%rip), %rdx
	movq	stderr(%rip), %rdi
	movl	$.LC148, %esi
	xorl	%eax, %eax
	call	fprintf
	jmp	.L569
.L696:
	movl	$.LC161, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L580
.L693:
	movl	$2, %edi
	movl	$.LC155, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L604:
	movq	hs(%rip), %rax
	leaq	32(%rsp), %rdi
	movl	76(%rax), %esi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L594
	jmp	.L607
.L701:
	movq	hs(%rip), %rax
	leaq	32(%rsp), %rdi
	movl	72(%rax), %esi
	call	handle_newconnect
	testl	%eax, %eax
	jne	.L594
	jmp	.L608
.L694:
	movl	$2, %edi
	movl	$.LC156, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L623:
	movq	%rbx, %rdx
	movl	$.LC85, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movq	logfile(%rip), %rdi
	call	perror
	movl	$1, %edi
	call	exit
.L697:
	call	shut_down
	movl	$5, %edi
	movl	$.LC106, %esi
	xorl	%eax, %eax
	call	syslog
	call	closelog
	xorl	%edi, %edi
	call	exit
.L692:
	movl	$2, %edi
	movl	$.LC154, %esi
	call	syslog
	movl	$1, %edi
	call	exit
.L705:
	movl	$.LC146, %esi
	movl	$2, %edi
	xorl	%eax, %eax
	call	syslog
	movl	$.LC31, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L704:
	movq	user(%rip), %rdx
	movl	$.LC133, %esi
	movl	$2, %edi
	call	syslog
	movq	stderr(%rip), %rdi
	movq	user(%rip), %rcx
	movl	$.LC134, %esi
	movq	argv0(%rip), %rdx
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L586:
	movl	$.LC162, %esi
	jmp	.L681
.L695:
	movl	$.LC159, %esi
	movl	$4, %edi
	xorl	%eax, %eax
	call	syslog
	jmp	.L583
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE164:
	.section	.text.startup
.LHOTE164:
	.local	watchdog_flag
	.comm	watchdog_flag,4,4
	.local	got_usr1
	.comm	got_usr1,4,4
	.local	got_hup
	.comm	got_hup,4,4
	.comm	stats_simultaneous,4,4
	.comm	stats_bytes,8,8
	.comm	stats_connections,8,8
	.comm	stats_time,8,8
	.comm	start_time,8,8
	.globl	terminate
	.bss
	.align 4
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	4
	.local	hs
	.comm	hs,8,8
	.local	httpd_conn_count
	.comm	httpd_conn_count,4,4
	.local	first_free_connect
	.comm	first_free_connect,4,4
	.local	max_connects
	.comm	max_connects,4,4
	.local	num_connects
	.comm	num_connects,4,4
	.local	connects
	.comm	connects,8,8
	.local	maxthrottles
	.comm	maxthrottles,4,4
	.local	numthrottles
	.comm	numthrottles,4,4
	.local	throttles
	.comm	throttles,8,8
	.local	max_age
	.comm	max_age,4,4
	.local	p3p
	.comm	p3p,8,8
	.local	charset
	.comm	charset,8,8
	.local	user
	.comm	user,8,8
	.local	pidfile
	.comm	pidfile,8,8
	.local	hostname
	.comm	hostname,8,8
	.local	throttlefile
	.comm	throttlefile,8,8
	.local	logfile
	.comm	logfile,8,8
	.local	local_pattern
	.comm	local_pattern,8,8
	.local	no_empty_referers
	.comm	no_empty_referers,4,4
	.local	url_pattern
	.comm	url_pattern,8,8
	.local	cgi_limit
	.comm	cgi_limit,4,4
	.local	cgi_pattern
	.comm	cgi_pattern,8,8
	.local	do_global_passwd
	.comm	do_global_passwd,4,4
	.local	do_vhost
	.comm	do_vhost,4,4
	.local	no_symlink_check
	.comm	no_symlink_check,4,4
	.local	no_log
	.comm	no_log,4,4
	.local	do_chroot
	.comm	do_chroot,4,4
	.local	data_dir
	.comm	data_dir,8,8
	.local	dir
	.comm	dir,8,8
	.local	port
	.comm	port,2,2
	.local	debug
	.comm	debug,4,4
	.local	argv0
	.comm	argv0,8,8
	.ident	"GCC: (GNU) 5.2.0"
	.section	.note.GNU-stack,"",@progbits
