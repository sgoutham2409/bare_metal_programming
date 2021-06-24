ENTRY(Reset_Handler)

MEMORY
{
    FLASH(rx):ORIGIN =0x08000000, LENGTH =1024K
    SRAM(rwx):ORIGIN =0x20000000, LENGTH =128K
}

SECTIONS
{
    .text :
    {
        *(.isr_vector)
        *(.text)
        *(.rodata)
        . = ALIGN(4);
        __end_of_text = .;
    }> FLASH /* >vma AT >lma; since vma(virtual memory address) is same as lma, we can omit the latter half */

    .data :
    {
        __start_of_data = .; /* Location counter, ., always tracks vma */
        *(.data)
        . = ALIGN(4);
        __end_of_data = .;
    }> SRAM AT> FLASH

    .bss :
    {
        __start_of_bss = .;
        *(.bss)
        *(COMMON)
        . = ALIGN(4);
        __end_of_bss = .;
    }> SRAM
}