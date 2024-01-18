f = concat(vector(216, n, n/n), concat(vector(215, n, -n/n), vector(N-1-216-215)));
f = Mod(Pol(shuffle(f)), x^N-1);

g = concat(vector(72, n, n/n), concat(vector(72, n, -n/n), vector(N-1-72-72)));
g = Mod(Pol(shuffle(g)), x^N-1);

Fp = Mod(1/f, p);
Fq = Mod(1/f, q);

phi = concat(vector(55, n, n/n), concat(vector(55, n, -n/n), vector(N-1-55-55)));
phi = Mod(Pol(shuffle(phi)), x^N-1);

h = Fq * g;