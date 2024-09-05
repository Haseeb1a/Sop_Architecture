import 'package:flutter/material.dart';

import '../../../../../../general/utils/appcolors.dart';
import '../../../../../../general/utils/text_styles.dart';
import '../../../../data/model/user_model.dart';

class UserCardItem extends StatelessWidget {
  final UserModel user;
  const UserCardItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1,
        color: AppColors.white,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          // leading: CircleAvatar(
          //   radius: 30,
          //   backgroundImage: Image.network(
          //     user.image,
          //     fit: BoxFit.cover,
          //   ).image,
          // ),
          title: AppStyles.normalText(
              title: user.name,
              size: 15,
              color: AppColors.dark,
              fontWeight: FontWeight.w600),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mqSize.height * 0.007,
              ),
              AppStyles.normalText(
                  title: 'Age ${user.age}',
                  size: 15,
                  color: AppColors.dark,
                  fontWeight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}
