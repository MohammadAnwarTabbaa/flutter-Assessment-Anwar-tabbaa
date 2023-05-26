import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assessment_anwar_tabbaa/modals/NFT.dart';
import 'package:flutter_assessment_anwar_tabbaa/screens/nft_reatil.dart';
import 'package:http/http.dart' as http;

class NFTListPage extends StatefulWidget {
  @override
  _NFTListPageState createState() => _NFTListPageState();
}

class _NFTListPageState extends State<NFTListPage> {
  List<NFT> nfts = [];
  int currentPage = 1;
  int itemsPerPage = 10;
  bool isLoading = false;
  bool isAllDataLoaded = false;

  Future<void> fetchNFTs() async {
    if (isLoading || isAllDataLoaded) return;

    setState(() {
      isLoading = true;
    });

    try {
      final url =
          'https://api.coingecko.com/api/v3/nfts/list?page=$currentPage&per_page=$itemsPerPage';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        // print(data);
        List<NFT> fetchedNFTs = [];
        for (var item in data) {
          print(item);
          final nft = NFT(
            // imageUrl: item['image_url'],
            name: item['name'],
            // description: item['description'],
            symbol: item['symbol'],
            // price: double.parse(item['price'].toString()),
          );
          fetchedNFTs.add(nft);
        }
        print(fetchedNFTs);
        setState(() {
          nfts.addAll(fetchedNFTs);
          currentPage++;
          isLoading = false;
          if (fetchedNFTs.length < itemsPerPage) {
            isAllDataLoaded = true;
          }
        });
      } else {
        print('Failed to fetch NFTs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNFTs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFT List'),
      ),
      body: ListView.builder(
        itemCount: nfts.length + 1, // +1 for the loading indicator
        itemBuilder: (context, index) {
          if (index < nfts.length) {
            return ListTile(
              title: Text(nfts[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NFTRetailPage(nft: nfts[index]),
                  ),
                );
              },
            );
          } else if (index == nfts.length && !isAllDataLoaded) {
            return ListTile(
              title: Center(child: CircularProgressIndicator()),
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: () {
          fetchNFTs();
        },
      ),
    );
  }
}
