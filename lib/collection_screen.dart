import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    home: collection_screen(),
  ));
}

class collection_screen extends StatelessWidget {
  const collection_screen({Key? key}) : super(key: key);

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
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変1'),
                                  title: Text(
                                    '焦らせるような文面でも、安易にリンクを開いてはいけません。URLを開いてしまうと、ウイルスがインストールされる可能性があります。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変1"),
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
                  child: _imageItem("異変1")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変2'),
                                  title: Text(
                                    '迷惑メールは安易に開いてはいけません。メールアプリの送信元を拒否する設定を活用しましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変2"),
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
                  child: _imageItem("異変2")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変3'),
                                  title: Text(
                                    'ウェブサイトに自分のアカウントでログインすると、登録されたメールアドレスに通知が送られてくることがあります。身に覚えのないログインの場合、アカウント情報が流出している可能性があります。パスワードを変更するなどの対策を取りましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変3"),
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
                  child: _imageItem("異変3")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変4'),
                                  title: Text(
                                    'メールの添付ファイルを開いただけでも、デバイスがウイルスに感染する可能性があります。知り合いからのメールであっても、注意しましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変4"),
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
                  child: _imageItem("異変4")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変5'),
                                  title: Text(
                                    'SNSでお金や商品を配ろうとする投稿は、注意しましょう。安易にリンクを開いたり、投稿を拡散してはいけません。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変5"),
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
                  child: _imageItem("異変5")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変6'),
                                  title: Text(
                                    'SNSでは個人情報を乗せるのはやめましょう。ユーザー名やプロフィール、投稿にも注意しましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変6"),
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
                  child: _imageItem("異変6")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変7'),
                                  title: Text(
                                    '非公開アカウントであっても、他人への誹謗中傷をSNSに投稿するのはやめましょう。法的な問題になる恐れもあります。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変7"),
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
                  child: _imageItem("異変7")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変8'),
                                  title: Text(
                                    '他人の個人情報をSNSに乗せるのはやめましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変8"),
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
                  child: _imageItem("異変8")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変9'),
                                  title: Text(
                                    '写真には個人を特定できる情報が含まれている可能性があります。自宅の写真だけでなく、駅の近くに住んでいるなどの情報を安易に公開しないようにしましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変9"),
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
                  child: _imageItem("異変9")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変10'),
                                  title: Text(
                                    'ウェブサイトの中には、広告が大量に出てくるサイトもあります。広告をブロックするか、そのようなサイトにはアクセスしないようにしましょう。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変10"),
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
                  child: _imageItem("異変10")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変11'),
                                  title: Text(
                                    'URLやウェブサイトが似ていても、まったく別のページということもあります。普段からのウイルス対策が重要です。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変11"),
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
                  child: _imageItem("異変11")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変12'),
                                  title: Text(
                                    '警告が出てくるなど、安全でないウェブサイトを見つけたら、絶対に開かないようにしましょう。ウイルスに感染したり、個人情報が抜き取られたりする可能性もあります。',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変12"),
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
                  child: _imageItem("異変12")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変13'),
                                  title: Text(
                                    '異変13の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変13"),
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
                  child: _imageItem("異変13")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変14'),
                                  title: Text(
                                    '異変14の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変14"),
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
                  child: _imageItem("異変14")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変15'),
                                  title: Text(
                                    '異変15の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変15"),
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
                  child: _imageItem("異変15")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変16'),
                                  title: Text(
                                    '異変16の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変16"),
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
                  child: _imageItem("異変16")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変17'),
                                  title: Text(
                                    '異変17の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変17"),
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
                  child: _imageItem("異変17")),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Column(
                              children: <Widget>[
                                AlertDialog(
                                  icon: Text('異変18'),
                                  title: Text(
                                    '異変18の説明',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  content: _simageItem("異変18"),
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
                  child: _imageItem("異変18")),
            ],
          ),
        ),
      ]),
    );
  }
}
