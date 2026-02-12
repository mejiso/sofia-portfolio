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

class _AutoPlayVideoState extends State<AutoPlayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      ('assets/nodal.mp4'),
    )
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        _controller.play(); 
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

class LocalImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/nodal.png',
      width: 280, 
      height: 280,
      fit: BoxFit.cover, 
    );
  }
}

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sofia Erykah Mejia Portfolio'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(
                'hi, i am sofia',
                speed: const Duration(milliseconds: 80),
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text('mejiso.dev@gmail.com',
              style: TextStyle(fontStyle: FontStyle.italic)),
          const SizedBox(height: 12),
          Text(
            'CS Major @ UCF | Data Analyst & Researcher @ Limbitless Solutions | Undergraduate Research Assistant @ UCF College of Engineering + Computer Science',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          Text(
            'languages:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
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
          const SizedBox(height: 24),
          Text(
            'skills:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
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
          const SizedBox(height: 32),
          const TypingSectionHeader(text: 'my projects...'),
          const SizedBox(height: 12),

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
          const SizedBox(height: 50),
          Center(
            child: SizedBox(
              width: 700,
              child: AutoPlayVideo(
                videoUrl: 'https://www.youtube.com/watch?v=ZJSIYxBx7A8',
              ),
            ),
          ),


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

          const SizedBox(height: 32),
          const TypingSectionHeader(text: 'my experience...'),
          const SizedBox(height: 12),

  
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


class HoverCard extends StatefulWidget {
  final Widget child;
  const HoverCard({super.key, required this.child});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: isHovered
            ? Matrix4.translationValues(0, -6, 0) 
            : Matrix4.identity(),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(isHovered ? 0.18 : 0.08),
              blurRadius: isHovered ? 22 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

class TypingSectionHeader extends StatelessWidget {
  final String text;

  const TypingSectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
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

class _ProjectCard extends StatelessWidget {
  final String title;
  final String tools;
  final String desc;

  const _ProjectCard({
    required this.title,
    required this.tools,
    required this.desc,
  });

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
