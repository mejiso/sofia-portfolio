import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AutoPlayVideo extends StatefulWidget {
  final String videoUrl;

  const AutoPlayVideo({super.key, required this.videoUrl});

  @override
  State<AutoPlayVideo> createState() => _AutoPlayVideoState();
}

// portfolio nodal player
class _AutoPlayVideoState extends State<AutoPlayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      ('assets/nodal.mp4'),
    )
      ..setVolume(0) 
      ..setLooping(true) // loops
      ..initialize().then((_) {
        _controller.play(); // autoplay the video
        setState(() {});
      });
  }

  // release video memory, prevent mem leak
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // checks if video is init, if video not init then shows loading
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    // video is init, show the video
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

// stateless widget: image is not altered, no animation, etc
// widget for nodal
class LocalImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset( // custom image from assets folder
      'assets/nodal.png',
      width: 280, 
      height: 280,
      fit: BoxFit.cover, // fit into 280x280 box and preserve aspect ratio
    );
  }
}

// app entry point
void main() => runApp(const PortfolioApp());

// root application widget,configures global theme and settings
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // to remove debug banner
      debugShowCheckedModeBanner: false,
      title: 'Portfolio', // set title
      theme: ThemeData( // set theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily, // set custom font from GoogleFonts
      ),
      // init screen of app
      home: const HomePage(),
    );
  }
}

// main portfolio theme, stateless because UI is static
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // use static list to easily edit widgets (add on or delete)
    const languages = ['Python', 'C', 'Java', 'Flutter', 'HTML/CSS'];
    const skills = [
      'Data Analysis',
      'Large Language Models',
      'Vision Language Models',
      'Academic Research + Abstract Writing',
      'Rehabilitation + Assistive Technology',
      'Music Production',
      'Blender',
    ];

    return Scaffold(
      // set bg color for entire screen
      backgroundColor: Colors.white,
      // top bar title
      appBar: AppBar(
        title: const Text('Sofia Erykah Mejia Portfolio'),
      ),
      body: ListView(
        // sets universal padding around all content
        padding: const EdgeInsets.all(24),
        children: [
          // custom typewriter animation for intro header
          AnimatedTextKit(
            isRepeatingAnimation: false, // does not repeat
            animatedTexts: [
              // animated text
              TypewriterAnimatedText(
                'hi, i am sofia',
                speed: const Duration(milliseconds: 80), // speed
                textStyle: const TextStyle( // text style, font size and bold
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // another text for email
          const SizedBox(height: 6),
          const Text('mejiso.dev@gmail.com',
              style: TextStyle(fontStyle: FontStyle.italic)),
          const SizedBox(height: 12),
          // description
          Text(
            'CS Major @ UCF | Data Analyst & Researcher @ Limbitless Solutions | Undergraduate Research Assistant @ UCF College of Engineering + Computer Science',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          // languages header
          Text(
            'languages:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          // .map to turn const languages list into widgets
          const SizedBox(height: 12),
          Wrap( // wrap automatically wraps to next line
            spacing: 12,
            runSpacing: 12,
            children: languages
                .map(
                  (lang) => Chip(
                    label: Text(
                      lang,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
                .toList(),
          ),
          // skills header
          const SizedBox(height: 24),
          Text(
            'skills:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          // .map for skills
          const SizedBox(height: 12),
          Wrap( // wrap for auto wrapping to next line
            spacing: 12,
            runSpacing: 12,
            children: skills
                .map(
                  (s) => Chip(
                    label: Text(
                      s,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
                .toList(),
          ),
          // projects header
          const SizedBox(height: 32),
          const TypingSectionHeader(text: 'my projects...'),
          const SizedBox(height: 12),

          // hovercard stateful widget class for mouse hover animation
          // NODAL project #1
          HoverCard(
            child: _ProjectCard(
              title: 'Nodal: MIDI Controller & Audio Visualizer',
              tools:
                  'Tools: React, TypeScript, WebMIDI/Audio, MediaPipe, Canvas API',
              desc:
                  '》Engineered a full-stack physics-based MIDI controller with MediaPipe real-time hand tracking and a custom physics engine (Knight Hacks VIII, 3-member team)\n'
                  '》Rendered 15+ dynamic \'nodes\' at 60 FPS with optimized Canvas pipelines to record 100+ MIDI input per/sec and seamless DAW integration (Ableton Live, Logic, GarageBand).',
            ),
          ),
          const SizedBox(height: 50), // to add spacing between sections
          // box for video
          Center(
            child: SizedBox(
              width: 700, // control size here
              child: AutoPlayVideo(
                videoUrl: 'https://www.youtube.com/watch?v=ZJSIYxBx7A8',
              ),
            ),
          ),

          // Univesal Stats Project #2
          const SizedBox(height: 50),
          HoverCard(
            child: _ProjectCard(
              title: 'Universal Statistical Analysis Script',
              tools: 'Tools: Python, Pandas, MatPlotLib, NumPy',
              desc:
                  '》Developed a data analytics framework for clinical trial datasets, capable of processing CSV/Excel files with 50+ variables via RegEx parsing and DataFrame Tidying\n'
                  '》Achieved 75% faster analysis for statistical tests through reusable scripts and automated statistical testing.',
            ),
          ),

          // experience header
          const SizedBox(height: 32),
          const TypingSectionHeader(text: 'my experience...'),
          const SizedBox(height: 12),

          //reuse project card for experience titles
          // Limbitless
          HoverCard(
            child: _ProjectCard(
              title: 'Research & Data Analysis Intern',
              tools: 'Limbitless Solutions: August 2025 - Present',
              desc:
                  '》Conducted research on EMG-powered prosthetics and XR rehabilitation.\n'
                  '》Developed reusable Python scripts to normalize multi-cohort clinical trial datasets, improving testing efficiency by 75%.\n'
                  '》Wrote 50+ research articles and led music production for serious games.',
            ),
          ),
          // KRSP research
          HoverCard(
            child: _ProjectCard(
              title: 'Undergraduate Researcher - Vision Language Models',
              tools:
                  'University of Central Florida — Supervised by Ahmed Abdelrahman, PhD',
              desc:
                  '》Implemented a vision-language model (InternVL) to classify driver emotions across 3,000 dashcam videos.\n'
                  '》Used VQA pipelines to improve behavioral interpretation accuracy by 30%.',
            ),
          ),
          // KRSP research 2
          HoverCard(
            child: _ProjectCard(
              title: 'Undergraduate Researcher - Secure & Embedded LLM Systems',
              tools:
                  'University of Central Florida — Supervised by Chanhee Lee, PhD',
              desc:
                  '》Researched secure and fault-tolerant LLMs for embedded systems using RAG, knowledge graphs, and MLC-LLM tooling.',
            ),
          ),
        ],
      ),
    );
  }
}

// reusable wrappter to add hover animation to any child
//stateful because hover state changes the widget dynamically (not static)

class HoverCard extends StatefulWidget {
  final Widget child; // child widget will be wrapped
  const HoverCard({super.key, required this.child}); // requires child wdiget

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false; // bool to track if mouse on widget (hovering)

  @override
  Widget build(BuildContext context) {
    // switches cursor to pointer when hovering on widget to indicate its a dynamic object
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      // update hover state when mouse hovers
      onEnter: (_) => setState(() => isHovered = true),
      // reset state when mouse exits
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        // moves the widget slightly upward when mouse hoves
        transform: isHovered
            ? Matrix4.translationValues(0, -6, 0) 
            : Matrix4.identity(),
        // adds shadow to box when hovered with decoration
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(isHovered ? 0.18 : 0.08), // shadow color
              blurRadius: isHovered ? 22 : 10, // radius of shadow
              offset: const Offset(0, 8),
            ),
          ],
        ),
        // render
        child: widget.child,
      ),
    );
  }
}

// reusable animated typing class for typewriter effect
// this is used on subheaders/headers
class TypingSectionHeader extends StatelessWidget {
  final String text; // header text is being animated

  const TypingSectionHeader({super.key, required this.text}); // requires text string

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false, // does not loop, runs once
      animatedTexts: [
        // text style
        TypewriterAnimatedText(
          text,
          speed: const Duration(milliseconds: 60),
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// project card class, used multiple times for projects and experiences, reusable
class _ProjectCard extends StatelessWidget {
  final String title; // main heading
  final String tools; // subtitle
  final String desc; // description
  // requirements
  const _ProjectCard({
    required this.title,
    required this.tools,
    required this.desc,
  });
  // card layout
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, 
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              tools,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 8),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
