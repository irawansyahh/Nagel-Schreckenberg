%Simulasi Arus Lalulintas Kendaraan.
%Menggunakan Teknik Celluler Automata.
            %Definisi Variabel
%Panjang Lintasan
M = 100;
%Jumlah Kendaraan
N = 10;
%Probabilitas
p = 0.3;
%Waktu
t = 1;
%Dikritisasasi waktu
dt = 1;
%Kecepatan awal masing-masing kendaraan
v = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%Jumlah masing-masing kendraan kembali ke posisi awal 
kembali = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%Kecepatan Maximum
vmax = 5;
%Waktu Maximum
tmax = 100;
%Posisi awal masing-masing 10 kendaraan
kendaraan = [5, 15, 25, 35, 45, 55, 65, 75, 85, 95];
pos_awal_kendaraan = [5, 15, 25, 35, 45, 55, 65, 75, 85, 95];
pos_kendaraan_baru = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%jumlah kendaraan yang melewati satu titik tertentu di jalan dalam waktu(t)
NN = 0;
%Membuat lintasan untuk kendaraan dengan lebar 'N-1' dan panjan 'M'
jalan = zeros(N-1, M);

%Menampilkan posisi awal masing-masing kendaraan
jalan(5,kendaraan) = 0;
imagesc(jalan);
axis equal

while (t<tmax)
  %Menghitung jarak antar kendaraan
  for i=1:N
    if(i<N)
        depan = pos_kendaraan_baru(i+1);
        if(depan < pos_kendaraan_baru(i))
            d = M - pos_kendaraan_baru(i)+depan;
        end
        d = depan - pos_kendaraan_baru(i);
    else
        d = pos_kendaraan_baru(i) - pos_kendaraan_baru(1);
    end
  end
  
  for j=1:N
    %Menghitung nilai dari kecepatan(v) kendaraan
    if(v(j)< vmax )
        %tambah kecepatan sebanyak 1 jika belum mencapai vmax
        v(j) = min(v(j)+1, vmax);
    elseif (v(j) >= d)
        %set kecepatan = jarak - 1 jika kecepatan melebihi jarak kendaraan didepan
        v(j) = min(v(j), d-1); 
    elseif(rand(1) <= p )
        %bangkitkan bilangan acak antara 0 sampai 1, jika hasilnya kurang dari 0.3 kurangi kecepatan sebanyak 1
        v(j) = max(0, v(j)-1);
    end
    %Merubah posisi kendaraan berdasarkan kecepatan(v)
    kendaraan(j) = kendaraan(j)+v(j);
    %Me-reset posisi kendaraan, jika kendaraan melebihi panjang lintasan
    if(kendaraan(j)>= M)
      kendaraan(j) = kendaraan(j)- M;
    end
    
    if(kendaraan(j) == 0)
      kendaraan(j) = kendaraan(j)+1;
    end
    %Menghitung waktu kembali
    if(kendaraan(j) == pos_awal_kendaraan(j))
            kembali(j) = kembali(j)+1;
    end
    %Menghitung jumlah kendaraan yang melewati satu titik tertentu di jalan dalam waktu(t)
    if(t>=80 && t<=90)
        NN = NN+1; 
    end
    %Menampilkan posisi masing-masing kendaraan yang sudah ter-update
    jalan(5,kendaraan) = 1;
    imagesc(jalan);
    axis equal
    pause(0.01)
    %Menghilangkan tampilan posisi sebelumnya masing-masing kendaraan
    jalan(5,kendaraan) = 0;
  end
  %Meng-update posisi kendaraan yang baru 
  pos_kendaraan_baru(j) = pos_kendaraan_baru(j)+kendaraan(j);  
  t = t+dt;
  disp(kendaraan);
  %disp(kembali);
end

kepadatan = (NN/M);
y = sprintf('kepadatan per satuan waktu pada waktu interval [x80; x90]. : %s second',kepadatan);
disp(y);

rataan = mean(kembali);
x = sprintf('waktu rata-rata ke posisi awal : %s second',rataan);
disp(x);

