#!/bin/bash

# Obtenha o hash do último commit na branch master
latest_commit=$(git log -n 1 --pretty=format:"%H" master)

# Obtenha a lista de todas as branches (excluindo a branch atual e a branch master)
branches=$(git branch | sed 's/\*//g' | sed 's/ //g' | grep -v '^master$')

# Faça o pull das últimas mudanças na branch master
git checkout master
git pull origin master

# Loop através das branches e aplique o último commit da master
for branch in $branches
do
  echo "Aplicando o último commit da master na branch $branch"
  git checkout $branch
  git cherry-pick $latest_commit --strategy-option theirs
  git push origin $branch
done

# Volte para a branch master
git checkout master
