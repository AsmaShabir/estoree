import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://static.vecteezy.com/system/resources/thumbnails/048/912/247/small/young-brunette-woman-holding-shopping-bags-showing-plastic-credit-card-and-smiling-standing-against-pink-background-photo.jpg',
      'https://static.vecteezy.com/system/resources/previews/036/528/297/non_2x/hand-drawn-online-shopping-horizontal-banner-vector.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.shade100,
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 400,
                height: 150,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: imageList.map((imagePath) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text('Category',style: TextStyle(fontSize: 16),),
              SizedBox(height: 20),

              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://media.istockphoto.com/id/1446098147/photo/shopping-happy-and-portrait-of-customer-with-bag-after-shopping-spree-buying-retail-fashion.jpg?s=612x612&w=0&k=20&c=OFL3OPm9SPaaUveM_z3-0DaFcvorK4H_wK4KnmSY0Og='),
                          ),
                          SizedBox(height: 5,),
                          Text('Women')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://media.istockphoto.com/id/901866822/photo/two-young-men-holding-up-clothes-to-look-at-in-clothes-shop.jpg?s=612x612&w=0&k=20&c=01LoBjQx5dRb273O0HpkauoqeCwkyWnS9KNv_OhgPoI='),
                          ),
                          SizedBox(height: 5,),
                          Text('Men')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://cdn.shopify.com/s/files/1/0373/5968/1672/files/mobile_banners_newarrivals.jpg'),
                          ),
                          SizedBox(height: 5,),
                          Text('Kids')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlExmwDOwXpjiQ0O9zNP7TGmqjoWgQRFxa_Q&s'),
                          ),
                          SizedBox(height: 5,),
                          Text('Food')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/collection-electronic-devices-including-laptop-phone-ipod_1065421-12202.jpg?semt=ais_hybrid'),
                          ),
                          SizedBox(height: 5,),
                          Text('Electronics')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://hemmingandwills.co.uk/cdn/shop/articles/featured_image_-_living_room_furniture_layout_1600x@2x.jpg?v=1692692232'),
                          ),
                          SizedBox(height: 5,),
                          Text('Furniture')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage
                              ('https://5.imimg.com/data5/SELLER/Default/2023/2/MQ/ER/ZK/155211317/crockery-500x500.jpg'),
                          ),
                          SizedBox(height: 5,),
                          Text('Crockery')
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
