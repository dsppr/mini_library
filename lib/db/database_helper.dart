import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// void printDatabasePath() async {
//   String path = join(await getDatabasesPath(),
//       'mini_library.db'); // Ganti 'my_database.db' dengan nama database Anda
//   print('Database path: $path');
// }

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mini_library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Buat tabel books
    await db.execute('''
    CREATE TABLE books (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author TEXT NOT NULL,
      category TEXT,
      status TEXT NOT NULL,
      description TEXT,
      cover TEXT
    )
  ''');

    // Data awal untuk tabel books
    List<Map<String, dynamic>> initialBooks = [
      {
        'title': 'Fur Immer Dein Ian',
        'author': 'Valerie',
        'category': 'Romance',
        'status': 'Available',
        'description':
            'Apakah ada yang lebih menyebalkan daripada menyembunyikan perasaan atas nama pertemanan?...',
        'cover': 'assets/images/fur_immer_dein_ian.jpg'
      },
      {
        'title': 'Majnun',
        'author': 'Anton Kurnia',
        'category': 'Historical Fiction',
        'status': 'Available',
        'description':
            'Majnun adalah kisah cinta, persahabatan, dan catatan atas sejarah yang dilupakan...',
        'cover': 'assets/images/majnun_anton_kurnia.jpg'
      },
      {
        'title': 'I Think I Love You',
        'author': 'Cha Mirae',
        'category': 'Young Adult Romance',
        'status': 'Available',
        'description':
            'Dua pria tampan di Kyunghee University, Jang Taehyun dan Han Seokjin, terlibat konflik...',
        'cover': 'assets/images/i_think_i_love_you_cha_mirae.jpg'
      },
      {
        'title': 'Where Stories Begin',
        'author': 'Wacaku',
        'category': 'Anthology',
        'status': 'Available',
        'description':
            'Antologi cerita pendek dari sepuluh penulis terpilih melalui perlombaan di tahun 2022...',
        'cover': 'assets/images/where_stories_begin_wacaku.jpg'
      },
      {
        'title': 'Ramai Yang Dulu Kita Bawa Pergi',
        'author': 'Suci Berliana',
        'category': 'Poetry & Reflection',
        'status': 'Available',
        'description':
            'Kilas balik pertemuan dan kenangan yang hanya bisa dijelaskan melalui rangkaian kata...',
        'cover':
            'assets/images/ramai_yang_dulu_kita_bawa_pergi_suci_berliana.jpg'
      },
      {
        'title': '172 Days',
        'author': 'Nadzira Shafa',
        'category': 'Romance',
        'status': 'Available',
        'description':
            'Kehidupan seorang wanita berubah dalam sekejap setelah kehilangan seseorang yang dicintai...',
        'cover': 'assets/images/172_days_nadzira_shafa.jpg'
      },
      {
        'title': 'Funiculi Funicula (Before the Coffee Gets Cold)',
        'author': 'Toshikazu Kawaguchi',
        'category': 'Magical Realism',
        'status': 'Available',
        'description':
            'Di sebuah kafe tua di Tokyo, pengunjung bisa menjelajahi waktu dengan syarat tertentu...',
        'cover':
            'assets/images/funiculi_funicula_before_the_coffee_gets_cold_toshikazu_kawaguchi.jpg'
      },
      {
        'title': 'Terpikat',
        'author': 'Ghefira Zakhira',
        'category': 'Teen Romance',
        'status': 'Available',
        'description':
            'Aruna jatuh cinta pada pandangan pertama kepada Abian, seorang siswa berprestasi yang sulit didekati...',
        'cover': 'assets/images/terpikat_ghefira_zakhira.jpg'
      },
      {
        'title': 'Oh My Savior',
        'author': 'Washashira',
        'category': 'Romance',
        'status': 'Available',
        'description':
            'Zelda, seorang gadis yang hidup serba kekurangan, menemukan cinta dalam sosok Zidane...',
        'cover': 'assets/images/oh_my_savior_washashira.jpg'
      },
      {
        'title': 'The Chronicles of Narnia #1: The Magicians Nephew',
        'author': 'C.S. Lewis',
        'category': 'Fantasy',
        'status': 'Available',
        'description':
            'Kisah tentang penciptaan dunia Narnia, di mana dua sahabat berpetualang melalui dunia lain...',
        'cover':
            'assets/images/the_chronicles_of_narnia_1_the_magicians_nephew.jpg'
      },
      {
        'title': 'Heartbreak Motel',
        'author': 'Ika Natassa',
        'category': 'Drama',
        'status': 'Available',
        'description':
            'Cerita tentang Ava, seorang aktris muda yang menghadapi perjalanan emosional dari masa lalu...',
        'cover': 'assets/images/heartbreak_motel.jpg'
      },
      {
        'title': 'The Chronicles of Narnia #3: The Horse & His Boy',
        'author': 'C.S. Lewis',
        'category': 'Fantasy',
        'status': 'Available',
        'description':
            'Empat pelarian bertemu dalam perjalanan penuh tantangan dan menemukan diri mereka di tengah pertempuran besar...',
        'cover':
            'assets/images/the_chronicles_of_narnia_3_the_horse_and_his_boy.jpg'
      },
      {
        'title': 'Sagaras',
        'author': 'Tere Liye',
        'category': 'Fantasy',
        'status': 'Available',
        'description':
            'Ali melanjutkan perjalanan untuk mengungkap misteri keluarganya, ditemani oleh sahabat sejati...',
        'cover': 'assets/images/sagaras.jpg'
      },
    ];

    // Insert data ke database
    for (var book in initialBooks) {
      await db.insert('books', book);
    }
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await instance.database;
    return await db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> values,
      String whereClause, List whereArgs) async {
    final db = await instance.database;
    return await db.update(table, values,
        where: whereClause, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String whereClause, List whereArgs) async {
    final db = await instance.database;
    return await db.delete(table, where: whereClause, whereArgs: whereArgs);
  }
}
