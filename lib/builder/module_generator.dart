import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:easy_events/annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'collector.dart';
import 'writer.dart';

class ModuleWriterGenerator extends GeneratorForAnnotation<AutoBlock> {
  Collector collector() {
    return ModuleGenerator.collector;
  }

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return Writer(collector()).write();
  }
}

class ModuleGenerator extends GeneratorForAnnotation<AutoMethod> {
  static Collector collector = Collector();

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    collector.collect(element, annotation, buildStep);
    return null;
  }
}
