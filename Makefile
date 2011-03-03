CC=arm-apple-darwin9-gcc
LD=$(CC)
LDFLAGS=-lobjc -dynamiclib -bind_at_load -framework CoreFoundation -framework Foundation
CFLAGS=-fconstant-cfstrings -std=gnu99 -Wall -O2

SBSDIR=/var/mobile/Library/SBSettings
CMDDIR=$(SBSDIR)/Commands
TOGDIR=$(SBSDIR)/Toggles/Tor

all:    Toggle.dylib

Toggle.dylib: main.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.m
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
	   
%.o: %.c
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f *.o Toggle.dylib
	rm -rf sbsettingstor

bundle:	Toggle.dylib
	@mkdir -p sbsettingstor
	@make install DESTDIR=./sbsettingstor

install: Toggle.dylib
	@install -d -m 0755 $(DESTDIR)/$(SBSDIR)
	@install -d -m 0755 $(DESTDIR)/$(CMDDIR)
	@install -d -m 0755 $(DESTDIR)/$(TOGDIR)
	@install -m 0755 com.sbsettingstor.checkenabled	$(DESTDIR)/$(CMDDIR)
	@install -m 0755 com.sbsettingstor.disable $(DESTDIR)/$(CMDDIR)
	@install -m 0755 com.sbsettingstor.enable $(DESTDIR)/$(CMDDIR)
	@cp -r Themes $(DESTDIR)/$(SBSDIR)
	@install -m 0755 Toggle.dylib $(DESTDIR)/$(TOGDIR)
