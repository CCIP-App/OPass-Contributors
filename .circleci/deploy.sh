
git config user.name "CircleCI"
git config user.email "circleci@oktw.network"

mv ./dist ./.git ./.circleci ./../

rm -rf ./*

mv ./../.git ./../dist ./

git checkout gh-pages

find . -maxdepth 1 ! -name '.git' ! -name 'dist' -exec rm -rf {} \;

mv dist/* ./
cp ./../.circleci ./ -rf

rm ./dist -rf

git add .
git add .circleci
git commit --allow-empty -m "$(git log master -1 --pretty=%B)"
git push --set-upstream origin gh-pages

echo "Deployed successfully"