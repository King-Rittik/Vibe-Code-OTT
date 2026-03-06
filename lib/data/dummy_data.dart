import 'package:kr_ott/data/models/content_model.dart';

class DummyData {
  // Video URLs
  static const String _video1 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
  static const String _video2 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
  static const String _video3 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4';
  static const String _video4 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4';
  static const String _video5 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4';
  static const String _video6 =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';

  // Thumbnail URLs (using picsum.photos with specific seeds for consistency)
  static String _thumb(int seed, {int w = 280, int h = 420}) =>
      'https://picsum.photos/seed/$seed/$w/$h';
  static String _backdrop(int seed) =>
      'https://picsum.photos/seed/${seed + 100}/1280/720';

  static final List<ContentModel> allContent = [
    ContentModel(
      id: '1',
      title: 'Big Buck Bunny',
      description:
          'A large, naive rabbit deals with three tiny bullying rodents in this beloved animated short. Follow our furry hero\'s journey through a beautiful meadow as he discovers that even the most gentle soul has limits when pushed too far. A heartwarming tale of nature, friendship, and justice.',
      thumbnail: _thumb(42),
      backdropUrl: _backdrop(42),
      videoUrl: _video1,
      genre: 'Animation',
      genres: ['Animation', 'Comedy', 'Family'],
      rating: 8.1,
      year: 2008,
      duration: '9m 56s',
      contentType: 'movie',
      isFeatured: true,
      isTrending: true,
      ageRating: 'U',
      cast: ['(Animated)', 'Sacha Goedegebure', 'Enrico Valenza'],
      director: 'Sacha Goedegebure',
      language: 'English',
    ),
    ContentModel(
      id: '2',
      title: "Elephant's Dream",
      description:
          'Two characters explore a strange mechanical world in this surreal and visually stunning animated film. Emo and Proog navigate the mysterious world of "The Machine" – a colossal, surreal construct of gears, tubes, and strange creatures. A landmark open-source animated film that pushed creative boundaries.',
      thumbnail: _thumb(15),
      backdropUrl: _backdrop(15),
      videoUrl: _video2,
      genre: 'Animation',
      genres: ['Animation', 'Sci-Fi', 'Fantasy'],
      rating: 7.3,
      year: 2006,
      duration: '10m 54s',
      contentType: 'movie',
      isFeatured: true,
      ageRating: 'U',
      cast: ['Cas Jansen', 'Tygo Gernandt'],
      director: 'Bassam Kurdali',
      language: 'English',
    ),
    ContentModel(
      id: '3',
      title: 'Sintel',
      description:
          'A girl named Sintel searches for her lost dragon companion across a harsh fantasy world. Her quest takes her through ancient deserts, icy mountains, and forgotten temples. But the truth behind her search may shatter everything she believes about her past and her bond with the creature she seeks.',
      thumbnail: _thumb(78),
      backdropUrl: _backdrop(78),
      videoUrl: _video3,
      genre: 'Fantasy',
      genres: ['Fantasy', 'Animation', 'Adventure'],
      rating: 8.0,
      year: 2010,
      duration: '14m 48s',
      contentType: 'movie',
      isFeatured: true,
      isTrending: true,
      isNew: false,
      ageRating: 'U/A 13+',
      cast: ['Halina Reijn', 'Thom Hoffman', 'Bram van der Kelen'],
      director: 'Colin Levy',
      language: 'English',
    ),
    ContentModel(
      id: '4',
      title: 'Tears of Steel',
      description:
          'In a dystopian future, a group of soldiers and scientists take shelter in a space shuttle, trying to save the planet from the machines that brought it to ruin. A gripping sci-fi thriller blending live-action footage with stunning visual effects, pushing the boundaries of indie filmmaking.',
      thumbnail: _thumb(91),
      backdropUrl: _backdrop(91),
      videoUrl: _video5,
      genre: 'Sci-Fi',
      genres: ['Sci-Fi', 'Action', 'Drama'],
      rating: 7.8,
      year: 2012,
      duration: '12m 14s',
      contentType: 'movie',
      isTrending: true,
      isNew: true,
      ageRating: 'U/A 16+',
      cast: ['Derek de Lint', 'Sergio Hasselbaink', 'Denise Rebergen'],
      director: 'Ian Hubert',
      language: 'English',
    ),
    ContentModel(
      id: '5',
      title: 'For Bigger Blazes',
      description:
          'A thrilling action spectacle featuring explosive visuals and relentless pacing. A showcase of extraordinary cinematic moments designed to keep you on the edge of your seat from the very first frame to the last. Pure adrenaline in its most cinematic form.',
      thumbnail: _thumb(33),
      backdropUrl: _backdrop(33),
      videoUrl: _video6,
      genre: 'Action',
      genres: ['Action', 'Thriller'],
      rating: 7.5,
      year: 2013,
      duration: '0m 15s',
      contentType: 'movie',
      isNew: true,
      ageRating: 'U/A 13+',
      cast: ['Various Artists'],
      director: 'Unknown',
      language: 'English',
    ),
    ContentModel(
      id: '6',
      title: 'Subaru Outback',
      description:
          'A captivating journey through rugged terrains and city streets, showcasing the versatility and adventure of exploration. This cinematic piece captures the raw beauty of the open road, from the winding mountain passes to the bustling urban landscape.',
      thumbnail: _thumb(56),
      backdropUrl: _backdrop(56),
      videoUrl: _video4,
      genre: 'Documentary',
      genres: ['Documentary', 'Adventure'],
      rating: 6.8,
      year: 2013,
      duration: '2m 41s',
      contentType: 'documentary',
      isNew: false,
      ageRating: 'U',
      cast: [],
      director: 'Unknown',
      language: 'English',
    ),
    // Series content
    ContentModel(
      id: '7',
      title: 'Shadow Realms',
      description:
          'In a world where darkness has consumed entire cities, a band of unlikely heroes must master ancient runes and forgotten magic to restore light. Each episode unravels deeper mysteries of the Shadow Realm, testing alliances and revealing shocking truths about the heroes themselves.',
      thumbnail: _thumb(200),
      backdropUrl: _backdrop(200),
      videoUrl: _video1,
      genre: 'Fantasy',
      genres: ['Fantasy', 'Drama', 'Mystery'],
      rating: 8.7,
      year: 2023,
      duration: '52m per episode',
      contentType: 'series',
      isTrending: true,
      isNew: true,
      ageRating: 'U/A 16+',
      cast: ['Sarah Connor', 'Marcus Hale', 'Lyra Quinn'],
      director: 'Mikhail Kovacs',
      language: 'English',
      seasons: 2,
      episodes: 16,
    ),
    ContentModel(
      id: '8',
      title: 'Neon Citadel',
      description:
          'A cyberpunk noir thriller set in Neo-Tokyo 2087, where a burned-out detective uncovers a conspiracy that threatens to destroy the city\'s neural grid. Stunning visuals, gritty storytelling, and unforgettable characters make this a must-watch for sci-fi lovers.',
      thumbnail: _thumb(300),
      backdropUrl: _backdrop(300),
      videoUrl: _video2,
      genre: 'Sci-Fi',
      genres: ['Sci-Fi', 'Thriller', 'Noir'],
      rating: 9.1,
      year: 2024,
      duration: '48m per episode',
      contentType: 'series',
      isFeatured: false,
      isTrending: true,
      isNew: true,
      ageRating: 'A',
      cast: ['Kenji Mori', 'Zara Okafor', 'Alexei Volkov'],
      director: 'Priya Sharma',
      language: 'English',
      seasons: 1,
      episodes: 8,
    ),
    ContentModel(
      id: '9',
      title: 'The Last Kingdom',
      description:
          'An epic historical drama following a displaced nobleman fighting to reclaim his birthright in 9th century England. With brutal battles, political intrigue, and unforgettable heroes, this sweeping saga explores what it means to belong when the world is constantly changing.',
      thumbnail: _thumb(400),
      backdropUrl: _backdrop(400),
      videoUrl: _video3,
      genre: 'Drama',
      genres: ['Drama', 'History', 'Action'],
      rating: 8.5,
      year: 2022,
      duration: '55m per episode',
      contentType: 'series',
      isTrending: false,
      isNew: false,
      ageRating: 'U/A 16+',
      cast: ['Alexander Dreymon', 'Emily Cox', 'David Dawson'],
      director: 'Various Directors',
      language: 'English',
      seasons: 5,
      episodes: 46,
    ),
    ContentModel(
      id: '10',
      title: 'Quantum Drift',
      description:
          'A mind-bending science fiction odyssey where a physicist discovers that parallel universes are collapsing into one another. Racing against time across multiple realities, she must sacrifice everything to prevent the ultimate cosmic catastrophe.',
      thumbnail: _thumb(500),
      backdropUrl: _backdrop(500),
      videoUrl: _video4,
      genre: 'Sci-Fi',
      genres: ['Sci-Fi', 'Mystery', 'Thriller'],
      rating: 8.9,
      year: 2024,
      duration: '50m per episode',
      contentType: 'series',
      isTrending: true,
      isNew: true,
      ageRating: 'U/A 13+',
      cast: ['Amara Diallo', 'James Whitfield', 'Chen Wei'],
      director: 'Sofia Reyes',
      language: 'English',
      seasons: 1,
      episodes: 10,
    ),
    ContentModel(
      id: '11',
      title: 'Crimson Tide Rising',
      description:
          'A gripping political thriller about a whistleblower who exposes corruption at the highest levels of government. As powerful forces close in, she must navigate a dangerous web of lies, betrayal, and moral compromise to survive and reveal the truth.',
      thumbnail: _thumb(600),
      backdropUrl: _backdrop(600),
      videoUrl: _video5,
      genre: 'Thriller',
      genres: ['Thriller', 'Drama', 'Political'],
      rating: 8.3,
      year: 2023,
      duration: '45m per episode',
      contentType: 'series',
      isTrending: false,
      isNew: false,
      ageRating: 'U/A 16+',
      cast: ['Isabella Torres', 'Robert Crane', 'Yuki Tanaka'],
      director: 'Marcus Johnson',
      language: 'English',
      seasons: 3,
      episodes: 30,
    ),
    ContentModel(
      id: '12',
      title: 'Ocean Depths',
      description:
          'Dive into the mysteries of the deep ocean in this breathtaking documentary series. From bioluminescent creatures of the abyss to ancient underwater civilizations, every episode reveals stunning secrets of the world\'s most unexplored frontier.',
      thumbnail: _thumb(700),
      backdropUrl: _backdrop(700),
      videoUrl: _video6,
      genre: 'Documentary',
      genres: ['Documentary', 'Nature', 'Science'],
      rating: 9.0,
      year: 2023,
      duration: '60m per episode',
      contentType: 'documentary',
      isTrending: false,
      isNew: true,
      ageRating: 'U',
      cast: [],
      director: 'David Attenborough Jr.',
      language: 'English',
      seasons: 1,
      episodes: 6,
    ),
  ];

  static List<ContentModel> get featured =>
      allContent.where((c) => c.isFeatured).toList();

  static List<ContentModel> get trending =>
      allContent.where((c) => c.isTrending).toList();

  static List<ContentModel> get newReleases =>
      allContent.where((c) => c.isNew).toList();

  static List<ContentModel> get movies =>
      allContent.where((c) => c.contentType == 'movie').toList();

  static List<ContentModel> get series =>
      allContent.where((c) => c.contentType == 'series').toList();

  static List<ContentModel> get documentaries =>
      allContent.where((c) => c.contentType == 'documentary').toList();

  static List<ContentModel> get sciFi =>
      allContent.where((c) => c.genres.contains('Sci-Fi')).toList();

  static List<ContentModel> get action => allContent
      .where(
          (c) => c.genres.contains('Action') || c.genres.contains('Adventure'))
      .toList();

  static ContentModel? findById(String id) =>
      allContent.where((c) => c.id == id).firstOrNull;

  static List<ContentModel> search(String query) {
    final q = query.toLowerCase();
    return allContent
        .where((c) =>
            c.title.toLowerCase().contains(q) ||
            c.description.toLowerCase().contains(q) ||
            c.genre.toLowerCase().contains(q) ||
            c.cast.any((a) => a.toLowerCase().contains(q)))
        .toList();
  }
}
