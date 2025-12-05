import 'package:flutter/material.dart';

class InfiniteCoverFlowList extends StatefulWidget {
  const InfiniteCoverFlowList({super.key});

  @override
  State<InfiniteCoverFlowList> createState() => _InfiniteCoverFlowListState();
}

class _InfiniteCoverFlowListState extends State<InfiniteCoverFlowList> {
  late PageController _pageController;
  double _currentPage = 0;

  // SỐ LƯỢNG CARD THỰC TẾ BẠN MUỐN CÓ
  final int _realItemCount = 5;
  // Bắt đầu từ 1 số rất lớn để giả lập vô tận về cả 2 phía
  final int _initialPage = 1000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.6,
      initialPage: _initialPage,
    );

    // Cập nhật current page ban đầu theo initialPage
    _currentPage = _initialPage.toDouble();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,

            // QUAN TRỌNG: Không set itemCount để nó chạy vô hạn
            // itemCount: null,
            itemBuilder: (context, index) {
              // 1. Tính toán hiệu ứng 3D (Dùng index gốc để animation mượt mà)
              double difference = index - _currentPage;

              // 2. Tính index thực tế của dữ liệu (Dùng toán tử chia lấy dư %)
              // Ví dụ: index chạy đến 1005, có 5 item => 1005 % 5 = 0 (quay lại ảnh đầu)
              int realIndex = index % _realItemCount;

              return Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..setEntry(
                        3,
                        2,
                        0.001,
                      ) // 1. Tạo chiều sâu 3D (Perspective)
                      // 2. THÊM DÒNG NÀY: Xoay theo trục Y
                      // difference * -0.45: Số càng lớn thì xoay càng gắt
                      // Dấu âm để nó xoay hướng vào trong trung tâm
                      ..rotateY(difference * -0.45),

                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Transform.rotate(
                    angle: difference * 0.4,

                    child: _buildCard(
                      realIndex,
                    ), // Truyền realIndex để lấy đúng dữ liệu
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        image: DecorationImage(
          fit: BoxFit.cover,
          // Load ảnh theo index thực tế
          image: NetworkImage('https://picsum.photos/400/600?random=$index'),
        ),
      ),
    );
  }
}
