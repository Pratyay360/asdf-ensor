#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/Pratyay360/ensor"
TOOL_NAME="ensor"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_releases() {
	curl "${curl_opts[@]}" "https://api.github.com/repos/Pratyay360/ensor/releases?per_page=100" |
		grep -o '"tag_name": *"[^"]*"' |
		cut -d'"' -f4 |
		sed 's/^v//'
}

list_all_versions() {
	# Releases like "main" or tags such as "v0.4.2" that point at the same
	# release as "0.4.2" are not installable versions.
	list_github_releases |
		grep -E '^[0-9]+\.[0-9]+\.[0-9]+(-[0-9]+)?$' |
		sort -u
}

get_os() {
	case "$(uname -s)" in
	Linux) echo "Linux" ;;
	Darwin) echo "Darwin" ;;
	FreeBSD) echo "Freebsd" ;;
	OpenBSD) echo "Openbsd" ;;
	*) fail "unsupported operating system: $(uname -s)" ;;
	esac
}

get_arch() {
	case "$(uname -m)" in
	x86_64 | amd64) echo "x86_64" ;;
	aarch64 | arm64) echo "arm64" ;;
	i386 | i686) echo "i386" ;;
	*) fail "unsupported architecture: $(uname -m)" ;;
	esac
}

release_url() {
	local version="$1"
	printf "%s/releases/download/%s/%s_%s_%s.tar.gz" \
		"$GH_REPO" "$version" "$TOOL_NAME" "$(get_os)" "$(get_arch)"
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	echo "* Downloading $TOOL_NAME release $version..."

	# Older releases are tagged with a leading "v", newer ones are not.
	url="$(release_url "$version")"
	if ! curl "${curl_opts[@]}" -o "$filename" -C - "$url" 2>/dev/null; then
		rm -f "$filename"
		url="$(release_url "v$version")"
		curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
	fi
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		install -m 0755 "$ASDF_DOWNLOAD_PATH/$TOOL_NAME" "$install_path/$TOOL_NAME"

		test -x "$install_path/$TOOL_NAME" || fail "Expected $install_path/$TOOL_NAME to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
