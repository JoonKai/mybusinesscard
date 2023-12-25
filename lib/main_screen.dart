import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController introduceController = TextEditingController();
  bool isEditMode = false; //자기소개 수정모드 상태

  @override
  void initState() {
    super.initState();
    //위젯이 처음 실행되었을때 이곳을 호출합니다.
    getIntroduceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.accessibility_new,
          color: Colors.black,
          size: 32,
        ),
        title: const Text(
          '발전하는 가수 하니를 소개합니다.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/hannie.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///이름섹션
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      '이름',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '하니',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      '나이',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '40',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      '취미',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '컴퓨터 게임',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      '직업',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '가수',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      '학력',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '대졸',
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      'MBTI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'INFP',
                  ),
                ],
              ),
            ),

            ///자기소개 입력 필드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  child: const Text(
                    '자기소개',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 16, top: 16),
                    child: Icon(
                      Icons.mode_edit,
                      color:
                          isEditMode == true ? Colors.blueAccent : Colors.black,
                      size: 24,
                    ),
                  ),
                  onTap: () async {
                    if (isEditMode == false) {
                      setState(() {
                        //update widget
                        isEditMode = true;
                      });
                    } else {
                      if (introduceController.text.isEmpty) {
                        //snackbar 메세지로 사용자에게 안내하기
                        var snackBar = const SnackBar(
                          content: Text('자기소개 입력 값이 비어 있습니다.'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        return; //하단의 로직을 실행하지 않고 여기서 메서드 종료
                      }
                      //저장 로직 구현
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setString(
                        'introduce',
                        introduceController.text,
                      );
                      setState(() {
                        //update widget
                        isEditMode = false;
                      });
                    }
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                maxLines: 5,
                controller: introduceController,
                enabled: isEditMode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xffD9D9D9),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getIntroduceData() async {
    //기존에 저장된 자기소개 데이터가 있다면 로드해오기!~
    var sharedPref = await SharedPreferences.getInstance();

    String introduceMsg = sharedPref.getString('introduce').toString();

    introduceController.text = introduceMsg ?? "";
  }
}
