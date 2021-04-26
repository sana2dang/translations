cd local
rm -rf data/
mkdir data
mkdir data/lang

for i in lang*
do

    echo "Processing $i"
    lang=`echo $i | sed 's/lang_//'`
    mkdir "data/lang/$lang"
    cp -r $i/* "data/lang/$lang"
    for n in data/lang/$lang/*.txt
    do
        ./tsc $n `echo $n | sed 's/txt/tsc/'`
        rm $n
    done
    for n in data/lang/$lang/Stage/*.txt
    do
        ./tsc $n `echo $n | sed 's/txt/tsc/'`
        rm $n
    done
    echo "tsc complete!"
	
    str=`cat $i/metadata`
    arr=(${str// / })
	echo $arr
    for key in {1..5}
    do
      sizearr=(${arr[$key]//:/ })
	echo ${sizearr[0]}
	echo ${sizearr[1]}
      ./fontbm -F ${arr[0]} --texture-width=${sizearr[1]} --texture-height=${sizearr[1]} -O data/lang/$lang/font_${key} -S ${sizearr[0]} --chars ${arr[6]}
    done
done

#cleanup


#rm -f fontbm
#rm -f fontbm.bin
#rm -f tsc
#rm -rf assets
#rm -rf lib

cd ..