$(OUTDIR)/unittest.o: src/unit_test.c
	@mkdir -p $(dir $@)
	@echo "    CC      "$@
	@$(CROSS_COMPILE)gcc $(CFLAGS) -MMD -MF $@.d -o $@ -c $(INCLUDES) $<


check: $(OUTDIR)/unittest.o
	$(MAKE) $(OUTDIR)/$(TARGET).bin DEBUG_FLAGS=-DDEBUG
	$(QEMU_STM32) -M stm32-p103 \
		-gdb tcp::3333 -S \
		-serial stdio \
		-kernel $(OUTDIR)/$(TARGET).bin -monitor null >/dev/null &
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-strlen.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-strlen.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-strcpy.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-strcpy.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-strcmp.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-strcmp.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-strncmp.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-strncmp.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-cmdtok.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-cmdtok.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-itoa.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-itoa.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-find_events.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-find_events.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-find_envvar.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-find_envvar.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-fill_arg.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-fill_arg.in
	@echo
	$(CROSS_COMPILE)gdb -batch -ex 'set logging file test_result/test-export_envvar.txt' -ex 'file $(OUTDIR)/$(TARGET).elf' -x unit_test/test-export_envvar.in
	@echo
	@pkill -9 $(notdir $(QEMU_STM32))
