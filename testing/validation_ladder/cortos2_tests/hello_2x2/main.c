#include <stdlib.h>
#include <stdint.h>
#include <cortos.h>
#include<stdio.h>
#include "ajit_access_routines.h"

void setup_uart()
{
        __ajit_serial_set_uart_reset__(1);
        __ajit_serial_set_baudrate__(115200, CLK_FREQUENCY);
        __ajit_serial_set_uart_reset__(0);
        __ajit_write_serial_control_register__ ( TX_ENABLE );

        *((int*) 0xffff3204) = 0x68686868;
}


void main_00 () 
{
	cortos_printf("Hello: 00: 1\n");
	cortos_printf("Hello: 00: 2\n");
	cortos_printf("Hello: 00: 3\n");

}

void main_01 () 
{
	cortos_printf("Hello: 01: 1\n");
	cortos_printf("Hello: 01: 2\n");
	cortos_printf("Hello: 01: 3\n");
}

void main_10 () 
{
	cortos_printf("Hello: 10: 1\n");
	cortos_printf("Hello: 10: 2\n");
	cortos_printf("Hello: 10: 3\n");
}

void main_11 () 
{
	cortos_printf("Hello: 11: 1\n");
	cortos_printf("Hello: 11: 2\n");
	cortos_printf("Hello: 11: 3\n");
}

