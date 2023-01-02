import 'package:forsa/custom/common_functions.dart';
import 'package:forsa/my_theme.dart';
import 'package:forsa/presenter/cart_counter.dart';
import 'package:forsa/screens/filter.dart';
import 'package:forsa/screens/product_details.dart';
import 'package:forsa/screens/category_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:forsa/app_config.dart';
import 'package:forsa/helpers/shimmer_helper.dart';
import 'package:forsa/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:forsa/custom/box_decorations.dart';


class Home extends StatefulWidget {
  Home({Key key,
    this.title,
    this.show_back_button = false,
    go_back = true,
    this.counter})
      : super(key: key);
  final CartCounter counter;
  final String title;
  bool show_back_button;
  bool go_back;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _allProductScrollController;
  ScrollController _featuredCategoryScrollController;
  ScrollController _mainScrollController = ScrollController();

  AnimationController pirated_logo_controller;
  Animation pirated_logo_animation;

  var _carouselImageList = ["https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg"];
  var _bannerOneImageList = ["https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg"];
  var _bannerTwoImageList = ["https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg"];
  var _featuredCategoryList = [
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTufW5fCESmrpdts2tThDHcoD6ClqU-j2Ca7iFZQnI9&s",
    "https://images.unsplash.com/photo-1580910051074-3eb694886505?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHBob25lfGVufDB8fDB8fA%3D%3D&w=1000&q=80"
        "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTufW5fCESmrpdts2tThDHcoD6ClqU-j2Ca7iFZQnI9&s",
    "https://images.unsplash.com/photo-1580910051074-3eb694886505?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHBob25lfGVufDB8fDB8fA%3D%3D&w=1000&q=80"
        "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTufW5fCESmrpdts2tThDHcoD6ClqU-j2Ca7iFZQnI9&s",
    "https://images.unsplash.com/photo-1580910051074-3eb694886505?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHBob25lfGVufDB8fDB8fA%3D%3D&w=1000&q=80"
        "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://dl3.upload.ir/1394-1//Newsletter17/38-Varanasi-India/6.jpg",
    "https://blogs.lse.ac.uk/businessreview/files/2016/07/Varanasi-India.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTufW5fCESmrpdts2tThDHcoD6ClqU-j2Ca7iFZQnI9&s",
    "https://images.unsplash.com/photo-1580910051074-3eb694886505?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHBob25lfGVufDB8fDB8fA%3D%3D&w=1000&q=80"
  ];

  bool _isCategoryInitial = true;

  bool _isCarouselInitial = true;
  bool _isBannerOneInitial = true;
  bool _isBannerTwoInitial = true;

  var _featuredProductList = [];
  bool _isFeaturedProductInitial = true;
  int _totalFeaturedProductData = 0;
  int _featuredProductPage = 1;
  bool _showFeaturedLoadingContainer = false;

  var _allProductList = [];
  bool _isAllProductInitial = true;
  int _totalAllProductData = 0;
  int _allProductPage = 1;
  bool _showAllLoadingContainer = false;
  int _cartCount = 0;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    if (AppConfig.purchase_code == "") {
      initPiratedAnimation();
    }

    fetchAll();

    _mainScrollController.addListener(() {
      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _allProductPage++;
        });
        _showAllLoadingContainer = true;
      }
    });
  }

  fetchAll() {
  }
  reset() {
    _carouselImageList.clear();
    _bannerOneImageList.clear();
    _bannerTwoImageList.clear();
    _featuredCategoryList.clear();

    _isCarouselInitial = true;
    _isBannerOneInitial = true;
    _isBannerTwoInitial = true;
    _isCategoryInitial = true;
    _cartCount = 0;

    setState(() {});

    resetFeaturedProductList();
    resetAllProductList();
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  resetFeaturedProductList() {
    _featuredProductList.clear();
    _isFeaturedProductInitial = true;
    _totalFeaturedProductData = 0;
    _featuredProductPage = 1;
    _showFeaturedLoadingContainer = false;
    setState(() {});
  }

  resetAllProductList() {
    _allProductList.clear();
    _isAllProductInitial = true;
    _totalAllProductData = 0;
    _allProductPage = 1;
    _showAllLoadingContainer = false;
    setState(() {});
  }

  initPiratedAnimation() {
    pirated_logo_controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    pirated_logo_animation = Tween(begin: 40.0, end: 60.0).animate(
        CurvedAnimation(
            curve: Curves.bounceOut, parent: pirated_logo_controller));

    pirated_logo_controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        pirated_logo_controller.repeat();
      }
    });

    pirated_logo_controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pirated_logo_controller?.dispose();
    _mainScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    //print(MediaQuery.of(context).viewPadding.top);
    return WillPopScope(
      onWillPop: () async {
        CommonFunctions(context).appExitDialog();
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
        app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: buildAppBar(statusBarHeight, context),
            ),
            //drawer: MainDrawer(),
            body: Stack(
              children: [
                RefreshIndicator(
                  color: MyTheme.accent_color,
                  backgroundColor: Colors.white,
                  onRefresh: _onRefresh,
                  displacement: 0,
                  child: CustomScrollView(
                    controller: _mainScrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          AppConfig.purchase_code == ""
                              ? Padding(
                            padding: const EdgeInsets.fromLTRB(
                              9.0,
                              16.0,
                              9.0,
                              0.0,
                            ),

                            // child: Container(
                            //   height: 140,
                            //   color: Colors.black,
                            //   child: Stack(
                            //     children: [
                            //       Positioned(
                            //           left: 20,
                            //           top: 0,
                            //           child: AnimatedBuilder(
                            //               animation:
                            //                   pirated_logo_animation,
                            //               builder: (context, child) {
                            //                 return Image.asset(
                            //                   "assets/pirated_square.png",
                            //                   height:
                            //                       pirated_logo_animation
                            //                           .value,
                            //                   color: Colors.white,
                            //                 );
                            //               })),
                            //       Center(
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(
                            //               top: 24.0, left: 24, right: 24),
                            //           child: Text(
                            //             "This is a pirated app. Do not use this. It may have security issues.",
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 18),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          )
                              : Container(),
                          buildHomeCarouselSlider(context),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              18.0,
                              10.0,
                              18.0,
                              10.0,
                            ),
                            child: buildHomeMenuRow1(context),
                          ),
                          // buildHomeBannerOne(context),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              18.0,
                              10.0,
                              18.0,
                              10.0,
                            ),
                            child: buildHomeMenuRow2(context),
                          ),
                        ]),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              18.0,
                              20.0,
                              18.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .home_screen_featured_categories,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 154,
                          child: buildHomeFeaturedCategories(context),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            color: MyTheme.accent_color,
                            child: Stack(
                              children: [
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset("assets/background_1.png")
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 18.0, left: 18.0),
                                      child: Text(
                                        AppLocalizations
                                            .of(context)
                                            .home_screen_featured_products,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    buildHomeFeatureProductHorizontalList()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            buildHomeBannerTwo(context),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              18.0,
                              18.0,
                              20.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations
                                      .of(context)
                                      .home_screen_all_products,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                buildHomeAllProducts2(context),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: buildProductLoadingContainer())
              ],
            )),
      ),
    );
  }

  Widget buildHomeAllProducts(context) {

    return GridView.builder(
      // 2
      //addAutomaticKeepAlives: true,
      itemCount: 10,
      controller: _allProductScrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.618),
      padding: EdgeInsets.all(16.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // 3
        return Card(
          elevation: 20,
          shadowColor: Colors.grey.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/app_logo.png"),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text("AAA"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildHomeAllProducts2(context) {
    return GridView.builder(
      // 2
      //addAutomaticKeepAlives: true,
      itemCount: 10,
      controller: _allProductScrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.618),
      padding: EdgeInsets.all(16.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return MaterialButton(

          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return ProductDetails();
                }));
          },
          child: Card(
            elevation: 20,
            shadowColor: Colors.grey.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(_featuredCategoryList[index]),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text("Product"),
                    Text("100\$"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    }

  Widget buildHomeFeaturedCategories(context) {
    return GridView.builder(
        padding:
        const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 20),
        scrollDirection: Axis.horizontal,
        controller: _featuredCategoryScrollController,
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            mainAxisExtent: 240.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Row(
                children: <Widget>[
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(6), right: Radius.zero),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.png',
                            image: _featuredCategoryList[index].toString(),
                            fit: BoxFit.cover,
                          ))),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Category",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style:
                        TextStyle(fontSize: 12, color: MyTheme.font_grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildHomeFeatureProductHorizontalList() {
    return SingleChildScrollView(
      child: MaterialButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return ProductDetails();
              }));
        },
        child: SizedBox(
          height: 248,
          child:ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_featuredCategoryList[index]),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text("Product"),
                          Text("100\$"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  Widget buildHomeMenuRow1(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 90,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/todays_deal.png")),
                  ),
                  Text(AppLocalizations
                      .of(context)
                      .home_screen_todays_deal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 90,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/flash_deal.png")),
                  ),
                  Text(AppLocalizations
                      .of(context)
                      .home_screen_flash_deal,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildHomeMenuRow2(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CategoryList(
                  is_top_category: true,
                );
              }));
            },
            child: Container(
              height: 90,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3 - 4,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/top_categories.png")),
                  ),
                  Text(
                    AppLocalizations
                        .of(context)
                        .home_screen_top_categories,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(132, 132, 132, 1),
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 14.0,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Filter(
                  selected_filter: "brands",
                );
              }));
            },
            child: Container(
              height: 90,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3 - 4,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/brands.png")),
                  ),
                  Text(AppLocalizations
                      .of(context)
                      .home_screen_brands,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 14.0,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 90,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3 - 4,
              decoration: BoxDecorations.buildBoxDecoration_1(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/top_sellers.png")),
                  ),
                  Text(AppLocalizations
                      .of(context)
                      .home_screen_top_sellers,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHomeCarouselSlider(context) {
    if (_isCarouselInitial && _carouselImageList.length == 0) {
      return Padding(
          padding:
          const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_carouselImageList.length > 0) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 338 / 140,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInExpo,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current_slider = index;
              });
            }),
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 0, bottom: 20),
                child: Stack(
                  children: <Widget>[
                    Container(
                      //color: Colors.amber,
                        width: double.infinity,
                        decoration: BoxDecorations.buildBoxDecoration_1(),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder_rectangle.png',
                              image: i,
                              height: 140,
                              fit: BoxFit.cover,
                            ))),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _carouselImageList.map((url) {
                          int index = _carouselImageList.indexOf(url);
                          return Container(
                            width: 7.0,
                            height: 7.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current_slider == index
                                  ? MyTheme.white
                                  : Color.fromRGBO(112, 112, 112, .3),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      );
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations
                    .of(context)
                    .home_screen_no_carousel_image_found,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildHomeBannerOne(context) {
    if (_isBannerOneInitial && _bannerOneImageList.length == 0) {
      return Padding(
          padding:
          const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 20),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_bannerOneImageList.length > 0) {
      return Padding(
        padding: app_language_rtl.$
            ? const EdgeInsets.only(right: 9.0)
            : const EdgeInsets.only(left: 9.0),
        child: CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 270 / 120,
              viewportFraction: .75,
              initialPage: 0,
              padEnds: false,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current_slider = index;
                });
              }),
          items: _bannerOneImageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, right: 9, top: 20.0, bottom: 20),
                  child: Container(
                    //color: Colors.amber,
                      width: double.infinity,
                      decoration: BoxDecorations.buildBoxDecoration_1(),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder_rectangle.png',
                            image: i,
                            fit: BoxFit.cover,
                          ))),
                );
              },
            );
          }).toList(),
        ),
      );
    } else if (!_isBannerOneInitial && _bannerOneImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations
                    .of(context)
                    .home_screen_no_carousel_image_found,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  Widget buildHomeBannerTwo(context) {
    if (_isBannerTwoInitial && _bannerTwoImageList.length == 0) {
      return Padding(
          padding:
          const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 10),
          child: ShimmerHelper().buildBasicShimmer(height: 120));
    } else if (_bannerTwoImageList.length > 0) {
      return Padding(
        padding: app_language_rtl.$
            ? const EdgeInsets.only(right: 9.0)
            : const EdgeInsets.only(left: 9.0),
        child: CarouselSlider(
          options: CarouselOptions(
              aspectRatio: 270 / 120,
              viewportFraction: 0.7,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.easeInExpo,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current_slider = index;
                });
              }),
          items: _bannerTwoImageList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, right: 9, top: 20.0, bottom: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecorations.buildBoxDecoration_1(),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder_rectangle.png',
                            image: i,
                            fit: BoxFit.fill,
                          ))),
                );
              },
            );
          }).toList(),
        ),
      );
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
                AppLocalizations
                    .of(context)
                    .home_screen_no_carousel_image_found,
                style: TextStyle(color: MyTheme.font_grey),
              )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      elevation: 20,
      flexibleSpace:
      // IconButton(onPressed: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => CheckoutFlow(geideaPublicKey, geideaApiPassword)),
      //   );
      // }, icon: Icon(Icons.ac_unit_rounded)),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: MyTheme.accent_color.withOpacity(0.9),
              image: DecorationImage(
                image: AssetImage("assets/background_1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 22, left: 18, right: 18),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Filter();
                  }));
                },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        buildHomeSearchBox(context),
                      ],

                ),
                  ),
              ),
            ),
      ),
    );
  }

  buildHomeSearchBox(BuildContext context) {
    return Container(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: MyTheme.white.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations
                    .of(context)
                    .home_screen_search,
                style: TextStyle(fontSize: 13.0, color: MyTheme.textfield_grey),
              ),
              Image.asset(
                'assets/search.png',
                height: 16,
                //color: MyTheme.dark_grey,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildProductLoadingContainer() {
    return Container(
      height: _showAllLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalAllProductData == _allProductList.length
            ? AppLocalizations
            .of(context)
            .common_no_more_products
            : AppLocalizations
            .of(context)
            .common_loading_more_products),
      ),
    );
  }
}
