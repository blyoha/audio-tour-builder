import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../../../blocs/routing/routing_bloc.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final RoutingBloc _bloc;
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _init();

    _bloc = context.read<RoutingBloc>();
  }

  Future<void> _init() async {
    await _player.setLoopMode(LoopMode.off);
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutingBloc, RoutingState>(
      bloc: _bloc,
      listener: (context, state) async {
        if (state is RoutingInPlace) {
          final source = AudioSource.uri(
            Uri.parse(state.place.audioUri!),
            tag: MediaItem(
              id: state.place.key.toString(),
              title: state.place.title!,
            ),
          );

          await _player.setAudioSource(source);
          _player.play();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AudioTitle(player: _player),
            const SizedBox(height: 10.0),
            Controls(player: _player),
          ],
        ),
      ),
    );
  }
}

class AudioTitle extends StatelessWidget {
  final AudioPlayer player;

  const AudioTitle({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: player.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) {
          return const SizedBox.shrink();
        }
        final metadata = state!.currentSource!.tag as MediaItem;

        return Text(metadata.title);
      },
    );
  }
}

class Controls extends StatelessWidget {
  final AudioPlayer player;

  const Controls({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          onPressed: () {
            player.seek(player.position - const Duration(seconds: 10));
          },
          child: const Icon(Icons.replay_10_rounded),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            final processing = state?.processingState;
            final playing = state?.playing;

            if (processing == ProcessingState.completed) {
              player.stop();
              player.seek(Duration.zero);
            }

            if (!(playing ?? false)) {
              return MaterialButton(
                onPressed: player.play,
                child: const Icon(Icons.play_arrow_rounded),
              );
            } else if (processing != ProcessingState.completed) {
              return MaterialButton(
                onPressed: player.pause,
                child: const Icon(Icons.pause_rounded),
              );
            }

            return const Icon(Icons.play_arrow_rounded);
          },
        ),
        MaterialButton(
          onPressed: () {
            player.seek(player.position + const Duration(seconds: 10));
          },
          child: const Icon(Icons.forward_10_rounded),
        ),
      ],
    );
  }
}
