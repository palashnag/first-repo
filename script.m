L=size(final_data,1);
B=size(final_data,2);
final=zeros(L,3*B);
final(1,B+1:3*B)=zeros(1,2*B);
final(2,2*B+1:3*B)=zeros(1,B);
final(1,1:B)=final_data(1,1:B);
final(2,B+1:2*B)=final_data(1,1:B);
final(2,1:B)=final_data(2,1:B);

for i=3:L
    final(i,1:B)=final_data(i,1:B);
    final(i,B+1:2*B)=final_data(i-1,1:B);
    final(i,2*B+1:3*B)=final_data(i-2,1:B);
end
