import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: CollectionScreen(),
  ));
}

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  @override
  void initState() {
    super.initState();
  }
  Widget _simageItem(String name) {
    var image = "images/" + name + ".svg";
    return Container(

      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
      ),
      child: SvgPicture.asset(
        image,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.7,
        // height: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  }

  Widget _imageItem(String name) {
    var image = "images/" + name + "s.svg";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 左揃えにする
      children: [
        // ラベルの表示
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          // ラベルに上下の余白を追加
          color: Colors.grey[700],
          // ラベルの背景色を黒に設定
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white, // 文字色を白に設定
              fontSize: 16,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: SvgPicture.asset(image, fit: BoxFit.cover),
        ),
      ],
    );
  }
  Widget _dialog(String ihenNumber, String discription) {
    return FutureBuilder<bool>(
      future: _containsValue(ihenNumber),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 読み込み中のインジケーター
        } else if (snapshot.hasError) {
          return Text('エラーが発生しました');
        } else {
          bool containsValue = snapshot.data ?? false;

          // 値が含まれている場合はContainer、含まれていない場合は別のWidgetを表示
          return containsValue
              ? InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Column(
                      children: <Widget>[
                        AlertDialog(
                          icon: Text('異変$ihenNumber'),
                          title: Text(
                            '$discription',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          content: _simageItem('異変$ihenNumber'),
                          actions: <Widget>[
                            GestureDetector(
                              child: Text('閉じる'),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ],
                    ));
              },
              child: _imageItem('異変$ihenNumber')
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左揃えにする
            children: [
              // ラベルの表示
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                // ラベルに上下の余白を追加
                color: Colors.grey[700],
                // ラベルの背景色を黒に設定
                child: Text(
                  "異変"+ihenNumber,
                  style: const TextStyle(
                    color: Colors.white, // 文字色を白に設定
                    fontSize: 16,
                  ),
                ),
              ),
                  Container(
                  width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        color: Colors.red,
        child: Center(
        child: Text(
        '未開放', // 含まれていない場合の表示
        style: TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
        ),
        ),
        )
            ],
          );Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            color: Colors.red,
            child: Center(
              child: Text(
                'このメッセージは表示されません', // 含まれていない場合の表示
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }
  Future<bool> _containsValue(String targetValue) async {
    final prefs = await SharedPreferences.getInstance();
    final String? intListString = prefs.getString("intListKey");

    if (intListString != null) {
      List<int> intList = List<int>.from(jsonDecode(intListString));
      return intList.contains(int.parse(targetValue)); // 文字列をintに変換してチェック
    }
    return false; // 値が存在しない場合
  }
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();


    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('コレクション',
          style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'arrow_upward',
            backgroundColor: Colors.blue,
            onPressed: () {
              controller.animateTo(
                0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInQuint,
              );
            },
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Positioned.fill(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,// 横に並べる画像の数
              childAspectRatio: 1.4, // 正方形として表示
            ),
            itemBuilder: (context, index) {
              return FittedBox(
                fit: BoxFit.contain, // 画像全体が見えるように縮小
                child: Transform.rotate(
                  angle: -0.1, // 画像を斜めにする角度（ラジアンで指定）
                  child: Image.asset(
                    'images/grey.png', // 使用する画像のパス
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        // Positioned.fill(
        //   child: Image.asset(
        //     "images/background2.png",
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            controller: controller,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1 / 1.2,
            children: <Widget>[
              Center(
                child: Text(
                  'mail',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ),
              Image.asset('images/nmail.png'),
              _dialog('1','焦らせるような文面でも、安易にリンクを開いてはいけません。URLを開いてしまうと、ウイルスがインストールされる可能性があります。'),
              _dialog('2', '迷惑メールは安易に開いてはいけません。メールアプリの送信元を拒否する設定を活用しましょう。'),
              _dialog('3', 'ウェブサイトに自分のアカウントでログインすると、登録されたメールアドレスに通知が送られてくることがあります。身に覚えのないログインの場合、アカウント情報が流出している可能性があります。パスワードを変更するなどの対策を取りましょう。'),
              _dialog('4', 'メールの添付ファイルを開いただけでも、デバイスがウイルスに感染する可能性があります。知り合いからのメールであっても、注意しましょう。'),
              _dialog('19','悪質なアカウントが不在配達を装ってSMS（ショートメッセージサービス）を送ってくることはよくあることです。ID・パスワードは絶対に入力してはいけません。'),
              _dialog('20','SMS（ショートメッセージサービス）には怪しいアルバイトの求人などが届くこともあります。犯罪絡みのものも多いため絶対に、リンクを開いたりしないでください。'),
              _dialog('21','突然知らない番号から電話がかかってきても、慌てないようにしましょう。相手の電話番号を調べるなどして、安全だという確証が得られてからかけなおせばよいだけです。'),
              _dialog('22','明らかに、に日本語がおかしいです。危険なアドレスである可能性が高いです。'),
              Center(
                child: Text(
                  'SNS',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ),
              Image.asset('images/nsns.png'),
              _dialog('5', 'SNSでお金や商品を配ろうとする投稿は、注意しましょう。安易にリンクを開いたり、投稿を拡散してはいけません。'),
              _dialog('6', 'SNSでは個人情報を乗せるのはやめましょう。ユーザー名やプロフィール、投稿にも注意しましょう。'),
              _dialog('7', '非公開アカウントであっても、他人への誹謗中傷をSNSに投稿するのはやめましょう。法的な問題になる恐れもあります。'),
              _dialog('8', '他人の個人情報をSNSに乗せるのはやめましょう。'),
              _dialog('9', '写真には個人を特定できる情報が含まれている可能性があります。自宅の写真だけでなく、駅の近くに住んでいるなどの情報を安易に公開しないようにしましょう。'),
              _dialog('23','画像にタグ付けされたユーザー名と投稿しているアカウントのユーザー名が違います。無断転載している可能性があります。'),
              _dialog('24','ユーザー名をよく見ると本来の公式アカウントのユーザー名と少し違います。また、認証マークの色も違います。公式のなりすましのアカウントである可能性が高いです。'),
              _dialog('25','フェイクニュースです。インターネットの情報はうのみにしないようにしましょう。裏取りが大切です。'),
              _dialog('26','知らないアカウントからのとつぜんのDMには注意しましょう。まずは、相手をじっくりと精査しましょう。'),
              Text(''),
              Center(
                child: Text(
                  'Web',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ),
              Image.asset('images/nbrowser.png'),
              _dialog('10', 'ウェブサイトの中には、広告が大量に出てくるサイトもあります。広告をブロックするか、そのようなサイトにはアクセスしないようにしましょう。'),
              _dialog('11', 'URLやウェブサイトが似ていても、まったく別のページということもあります。普段からのウイルス対策が重要です。'),
              _dialog('12', '警告が出てくるなど、安全でないウェブサイトを見つけたら、絶対に開かないようにしましょう。ウイルスに感染したり、個人情報が抜き取られたりする可能性もあります。'),
              _dialog('13', 'フェイクニュースには気を付けましょう。'),
              _dialog('14', '過剰な広告が出てくるウェブは危険な可能性があります。閲覧などは避けましょう。'),
              _dialog('27','アドレスバーに注意信号が出ていますが、これはウェブサイトのデータの中にSSL暗号化していない情報が含まれているということです。この状態のウェブサイトでは簡単に情報が抜き取られてしまいます。'),
              _dialog('28','パスワードが簡単すぎます。しっかり指示に従って、強力なパスワードを使用してください。使いまわしも避けるべきでしょう。'),
              _dialog('29','パスワードの確認がなく、住所を入力するフォームに代わっています。パスワードの確認フォームがない場合、タイプミスしていたときにログインできなくなります。'),
              _dialog('30','アドレスバーをよく見るとアドレスが違います。分かりにくいアドレスの違いには特に注意しましょう。'),
              Text(''),
              Center(
                child: Text(
                  'setting',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.green,
                  ),
                ),
              ),
              Image.asset('images/nsettings.png'),
              _dialog('15', '「インターネット共有へ自動接続」の項目がついています。勝手に危険なネットワークに接続してしまう可能性を避けるため、できるだけ接続を切っておきましょう。'),
              _dialog('16', '利用可能なネットワークの項目に表示される、Wi-Fiの名前をSSIDといいます。例え接続ができる状態にあったとしても、知らないSSIDのネットワークには接続しないようにしましょう。'),
              _dialog('17', '安全性の低いネットワークには接続しないようにしましょう。'),
              _dialog('18', 'Wi-Fiがオフになっています。'),
              _dialog('31','バッテリーの最大容量が少なすぎます。気を付けて使いましょう。'),
              _dialog('32','画面がオフになっている間に大量のバッテリーが消費されています。隠しアプリがインストールされている可能性もあります。怪しいと思ったらすぐに専門家に相談しましょう。'),
              _dialog('33','よくわからいアプリが多くのバッテリーを消費しています。怪しいと感じたら。一度アンインストールしてみましょう。'),
              //           Center(
              //             child: Text(
              //               'phone',
              //                   style: TextStyle(
              // fontSize: 50,
              // fontWeight: FontWeight.bold,
              // fontStyle: FontStyle.italic,
              // )
              //             )
              //           ),
              //           Image.asset('images/nphone.png'),
              //           _dialog('19',''),
              //           _dialog('20',''),
              //           _dialog('21',''),
              //           _dialog('22',''),
            ],
          ),
        ),
      ]),
    );
  }
}


// _dialog('','')