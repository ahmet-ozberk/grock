import 'dart:developer';

import 'package:flutter/material.dart';

extension DeveloperExtension on Object {
  void get logger {
    log(this.toString(), name: this.runtimeType.toString());
  }

  void get printer {
    print(this.toString());
  }

  void get debugger {
    debugPrint(this.toString());
  }

  void get debuggerStack {
    debugPrintStack(label: this.toString());
  }

  void get debuggerDump {
    debugDumpApp();
  }

  void get debuggerDumpRenderTree {
    debugDumpRenderTree();
  }

  void get debuggerDumpLayerTree {
    debugDumpLayerTree();
  }
}