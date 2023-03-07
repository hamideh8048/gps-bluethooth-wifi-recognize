import 'package:flutter/material.dart';

Widget routingToCompanyWidget(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Color(0xff3478F2),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35, // Image radius
                  backgroundImage: AssetImage("assets/images/piece_of_map.png"),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("شرکت نو اندیش",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text("شهرک غرب، بلوار فلامک کوچه زرفشان پلاک ۳",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1.2, color: Colors.black12),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset("assets/images/map_vector.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                Text("مسیریابی تا شرکت",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 14
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 22,
                  width: 22,
                  child: Image.asset("assets/images/location.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset("assets/images/airdrop.png", fit: BoxFit.fill),
                ),
              ],
            )
          ],
        )
    ),
  );
}