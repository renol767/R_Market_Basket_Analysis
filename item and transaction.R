library(arules)

transaksi <- read.transactions(file = "Data_Transaksi.txt", format="single", sep="\t", cols=c(1,2), skip=1)

# Melihat ada item apa saja
transaksi@itemInfo

# Melihat daftar kode transaksi
transaksi@itemsetInfo

# tampilkan dalam bentuk matrix
transaksi@data
# Penjelasan Output . = item tidak ada di transaksi, | = item ada di transaksi

# Menampilkan item frequency, type = "absolute" ketika yang ingin kita tampilkan bukan dalam bentuk persen tapi jumlah item
data_item <- itemFrequency(transaksi, type="absolute")

#Melakukan sorting pada data_item
data_item <- sort(data_item, decreasing = TRUE)

#Mengambil 3 item pertama
data_item <- data_item[1:3]

#Konversi data_item menjadi data frame dengan kolom Nama_Produk dan Jumlah
data_item <- data.frame("Nama Produk"=names(data_item), "Jumlah"=data_item, row.names=NULL)

print(data_item)


#Menulis File Statistik Top 3
write.csv(data_item, file="top3_item_retail.txt", eol = "\r\n")

# Membuat plot item frequency
itemFrequencyPlot(transaksi)

# Melihat itemset per transaksi
inspect(transaksi)

# membuat rules dengan fungsi apriori
apriori(transaksi)

#Menghasilkan association rules dan disimpan sebagai variable mba
mca <- apriori(transaksi)

#Melihat isi dari rules dengan menggunakan fungsi inspect
inspect(mca)

#Filter rhs dengan item "Sirup" dan tampilkan
inspect(subset(mca, rhs %in% "Sirup"))

#Filter lhs dengan item Gula
inspect(subset(mca, lhs %in% "Gula"))

# Filter LHS dan RHS
inspect(subset(mca, lhs %in% "Pet Food" & rhs %in% "Sirup"))