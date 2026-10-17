version 16
args wp06_out
assert _N==0
assert c(k)==0
capture noisily mata: assert(wp06_sigmoid(0)==.5)
assert _rc==0
mata:
void wp06_tests()
{
    real scalar k,p,j,i,t,h,r,nperm,ii,delta
    real rowvector b,bp,bm,perm,ip
    real matrix T,F,J0,J1,P,A,R,V,W,V0
    real colvector q,q0,s
    string scalar out
    out=st_local("wp06_out")
    assert(out!="")
    h=1e-5
    for (k=2;k<=5;k++) {
        p=14*k
        b=J(1,p,0)
        for (j=1;j<=6;j++) {
            b[k+(2*j-2)*k+1..k+(2*j-1)*k]=J(1,k,-ln(2))
            b[k+(2*j-1)*k+1..k+2*j*k]=J(1,k,ln(2))
        }
        q=wp06_map(b,k)
        assert(rows(q)==1458 & max(abs(q:-1/1458))<1e-15)
        J0=wp06_jac(b,k)
        assert(max(abs(J0[.,1..k-1]))<1e-15 & sum(svdsv(J0):>1e-9)==13)
        printf("WP06_K%g_UNIFORM_AND_IDENTICAL_RANK13_PASS\n",k)
        for (i=2;i<=k;i++) b[i]=cos(i)/2
        for (j=1;j<=6;j++) for (i=1;i<=k;i++) {
            t=k+(2*j-2)*k+i
            b[t]=-1+1.2*sin(i*j+.3*j)
            b[t+k]=b[t]+.6+.7*(1+cos(i+2*j))
        }
        for (i=1;i<=k;i++) b[13*k+i]=sin(i*1.7)
        T=wp06_transform(b,k);q=wp06_map(b,k);J1=wp06_jac(b,k)
        assert(abs(sum(q)-1)<1e-12 & min(q)>=0 & !missing(J1))
        for (j=2;j<=p;j++) {
            bp=b;bm=b;bp[j]=bp[j]+h;bm[j]=bm[j]-h
            assert(max(abs((wp06_map(bp,k)-wp06_map(bm,k))/(2*h)-J1[.,j-1]))<1e-8)
        }
        s=svdsv(J1);r=sum(s:>1e-10*max(s))
        assert(r==p-1 & max(abs(colsum(J1)))<1e-12)
        printf("WP06_K%g_JACOBIAN_%g_FREE_COORDINATES_PASS\n",k,p-1)
        V=I(p);V[1,.]=J(1,p,0);V[.,1]=J(p,1,0);V[2,p]=.25;V[p,2]=.25
        P=wp06_permutations(k);nperm=rows(P)
        assert(nperm==(k==2 ? 2 : (k==3 ? 6 : (k==4 ? 24 : 120))))
        for (ii=1;ii<=nperm;ii++) {
            perm=P[ii,.];A=wp06_rebase(perm);bp=(A*b')';W=A*V*A'
            assert(max(abs(wp06_map(bp,k)-q))<1e-13 & max(abs(W-W'))<1e-14)
            assert(bp[1]==0 & max(abs(W[1,.]))==0 & max(abs(W[.,1]))==0)
            ip=J(1,k,0);for (i=1;i<=k;i++) ip[perm[i]]=i
            R=wp06_rebase(ip)
            assert(max(abs((R*bp')'-b))<1e-12 & max(abs(R*W*R'-V))<1e-12)
        }
        bp=(wp06_rebase(P[nperm,.])*b')'
        assert(rows(wp06_matches(T,wp06_transform(bp,k)))>=1)
        F=J(20,k,1/3);F[1,.]=J(1,k,1/k);F[20,.]=J(1,k,.5)
        assert(rows(wp06_matches(F,F))==nperm)
        printf("WP06_K%g_ALL_%g_REBASE_COVARIANCE_MATCH_TIES_PASS\n",k,nperm)
        bp=b;bp[2]=1000;bp[1]=0;bp[13*k+1]=-1000
        assert(!missing(wp06_map(bp,k)) & abs(sum(wp06_map(bp,k))-1)<1e-12)
        wp06_native(out+"/native-k"+strofreal(k,"%1.0f")+".csv",b,V,k)
        printf("WP06_K%g_NATIVE_%g_EXCLUSIVE_PRECISION_PASS\n",k,7+p+p*p)
    }
}
end
mata: wp06_tests()
capture noisily mata: wp06_transform(J(1,28,0),2)
assert _rc!=0
capture noisily mata: wp06_transform(J(1,28,.),2)
assert _rc!=0
assert _N==0
assert c(k)==0
display "WP06_ARTIFICIAL_GENERAL_K_ALL_PASS"
