import 'package:flutter/scheduler.dart' show Ticker, TickerCallback, TickerProvider;

class CustomTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
