// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:inject_generator/inject_generator.dart' as _i2;
import 'package:json_serializable/builder.dart' as _i3;
import 'package:mobx_codegen/builder.dart' as _i4;
import 'package:source_gen/builder.dart' as _i5;
import 'package:build_config/build_config.dart' as _i6;
import 'dart:isolate' as _i7;
import 'package:build_runner/build_runner.dart' as _i8;
import 'dart:io' as _i9;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
      'inject_generator:inject_generator',
      [_i2.summarizeBuilder, _i2.generateBuilder],
      _i1.toDependentsOf('inject_generator'),
      hideOutput: false),
  _i1.apply('json_serializable:json_serializable', [_i3.jsonSerializable],
      _i1.toDependentsOf('json_serializable'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('mobx_codegen:mobx_generator', [_i4.storeGenerator],
      _i1.toDependentsOf('mobx_codegen'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('source_gen:combining_builder', [_i5.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: ['source_gen:part_cleanup']),
  _i1.applyPostProcess('source_gen:part_cleanup', _i5.partCleanup,
      defaultGenerateFor: const _i6.InputSet())
];
main(List<String> args, [_i7.SendPort sendPort]) async {
  var result = await _i8.run(args, _builders);
  sendPort?.send(result);
  _i9.exitCode = result;
}
