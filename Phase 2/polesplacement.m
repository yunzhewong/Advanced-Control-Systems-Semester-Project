p = [-3+5i, -3-5i, -25+460i, -25-460i];

K = place(A, B, p)

Acl = A-B*K;
syscl = ss(Acl,B,C,D);
Pcl = pole(syscl)

figure
step(syscl)