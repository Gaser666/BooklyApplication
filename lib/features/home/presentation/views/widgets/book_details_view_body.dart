import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_details_section.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/similar_books_section.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.7),
              child: Column(
                children: [
                  const CustomBookDetailsAppBar(),
                  BookDetailsSection(
                    bookModel: bookModel,
                  ),
                  const Expanded(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  const SimilarBooksSection(),
                ],
              ),
            )),
      ],
    );
  }
}
