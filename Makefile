PARSERGEN = _build/bin/parsergen
MELANGE = _build/bin/melange

.PHONY: parsergen melange check clean all

all: melange
parsergen: $(PARSERGEN)
melange: $(MELANGE)

$(PARSERGEN):
	dylan-compiler -build parsergen

melange-parser/c-parse.dylan: melange-parser/c-parse.input $(PARSERGEN)
	$(PARSERGEN) melange-parser/c-parse.input melange-parser/c-parse.dylan

melange/int-parse.dylan: melange/int-parse.input $(PARSERGEN)
	$(PARSERGEN) melange/int-parse.input melange/int-parse.dylan

$(MELANGE): melange-parser/c-parse.dylan melange/int-parse.dylan
	dylan-compiler -build melange

check: $(MELANGE)
	@echo "All is well."

clean:
	rm -rf _build
	rm -f melange/c-parse.dylan
	rm -f melange/int-parse.dylan

