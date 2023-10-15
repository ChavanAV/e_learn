import 'package:flutter/material.dart';

import '../../../method_provider/methods.dart';

class DocumentCard extends StatelessWidget {
  final String documentName;
  final String documentUrl;
  final String documentType;
  final Color color;
  const DocumentCard(
      {super.key,
      required this.documentName,
      required this.color,
      required this.documentUrl,
      required this.documentType});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        MethodProvider().openDocument(documentUrl);
      },
      style: ListTileStyle.list,
      leading: Container(
        alignment: Alignment.center,
        width: 43,
        height: 40,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Text(documentType,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
      ),
      title: Text(documentName),
    );
  }
}
