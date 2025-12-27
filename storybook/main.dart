import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

// Stories imports
import 'stories/app_button_story.dart';
import 'stories/electrical_node_widget_story.dart';

void main() {
  runApp(const StorybookApp());
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'Core/AppButton/Primary',
      stories: [
        ...appButtonStories,
        ...electricalNodeWidgetStories,
      ],
    );
  }
}
