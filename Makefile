all: xmlindent

PREFIX=/usr/local
BIN_INSTALL_DIR=$(PREFIX)/bin
MAN_INSTALL_DIR=$(PREFIX)/share/man/man1

xmlindent: buffer.o error.o indent.o main.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ -lfl

.c.o:
	$(CC) $(CFLAGS) $^ -c -o $@

indent.c: lex.yy.c
	touch indent.c

lex.yy.c: xmlindent.yy
	flex xmlindent.yy

install: xmlindent
	mkdir -p $(BIN_INSTALL_DIR)
	mkdir -p $(MAN_INSTALL_DIR)
	install -m555 xmlindent $(BIN_INSTALL_DIR)/xmlindent
	install -m444 xmlindent.1 $(MAN_INSTALL_DIR)/xmlindent.1

uninstall:
	rm -f $(BIN_INSTALL_DIR)/xmlindent
	rm -f $(MAN_INSTALL_DIR)/xmlindent.1

clean:
	rm -f xmlindent *.o core lex.yy.c

.PHONY: all clean
