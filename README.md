# CatFinder

## Scop

Aplicatia implementata in **GNU Octave** poate determina cu un procent de minim
**80%**, daca o imagine data contine sau nu o pisica. Acest algoritm este implementat
in doua moduri, initial folosind **Householder**, iar apoi cu **Gradient Descent**,
pentru a imbunatati timpul de executie.

Mai multe detalii despre algoritmul folosit pentru fiecare implementare, se pot
gasi [aici(householder)](https://acs.curs.pub.ro/2019/pluginfile.php/67380/mod_resource/content/12/Tema%201%20MN%20-%202020.pdf#section.3) si [aici(gradient-descent)](https://acs.curs.pub.ro/2019/pluginfile.php/67380/mod_resource/content/12/Tema%201%20MN%20-%202020.pdf#section.4).

## Continut foldere

Fiecare folder principal contine cate 3 subdirectoare. Acestea sunt:

* src - folder cu sursele ce constituie aplicatia propriu-zisa;
* dataset - folder cu doua tipuri de imagini, cu pisici si fara pisici, pe baza
carora se "invata" aplicatia care imagini contin pisici si care nu;
* testset - folder cu ajutorul caruia se testeaza aplicatia si se obtine un
procent minim de 80%.

## Explicatii despre implementare

Explic functionalitatea fiecarei functii folosite din cadrul celor doua implementari.

### Householder prediction

1. rgbHistogram
  Construiesc matricile *R* *G* *B* folosind *imread*. Pentru fiecare matrice repet
  urmatorul procedeu:

    * Construiesc o matrice *index*, astfel incat index(i)(j) = k, unde R(i)(j) se 
    aflat in intervalul \[(k-1) * 256 / count_bins; k * 256 / counts_bins). Adica
    aflu in ce intervalul se afla fiecare pixel din matricea *R* si retin aceasta
    valoare in matricea *index*.

    * Transform aceasta matrice intr-un vector coloana *subs*, pentru a aplica
    *accumarray*. Folosesc aceasta functie pentru a numara cate numere din matricea
    *index* au voloare *a*, pentru orice *a*, numar din matricea *index*
    (ca un vector de frecventa).
    
    * Introduc aceste valori in *sol*, (avand grija
    la indici) si mergand pana la elementul maxim din *index*, restul ramanand 0,
    asa cum este initializat *sol*, la inceput.

  Fac acelasi lucru si pentru matricile G si B

2. hsvHistogram

  Pentru fiecare pixel din matricile *R* *G* *B*, fac conversie pentru a obtine
  informatii despre pixel, in format *hsv*. Folosesc astfel functia *RGBB2HSV*
  care imi returneaza vectorii *h* *s* si *v* ce contin toti pixelii imaginii.
  Am folosit algoritmul din pseudocod dat in [enunt](https://acs.curs.pub.ro/2019/pluginfile.php/67380/mod_resource/content/12/Tema%201%20MN%20-%202020.pdf#subsubsection.3.2.2), intr-o forma vectorizata.

  Folosesc acesti vectori *h* *s* *v* in functia principala in acelasi fel ca
  in *rgbHistogram*.

3. Householder

  Folosesc algoritmul pentru a genera matricile *Q* si *R*.

4. SST

  Rezolv sistemul cu metoda clasica pentru matrici triunghiulare.

5. preprocess

  Construiesc calea catre cele 2 directoare din *dataset*: *cats* si *not_cats*.

  Procedez la fel pentru ambele diretoare.

  Folosesc functia *getImgNames* pentru a obtine toate imaginile de la directorul
  *cats*. Pentru fiecare imagine din acest director, construiesc calea catre
  aceasta imagine, verific tipul histogramei, dupa care aplic functia care trebuie
  construiind matricea *X*, cum este descris [aici](https://acs.curs.pub.ro/2019/pluginfile.php/67380/mod_resource/content/12/Tema%201%20MN%20-%202020.pdf#subsubsection.3.2.3).
  Completez vectorul *y* cu 1 pentru acest director, iar ulterior doar -1.

  Fac acelasi lucru cu directorul *not_cats*.

6. learn

  Adaug o coloana de 1 matricii X si rezolv sistemul cu Householder si SST

7. evaluate

  Ca la *preprocess*, formez calea catre cele 2 directoare din *testset*,
  *cats* si *not_cats*, iau fiecare imagine din ele si verific cu ajutorul lui *w* daca este o pisica sau nu. La final calculez procentul ca raport din numarul de pisici gasite cu acest algoritm si numarul real de pisici.


### Gradient Descent prediction

1. learn

  Adaug ca in implementarea precedenta o coloana de 1 matricii *X*. Generez un
  vector *w* random cu elemente din intervalul (-1 1). Scalez coloanele
  din matricea *X*,
  folosind x - mean(x) / std(x). Apoi repet procedeul de *epochs* ori: iau *k*
  linii random din matricea *X* si calculez noua valoare a lui *w* pe baza formulei respective.

2. evaluate

  Construiesc matricea *X* si vectorul *y* cu datele despre imaginile din test,
  pentru a putea scala matricea *X* pe coloane. Apoi verific fiecare imagine
  daca este cu pisici sau fara si calculez numarul de imagini corecte, dupa care calculez procentul.


