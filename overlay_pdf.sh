#! /bin/bash

bkgr=$(ls | grep .All.pdf)
list=$(ls | grep .pdf | grep -v All.pdf | grep -v Overlay.pdf)
output=$(echo $bkgr | sed s/All.pdf/Overlay.pdf/)

echo $bkgr
echo $list

array=($list)
n=$(expr ${#array[@]} - 1)

temp_pdf_in=${array[0]}
for i in $(seq 1 $n); do
	echo $i ${array[$i]}
	pdftk ${array[$i]} background $temp_pdf_in output temp_pdf_${i}.pdf
    temp_pdf_in=$(echo temp_pdf_${i}.pdf)
done

pdftk $temp_pdf_in background $bkgr output $output
rm temp_pdf_*.pdf
