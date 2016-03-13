file warmup

set disassembly-flavor intel

#tcatch syscall alarm
#Catch the syscall.
#commands 1
#jump 0x804811c
# set ($rax) = 0
# make the ptrace return 0 so we are under the #radar
#end

#break *0x8048112
#commands 1
#jump *0x08048118
#c
#end

# Entry point
# b *0x80480d8

# ret main
b *0x80481bb
commands
record
c
end

run < input
