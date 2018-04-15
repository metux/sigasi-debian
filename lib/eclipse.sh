
eclipse_mirror_repo() {
    local repo="$1"
    local target="$2"

    pr_info "Mirroring P2 repo: $repo"

    rm -Rf $target
    mkdir -p $target

    # fetch metadata
    pr_info "fetching metadata"
    $ECLIPSE_CMD -nosplash -verbose \
        -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication \
        -source "$repo" \
        -destination "$target"

    # fetch artifacts
    pr_info "fetching artifacts"
    $ECLIPSE_CMD -nosplash -verbose \
        -application org.eclipse.equinox.p2.artifact.repository.mirrorApplication \
        -source "$repo" \
        -destination "$target"
}

eclipse_copy_plugin() {
    local p="$1"
    local src="$2"
    local dst="$3"

    mkdir -p $dst/plugins
    case $1 in
        (*:*) name=${1%:*} version=${1##*:}
            pr_info "copying plugin \"$name\" version=\"$version\""
            cp $src/plugins/${name}_${version}*.jar $dst/plugins/ || die "copying plugin $1"
        ;;
        (*)
            pr_info "copying plugin \"$p\" (all versions)"
            cp $src/plugins/${p}_*.jar $dst/plugins/ || die "copying plugin $1"
        ;;
    esac
}

eclipse_copy_feature() {
    local p="$1"
    local src="$2"
    local dst="$3"

    mkdir -p $dst/features
    case $1 in
        (*:*) name=${1%:*} version=${1##*:}
            pr_info "copying feature \"$name\" version=\"$version\""
            cp $src/features/${name}.feature_${version}*.jar $dst/features/ || die "copying feature $1"
        ;;
        (*)
            pr_info "copying feature \"$p\" (all versions)"
            cp $src/features/${name}.feature_*.jar $dst/features/ || die "copying feature $1"
        ;;
    esac
}

eclipse_create_repo() {
    local src="$1"
    local dst="$2"
    local cfg="$3"

    pr_info "creating local repo ..."
    $ECLIPSE_CMD -nosplash -verbose \
        -application org.eclipse.equinox.p2.publisher.FeaturesAndBundlesPublisher \
        -metadataRepository "$dst" \
        -artifactRepository "$dst" \
        -source $src \
        -configs $cfg \
        -compress \
        -publishArtifacts
}

eclipse_create_tree() {
    local src="$1"
    local dst="$2"
    local pkg="$3"
    local pkg_tree="$dst/dropins/$pkg"

    rm -Rf $dst
    mkdir -p $pkg_tree/eclipse/features $pkg_tree/eclipse/plugins

    cp -Rf $src/plugins/* $pkg_tree/eclipse/plugins
    cp -Rf $src/features/* $pkg_tree/eclipse/features
}

eclipse_install_tree() {
    local src="$1"
    local prefix="$ECLIPSE_PREFIX"
    pr_info "eclipse prefix: $ECLIPSE_PREFIX"

    sudo cp -R $src/* "$ECLIPSE_PREFIX"
}
