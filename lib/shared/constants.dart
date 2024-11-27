import 'package:flutter/widgets.dart';

import 'extensions.dart';
import 'package:hugeicons/hugeicons.dart';

/// Set breakpoints for different media
enum Breakpoints {
	mobile(767), tablet(1024), desktop(2048);
	final int maxWidth;
	const Breakpoints(this.maxWidth);

	static Breakpoints media(double width) => switch(width) {
			> 0 && <=767 => mobile,
			> 767 && <= 1024 => tablet,
			_ => desktop
		};
}
final radius6 =  BorderRadius.circular(6);

const orgIcon = HugeIcons.strokeRoundedLayers01;
const projectIcon = HugeIcons.strokeRoundedFolder03;
const featureIcon = HugeIcons.strokeRoundedKeyframeLeft;
const issueIcon = HugeIcons.strokeRoundedNavigation03;
const taskIcon = HugeIcons.strokeRoundedMessenger;
