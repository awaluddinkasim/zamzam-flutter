import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamzam/shared/services/dio.dart';
import 'package:zamzam/shared/utils.dart';
import 'package:zamzam/shared/widgets/input_label.dart';
import 'package:zamzam/shared/states/auth.dart';

class UploadModal extends ConsumerStatefulWidget {
  const UploadModal({super.key, required this.order});

  final Map order;

  @override
  ConsumerState<UploadModal> createState() => _UploadModalState();
}

class _UploadModalState extends ConsumerState<UploadModal> {
  final nominal = TextEditingController();

  File? img;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      img = File(image.path);
    });
  }

  Future upload() async {
    final navigator = Navigator.of(context);
    final token = ref.read(authProvider)!.token;

    FormData data = FormData.fromMap({
      "order_id": widget.order['id'],
      "nominal": nominal.text,
      "bukti": await MultipartFile.fromFile(img!.path),
    });

    Response response = await Request.post('upload', data, token: token);
    if (response.statusCode == 200) {
      navigator.pop();
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InputLabel(label: "Nominal"),
            TextFormField(
              controller: nominal,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 8,
                ),
                prefixText: "Rp. ",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const InputLabel(label: "Pilih gambar"),
            Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                borderRadius: BorderRadius.circular(12),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  padding: const EdgeInsets.all(6),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                      child: img != null ? Image.file(File(img!.path)) : const Text("Tap disini"),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FilledButton.tonal(
              onPressed: () {
                loading(context);
                upload();
              },
              child: const Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
