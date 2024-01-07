#! /bin/bash

printf "#####################\n"
printf "#   COMPIL ARDUINO  #\n"
printf "#####################\n"

mkdir ".build"
mkdir ".tmp"
cd "src"

for c in *.cpp;do
    [ -f "$c" ] || break
    avr-gcc  -Os -DF_CPU=16000000UL -mmcu=atmega328p -c $c -o ../.tmp/${c%.*}.o
    filesC="$filesC $c"
done
exit 


printf 'P3'
avr-gcc -DF_CPU=16000000UL -mmcu=atmega328p $filesC -o .build 2> /dev/null
printf '. done [links]\n'
exit


print 'P4'
avr-objcopy -0 ihex -R .eeprom build build.hex
printf '. done [.hex]\n'
exit


printf "Voulez vous commencer le televersement ? [O/N]: "
read -r TELEV
if [[ $TELEV == 'N' ]];then
    printf "Bye bye\n"
    exit
else
    printf "Démarage du téléversement \n"
    avrdude -F -V -c arduino -p ATMEGA328 -P /dev/ttyS1 -b 115200 -U flash:w:build
fi

exit