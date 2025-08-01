/*
 * Copyright (c) 2021 NXP
 *
 * SPDX-License-Identifier: Apache-2.0
 */

OUTPUT_ARCH(xtensa)

#include <soc/memory.h>
#include <xtensa/config/core-isa.h>

#include <zephyr/linker/linker-defs.h>
#include <zephyr/linker/linker-tool.h>
#include <zephyr/linker/sections.h>

#define RAMABLE_REGION sdram0 :sdram0_phdr
#define ROMABLE_REGION sdram0 :sdram0_phdr

MEMORY
{
  vector_reset_text :
    org = XCHAL_RESET_VECTOR0_PADDR_IRAM,
    len = MEM_RESET_TEXT_SIZE
  vector_reset_lit :
    org = XCHAL_RESET_VECTOR0_PADDR_IRAM + MEM_RESET_TEXT_SIZE,
    len = MEM_RESET_LIT_SIZE
  vector_base_text :
    org = XCHAL_VECBASE_RESET_PADDR_IRAM,
    len = MEM_VECBASE_LIT_SIZE
  vector_int2_lit :
    org = XCHAL_INTLEVEL2_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_int2_text :
    org = XCHAL_INTLEVEL2_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_int3_lit :
    org = XCHAL_INTLEVEL3_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_int3_text :
    org = XCHAL_INTLEVEL3_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_int4_lit :
    org = XCHAL_INTLEVEL4_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_int4_text :
    org = XCHAL_INTLEVEL4_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_int5_lit :
    org = XCHAL_INTLEVEL5_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_int5_text :
    org = XCHAL_INTLEVEL5_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_kernel_lit :
    org = XCHAL_KERNEL_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_kernel_text :
    org = XCHAL_KERNEL_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_user_lit :
    org = XCHAL_USER_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_user_text :
    org = XCHAL_USER_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  vector_double_lit :
    org = XCHAL_DOUBLEEXC_VECTOR_PADDR_IRAM - MEM_VECT_LIT_SIZE,
    len = MEM_VECT_LIT_SIZE
  vector_double_text :
    org = XCHAL_DOUBLEEXC_VECTOR_PADDR_IRAM,
    len = MEM_VECT_TEXT_SIZE
  iram_text_start :
    org = XCHAL_DOUBLEEXC_VECTOR_PADDR_IRAM + MEM_VECT_TEXT_SIZE,
    len = (IRAM_BASE + IRAM_SIZE) - (XCHAL_DOUBLEEXC_VECTOR_PADDR + MEM_VECT_TEXT_SIZE)
  sdram0 :
    org = SDRAM0_BASE,
    len = SDRAM0_SIZE
#ifdef CONFIG_GEN_ISR_TABLES
  IDT_LIST :
    org = IDT_BASE,
    len = IDT_SIZE
#endif
}

PHDRS
{
  vector_reset_text_phdr PT_LOAD;
  vector_reset_lit_phdr PT_LOAD;
  vector_base_text_phdr PT_LOAD;
  vector_base_lit_phdr PT_LOAD;
  vector_int2_text_phdr PT_LOAD;
  vector_int2_lit_phdr PT_LOAD;
  vector_int3_text_phdr PT_LOAD;
  vector_int3_lit_phdr PT_LOAD;
  vector_int4_text_phdr PT_LOAD;
  vector_int4_lit_phdr PT_LOAD;
  vector_int5_text_phdr PT_LOAD;
  vector_int5_lit_phdr PT_LOAD;
  vector_kernel_text_phdr PT_LOAD;
  vector_kernel_lit_phdr PT_LOAD;
  vector_user_text_phdr PT_LOAD;
  vector_user_lit_phdr PT_LOAD;
  vector_double_text_phdr PT_LOAD;
  vector_double_lit_phdr PT_LOAD;
  iram_text_start_phdr PT_LOAD;
  sdram0_phdr PT_LOAD;
}

PROVIDE(_memmap_reset_vector = XCHAL_RESET_VECTOR0_PADDR_IRAM);
PROVIDE(_memmap_vecbase_reset = XCHAL_VECBASE_RESET_PADDR_IRAM);

ENTRY(CONFIG_KERNEL_ENTRY)

/* Various memory-map dependent cache attribute settings: */
_memmap_cacheattr_wb_base = 0x00000012;
_memmap_cacheattr_wt_base = 0x00000012;
_memmap_cacheattr_bp_base = 0x00000022;
_memmap_cacheattr_unused_mask = 0xFFFFFF00;
_memmap_cacheattr_wb_trapnull = 0x22222212;
_memmap_cacheattr_wba_trapnull = 0x22222212;
_memmap_cacheattr_wbna_trapnull = 0x22222212;
_memmap_cacheattr_wt_trapnull = 0x22222212;
_memmap_cacheattr_bp_trapnull = 0x22222222;
_memmap_cacheattr_wb_strict = 0xFFFFFF12;
_memmap_cacheattr_wt_strict = 0xFFFFFF12;
_memmap_cacheattr_bp_strict = 0xFFFFFF22;
_memmap_cacheattr_wb_allvalid = 0x22222212;
_memmap_cacheattr_wt_allvalid = 0x22222212;
_memmap_cacheattr_bp_allvalid = 0x22222222;
_memmap_region_map = 0x00000003;
PROVIDE(_memmap_cacheattr_reset = _memmap_cacheattr_wb_trapnull);

SECTIONS
{

#include <zephyr/linker/rel-sections.ld>

#ifdef CONFIG_LLEXT
#include <zephyr/linker/llext-sections.ld>
#endif
  .ResetVector.text : ALIGN(4)
  {
    _ResetVector_text_start = ABSOLUTE(.);
    KEEP (*(.ResetVector.text))
    _ResetVector_text_end = ABSOLUTE(.);
  } >vector_reset_text :vector_reset_text_phdr

  .ResetVector.literal : ALIGN(4)
  {
    _ResetVector_literal_start = ABSOLUTE(.);
    *(.ResetVector.literal)
    _ResetVector_literal_end = ABSOLUTE(.);
  } >vector_reset_lit :vector_reset_lit_phdr

  .WindowVectors.text : ALIGN(4)
  {
    _WindowVectors_text_start = ABSOLUTE(.);
    KEEP (*(.WindowVectors.text))
    _WindowVectors_text_end = ABSOLUTE(.);
  } >vector_base_text :vector_base_text_phdr

  .Level2InterruptVector.literal : ALIGN(4)
  {
    _Level2InterruptVector_literal_start = ABSOLUTE(.);
    *(.Level2InterruptVector.literal)
    _Level2InterruptVector_literal_end = ABSOLUTE(.);
  } >vector_int2_lit :vector_int2_lit_phdr

  .Level2InterruptVector.text : ALIGN(4)
  {
    _Level2InterruptVector_text_start = ABSOLUTE(.);
    KEEP (*(.Level2InterruptVector.text))
    _Level2InterruptVector_text_end = ABSOLUTE(.);
  } >vector_int2_text :vector_int2_text_phdr

  .Level3InterruptVector.literal : ALIGN(4)
  {
    _Level3InterruptVector_literal_start = ABSOLUTE(.);
    *(.Level3InterruptVector.literal)
    _Level3InterruptVector_literal_end = ABSOLUTE(.);
  } >vector_int3_lit :vector_int3_lit_phdr

  .Level3InterruptVector.text : ALIGN(4)
  {
    _Level3InterruptVector_text_start = ABSOLUTE(.);
    KEEP (*(.Level3InterruptVector.text))
    _Level3InterruptVector_text_end = ABSOLUTE(.);
  } >vector_int3_text :vector_int3_text_phdr

  .DebugExceptionVector.literal : ALIGN(4)
  {
    _DebugExceptionVector_literal_start = ABSOLUTE(.);
    *(.DebugExceptionVector.literal)
    _DebugExceptionVector_literal_end = ABSOLUTE(.);
  } >vector_int4_lit :vector_int4_lit_phdr

  .DebugExceptionVector.text : ALIGN(4)
  {
    _DebugExceptionVector_text_start = ABSOLUTE(.);
    KEEP (*(.DebugExceptionVector.text))
    _DebugExceptionVector_text_end = ABSOLUTE(.);
  } >vector_int4_text :vector_int4_text_phdr

  .NMIExceptionVector.literal : ALIGN(4)
  {
    _NMIExceptionVector_literal_start = ABSOLUTE(.);
    *(.NMIExceptionVector.literal)
    _NMIExceptionVector_literal_end = ABSOLUTE(.);
  } >vector_int5_lit :vector_int5_lit_phdr

  .NMIExceptionVector.text : ALIGN(4)
  {
    _NMIExceptionVector_text_start = ABSOLUTE(.);
    KEEP (*(.NMIExceptionVector.text))
    _NMIExceptionVector_text_end = ABSOLUTE(.);
  } >vector_int5_text :vector_int5_text_phdr

  .KernelExceptionVector.literal : ALIGN(4)
  {
    _KernelExceptionVector_literal_start = ABSOLUTE(.);
    *(.KernelExceptionVector.literal)
    _KernelExceptionVector_literal_end = ABSOLUTE(.);
  } >vector_kernel_lit :vector_kernel_lit_phdr

  .KernelExceptionVector.text : ALIGN(4)
  {
    _KernelExceptionVector_text_start = ABSOLUTE(.);
    KEEP (*(.KernelExceptionVector.text))
    _KernelExceptionVector_text_end = ABSOLUTE(.);
  } >vector_kernel_text :vector_kernel_text_phdr

  .UserExceptionVector.literal : ALIGN(4)
  {
    _UserExceptionVector_literal_start = ABSOLUTE(.);
    *(.UserExceptionVector.literal)
    _UserExceptionVector_literal_end = ABSOLUTE(.);
  } >vector_user_lit :vector_user_lit_phdr

  .UserExceptionVector.text : ALIGN(4)
  {
    _UserExceptionVector_text_start = ABSOLUTE(.);
    KEEP (*(.UserExceptionVector.text))
    _UserExceptionVector_text_end = ABSOLUTE(.);
  } >vector_user_text :vector_user_text_phdr

  .DoubleExceptionVector.literal : ALIGN(4)
  {
    _DoubleExceptionVector_literal_start = ABSOLUTE(.);
    *(.DoubleExceptionVector.literal)
    _DoubleExceptionVector_literal_end = ABSOLUTE(.);
  } >vector_double_lit :vector_double_lit_phdr

  .DoubleExceptionVector.text : ALIGN(4)
  {
    _DoubleExceptionVector_text_start = ABSOLUTE(.);
    KEEP (*(.DoubleExceptionVector.text))
    _DoubleExceptionVector_text_end = ABSOLUTE(.);
  } >vector_double_text :vector_double_text_phdr

  .iram.text : ALIGN(4)
  {
    _stext = .;
    _iram_text_start = ABSOLUTE(.);
    *(.iram0.literal .iram.literal .iram.text.literal .iram0.text .iram.text)
    _iram_text_end = ABSOLUTE(.);
  } >iram_text_start :iram_text_start_phdr

  .rodata : ALIGN(4)
  {
    __rodata_region_start = ABSOLUTE(.);
    *(.rodata)
    *(.rodata.*)
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    __XT_EXCEPTION_TABLE__ = ABSOLUTE(.);
    KEEP (*(.xt_except_table))
    KEEP (*(.gcc_except_table .gcc_except_table.*))
    *(.gnu.linkonce.e.*)
    *(.gnu.version_r)
    KEEP (*(.eh_frame))
    KEEP (*crtbegin.o(.ctors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
    KEEP (*crtbegin.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
    __XT_EXCEPTION_DESCS__ = ABSOLUTE(.);
    *(.xt_except_desc)
    *(.gnu.linkonce.h.*)
    __XT_EXCEPTION_DESCS_END__ = ABSOLUTE(.);
    *(.xt_except_desc_end)
    *(.dynamic)
    *(.gnu.version_d)
    . = ALIGN(4);
    _bss_table_start = ABSOLUTE(.);
    LONG(_bss_start)
    LONG(_bss_end)
    _bss_table_end = ABSOLUTE(.);
    __rodata_region_end = ABSOLUTE(.);
  } >sdram0 :sdram0_phdr

  .module_init : ALIGN(4)
  {
   _module_init_start = ABSOLUTE(.);
    *(*.initcall)
    _module_init_end = ABSOLUTE(.);
  } >sdram0 :sdram0_phdr

  .text : ALIGN(4)
  {
    _stext = .;
    __text_region_start = ABSOLUTE(.);
    KEEP (*(.ResetVector.text))
    *(.ResetVector.literal)
    *(.init.literal)
    *(.entry.text)
    /* to support backtrace */
    KEEP (*(.iram1.literal .iram1))
    KEEP(*(.init))
    *(.literal .text .literal.* .text.* .stub .gnu.warning .gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)
    *(.fini.literal)
    KEEP(*(.fini))
    *(.gnu.version)
    __text_region_end = ABSOLUTE(.);
    _etext = .;
  } >iram_text_start :iram_text_start_phdr

#include <zephyr/linker/common-rom.ld>
/* Located in generated directory. This file is populated by calling
 * zephyr_linker_sources(ROM_SECTIONS ...). Useful for grouping iterable RO structs.
 */
#include <snippets-rom-sections.ld>

  .fw_ready : ALIGN(4)
  {
    KEEP(*(".fw_ready"));
    KEEP (*(.fw_ready_metadata))
  } >sdram0 :sdram0_phdr

  .data : ALIGN(4)
  {
    __data_start = ABSOLUTE(.);
    *(.data)
    *(.data.*)
    *(.gnu.linkonce.d.*)
    KEEP(*(.gnu.linkonce.d.*personality*))
    *(.data1)
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
    *(.sdata2)
    *(.sdata2.*)
    *(.gnu.linkonce.s2.*)
    KEEP(*(.jcr))
    _trace_ctx_start = ABSOLUTE(.);
    *(.trace_ctx)
    _trace_ctx_end = ABSOLUTE(.);
    . = ALIGN(4);
    *(.gna_model)
    __data_end = ABSOLUTE(.);
    . = ALIGN(4096);
  } >sdram0 :sdram0_phdr

  .lit4 : ALIGN(4)
  {
    _lit4_start = ABSOLUTE(.);
    *(*.lit4)
    *(.lit4.*)
    *(.gnu.linkonce.lit4.*)
    _lit4_end = ABSOLUTE(.);
  } >sdram0 :sdram0_phdr

#include <zephyr/linker/common-ram.ld>

  .bss (NOLOAD) : ALIGN(8)
  {
    . = ALIGN (8);
    _bss_start = ABSOLUTE(.);
    *(.dynsbss)
    *(.sbss)
    *(.sbss.*)
    *(.gnu.linkonce.sb.*)
    *(.scommon)
    *(.sbss2)
    *(.sbss2.*)
    *(.gnu.linkonce.sb2.*)
    *(.dynbss)
    *(.bss)
    *(.bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN (8);
    _bss_end = ABSOLUTE(.);
  } >sdram0 :sdram0_phdr

  .noinit (NOLOAD) : ALIGN(4)
  {
    *(.noinit)
    *(.noinit.*)
  } >sdram0 :sdram0_phdr

  .heap_mem (NOLOAD) : ALIGN(8)
  {
    . = ALIGN (8);
    _heap_mem_start = ABSOLUTE(.);
    *(*.heap_mem)
    _heap_mem_end = ABSOLUTE(.);

  } >sdram0 :sdram0_phdr

  /* stack */
  _end = ALIGN (8);

  /DISCARD/ : { *(.note.GNU-stack) }
  _heap_sentry = SDRAM0_BASE + SDRAM0_SIZE;
  __stack = SDRAM0_BASE + SDRAM0_SIZE + CONFIG_RT595_ADSP_STACK_SIZE;
  .comment  0 :  { *(.comment) }
  .debug  0 :  { *(.debug) }
  .line  0 :  { *(.line) }
  .debug_srcinfo  0 :  { *(.debug_srcinfo) }
  .debug_sfnames  0 :  { *(.debug_sfnames) }
  .debug_aranges  0 :  { *(.debug_aranges) }
  .debug_pubnames  0 :  { *(.debug_pubnames) }
  .debug_info  0 :  { *(.debug_info) }
  .debug_abbrev  0 :  { *(.debug_abbrev) }
  .debug_line  0 :  { *(.debug_line) }
  .debug_frame  0 :  { *(.debug_frame) }
  .debug_str  0 :  { *(.debug_str) }
  .debug_loc  0 :  { *(.debug_loc) }
  .debug_macinfo  0 :  { *(.debug_macinfo) }
  .debug_weaknames  0 :  { *(.debug_weaknames) }
  .debug_funcnames  0 :  { *(.debug_funcnames) }
  .debug_typenames  0 :  { *(.debug_typenames) }
  .debug_varnames  0 :  { *(.debug_varnames) }
  .debug_ranges  0 :  { *(.debug_ranges) }
  .debug_addr  0 :  { *(.debug_addr) }
  .debug_line_str  0 :  { *(.debug_line_str) }
  .debug_loclists  0 :  { *(.debug_loclists) }
  .debug_macro  0 :  { *(.debug_macro) }
  .debug_names  0 :  { *(.debug_names) }
  .debug_rnglists  0 :  { *(.debug_rnglists) }
  .debug_str_offsets  0 :  { *(.debug_str_offsets) }
  .debug_sup  0 :  { *(.debug_sup) }
  .xtensa.info  0 :  { *(.xtensa.info) }
  .xt.insn 0 :
  {
    KEEP (*(.xt.insn))
    KEEP (*(.gnu.linkonce.x.*))
  }
  .xt.prop 0 :
  {
    KEEP (*(.xt.prop))
    KEEP (*(.xt.prop.*))
    KEEP (*(.gnu.linkonce.prop.*))
  }
  .xt.lit 0 :
  {
    KEEP (*(.xt.lit))
    KEEP (*(.xt.lit.*))
    KEEP (*(.gnu.linkonce.p.*))
  }
  .xt.profile_range 0 :
  {
    KEEP (*(.xt.profile_range))
    KEEP (*(.gnu.linkonce.profile_range.*))
  }
  .xt.profile_ranges 0 :
  {
    KEEP (*(.xt.profile_ranges))
    KEEP (*(.gnu.linkonce.xt.profile_ranges.*))
  }
  .xt.profile_files 0 :
  {
    KEEP (*(.xt.profile_files))
    KEEP (*(.gnu.linkonce.xt.profile_files.*))
  }
#ifdef CONFIG_GEN_ISR_TABLES
#include <zephyr/linker/intlist.ld>
#endif
}
