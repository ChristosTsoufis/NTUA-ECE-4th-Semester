#include <iostream>

using namespace std;

long long int fract (int x){
	long long int y=x;
	long long int sum=1;
	if (y==0) return 1;
	for (y=x;y>0;y--) sum*=y;
	return sum;
}
long long int funny(int x, int y){
	long long int m=fract(x)/(fract(y)*fract(x-y));
	return m;
}
int main(){
	//subsets of L elements
	long long int M;
	int i;
	while (true) {
		cout<<"give=: ";
		long long int m,n,L,k;
		cin>>n>>m>>k>>L;
		M=0;
		if (L>m){
			for (i=k;i<=m;i++){
				M+=funny(m,i)*funny(n-m,L-i);
			} 
		}
		else {
				for (i=k;i<=L;i++){
				M+=funny(m,i)*funny(n-m,L-i);
			} 
	}
	cout<<M<<"\n";
}
	
	//strings
	int n;
	cin>>n;
	int M=(n-7)+7*(n-7)*(n-8)/2;
	cout<<M<<"\n";

	//Subsets of 8 elements
	long long int N,d,L,M;
	while (true){
		cin>>L>>N>>d;
		M=fract(d+1)*fract(N-L)/fract(d+1-L);
		cout<<M<<"\n";
	}


}
