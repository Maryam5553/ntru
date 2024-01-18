nextBin(val) = {
    c = bitand(val,-val);
    r = val + c;
    tmp = bitxor(r,val);
    tmp2 = floor(( tmp >> 2 ) / c);
    res = bitor( tmp2 , r);
    return (res);
}

get_key(vec, k, q) = {
    pos = floor(log(q)/log(2)) - 1;
    res = 0;
    for(j=1, k,
        if(bitand(vec[j],1<<pos), res += 1<<(k-j));
    );
    return (res);
}

add_dict(M, key, fct) = {
    tmp_tab = [];
    if(mapisdefined(M, key), tmp_tab = mapget(M, key));
    mapput(M, key, concat(tmp_tab, [fct]));
    return (M);
}

stock(N, p, q, df, h) = {
    M = Map();
    n = floor(N/2);
    d = floor(df/2) + 1;
    val = 2^d-1;
    pol_number = binomial(n, d);
    k = floor(log(pol_number*100)/log(2)) + 1;
    for(i=1, pol_number,
        bin_val = digits(val, 2);
        f1 = concat(bin_val, vector(n, x, 0));
        f1 = Pol(f1);
        tmp = f1*h;
        key = get_key(Vec(lift(lift(tmp))), k, q);
        M = add_dict(M, key, f1);
        val = nextBin(val);
    );
}

get_all_key(vec, k, q) = {
    pos = floor(log(q)/log(2)) - 1;
    tab_var = [0];
    for(j = 1, k,
        if(bitxor(bitand(vec[j], bitneg(1<<pos, pos)), 2^pos-1),,
            tab_size = #tab_var;
            for(l=1, tab_size,
                tab_var = concat(tab_var, tab_var[l]+1<<(k-j));
            );
        );
    );

    gak_key = get_key(vec, k, q);
    for(j = 1, #tab_var, tab_var[j] = bitxor(tab_var[j], gak_key));
    return (tab_var);
}

isbinary(vec) = {
    for(ib_i=1, #vec,
        if(vec[ib_i] != 0 && vec[ib_i] != 1, return (0););
    );
    return (1);
}

match(N,p,q,df,h) = {
    n = floor(N/2);
    d = floor(df/2);
    val = 2^d - 1;
    pol_number = binomial(n, d);
    for(i=1, pol_number,
        bin_val = digits(val, 2);
        f2 = Pol(bin_val);
        m_tmp = -f2*h;
        m_all_key = get_all_key(Vec(lift(lift(m_tmp))), k, q);
        for(j=1, #m_all_key,
            if(mapisdefined(M, m_all_key[j]),
                m_tab_f1 = mapget(M, m_all_key[j]);
                for(l=1, #m_tab_f1,
                    m_f1 = m_tab_f1[l];
                    m_f = m_f1+f2;
                    if(isbinary(Vec(lift(m_f*h))), print(m_f));
                );
            );
        );
        val = nextBin(val);
    );
}