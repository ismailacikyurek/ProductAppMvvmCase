In this application, I got the values showing the air quality according to the city names from https://api.ambeedata.com/ using Alamofire. I then saved these values to the core data. I used the MVVM design pattern.

Sing Up Page:

On this page the user registers using firebaseAuth. It has password repeat and secureText feature.

Sing Up Page:

On this page the user is logging in using firebaseAuth. If the user has entered before, it goes directly to the Product page.

Home Page :

Here, the products coming from the API are listed in the collectionView. Filtering is done by entering category or product name in SearchBar.

Profile Page :

On this page, the user logs out safely.

Category Page :

Here, the categories of products coming from API are listed. The user selects a category.

--SCREEN -- 
<img width="352" alt="Ekran Resmi 2022-08-30 16 03 28" src="https://user-images.githubusercontent.com/82399051/187444224-18151a51-87a8-47eb-b015-929993bf9b89.png">
