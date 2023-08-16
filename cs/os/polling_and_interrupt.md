# Polling and Interrupt

## Polling:
- Polling is <b>not a hardware mechanism, its a protocol</b>.
- CPU <b>steadily checks</b> whether the device needs attention. 
- Process unit <b>keeps asking the I/O device whether or not it desires CPU processing</b>. 


## Interrupt:
- Interrupt is a <b>hardware mechanism</b> in which, the device notices the CPU that it requires its attention. 
- Interrupt can <b>take place at any time</b>. 
- When CPU gets an interrupt signal, <b>CPU stops the current process</b> and respond to the interrupt 
by <b>passing the control to interrupt handler</b>. (ISR: Interrupt Service Routine)


## comparison
| INTERRUPT | POLLING |
| :--- | :--- |
| In interrupt, the device notices the CPU that it requires its attention. | Whereas, in polling, CPU steadily checks whether the device needs attention.|
| An interrupt is not a protocol, its a hardware mechanism. | Whereas it isn’t a hardware mechanism, its a protocol.|
| In interrupt, the device is serviced by interrupt handler. | While in polling, the device is serviced by CPU.|
| Interrupt can take place at any time. | Whereas CPU steadily ballots the device at regular or proper interval.|
| In interrupt, interrupt request line is used as indication for indicating that device requires servicing. | While in polling, Command ready bit is used as indication for indicating that device requires servicing.|
| In interrupts, processor is simply disturbed once any device interrupts it. | On the opposite hand, in polling, processor waste countless processor cycles by repeatedly checking the command-ready little bit of each device.|


## Reference
- https://www.geeksforgeeks.org/difference-between-interrupt-and-polling/
