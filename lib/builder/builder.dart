import 'package:build/build.dart';
import 'package:easy_events/builder/module_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder moduleBuilder(BuilderOptions options) => LibraryBuilder(ModuleGenerator(),
    generatedExtension: '.internal_invalid.dart');

Builder moduleWriteBuilder(BuilderOptions options) =>
    LibraryBuilder(ModuleWriterGenerator(),
        generatedExtension: '.internal.dart');
