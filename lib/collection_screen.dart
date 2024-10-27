import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    home: collection_screen(),
  ));
}

class collection_screen extends StatelessWidget {

  const collection_screen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    Widget _simageItem(String name) {
      var image = "images/" + name + ".svg";
      return Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
        ),
        child: SvgPicture.asset(
          image,
          fit: BoxFit.cover,
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

    Widget _dialog(String ihenNumber,String discription){
      return InkWell(
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
      );
    }

    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('コレクション'),
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
          child: Image.asset(
            "images/background2.png",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            controller: controller,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1 / 1.2,
            children: <Widget>[
          Text(
          'mail',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
              _dialog('1','焦らせるような文面でも、安易にリンクを開いてはいけません。URLを開いてしまうと、ウイルスがインストールされる可能性があります。'),
              _dialog('2', '迷惑メールは安易に開いてはいけません。メールアプリの送信元を拒否する設定を活用しましょう。'),
              _dialog('3', 'ウェブサイトに自分のアカウントでログインすると、登録されたメールアドレスに通知が送られてくることがあります。身に覚えのないログインの場合、アカウント情報が流出している可能性があります。パスワードを変更するなどの対策を取りましょう。'),
              _dialog('4', 'メールの添付ファイルを開いただけでも、デバイスがウイルスに感染する可能性があります。知り合いからのメールであっても、注意しましょう。'),
              Text(''),
              Text(
                'SNS',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              _dialog('5', 'SNSでお金や商品を配ろうとする投稿は、注意しましょう。安易にリンクを開いたり、投稿を拡散してはいけません。'),
              _dialog('6', 'SNSでは個人情報を乗せるのはやめましょう。ユーザー名やプロフィール、投稿にも注意しましょう。'),
              _dialog('7', '非公開アカウントであっても、他人への誹謗中傷をSNSに投稿するのはやめましょう。法的な問題になる恐れもあります。'),
              _dialog('8', '他人の個人情報をSNSに乗せるのはやめましょう。'),
              _dialog('9', '写真には個人を特定できる情報が含まれている可能性があります。自宅の写真だけでなく、駅の近くに住んでいるなどの情報を安易に公開しないようにしましょう。'),
              Text(
                'Web',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              _dialog('10', 'ウェブサイトの中には、広告が大量に出てくるサイトもあります。広告をブロックするか、そのようなサイトにはアクセスしないようにしましょう。'),
              _dialog('11', 'URLやウェブサイトが似ていても、まったく別のページということもあります。普段からのウイルス対策が重要です。'),
              _dialog('12', '警告が出てくるなど、安全でないウェブサイトを見つけたら、絶対に開かないようにしましょう。ウイルスに感染したり、個人情報が抜き取られたりする可能性もあります。'),
              _dialog('13', 'フェイクニュースには気を付けましょう。'),
              _dialog('14', '過剰な広告が出てくるウェブは危険な可能性があります。閲覧などは避けましょう。'),
              Text(
                'setting',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              _dialog('15', '「インターネット共有へ自動接続」の項目がついています。勝手に危険なネットワークに接続してしまう可能性を避けるため、できるだけ接続を切っておきましょう。'),
              _dialog('16', '利用可能なネットワークの項目に表示される、Wi-Fiの名前をSSIDといいます。例え接続ができる状態にあったとしても、知らないSSIDのネットワークには接続しないようにしましょう。'),
              _dialog('17', '安全性の低いネットワークには接続しないようにしましょう。'),
              _dialog('18', 'Wi-Fiがオフになっています。'),
            ],
          ),
        ),
      ]),
    );
  }
}