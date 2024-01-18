/* proba que coef de P1*P2 = u (où Pi a di coef à 1)*/

Pbinom(N,d1,d2,u) = {
    return( binomial(d1,u)*binomial(N-d1,d2-u) / binomial(N,d2));
}

/* proba que (coef de prg = s-b) et (coef de fm = b) */

Pprod(N,p,df,dg,dr,dm,s,b) = {
    return( Pbinom(N,df,dm,(s-b)/p) * Pbinom(N,dg,dr,b) );
}

/* proba que (coef de p*r*g+f*m) = s */

Pcoef(N,p,df,dg,dr,dm,s) = {
    borne_min = max( max(s-(p*min(dm,df)), max(0,dr+dg-N)), 0);
    borne_max = min( min(s-(p*max(0,dm+df-N)), min(dr,dg)), s);
    somme1 = 0;
    for(b=borne_min, borne_max, if( (s-b)%p==0, somme1 += Pprod(N,p,df,dg,dr,dm,s,b) ;) );
    return(somme1);
}


/* proba que width(prg+fm) >= q */
Pechec(N,p,q,df,dg,dr,dm) = {
    coef_max = p*min(dr,dg)+min(df,dm);
    /* min(df,dm)*(p-1) - (p-1)/2 + 2*p*min(dr,dg);*/
    somme2 = 0;
    for(t=0, coef_max, 
        somme3 = 0;
        somme4 = 0;
        for(s=0, t, somme3+= Pcoef(N,p,df,dg,dr,dm,s););
        for(s=q+t, coef_max, somme4+= Pcoef(N,p,df,dg,dr,dm,s););
        somme2+=(1-(1-somme4)^N) * ((1- somme3)^N - (1- (somme3 + Pcoef(N,p,df,dg,dr,dm,t)))^N );
    );
    return(somme2*1.);
}

N=40;
p=2;
q=63;
df=72;
dg=72;
dr=72;
dm=40;
res = Pechec(N,p,df,dg,dr,dm)