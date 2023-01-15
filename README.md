# memleketim-Uygulamasi
Memleketim Uygulaması;
Uygulamanızda memleketinizde önemli olarak gördüğünüz en az 3 yerin bilgilerinin girilmiş olması 
gerekmektedir.
Kontrol sırasında uygulamada bahsedilen hem kullanıcı girişi tipine göre giriş ve kontrolü hemde yeni 
yer bilgisi giriş denemesi yapılacaktır.
1- Uygulamada kullanıcı girişi, kontrolü ve bilgi girişleri Firebase kullanılarak yapılacak.
 Kullanıcı Girişi – Firebase Authentication
 Veri Girişleri – Firebase Cloud Firestore
 Resim Depolama – Firebase Storage
2- Kullanıcı giriş ekranı tek olacak. Mail ve şifre ile giriş olacak. Giriş yapan kullanıcının mail tipine
(admin yada normal) göre Admin yada Normal kullanıcı ekranı karşısına gelecek.
3- Admin ekranında Yer Ekle ve Yer Güncelle diye 2 buton olacak.
 Yer Ekle bölümünde, Yer adı, Yer hakkında bilgi, Yerin resmi, Yerin konum bilgisi girilecek.
Yerin resmi için galeriden bir resim ya da o an kameradan çekilen bir resim seçilecek ve resim 
firebase-storage de depolanacak.
Yer konum bilgisi seçiminde harita ekrana gelecek. Haritadan istediğim konum seçilecek ve bu 
konum bilgisi (enlem-boylam) tutulacak.
 Yer Güncelle bölümünde, daha önce girilmiş yer adlarının listesi gelecek. Bu listedeki herhangi bir 
yer adı seçildiğinde o yer ili ilgili bilgiler ekrana gelecek ve bu bilgilerden herhangi biri update 
edilebilinecek.
4- Kullanıcı ekranında Yer adlarının listesi ekrana gelecek. Bu listedeki herhangi bir yer adı seçildiğinde 
o yer ili ilgili bilgiler ekrana gelecek.
