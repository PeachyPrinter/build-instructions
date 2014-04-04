echo "<html><head><link rel='stylesheet' href='app/resources/app.css' type='text/css'></head><body><table border='0'>" > dist/singlepage.html
echo "<style media="screen" type="text/css">.buttons { display: none; }</style>" >> dist/singlepage.html
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
do
  echo "<tr><td width='50%'>" >> dist/singlepage.html
  cat src/section$i.html >> dist/singlepage.html
  echo "</td><td>" >> dist/singlepage.html
  cat src/section$i.html | grep "set_images" | sed "s/^.*\[//" | sed "s/\].*$//" | tr ',' $'\n' | tr -d "'" | grep -v noimage | grep -v default | awk '{ printf "<a href=|%s|><img height=|150| width=|150| src=|%s|\/></a>\n", $0, $0 }' | tr "|" "'" >> dist/singlepage.html
  echo "</td></tr><tr><td colspan='2'><hr/></td></tr>" >> dist/singlepage.html
done
echo "</table></body></html>" >> dist/singlepage.html

