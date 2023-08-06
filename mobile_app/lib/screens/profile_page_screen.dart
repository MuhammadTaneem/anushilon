import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../Providers/package_provider.dart';
import '../services/google_sign_service.dart';
import 'package_detais_screen.dart';
import '../schema/package_schema.dart';
import '../utils/urtils.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  var email;
  var profileUrl;
  var name;
  late int balance =0;
  late bool loading = true;
  late GoogleAuthService googleAuth =  GoogleAuthService();




  getProfileData()  async {
    final LocalStorage storage = await getStorage();
    name = await storage.getItem('userDisplayName');
    email = await storage.getItem('userEmail');
    balance = await storage.getItem('balance')??0;
    profileUrl = await storage.getItem('userPhotoUrl');
    setState(() {
    loading = false;
    });
  }



  @override
  void initState() {
    super.initState();
    initializeDateFormatting('bn', null);

    // getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    // DateFormat dateFormat = DateFormat.yMMMd('bn');
    NumberFormat banglaNumberFormat = NumberFormat.decimalPattern('bn');
    List<PackageType> items = Provider.of<PackageProvider>(context, listen: false).getPackagesFromIdList();
    getProfileData();



    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("প্রোফাইল"),
        actions: [IconButton(onPressed: (){
          googleAuth.logout(context);
        }, icon: Icon(Icons.logout))],

      ),
      body: loading?
        SpinKitSpinningLines(
          color: Theme.of(context).colorScheme.secondary,
          size: 60.0,
        ):
        SingleChildScrollView(
          child: Column(
          children: [
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileUrl!=null?
                CachedNetworkImage(
                  imageUrl: profileUrl??'',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 80,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => SpinKitSpinningLines(
                    color: Theme.of(context).colorScheme.secondary,
                    size: 60.0,
                  ), // Show loading indicator
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/pp.png'), // Show alternative image on error
                  ),
                ):Container(),


              ],
            ),
            const Gap(20),
            Text(name??'', style: Theme.of(context).textTheme.headlineSmall),
            const Gap(5),
            Text("ইমেইল : ${email??''}"),
            Text("ব্যালেন্স :${banglaNumberFormat.format(balance)} টাকা",),
            // Text("ব্যালেন্স : 123 taka"),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(
                children: [



                  Container(
                    color:Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'আমার প্যাকেজ সমূহ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  )
,


                  // const Divider(thickness: .5),
                  //
                  // Text("আমার প্যাকেজ সমূহ",style: TextStyle(
                  //   fontSize: 17,
                  //   color: Theme.of(context).colorScheme.secondary
                  // ),),
                  // const Divider(thickness: .5),

                  // Text("আমার প্যাকেজ সমূহ",style: TextStyle(
                  //   fontSize: 14,
                  //   // color: Theme.of(context).colorScheme.secondary
                  // ),),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 100,
                        // crossAxisSpacing: 8,
                        // mainAxisSpacing: 8,
                      ),
                      itemCount: items.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // separatorBuilder: (BuildContext context, int index) => SizedBox(height: 1,),
                      itemBuilder: (BuildContext context, int index) {
                        PackageType package = items[index];
                        int expireIn = package.endDate.difference(package.startDate).inDays;
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackageDetailsWidget(package: package),
                              ),
                            );
                          },
                          child: Card(
                            elevation: .8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(package.name)),
                                  Text("মেয়াদঃ ${banglaNumberFormat.format(expireIn)} দিন"),
                                  Text("পরীক্ষা বাকিঃ  ${banglaNumberFormat.format(package.noOfExam-package.noOfExamDone)} টি")
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                  //   child: Text("পূর্ববর্তী পরীক্ষা সমূহ",style: TextStyle(
                  //       fontSize: 20,
                  //       color: Theme.of(context).colorScheme.secondary
                  //   ),),
                  // ),
                  SizedBox(height: 20,),
                  Container(
                    color:Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'পূর্ববর্তী পরীক্ষা সমূহ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: items.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 1,),
                    itemBuilder: (BuildContext context, int index) {
                      PackageType package = items[index];
                      int expireIn = package.endDate.difference(package.startDate).inDays;
                      // return ListTile(
                      //   title: Text(package.name),
                      //   subtitle: Text("$expireIn"),
                      //   // Add any other relevant information from the package
                      // );
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PackageDetailsWidget(package: package),
                              ),
                            );
                          },
                          child: Card(
                            elevation: .8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(package.name),
                                  Text("মেয়াদঃ $expireIn দিন"),
                                  Text("পরীক্ষা বাকিঃ  ${package.noOfExam-package.noOfExamDone} টি")
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),






                ],
              ),
            ),
          ],

      ),
        ),
    );
  }
}
