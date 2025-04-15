#!/bin/bash
set -ue
set -o pipefail

# username/email
git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_EMAIL}"

# default editor
git config --replace-all core.editor vim

# Allow fast-forward marge only if pull
git config --global --add merge.ff false
git config --global --add pull.ff only

#
# alias
#
git config --global alias.st 'status -s'
#git config --global alias.add 'add'
git config --global alias.amend 'commit --amend'
#git config --global alias.dif 'diff'
#git config --global alias.difc 'diff --cached'
git config --global alias.diffc 'diff --cached'
git config --global alias.ch 'checkout'
git config --global alias.chm 'checkout main'
git config --global alias.chd 'checkout develop'
git config --global alias.log1 'log --graph --oneline'
git config --global alias.unstage 'reset HEAD'

# setup new repo
git config --global alias.new '!
git init
git switch --orphan main
git commit -m ":tada: origin" --allow-empty --no-verify

git switch --orphan develop
git commit -m ":tada: origin" --allow-empty --no-verify
'

# bump submodules

chmod +x ./scripts/bump.sh
# shellcheck disable=SC2016
ln -sf "$(realpath ./scripts/bump.sh)" "${HOME}/bin/bump"

# shellcheck disable=SC2016
git config --global alias.bump '! bump $(git rev-parse --show-toplevel) '

# shellcheck disable=SC2026,SC2154,SC2086,SC2016
git config --global alias.bumpall '!git submodule foreach '\''bump $toplevel $path'\'''

# m2m script (merge to main)
# shellcheck disable=SC2046
ln -sf $(realpath ./scripts/m2m.sh) "${HOME}/bin/m2m"
git config --global alias.m2m "! ${HOME}/bin/m2m"

# alias
# https://gitmoji.dev/

# shellcheck disable=SC2016
{
    git config --global alias.commnew '!f(){ git commit -m ":sparkles: $1"; }; f'
    git config --global alias.commfix '!f(){ git commit -m ":bug: $1"; }; f'
    git config --global alias.commremove '!f(){ git commit -m ":fire: $1"; }; f'
    git config --global alias.commformat '!f(){ git commit -m ":art: $1"; }; f'
    git config --global alias.commrefact '!f(){ git commit -m ":recycle: $1"; }; f'
    git config --global alias.commwip '!f(){ git commit -m ":construction: $1"; }; f'
    git config --global alias.commcfg '!f(){ git commit -m ":wrench: $1"; }; f'
    git config --global alias.commscript '!f(){ git commit -m ":hammer: $1"; }; f'
    git config --global alias.commrename '!f(){ git commit -m ":truck: $1"; }; f'
    git config --global alias.commchange '!f(){ git commit -m ":boom: $1"; }; f'
    git config --global alias.commbump '!f(){ git commit -m ":pushpin: $1"; }; f'
    git config --global alias.commdocs '!f(){ git commit -m ":memo: $1"; }; f'
    git config --global alias.commtag '!f(){ git tag -m ":bookmark: $1"; }; f'
    git config --global alias.commmerge '!f(){ git commit -m ":twisted_rightwards_arrows: $1"; }; f'
}

# pre-commit
pip3 install pre-commit
# shellcheck disable=SC2016
git config --global alias.precommit-install '!
toplevel=$(git rev-parse --show-toplevel)

rm -rf /tmp/git-hooks
git clone git@github.com:uyiromo/git-hooks.git /tmp/git-hooks --depth 1
for f in $(ls /tmp/git-hooks/configs/* ); do
    ff=$(basename $f)
    cp "${f}"  "${toplevel}/${ff}"
    git add "${ff}"
done
for f in $(ls /tmp/git-hooks/configs/.* ); do
    ff=$(basename $f)
    cp "${f}"  "${toplevel}/${ff}"
    git add "${ff}"
done
cp /tmp/git-hooks/.pre-commit-config.yaml "${toplevel}/"
git add .pre-commit-config.yaml
git commit -m ":wrench: add hooks" --no-verify
pre-commit install -t commit-msg -t pre-push -t pre-commit
'
