import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:aerocode/controllers/backend_controller.dart';
import 'package:aerocode/controllers/space_controller.dart';
import 'package:aerocode/controllers/code_controller.dart';

import 'constants.dart';
import 'components/dropdown_selector.dart';

import 'common/themes.dart';

import 'package:aerocode/utils/snackbar.dart';
// import 'common/snippets.dart';

const _defaultLanguage = 'dart';
// const _defaultTheme = 'shades-of-purple';
const _defaultTheme = 'aerocode';

const _defaultAnalyzer = DefaultLocalAnalyzer();
final _dartAnalyzer = DartPadAnalyzer();

const toggleButtonColor = Color.fromARGB(124, 255, 255, 255);
const toggleButtonActiveColor = Colors.white;

final _analyzers = [_defaultAnalyzer, _dartAnalyzer];

final _backendCtr = Get.put(backendController());
final _codeCtr = Get.put(codeController());
final _spaceCtr = Get.put(spaceController());

class Space extends StatefulWidget {

  Space({required this.spaceID, required this.code});

  final String spaceID;
  final String code;
  // String spaceID = '453443';

  @override
  State<Space> createState() => _SpaceState();
}


class _SpaceState extends State<Space> {

  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();

  String _language = _defaultLanguage;
  String _theme = _defaultTheme;
  AbstractAnalyzer _analyzer = _defaultAnalyzer;

  bool _showNumbers = true;
  bool _showErrors = true;
  bool _showFoldingHandles = true;

  final _codeFieldFocusNode = FocusNode();

  late final _codeController = CodeController(
    language: builtinLanguages[_language],
    namedSectionParser: const BracketsStartEndNamedSectionParser(),
    text: widget.code,
  );

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (_, constraints)
      {
        return Title(
          title: 'Space',
          color: Colors.black,
          child: Builder(
            builder: (context) {
              if(constraints.maxWidth > 1056) {
                return Scaffold(
                  backgroundColor: themes[_theme]?['root']?.backgroundColor,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.black,
                    title: Row(
                      children: [
              
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Text(
                            "{aerocode}",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              ),
                            ),
                        ),
              
                        // const SizedBox(width: 30.0),
              
                        const Text('Space'),
                        const SizedBox(width: 10.0),
                        Text('#${widget.spaceID}',
                          style: const TextStyle(
                            backgroundColor: Colors.white,
                            color: Color(0xff610094),
                          ),
                        ),
                      ],
                    ),

                    actions: [
                      
                      IconButton(
                        onPressed: (){
                          _codeCtr.updateContent(newContent: _codeController.text, spaceID: widget.spaceID);
                          showSnackbar(context, "Update sent to server", bgColor: Colors.white, kDuration: const Duration(seconds: 2));
                        }, 
                        icon: const Icon(Icons.check)
                      ),
                  
                      IconButton(
                        onPressed: () async {
                          final newCode = await _codeCtr.getCode(spaceID: widget.spaceID);
                          setState(() {
                            _codeController.text = newCode;
                          });
                          showSnackbar(context, "Space refreshed", bgColor: Colors.white, kDuration: const Duration(seconds: 2));
                        }, 
                        icon: const Icon(Icons.refresh)
                      ),
                  
                      IconButton(
                        color: _showNumbers ? toggleButtonActiveColor : toggleButtonColor,
                        onPressed: () => setState(() {
                          _showNumbers = !_showNumbers;
                          showSnackbar(context, _showNumbers ? "Enabled numbering" : "Disabled numbering", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                        }),
                        icon: const Icon(Icons.numbers),
                      ),
                  
                      IconButton(
                        color: _showErrors ? toggleButtonActiveColor : toggleButtonColor,
                        onPressed: () => setState(() {
                          _showErrors = !_showErrors;
                          showSnackbar(context, _showErrors ? "Enabled error hint" : "Disabled error hint", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                        }),
                        icon: const Icon(Icons.cancel),
                      ),
                  
                      IconButton(
                        color: _showFoldingHandles
                            ? toggleButtonActiveColor
                            : toggleButtonColor,
                        onPressed: () => setState(() {
                          _showFoldingHandles = !_showFoldingHandles;
                          showSnackbar(context, _showFoldingHandles ? "Enabled folding handles" : "Disabled folding handles", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                        }),
                        icon: const Icon(Icons.chevron_right),
                      ),
                  
                      const SizedBox(width: 20),
                      DropdownSelector(
                        onChanged: _setLanguage,
                        icon: Icons.code,
                        value: _language,
                        values: languageList,
                      ),
                  
                      const SizedBox(width: 20),
                      DropdownSelector<AbstractAnalyzer>(
                        onChanged: _setAnalyzer,
                        icon: Icons.bug_report,
                        value: _analyzer,
                        values: _analyzers,
                        itemToString: (item) => item.runtimeType.toString(),
                      ),
                  
                      const SizedBox(width: 20),
                      DropdownSelector(
                        onChanged: _setTheme,
                        icon: Icons.color_lens,
                        value: _theme,
                        values: themeList,
                      ),
                  
                      const SizedBox(width: 20),
                    ],
                  ),
                  body: ListView(
                    children: [
                      CodeTheme(
                        data: CodeThemeData(styles: themes[_theme]),
                        child: CodeField(
                          focusNode: _codeFieldFocusNode,
                          controller: _codeController,
                          textStyle: const TextStyle(fontFamily: 'IBM Plex Mono'),
                          gutterStyle: GutterStyle(
                            textStyle: const TextStyle(
                              color: Colors.purple,
                            ),
                            showLineNumbers: _showNumbers,
                            showErrors: _showErrors,
                            showFoldingHandles: _showFoldingHandles,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              else {
                return Scaffold(
                  backgroundColor: themes[_theme]?['root']?.backgroundColor,
                  body: SliderDrawer(
                    appBar: AppBar(
                      // automaticallyImplyLeading: false,
                      backgroundColor: Colors.black,
                      title: const Text("{aerocode}"),
                      leading: IconButton(
                        onPressed: (){
                          _key.currentState?.toggle();
                        }, 
                        icon: const Icon(Icons.menu)
                      ),
                    ),
                    slider: ListView(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                            "{aerocode}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        const SizedBox(
                          height: 50,
                        ),
                        
                        TextButton(
                          onPressed: (){
                            _codeCtr.updateContent(newContent: _codeController.text, spaceID: widget.spaceID);
                            showSnackbar(context, "Update sent to server", bgColor: Colors.white, kDuration: const Duration(seconds: 2));
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.check, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        TextButton(
                          onPressed: () async {
                            final newCode = await _codeCtr.getCode(spaceID: widget.spaceID);
                            setState(() {
                              _codeController.text = newCode;
                              showSnackbar(context, "Space refreshed", bgColor: Colors.white, kDuration: const Duration(seconds: 2));
                            });
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const[
                              Icon(Icons.refresh, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Refresh',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                    
                        TextButton(
                          onPressed: () => setState(() {
                            _showNumbers = !_showNumbers;
                            showSnackbar(context, _showNumbers ? "Enabled numbering" : "Disabled numbering", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.numbers, color:_showNumbers ? toggleButtonActiveColor : toggleButtonColor),
                              const SizedBox(width: 10),
                              const Text(
                                'Numbers',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                    
                        TextButton(
                          onPressed: () => setState(() {
                            _showErrors = !_showErrors;
                            showSnackbar(context, _showErrors ? "Enabled error hint" : "Disabled error hint", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel, color: _showErrors ? toggleButtonActiveColor : toggleButtonColor),
                              const SizedBox(width: 10),
                              const Text(
                                'Errors',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                    
                        TextButton(
                          onPressed: () => setState(() {
                            _showFoldingHandles = !_showFoldingHandles;
                            showSnackbar(context, _showFoldingHandles ? "Enabled folding handles" : "Disabled folding handles", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chevron_right, color: _showFoldingHandles ? toggleButtonActiveColor : toggleButtonColor),
                              const SizedBox(width: 10),
                              const Text(
                                'Folding Handles',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                    
                        const SizedBox(width: 20),

                        Center(
                          child: DropdownSelector(
                            onChanged: _setLanguage,
                            icon: Icons.code,
                            value: _language,
                            values: languageList,
                          ),
                        ),
                    
                        const SizedBox(width: 20),

                        Center(
                          child: DropdownSelector<AbstractAnalyzer>(
                            onChanged: _setAnalyzer,
                            icon: Icons.bug_report,
                            value: _analyzer,
                            values: _analyzers,
                            itemToString: (item) => item.runtimeType.toString(),
                          ),
                        ),
                    
                        const SizedBox(width: 20),
                        
                        Center(
                          child: DropdownSelector(
                            onChanged: _setTheme,
                            icon: Icons.color_lens,
                            value: _theme,
                            values: themeList,
                          ),
                        ),
                      ],
                    ),
                    key: _key,
                    child: ListView(
                      children: [
                        CodeTheme(
                          data: CodeThemeData(styles: themes[_theme]),
                          child: CodeField(
                            focusNode: _codeFieldFocusNode,
                            controller: _codeController,
                            textStyle: const TextStyle(fontFamily: 'IBM Plex Mono'),
                            gutterStyle: GutterStyle(
                              textStyle: const TextStyle(
                                color: Colors.purple,
                              ),
                              showLineNumbers: _showNumbers,
                              showErrors: _showErrors,
                              showFoldingHandles: _showFoldingHandles,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFieldFocusNode.dispose();

    for (final analyzer in _analyzers) {
      analyzer.dispose();
    }

    super.dispose();
  }

  void _setLanguage(String value) {
    setState(() {
      _language = value;
      _codeController.language = builtinLanguages[value];
      _analyzer = _defaultAnalyzer;
      showSnackbar(context, "Language changed", bgColor: Colors.white, kDuration: const Duration(seconds: 1));

      _codeFieldFocusNode.requestFocus();
    });
  }

  void _setAnalyzer(AbstractAnalyzer value) {
    setState(() {
      _codeController.analyzer = value;
      _analyzer = value;
      showSnackbar(context, "Analyzer changed", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
    });
  }

  void _setTheme(String value) {
    setState(() {
      _theme = value;
      _codeFieldFocusNode.requestFocus();
      showSnackbar(context, "Theme changed", bgColor: Colors.white, kDuration: const Duration(seconds: 1));
    });
  }
}

// Icon(Icons.chevron_right, color: _showFoldingHandles ? toggleButtonActiveColor : toggleButtonColor),