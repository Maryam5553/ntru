gen_mat(N, q, h) = {
    hn = Mat();
    tmp_h = Mod(lift(lift(h)), x^N-1);
    for(i=1, N,
        h_v = Vec(lift(tmp_h));
        h_v = Vecrev(concat(vector(N-#h_v), h_v));
        hn = matconcat([hn;h_v]);
        tmp_h = tmp_h*x;
    );
    hn = matconcat([matid(N), hn; matrix(N), matid(N)*q]);
    return (hn);
}