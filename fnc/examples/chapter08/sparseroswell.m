%%
% Here we load the adjacency matrix of a graph with 2790 nodes. Each node
% is a web page referring to Roswell, NM, and the edges represent links
% between web pages.
load roswelladj   % get from the book's website
a = whos('A')

%%
% We may define the density of $\mathbf{A}$ as the number of nonzeros divided by the
% total number of entries.
sz = size(A);  n = sz(1);
density = nnz(A) / prod(sz)

%%
% We can compare the storage space needed for the sparse $\mathbf{A}$ with the
% space needed for its dense or full counterpart. This ratio can never be
% as small as the density of nonzeros, because of the need to store
% locations as well as data. However, it's still quite small here, even
% though the matrix is not really large.
F = full(A);
f = whos('F');
a.bytes/f.bytes

%%
% Matrix-vector products are also much faster using the sparse form,
% because operations with structural zeros are skipped.
x = randn(n,1);
tic, for i = 1:200, A*x; end
sparse_time = toc

%%
tic, for i = 1:200, F*x; end
dense_time = toc

%%
% However, the sparse storage format in MATLAB is column-oriented.
% Operations on rows may take a lot longer than similar ones on columns.
v = A(:,1000);
tic, for i = 1:n, A(:,i)=v; end
column_time = toc
r = v';
tic, for i = 1:n, A(i,:)=r; end
row_time = toc

