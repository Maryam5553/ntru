setrand(getwalltime())

N = 40;
p = 3;
q = 64;
df = 7;
dg = 3;
d = 4;

P = x^N - 1;

shuffle(l) =
{
    tmp = vector(#l);
    for(i=1, #l, tmp[i] = [random(), l[i]]);
    tmp = vecsort(tmp);
    for(i=1, #l, l[i] = tmp[i][2]);
    return(l);
}

gen_key(N, p, q) = 
{
    f = concat(vector(df, n, n/n), concat(vector(df-1, n, -n/n), vector(N-2*df)));
    f = Mod(Pol(shuffle(f)), x^N-1);

    while((poldegree(lift(lift(bezoutres(Mod(f,p), P)[3])) )!= 0) || (poldegree(bezoutres(Mod(f,q), P)[3] )!=0) ,
        f = concat(vector(df, n, n/n), concat(vector(df-1, n, -n/n), vector(N-2*df)));
        f = Mod(Pol(shuffle(f)), x^N-1);
    );

    g = concat(vector(dg, n, n/n), concat(vector(dg, n, -n/n), vector(N-1-2*dg)));
    g = Mod(Pol(shuffle(g)), x^N-1);

    Fp = Mod(1/f, p);
    Fq = Mod(1/f, q);

    h = Fq * g;
}

gen_key_bin(N,p,q) = {
    f = concat(vector(df, n, n/n), vector(N-df));
    f = Mod(Pol(shuffle(f)), x^N-1);

    g = concat(vector(dg, n, n/n), vector(N-1-2*dg));
    g = Mod(Pol(shuffle(g)), x^N-1);

    Fq = Mod(1/f, q);

    h = Fq * g;
}

encrypt(p, q, h, m) = 
{
    phi = concat(vector(d, n, n/n), concat(vector(d, n, -n/n), vector(N-1-2*d)));
    phi = Mod(Pol(shuffle(phi)), x^N-1);

    e = p*phi*h + m;
}

decrypt(e, f, Fp) =
{
    a = f*e;
    a = centerlift(lift(a));
    d = centerlift(lift(Fp*a));
}

m = centerlift(lift(Mod(Mod(random(1000*P),P), p)));