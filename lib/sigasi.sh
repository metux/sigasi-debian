
SIGASI_REPO_URL=http://download.sigasi.com/updates/studio
SIGASI_REPO_ORIG=repo/orig/$eclipse_version
SIGASI_REPO_TMP=repo/tmp/$eclipse_version
SIGASI_REPO_TARGET=repo/target/$eclipse_version
SIGASI_CONFIG=gtk.linux.x86
SIGASI_PKG=sigasi
SIGASI_TREE=repo/tree

sigasi_mirror_orig() {
    pr_info "Mirroring sigasi update site ..."
    eclipse_mirror_repo "$SIGASI_REPO_URL" "$SIGASI_REPO_ORIG"
}

sigasi_filter_repo() {
    pr_info "copying to temporary repo ..."

    FEATURES="
        com.sigasi.hdt.toolchains:3.7.1
        com.sigasi.hdt.verilog:3.7.1
        com.sigasi.hdt.vhdl:3.7.1
        com.sigasi.hdt.statemachines:3.7.1
        com.sigasi.hdt.docgen:3.7.1
        com.sigasi.hdt.shared:3.7.1
        com.sigasi.markers:1.0.4
        com.mousefeed:2.0.3
        com.sigasi.hdt.blockdiagram:3.7.1
    "

    PLUGINS="
        com.sigasi.talkback:3.7.1
        com.sigasi.runner:3.7.1
        com.sigasi.hdt.readonlyfilesystem:3.7.1
        com.sigasi.hdt.vhdl.ide:3.7.1
        com.sigasi.hdt.vhdl.documentation:3.7.1
        com.sigasi.markers.ui:1.0.4
        com.sigasi.hdt.docgen.resources:3.7.1
        com.sigasi.hdt.docgen:3.7.1
        com.sigasi.hdt.statemachines:3.7.1
        com.sigasi.hdt.toolchains:3.7.1
        com.sigasi.runner.listener:3.7.1
        com.sigasi.hdt.epl:3.7.1
        com.sigasi.hdt.epl.ui:3.7.1
        com.sigasi.hdt.variables:3.7.1
        com.sigasi.hdt.shared:3.7.1
        com.sigasi.hdt.shared.model:3.7.1
        com.sigasi.hdt.vhdl.model:3.7.1
        com.sigasi.hdt.annotations.runtime:3.7.1
        com.sigasi.hdt.shared.ui:3.7.1
        com.sigasi.hdt.flexlm:3.7.1
        com.sigasi.hdt.verilog.model:3.7.1
        com.sigasi.hdt.graphics.model:3.7.1
        com.sigasi.hdt.toolchains.labs:3.7.1
        com.sigasi.hdt.toolchains.xilinx:3.7.1
        com.sigasi.hdt.toolchains.cadence:3.7.1
        com.sigasi.hdt.toolchains.onespin:3.7.1
        com.sigasi.hdt.toolchains.ghdl:3.7.1
        com.sigasi.hdt.toolchains.vunit:3.7.1
        com.sigasi.hdt.vhdl:3.7.1
        com.sigasi.hdt.vhdl.ui:3.7.1
        com.sigasi.hdt.blockdiagram.view:3.7.1
        com.sigasi.hdt.graphics.ui:3.7.1
        com.sigasi.hdt.graphics:3.7.1
        com.sigasi.hdt.blockdiagram.model:3.7.1
        com.sigasi.hdt.blockdiagram:3.7.1
        com.sigasi.hdt.verilog:3.7.1
        com.sigasi.hdt.verilog.ide:3.7.1
        com.sigasi.hdt.verilog.ui:3.7.1
        com.sigasi.hdt.graphics.ide:3.7.1
        com.google.gson:2.7.0
        com.google.inject:3.0.0
        com.mousefeed:2.0.3
        de.cau.cs.kieler.formats:0.42.1
        de.cau.cs.kieler.formats.gml:0.42.2
        de.cau.cs.kieler.formats.kgraph:0.42.2
        de.cau.cs.kieler.klighd.piccolo.freehep:0.42.2
        de.cau.cs.kieler.core:0.12.0
        de.cau.cs.kieler.core.kgraph:0.6.1
        de.cau.cs.kieler.core.krendering:0.5.0
        de.cau.cs.kieler.core.krendering.extensions:0.5.0
        de.cau.cs.kieler.graphs.klighd:0.42.1
        de.cau.cs.kieler.klighd.krendering:0.42.1
        de.cau.cs.kieler.klighd.ui.view:0.42.1
        de.cau.cs.kieler.klighd.kgraph:0.42.1
        de.cau.cs.kieler.klighd:0.42.5
        de.cau.cs.kieler.klighd:0.5.0
        de.cau.cs.kieler.klighd.krendering.extensions:0.42.1
        de.cau.cs.kieler.klighd.piccolo:0.42.4
        de.cau.cs.kieler.klighd.piccolo:0.5.0
        de.cau.cs.kieler.klighd.ui:0.42.1
        de.cau.cs.kieler.klighd.ui:0.4.0
        de.cau.cs.kieler.kiml:0.15.0
        de.cau.cs.kieler.klay.layered:0.8.0
        de.cau.cs.kieler.kiml.service:0.7.0
        de.cau.cs.kieler.kiml.ui:0.11.0
        edu.umd.cs.piccolo:1.6.0
        org.eclipse.elk.alg.layered:0.2.1
        org.eclipse.elk.core:0.2.1
        org.eclipse.elk.core.service:0.2.1
        org.eclipse.elk.graph:0.2.1
        org.eclipse.emf:2.6.0
        org.eclipse.emf.common:2.13.0
        org.eclipse.emf.ecore.xcore.lib
        org.eclipse.emf.transaction:1.9.0
        org.eclipse.emf.validation:1.8.0
        org.eclipse.lsp4j:0.3.0
        org.eclipse.lsp4j.jsonrpc:0.3.0
        org.eclipse.xtend.lib:2.13.0
        org.eclipse.xtend.lib.macro:2.13.0
        org.eclipse.xtext:2.13.0
        org.eclipse.xtext.builder:2.13.0
        org.eclipse.xtext.ide:2.13.0
        org.eclipse.xtext.logging:1.2.15
        org.eclipse.xtext.smap:2.13.0
        org.eclipse.xtext.ui:2.13.0
        org.eclipse.xtext.ui.codetemplates:2.13.0
        org.eclipse.xtext.ui.codetemplates.ide:2.13.0
        org.eclipse.xtext.ui.codetemplates.ui:2.13.0
        org.eclipse.xtext.ui.shared:2.13.0
        org.eclipse.xtext.util:2.13.0
        org.eclipse.xtext.xbase.lib:2.13.0
        org.rythmengine.rythm-engine:1.1.1
    "

    CLEAN_PLUGINS_FILES="
        com.google.gson_2.7.0.v20161205-1708.jar
        com.google.inject_3.0.0.v201312141243.jar
        org.eclipse.emf.ecore.xcore.lib_1.1.100.v20150806-0546.jar
        org.eclipse.emf.ecore.xcore.lib_1.1.100.v20160209-0349.jar
        org.eclipse.emf.transaction_1.9.0.201506010221.jar
        org.eclipse.emf.validation_1.8.0.201505312255.jar
        org.eclipse.xtext.logging_1.2.15.v201512010527.jar
        org.eclipse.xtext.logging_1.2.15.v201603040440.jar
        org.eclipse.xtext.logging_1.2.15.v201605250459.jar
        org.eclipse.xtext.logging_1.2.15.v20170130-0818.jar
        org.eclipse.xtext.logging_1.2.15.v20170519-0809.jar
        org.rythmengine.rythm-engine_1.1.1.2016*.jar
        org.rythmengine.rythm-engine_1.1.1.201703291150.jar
        org.rythmengine.rythm-engine_1.1.1.201704031909.jar
        org.rythmengine.rythm-engine_1.1.1.201706131037.jar
        org.rythmengine.rythm-engine_1.1.1.201708072248.jar
        org.rythmengine.rythm-engine_1.1.1.201709221244.jar
        org.rythmengine.rythm-engine_1.1.1.201710041101.jar
        org.rythmengine.rythm-engine_1.1.1.201710190911.jar
        org.rythmengine.rythm-engine_1.1.1.201712121907.jar
    "

    rm -Rf $SIGASI_REPO_TMP

    for f in $FEATURES ; do
        eclipse_copy_feature "$f" "$SIGASI_REPO_ORIG" "$SIGASI_REPO_TMP"
    done

    for p in $PLUGINS ; do
        eclipse_copy_plugin "$p" "$SIGASI_REPO_ORIG" "$SIGASI_REPO_TMP"
    done

    for f in $CLEAN_PLUGINS_FILES ; do
        rm $SIGASI_REPO_TMP/plugins/$f
    done

    local target_uri="file://$(pwd)/$SIGASI_REPO_TARGET"
    eclipse_create_repo $SIGASI_REPO_TMP "$target_uri" "$SIGASI_CONFIG"
}

sigasi_create_tree() {
    pr_info "creating sigasi installation tree"
    eclipse_create_tree $SIGASI_REPO_TARGET "$SIGASI_TREE" "$SIGASI_PKG"
}

sigasi_install_tree() {
    pr_info "installing sigasi tree"
    eclipse_install_tree "$SIGASI_TREE"
}
