git pull origin master

#netflify shrinks imgs, but not as much
#sh source/images/shrink_img.sh $(pwd)/source/images/blog

git add -A
git commit -m "$1"
git push origin master
