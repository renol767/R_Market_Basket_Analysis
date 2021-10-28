library(arules)
library(arulesViz)
library(plotly)

transaksi <- read.transactions(file = "Data_Transaksi.txt", format="single", sep="\t", cols=c(1,2), skip=1)

# Membuat Rules disini berbeda dari sebelumnya karena memakai nilai minimum support dan confidence
# Jadi rules yang dihasilkan ada 16
# apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))

# Simpan rules ke MDA
mda <- apriori(transaksi,parameter = list(supp = 0.1, confidence = 0.5))

# lalu inspect dengan filter rhs dan lhs disini item nya teh celup, note | : Atau
# Tambahkan lagi filter lift nya harus diatas 1
inspect(subset(mda, (lhs %in% "Teh Celup" | rhs %in% "Teh Celup") & lift > 1))

# Filter dengan %ain%, Filter ini tidak cocok jika kita ingin melakukan filter itemset dengan logika AND
# Artinya seluruh item harus muncul dalam itemset yang terpilih untuk keperluah tersebut

inspect(subset(mda, (lhs %ain% c("Pet Food", "Gula"))))

# Visualisaskan dengan graph
plot(subset(mda, lift > 1,1), method="graph")