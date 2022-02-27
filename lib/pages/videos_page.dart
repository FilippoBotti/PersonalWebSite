import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_site/blocs/websiteBloc/website.dart';
import 'package:web_site/blocs/websiteBloc/website_states.dart';
import 'package:web_site/models/video.dart';
import 'package:web_site/pages/projects_page.dart';
import 'package:web_site/utility/constants.dart';
import 'package:web_site/utility/responsive.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key? key, required this.state}) : super(key: key);

  final WebsiteShowVideos state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: SingleChildScrollView(
              child: Column(children: [
            GestureDetector(
              onTap: () async {
                await launch("https://www.youtube.com/channel/${state.channel.videoId}");
              },
              child: ChannelBanner(
                channel: state.channel,
              ),
            ),
            Responsive(
              mobile: VideosGridView(
                videos: state.videos,
                crossAxisCount: 1,
                childAspectRatio: 1.4,
              ),
              mobileLarge: VideosGridView(
                videos: state.videos,
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              desktop: VideosGridView(
                videos: state.videos,
              ),
              tablet: VideosGridView(
                videos: state.videos,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              largeDesktop: VideosGridView(
                videos: state.videos,
                childAspectRatio: 1.4,
              ),
            )
          ])),
        ));
  }
}

class VideosGridView extends StatelessWidget {
  const VideosGridView({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.5,
    required this.videos,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List<YoutubeVideo> videos;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: Text("My Videos", style: Theme.of(context).textTheme.headline6!),
      ),
      GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) => VideoCard(
                video: videos[index],
              ))
    ]);
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required this.video,
  }) : super(key: key);

  final YoutubeVideo video;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6!),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Text(
                video.description!,
                maxLines: !Responsive.isDesktop(context)
                    ? Responsive.isMobile(context)
                        ? 3
                        : 4
                    : 5,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  height: 1.5,
                ),
              ),
            ),
          ),
          Row(children: [
            const Spacer(),
            TextButton(
                onPressed: () async {
                  await launch("https://www.youtube.com/watch?v=${video.videoId}");
                },
                child: const Text(
                  "Guarda ora",
                  style: TextStyle(color: primaryColor),
                )),
          ])
        ],
      ),
      padding: const EdgeInsets.all(defaultPadding),
      color: secondaryColor,
    );
  }
}

class ChannelBanner extends StatelessWidget {
  const ChannelBanner({Key? key, required this.channel}) : super(key: key);

  final YoutubeChannel channel;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: Responsive.isMobile(context) ? 2.5 : 3,
        child: Stack(fit: StackFit.expand, children: [
          Image.network(
            "https://junyanz.github.io/CycleGAN/images/teaser_high_res.jpg",
            fit: BoxFit.cover,
          ),
          Container(color: darkColor.withOpacity(0.66)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ingegnere per caso",
                      style: Responsive.isLargeDesktop(context)
                          ? Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white)
                          : Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                  !(Responsive.isMobile(context) || Responsive.isMobileLarge(context) )
                      ? Text(
                          channel.description,
                          style: Theme.of(context).textTheme.subtitle1!,
                        )
                      : Container(),
                  const Responsive(
                    desktop: SizedBox(
                      height: defaultPadding,
                    ),
                    mobile: SizedBox(
                      height: defaultPadding/2,
                    ),
                  ),
                  ProgressCounters(channel: channel),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  if (!(Responsive.isMobile(context) || Responsive.isMobileLarge(context) || Responsive.isTablet(context)))
                    ElevatedButton(
                        onPressed: () async {
                          await launch("https://www.youtube.com/channel/${channel.videoId}");
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding * 2,
                              vertical: defaultPadding),
                          backgroundColor: primaryColor,
                        ),
                        child: const Text(
                          "Explore now",
                          style: TextStyle(color: darkColor),
                        )),
                ]),
          )
        ]));
  }
}

class ProgressCounters extends StatelessWidget {
  const ProgressCounters({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final YoutubeChannel channel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            AnimatedProgressIndicator(
              text: channel.viewCount,
              finalValue: double.parse(channel.viewCount),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              'Views',
              style: Theme.of(context).textTheme.subtitle2!,
            ),
          ],
        ),
        SizedBox(width: defaultPadding,),
        Column(
          children: [
            AnimatedProgressIndicator(
              text: channel.subscriberCount,
              finalValue: double.parse(channel.viewCount),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              'Subs',
              style: Theme.of(context).textTheme.subtitle2!,
            ),
          ],
        ),
        SizedBox(width: defaultPadding,),
        Column(
          children: [
            AnimatedProgressIndicator(
              text: channel.videoCount,
              finalValue: double.parse(channel.viewCount),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              'Video',
              style: Theme.of(context).textTheme.subtitle2!,
            ),
          ],
        ),
      ],
    );
  }
}

class AnimatedProgressIndicator extends StatelessWidget {
  const AnimatedProgressIndicator({
    Key? key,
    required this.finalValue,
    required this.text,
  }) : super(key: key);

  final double finalValue;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: finalValue/10000),
            duration: Duration(seconds: 1),
            builder: (BuildContext context, double value, Widget? child) {
              return CircularProgressIndicator(
                value: value,
                color: primaryColor,
              );
            },
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 15,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!,
            )),
      ],
    );
  }
}
