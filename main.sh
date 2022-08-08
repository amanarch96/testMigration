# stores list of remote branches on Bitbucket repository
git branch -r >> branches.txt
# removes leading and trimming whitespaces in each line of file 'branches.txt'
sed "s/^[ \t]*//" -i branches.txt
# deletes first line of file 'branches.txt'
sed '1d' branches.txt > tmpfile; mv tmpfile branches.txt
# deletes first seven characters, 'origin/'
sed -r 's/.{7}//' branches.txt > tmpfile; mv tmpfile branches.txt
# iterate through each branch for migration
while read branch; do
  echo $branch
  git checkout $branch
  git push upstream $branch
done <branches.txt
# push tags
git push --tags upstream
