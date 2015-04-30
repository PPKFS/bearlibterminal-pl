		

blt:
	swipl-ld -O -Ilib/include -L. -lBearLibTerminal -shared -cc-options,-std=c++11 -o lib/blt.so src/blt.cpp

blt2:
	g++ -c -O -fpic -std=c++11 -fno-strict-aliasing -pthread -fPIC -D_FORTIFY_SOURCE=2 -D_REENTRANT -D__SWI_PROLOG__ -I/usr/lib/swipl-6.6.6/include -Ilib/include -o blt.o src/blt.cpp
	g++ -o lib/blt.so -shared -Wl,-rpath=$$ORIGIN -rdynamic -Wl,-O1,--sort-common,--as-needed,-z,relro -pthread -Wl,-rpath=/usr/lib/swipl-6.6.6/lib/x86_64-linux blt.o -L/usr/lib/swipl-6.6.6/lib/x86_64-linux -Llib -lBearLibTerminal -lswipl
	rm -r blt.o
clean:
	rm -rf lib/blt.so
