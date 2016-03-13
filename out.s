
warmup:     file format elf32-i386


Disassembly of section .text:

080480d8 <.text>:
 80480d8:	83 ec 10             	sub    esp,0x10
 80480db:	c7 04 24 0a 00 00 00 	mov    DWORD PTR [esp],0xa
 80480e2:	e8 26 00 00 00       	call   0x804810d
 80480e7:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
 80480ee:	c7 44 24 04 bc 91 04 	mov    DWORD PTR [esp+0x4],0x80491bc
 80480f5:	08 
 80480f6:	c7 44 24 08 16 00 00 	mov    DWORD PTR [esp+0x8],0x16
 80480fd:	00 
 80480fe:	e8 32 00 00 00       	call   0x8048135
 8048103:	e8 52 00 00 00       	call   0x804815a
 8048108:	e8 40 00 00 00       	call   0x804814d

 804810d:	b8 1b 00 00 00       	mov    eax,0x1b
 8048112:	8b 5c 24 04          	mov    ebx,DWORD PTR [esp+0x4]
 8048116:	cd 80                	int    0x80
 8048118:	85 c0                	test   eax,eax
 804811a:	78 31                	js     0x804814d
 804811c:	c3                   	ret    

 804811d:	b8 03 00 00 00       	mov    eax,0x3
 8048122:	8b 5c 24 04          	mov    ebx,DWORD PTR [esp+0x4]
 8048126:	8b 4c 24 08          	mov    ecx,DWORD PTR [esp+0x8]
 804812a:	8b 54 24 0c          	mov    edx,DWORD PTR [esp+0xc]
 804812e:	cd 80                	int    0x80
 8048130:	85 c0                	test   eax,eax
 8048132:	78 19                	js     0x804814d
 8048134:	c3                   	ret    

 8048135:	b8 04 00 00 00       	mov    eax,0x4
 804813a:	8b 5c 24 04          	mov    ebx,DWORD PTR [esp+0x4]
 804813e:	8b 4c 24 08          	mov    ecx,DWORD PTR [esp+0x8]
 8048142:	8b 54 24 0c          	mov    edx,DWORD PTR [esp+0xc]
 8048146:	cd 80                	int    0x80
 8048148:	85 c0                	test   eax,eax
 804814a:	78 01                	js     0x804814d
 804814c:	c3                   	ret    

 804814d:	b8 01 00 00 00       	mov    eax,0x1
 8048152:	bb 00 00 00 00       	mov    ebx,0x0
 8048157:	cd 80                	int    0x80
 8048159:	f4                   	hlt    
 
 804815a:	83 ec 30             	sub    esp,0x30
 804815d:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
 8048164:	8d 44 24 10          	lea    eax,[esp+0x10]
 8048168:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
 804816c:	c7 44 24 08 34 00 00 	mov    DWORD PTR [esp+0x8],0x34
 8048173:	00 
 8048174:	e8 a4 ff ff ff       	call   0x804811d
 8048179:	c7 04 24 01 00 00 00 	mov    DWORD PTR [esp],0x1
 8048180:	c7 44 24 04 d3 91 04 	mov    DWORD PTR [esp+0x4],0x80491d3
 8048187:	08 
 8048188:	c7 44 24 08 0b 00 00 	mov    DWORD PTR [esp+0x8],0xb
 804818f:	00 
 8048190:	e8 a0 ff ff ff       	call   0x8048135
 8048195:	b8 af be ad de       	mov    eax,0xdeadbeaf
 804819a:	b9 af be ad de       	mov    ecx,0xdeadbeaf
 804819f:	ba af be ad de       	mov    edx,0xdeadbeaf
 80481a4:	bb af be ad de       	mov    ebx,0xdeadbeaf
 80481a9:	be af be ad de       	mov    esi,0xdeadbeaf
 80481ae:	bf af be ad de       	mov    edi,0xdeadbeaf
 80481b3:	bd af be ad de       	mov    ebp,0xdeadbeaf
 80481b8:	83 c4 30             	add    esp,0x30
 80481bb:	c3                   	ret    
