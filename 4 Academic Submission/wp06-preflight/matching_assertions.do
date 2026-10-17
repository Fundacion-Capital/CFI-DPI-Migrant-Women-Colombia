version 16
assert _N==0
assert c(k)==0
mata:
void wp06_matching_tests()
{
    real scalar k,j,i,t
    real rowvector b,perm,ip,bp
    real matrix T,U,M
    for (k=2;k<=5;k++) {
        b=J(1,14*k,0)
        for (i=2;i<=k;i++) b[i]=i/7
        for (j=1;j<=6;j++) for (i=1;i<=k;i++) {
            t=k+(2*j-2)*k+i;b[t]=-1+i/9+j/11;b[t+k]=b[t]+1+j/9
        }
        for (i=1;i<=k;i++) b[13*k+i]=i/3
        perm=(2..k,1);ip=J(1,k,.)
        for (i=1;i<=k;i++) ip[perm[i]]=i
        bp=(wp06_rebase(perm)*b')';T=wp06_transform(b,k);U=wp06_transform(bp,k)
        M=wp06_matches(T,U)
        assert(rows(M)==1 & M==ip & max(abs(T-U[.,M[1,.]]))<1e-13)
        bp[13*k+1]=bp[13*k+1]+.1;U=wp06_transform(bp,k);M=wp06_matches(T,U)
        assert(max(abs(T-U[.,M[1,.]]))>1e-6)
        printf("WP06_K%g_UNIQUE_INVERSE_MATCH_AND_NONLABEL_CHANGE_PASS\n",k)
    }
}
end
mata: wp06_matching_tests()
assert _N==0
assert c(k)==0
display "WP06_MATCHING_STRONG_ALL_PASS"
