
DROPINS=/usr/share/eclipse/dropins/

all:	stage-create-tree.stat
	@echo "nothing to build"

stage-mirror-orig.stat:
	@./sigasi-mirror-orig
	@touch $@

stage-filter-repo.stat:		stage-mirror-orig.stat
	@./sigasi-filter-repo
	@touch $@

stage-create-tree.stat:	stage-filter-repo.stat
	@./sigasi-create-tree
	@touch $@

install:	stage-create-tree.stat
	@mkdir -p $(DESTDIR)/$(DROPINS)
	@cp -R -p repo/tree/dropins/* $(DESTDIR)/$(DROPINS)

clean:
	@rm -f *.stat repo
