c = "hello"


/* convertit une chaîne de caractère en un vecteur de polynôme où chaque polynôme est la représentation binaire d'une lettre */

convertir(c) = {
    V = Vec(Vecsmall(c));
    c_res = [];
    for ( i=1, #V, 
        tmp = concat(vector(8-#digits(V[i], 2)), digits(V[i], 2));
        c_res = concat(c_res, tmp); 
    );
    return (Pol(c_res));
}

/* convertit un vecteur de polynôme en chaîne de caractère (chaque polynôme étant la représentation binaire d'une lettre) */

deconvertir(N, p) = {

    V = concat(vector(N-#Vec(p)), Vec(p));
    c = [];
    str = "";
    for(i=1, #V,
        c = concat(c, V[i]);
        if(i%8,,
            str = concat(str, Strchr(fromdigits(c, 2)));
            c = [];
        );
    );
    return (str);
}



/* Explication ligne par ligne
 * V = Vec(Vecsmall(c));                conv str en vec
 * for (i=1, #V, V[i]=V[i]-97);         ascii->n° lettre alphabet
 * for (i=1, #V, V[i]=digits(V[i],2));  conv binaire
 * for (i=1, #V, V[i]=Pol(V[i]));       conv chaque lettre en pol
 * V
 */