version 16
assert _N==0
assert c(k)==0
mata:
real scalar wp06_sigmoid(real scalar z)
{
    assert(!missing(z))
    return(z>=0 ? 1/(1+exp(-z)) : exp(z)/(1+exp(z)))
}
real matrix wp06_transform(real rowvector b,real scalar k)
{
    real matrix T
    real rowvector w
    real scalar i,j,t,c1,c2
    assert(k>=2 & k<=5 & k==floor(k) & cols(b)==14*k & !missing(b) & b[1]==0)
    w=exp(b[1..k]:-max(b[1..k]));w=w/sum(w);T=J(20,k,.)
    T[1,.]=w
    for (j=1;j<=6;j++) for (i=1;i<=k;i++) {
        t=k+(2*j-2)*k+i
        assert(b[t]<b[t+k])
        c1=wp06_sigmoid(b[t]);c2=wp06_sigmoid(b[t+k])
        T[2+3*(j-1),i]=c1
        T[3+3*(j-1),i]=c2-c1
        T[4+3*(j-1),i]=1-c2
    }
    for (i=1;i<=k;i++) T[20,i]=wp06_sigmoid(b[13*k+i])
    assert(!missing(T) & min(T)>=0 & max(T)<=1 & abs(sum(w)-1)<1e-12)
    return(T)
}
real matrix wp06_components(real matrix T)
{
    real matrix F
    real scalar y,j,i,x,k
    k=cols(T);assert(rows(T)==20 & !missing(T));F=J(1458,k,1)
    for (y=0;y<1458;y++) for (i=1;i<=k;i++) {
        for (j=1;j<=6;j++) F[y+1,i]=F[y+1,i]*T[2+3*(j-1)+mod(floor(y/3^(j-1)),3),i]
        x=floor(y/729)
        F[y+1,i]=F[y+1,i]*(x ? T[20,i] : 1-T[20,i])
    }
    assert(max(abs(colsum(F):-1))<1e-12)
    return(F)
}
real colvector wp06_map(real rowvector b,real scalar k)
{
    real matrix T
    T=wp06_transform(b,k)
    return(wp06_components(T)*T[1,.]')
}
real matrix wp06_jac(real rowvector b,real scalar k)
{
    real matrix T,F,D
    real colvector q
    real scalar y,j,i,l,x,z,prod,t,c1,c2,sg1,sg2
    T=wp06_transform(b,k);F=wp06_components(T);q=F*T[1,.]';D=J(1458,14*k-1,0)
    for (i=2;i<=k;i++) D[.,i-1]=T[1,i]*(F[.,i]-q)
    for (y=0;y<1458;y++) for (i=1;i<=k;i++) {
        for (j=1;j<=6;j++) {
            prod=1
            for (l=1;l<=6;l++) if (l!=j) prod=prod*T[2+3*(l-1)+mod(floor(y/3^(l-1)),3),i]
            x=floor(y/729);prod=prod*(x ? T[20,i] : 1-T[20,i])
            z=mod(floor(y/3^(j-1)),3);sg1=(z==0 ? 1 : (z==1 ? -1 : 0));sg2=(z==1 ? 1 : (z==2 ? -1 : 0))
            t=k+(2*j-2)*k+i;c1=wp06_sigmoid(b[t]);c2=wp06_sigmoid(b[t+k])
            D[y+1,t-1]=T[1,i]*prod*sg1*c1*(1-c1)
            D[y+1,t+k-1]=T[1,i]*prod*sg2*c2*(1-c2)
        }
        prod=1
        for (j=1;j<=6;j++) prod=prod*T[2+3*(j-1)+mod(floor(y/3^(j-1)),3),i]
        D[y+1,13*k+i-1]=T[1,i]*prod*(floor(y/729) ? 1 : -1)*T[20,i]*(1-T[20,i])
    }
    assert(!missing(D))
    return(D)
}
real matrix wp06_permutations(real scalar k)
{
    real matrix P
    real rowvector v
    real scalar z,i
    assert(k>=2 & k<=5 & k==floor(k));P=J(0,k,.)
    for (z=0;z<k^k;z++) {
        v=J(1,k,.)
        for (i=1;i<=k;i++) v[i]=1+mod(floor(z/k^(i-1)),k)
        if (rows(uniqrows(sort(v',1)))==k) P=P\v
    }
    return(P)
}
real matrix wp06_rebase(real rowvector perm)
{
    real matrix A
    real scalar k,i,j
    k=cols(perm);assert(k>=2 & k<=5 & sum(sort(perm',1):!=(1::k))==0)
    A=J(14*k,14*k,0)
    for (i=2;i<=k;i++) {
        A[i,perm[i]]=1
        A[i,perm[1]]=A[i,perm[1]]-1
    }
    for (j=1;j<=13;j++) for (i=1;i<=k;i++) A[j*k+i,j*k+perm[i]]=1
    return(A)
}
real matrix wp06_matches(real matrix T,real matrix U)
{
    real matrix P
    real colvector costs
    real scalar i,k
    k=cols(T);assert(rows(T)==20 & rows(U)==20 & cols(U)==k & !missing(T) & !missing(U))
    P=wp06_permutations(k);costs=J(rows(P),1,.)
    for (i=1;i<=rows(P);i++) costs[i]=max(abs(T-U[.,P[i,.]]))
    return(select(P,abs(costs:-min(costs)):<=1e-12))
}
string scalar wp06_stripe(real scalar k,real scalar j)
{
    real scalar block
    if (j<=k) return("ART:C"+strofreal(j,"%1.0f"))
    if (j<=13*k) {
        block=floor((j-k-1)/k)
        return("ART:o"+strofreal(floor(block/2)+1,"%1.0f")+"_cut"+strofreal(mod(block,2)+1,"%1.0f")+"_c"+strofreal(mod(j-k-1,k)+1,"%1.0f"))
    }
    return("ART:binary_c"+strofreal(j-13*k,"%1.0f"))
}
void wp06_line(real scalar fh,string scalar kind,real scalar i,real scalar j,real scalar value,string scalar rs,string scalar cs)
{
    string scalar dec,hx
    dec=strtrim(strofreal(value,"%24.17g"));hx=strtrim(strofreal(value,"%21x"))
    assert(strtoreal(dec)==value & strtoreal(hx)==value)
    fput(fh,"ARTIFICIAL_WP06,"+kind+","+strofreal(i,"%3.0f")+","+strofreal(j,"%3.0f")+","+rs+","+cs+","+dec+","+hx)
}
void wp06_native(string scalar path,real rowvector b,real matrix V,real scalar k)
{
    real scalar fh,p,i,j
    real rowvector m
    string rowvector names
    p=14*k;assert(cols(b)==p & rows(V)==p & cols(V)==p & b[1]==0)
    assert(!missing(b) & !missing(V) & max(abs(V-V'))==0 & max(abs(V[1,.]))==0 & max(abs(V[.,1]))==0)
    fh=fopen(path,"w")
    fput(fh,"origin,kind,i,j,rowstripe,colstripe,decimal,hex")
    m=(11,p-1,-12.345678901234567,1,p,p,p);names=("N","rank","ll","converged","rows_b","rows_V","cols_V")
    for (j=1;j<=7;j++) wp06_line(fh,"meta",0,j,m[j],"ART",names[j])
    for (j=1;j<=p;j++) wp06_line(fh,"b",1,j,b[j],"",wp06_stripe(k,j))
    for (i=1;i<=p;i++) for (j=1;j<=p;j++) wp06_line(fh,"V",i,j,V[i,j],wp06_stripe(k,i),wp06_stripe(k,j))
    fclose(fh)
}
end
