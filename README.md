# 0ops CTF 2016 : Exploit 100

**Category:** exploit |
**Name:** warmup

**Description:**

> Notice: This service is protected by a sandbox, you can only read the flag at /home/warmup/flag

> 202.120.7.207 52608
___

## Write-up

This writup is offered by the [HexpressoTeam](http://hexpresso.github.io/),
The exploit has been done by Beuc and  [@chaign\_c](https://twitter.com/chaign_c)

A lot of fun here since it was one of the most crazy exploit we ever made.
 TLDR: [exploit.py](/final_exploit.py)

### Step 0: war of information
    $ ls -lh warmup
    -rwxrwxrwx 1 tutu users 724 12.03.2016 20:44 warmup
    $ file warmup
    warmup: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=c1791030f336fcc9cda1da8dc3a3f8a70d930a11, stripped
    $ checksec --file warmup
    RELRO           STACK CANARY      NX            PIE             RPATH      RUNPATH      FILE
    No RELRO        No canary found   NX enabled    No PIE          No RPATH   No RUNPATH   warmup


So it's a statically linked 32 bits elf with nx protection. From the size (724) we can presume that it's compiled from an asm code.

### Step 1: Find the white rabbit

After playing a little we can crash the program using a large buffer in input.

### Step 2: $eip
Now we want to overwrite the current instruction pointer $eip because it's sexy and this way we can control the flow of execution.

With the help of our best pattern generator we know that the offset of saved $eip is 32.

By starting a dmesg -w in a second terminal, we are notified of all segv and know exactly if $eip is overwritted or not. 

### Step 3: Analysis:

It's time to read some asm:

    $ objdump -d -M warmup > out.s
    $ ROPGadget --binary warmup --depth 60

##### Constraint:

Because NX protection is actived, we can't think of shellcode at this step, the obvious solution is to ROP.

We can't use exec because it's a sandbox only open,read,write syscall are reachable.

The vulnerability allow us to control a rop context stack size of only 5*4 bytes size aka 5 address. We better have a short payload or try to expand our power.

### Step 4: I want it bigger!

We only have 5*4 bytes to do our exploit, it's not enough to perform a open->read->write. So what can we do about it ?
Make it bigger by reading again and stack pivot was the first idea but it sound like with our gadgets it's not possible. So we thought about code reuse, in fact a ret near the entry point make the program restart again and we can exploit it again ! at each loop we can send one gadget and his parameters.

### Step 5: read/write:

Since the program contains some function who load their parameter from stack and use it to execute some syscall we can use them like in ret2libc. So using those we can read and write as we want, but which buffer can be used ?

    $ readlef -l warmup
    ...
        Program Headers:
    Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
    LOAD           0x000000 0x08048000 0x08048000 0x001bc 0x001bc R E 0x1000
    LOAD           0x0001bc 0x080491bc 0x080491bc 0x00023 0x00023 RW  0x1000
    NOTE           0x0000b4 0x080480b4 0x080480b4 0x00024 0x00024 R   0x4
    GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10
    ...
At 0x080491bc there is a writable page not affected by ASLR.

### Step 6: open

There is no routine where the open syscall is used, we have to craft it using our imagination. The part where arguments are set can be reused from other syscalls, but for open [syscall](http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html) eax should be 5. We didn't found any gadget to set eax, so we use the return tricks (function and syscall set the eax register to their return value). read syscall can be use but it take too much place, and here come the genius Beuc with is idea of using [alarm](http://linux.die.net/man/2/alarm) syscall, this syscall set eax to the number of seconds remaing to the current alarm. Note that all the exploit relies on the alarm syscall because it take less place that a read syscall, and it coincide exactly, one more byte and the exploit couldn't be done this way.
We show you this little ascii art so you can get how gadgets fit and rely on each other.

                               | call alarm at the       | rop gadget to set ebx,ecx,edx | loop again
        GADGET                 | time (5 sec) so eax is  | (params of open)              | and clean stack
                               | set to (10-5) => 5      | and syscall open              | 
    ------------------------------------------------------------------------------------------------------------------
    rop_alarm                  |  call alarm, saved eip  |                               |
    ------------------------------------------------------------------------------------------------------------------
    rop_set_ebx_ecx_edx_int80  | alarm params, saved ebp | gadget, saved eip             |
    ------------------------------------------------------------------------------------------------------------------
    rop_loop_neat_entry_point  |                         | saved ebp                     | code reuse, saved eip
    ------------------------------------------------------------------------------------------------------------------
    rw_memory                  |                         | filename                      | saved ebp
     -----------------------------------------------------------------------------------------------------------------
    0x0                        |                         | O_RDONLY                      |
    ------------------------------------------------------------------------------------------------------------------

### Step 7: Devil is in the details

There is a lot more going on I let you checkout the exploit [exploit](/final_exploit.py)
If you have questions don't hesitate to contact me on irc or twitter. :D

There are a full bunch of file on the repository so you can see that we passed more time than we want to admit and you can investigate all steps we did before having a working exploit on remote.

----
[@chaign\_c](https://twitter.com/chaign_c) from [HexpressoTeam](http://hexpresso.github.io/)
