#!/bin/bash

# Git LFS 추적 해제할 파일 경로
FILES_TO_UNTRACK=("wonroom/build/app/outputs/flutter-apk/app-debug.apk")

# 현재 브랜치 저장
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)

# 모든 브랜치 목록 가져오기
BRANCHES=$(git branch -r | grep -v '\->')

# 모든 브랜치에 대해 반복
for BRANCH in $BRANCHES; do
  # 원격 브랜치 이름에서 'origin/' 제거
  BRANCH_NAME=${BRANCH#origin/}
  
  # 브랜치 체크아웃
  git checkout $BRANCH_NAME
  
  # LFS 추적 해제
  for FILE in "${FILES_TO_UNTRACK[@]}"; do
    git lfs untrack "$FILE"
    git rm --cached "$FILE"
  done

  # 변경 사항 커밋
  git add .gitattributes
  git commit -m "Stop tracking specified files with Git LFS"

  # 원격에 푸시
  git push origin $BRANCH_NAME
done

# 원래 브랜치로 돌아가기
git checkout $CURRENT_BRANCH
