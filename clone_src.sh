#!/bin/bash

# Author: Ivan Do
# Description: This script download Android AOSP Source

if [[ ! -e ${PWD}/repo ]]; then
	echo "repo does not exist!! Clone repo..."
	echo "wget  https://storage.googleapis.com/git-repo-downloads/repo"
	wget  https://storage.googleapis.com/git-repo-downloads/repo
	chmod +x ${PWD}/repo
fi
echo "Clone Android SRC..."
if [[ ! -e ${PWD}/init_done ]]; then
	#statements	
	echo "./repo init --depth=1 -u https://source.codeaurora.org/quic/la/platform/manifest.git -b release -m LA.BR.1.2.9-04610-8x09.0.xml --repo-url=git://codeaurora.org/tools/repo.git --repo-branch=caf-stable"
	./repo init --depth=1 -u https://source.codeaurora.org/quic/la/platform/manifest.git -b release -m LA.BR.1.2.9-04610-8x09.0.xml --repo-url=git://codeaurora.org/tools/repo.git --repo-branch=caf-stable 
	echo "init finished" > init_done 
fi

# ./repo sync -j2

echo "./repo sync  -f --no-clone-bundle --no-tags -j2"
./repo sync  -f --no-clone-bundle --no-tags -j2


