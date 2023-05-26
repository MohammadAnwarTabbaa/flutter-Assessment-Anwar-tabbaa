import 'package:flutter/material.dart';
import 'package:flutter_assessment_anwar_tabbaa/modals/NFT.dart';
import 'package:flutter_assessment_anwar_tabbaa/widget/comment_section.dart';

class NFTRetailPage extends StatelessWidget {
  final NFT nft;

  NFTRetailPage({required this.nft});

  // String getLargeImageUrl() {
  //   // Modify the URL to get the larger image dimensions
  //   return nft.imageUrl.replaceFirst('/small/', '/large/');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nft.name),
      ),
      body: Column(
        children: [
          // Image.network(getLargeImageUrl()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${nft.name}'),
                // Text('Description: ${nft.description}'),
                Text('Symbol: ${nft.symbol}'),
                // Text('Price: \$${nft.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          CommentSection()
        ],
      ),
    );
  }
}
