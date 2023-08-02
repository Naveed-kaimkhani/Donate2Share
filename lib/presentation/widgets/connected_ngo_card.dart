import 'package:donation_app/domain/models/user_model.dart';
import 'package:donation_app/presentation/widgets/ngo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/ngos_list_provider.dart';

class ConnectedNGOCard extends StatelessWidget {
  const ConnectedNGOCard({
    super.key,
    // required this.NgoList,
  });

  // final List<UserModel>? NgoList;

  @override
  Widget build(BuildContext context) {
    List<UserModel>? NgoList =
        Provider.of<NgoListProvider>(context, listen: false).ngos;
    return SizedBox(
        height: 90.h,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: NgoList!.length,
            itemBuilder: (context, index) {
              return NgoList.isEmpty
                  ? Text("No Ngo Found")
                  : NGOCard(
                      url: NgoList[index].profileImage!,
                      name: NgoList[index].name!,
                    );
            }));
  }
}
