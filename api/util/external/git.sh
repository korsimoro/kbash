#!/bin/bash
# -------------------------------------------------------------- git utilities
git_has_changes() {
  DIR="$KITWB_BASE_DIR/$1"
  CHANGES=$(git --git-dir "$DIR/.git" --work-tree "$DIR" status --porcelain)
  [ ! -z "$CHANGES" ]
}
git_current_branch() {
  DIR="$KITWB_BASE_DIR/$1"
  git --git-dir "$DIR/.git" --work-tree "$DIR" rev-parse --abbrev-ref HEAD
}
git_checkout() {
  DIR="$KITWB_BASE_DIR/$1"
  BRANCH=$2
  git --git-dir "$DIR/.git" --work-tree "$DIR" checkout $BRANCH
}
git_update() {
  DIR="$KITWB_BASE_DIR/$1"
  git --git-dir "$DIR/.git" --work-tree "$DIR" pull origin $2
}
git_commit_release_notes() {
  DIR="$KITWB_BASE_DIR/$1"
  git --git-dir "$DIR/.git" --work-tree "$DIR" add $DIR/devops/release-notes/$2.md
  git --git-dir "$DIR/.git" --work-tree "$DIR" commit -m "Adding release notes"
}
git_short_hash() {
  DIR="$KITWB_BASE_DIR/$1"
  git --git-dir "$DIR/.git" --work-tree "$DIR" log --pretty=format:'%h' -n 1
}
# note, git-stash must be 'in' the working tree --work-tree doesn't work
git_stash_for_fupdate() (
  DIR="$KITWB_BASE_DIR/$1"
  #echo git --git-dir "$DIR/.git" --work-tree "$DIR" stash save kd-repos-fupdate
  #git --git-dir "$DIR/.git" --work-tree "$DIR" stash save kd-repos-fupdate
  cd "$DIR"
  git stash save kd-repos-fupdate
)
git_release() {
  SELECTED_REPO_TAG=$1
  BRANCH=$2
  NEW_VERSION=$3
  REPO="$KITWB_BASE_DIR/$SELECTED_REPO_TAG"
  GIT="git --git-dir $REPO/.git --work-tree $REPO"
  RELEASE_NOTES=$REPO/devops/release-notes/$NEW_VERSION.md
  NOTE=$(cat $RELEASE_NOTES)
  $GIT commit -m "Prepping for release" $REPO/*/*.csproj $RELEASE_NOTES
  $GIT checkout master
  $GIT pull origin master
  $GIT merge --squash $BRANCH
  $GIT commit -m "$NOTE"
  $GIT push origin master
  $GIT checkout $BRANCH
  $GIT merge master -m "Bringing $BRANCH up to date with master following release"
  $GIT push origin $BRANCH
}

set_git_status() {
  REPO=$1
  BRANCH=$(git_current_branch $REPO)
  HASH=$(git_short_hash $REPO)
  if git_has_changes $REPO; then
    STATUS="has changes"
  else
    STATUS="unchanged"
  fi
}
