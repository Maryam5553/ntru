/*Test cryptage chaînes caractère*/

\r gen_key.gp


c = "Je suis un message caché..."

V = convertir(c)

gen_key(N,p,q)
encrypt(p,q,h,V)
decrypt(e, f, Fp)