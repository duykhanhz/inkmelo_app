import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTitle extends StatelessWidget {
  final String title;
  final String bookUrl;
  final String author;
  final int price;
  final String rating;
  final int totalRating;
  const BookTitle({super.key, required this.title, required this.bookUrl, required this.author, required this.price, required this.rating, required this.totalRating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  )
                ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    bookUrl,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 4,),
                  Text("By: $author",
                    style: Theme.of(context).textTheme.labelMedium,),
                  SizedBox(height: 5,),
                  Text("Price: $price", style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.secondary),),
                  Row(children: [
                    SvgPicture.asset("assets/Icons/star.svg"),
                    Text(
                      rating,
                      style: Theme.of(context).textTheme.bodyMedium,),
                    Text(
                      "($totalRating ratings)",
                      style: Theme.of(context).textTheme.labelMedium,),
                  ],)
                ],))
            ],
          ),
        ),
      ),
    );
  }
}