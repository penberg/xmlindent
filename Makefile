all: xmlindent

PREFIX=/usr/local
DESTDIR=
BIN_INSTALL_DIR=$(PREFIX)/bin
MAN_INSTALL_DIR=$(PREFIX)/share/man/man1
CFLAGS=-Wall -g
LDFLAGS=-Wl,-z,defs -Wl,-as-needed -Wl,--no-undefined

xmlindent: buffer.o error.o indent.o main.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ -lfl

.c.o:
	$(CC) $(CFLAGS) $^ -c -o $@

indent.c: lex.yy.c
	touch indent.c

lex.yy.c: xmlindent.yy
	flex xmlindent.yy

install: xmlindent
	mkdir -p $(DESTDIR)$(BIN_INSTALL_DIR)
	mkdir -p $(DESTDIR)$(MAN_INSTALL_DIR)
	install -m555 xmlindent $(DESTDIR)$(BIN_INSTALL_DIR)/xmlindent
	install -m444 xmlindent.1 $(DESTDIR)$(MAN_INSTALL_DIR)/xmlindent.1

uninstall:
	rm -f $(DESTDIR)$(BIN_INSTALL_DIR)/xmlindent
	rm -f $(DESTDIR)$(MAN_INSTALL_DIR)/xmlindent.1

clean:
	rm -f xmlindent *.o core lex.yy.c

.PHONY: all clean install uninstall
