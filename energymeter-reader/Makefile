INSTALLDIR=/usr/local
BINDIR=$(INSTALLDIR)/bin
RCDIR=$(INSTALLDIR)/etc/rc.d

all: elmeter

elmeter: elmeter.c
	$(CC) -O2 $> -o $@

install:
	cp elmeter $(BINDIR)
	cp powerwatcher $(BINDIR)
	cp powerwatcher-etc-rc $(RCDIR)/powerwatcher

	echo "Add the following to your rc.conf is equivalend:"
	cat rc.conf-additions


