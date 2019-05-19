#cambio manual de inconsistencia BD de 2014 por 14
sed 's/2014/14/' data.csv > out.20

#cambio manual de inconsistencia BD de de 13 por 14 en penultima fila 
sed 's/13;A;2/14;A;2/' out.20 > out.21

# Pone un cero donde encuentra un dígito único al principio de la línea
sed 's#^\([0-9]\)/#0\1/#' out.21 > out.22

# Pone un cero donde encuentra un dígito único entre '/' y '/'
sed 's#/\([0-9]\)/#/0\1/#' out.22 > out.23

#Convierta el formato de las fechas de DD/MM/YY a YYYY-MM-DD.
sed -e 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\([0-9][0-9]\)/20\3-\2-\1/g' out.23 > out.1

#Use el . para indicar decimales.
sed 's/,/./g' out.1 > out.3

#Reemplace los ; por ,
sed 's/;/,/g' out.3 >out.4

#Elimina la columna 5 (el cero)
sed 's/,0/ /g' out.4 > out.5

# lo que este entre ,, cambielo por \N
sed 's/,,/,\N,/g' out.5 > out.6

# lo que este entre ,n cambielo por ,\N
sed 's/,n/,\\\N/g' out.6 > out.77

#Transforme el archivo para que todos los campos nulos aparezcan como \N.
sed 's/,N,/,\\\N,/g' out.77 > out.7

sed 's/,N/,\\\N/g' out.7 > out.8

#cambia letras minúsculas por mayúsculas
sed -e 's/a/A/g' -e 's/c/C/g' -e 's/n/N/g' out.8 > out.10

# Agregue ',\N' a las filas que terminan en ','
sed -e "s/,$/,\\\N/g" out.10 > out.11


#cambiando 200.0 por 200,0
sed -e 's/,200.0/,200,0/' out.11 > out.12

#Imprime lo que no tenga \N
grep -v '\N' out.11 > out.13

cat out.12

rm out.*


