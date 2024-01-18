
N = 20;
P = x^N - 1;
p = 2;
q = 33;
df=6;
dg=3;
f = concat(vector(df, n, n/n), vector(N-df));
f = Mod(Pol(shuffle(f)), x^N-1);


while((poldegree(bezoutres(Mod(f,p), P)[3]) != 0) || (poldegree(bezoutres(Mod(f,q), P)[3] )!=0),
    f = concat(vector(df, n, n/n), vector(N-df));
    f = Mod(Pol(shuffle(f)), x^N-1); );
    
g = concat(vector(dg, n, n/n), concat(vector(dg-1, n, -n/n), vector(N-2*dg)));
g = Mod(Pol(shuffle(g)), x^N-1);

Fp = Mod(1/f, p);
Fq = Mod(1/f, q);