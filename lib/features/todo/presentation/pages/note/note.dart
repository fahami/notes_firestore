import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/core/util/utils.dart';
import 'package:share_plus/share_plus.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteDetailScreen({Key? key, this.id, this.isNew = false}) : super(key: key);
  final String? id;
  final bool isNew;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();
  bool isAction = false;
  Color selectedColor = Colors.white;
  @override
  void initState() {
    _titleController.text = widget.isNew ? "" : "Dear Diary";
    _contentController.text = widget.isNew
        ? ""
        : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    super.initState();
  }

  final colors = [
    Colors.white,
    ThemeColor.accentColor,
    ThemeColor.greenish,
    ThemeColor.pinky,
    ThemeColor.primaryColor,
  ];

  List<Widget> _buildAction() {
    return isAction
        ? [
            BuildSwatch(
              colors: colors,
              selectColor: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
            const DeleteButton(),
            SaveButton(
                contentController: _contentController, isNew: widget.isNew),
          ]
        : [Container()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeColor.typography),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: ThemeColor.typography,
            ),
            onPressed: () => Share.share(_contentController.text),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: "Judul",
                  border: InputBorder.none,
                  hintStyle: ThemeText.alternativeStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: selectedColor.computeLuminance() > 0.5
                          ? ThemeColor.typography
                          : Colors.white)),
              style: ThemeText.alternativeStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: selectedColor.computeLuminance() > 0.5
                      ? ThemeColor.typography
                      : Colors.white),
            ),
            Text(
              widget.isNew
                  ? simpleDate(DateTime.now().toIso8601String())
                  : "Selasa, 17 November 2022 • 320 Karakter",
              style: ThemeText.captionStyle.copyWith(
                  color: selectedColor.computeLuminance() > 0.5
                      ? ThemeColor.typography
                      : Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  TextFormField(
                    controller: _contentController,
                    style: ThemeText.captionStyle.copyWith(
                        color: selectedColor.computeLuminance() > 0.5
                            ? ThemeColor.typography
                            : Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tulis sesuatu...",
                      hintStyle: ThemeText.captionStyle.copyWith(
                          color: selectedColor.computeLuminance() > 0.5
                              ? ThemeColor.typography
                              : Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.easeOutCirc,
                duration: const Duration(seconds: 2),
                child: Column(
                  children: _buildAction(),
                )),
            ListTile(
              title: Text(
                widget.isNew
                    ? simpleDate(DateTime.now().toIso8601String())
                    : "Selasa, 17 November 2022 • 320 Karakter",
                style:
                    ThemeText.captionStyle.copyWith(color: ThemeColor.caption),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    isAction = !isAction;
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                  color: ThemeColor.typography,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.isNew,
    required TextEditingController contentController,
  })  : _contentController = contentController,
        super(key: key);

  final bool isNew;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.save,
        color: ThemeColor.typography,
      ),
      title: Text(
        "Simpan",
        style: ThemeText.bodyStyle,
      ),
      onTap: () {
        if (isNew) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context, _contentController.text);
        }
      },
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.delete,
        color: ThemeColor.typography,
      ),
      title: Text(
        "Hapus",
        style: ThemeText.bodyStyle,
      ),
      onTap: () {
        Navigator.pop(context, null);
      },
    );
  }
}

class BuildSwatch extends StatelessWidget {
  const BuildSwatch({
    Key? key,
    required this.colors,
    required this.selectColor,
  }) : super(key: key);

  final List<Color> colors;
  final ValueChanged<Color> selectColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: InkWell(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors[index].computeLuminance() > 0.5
                        ? ThemeColor.disabled
                        : Colors.white,
                    width: 2,
                  ),
                ),
              ),
              onTap: () => selectColor(colors.elementAt(index)),
            ),
          );
        },
      ),
    );
  }
}
