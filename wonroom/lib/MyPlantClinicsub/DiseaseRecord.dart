import 'package:flutter/material.dart';
import 'package:wonroom/plantClinicChat.dart';

class DiseaseRecord extends StatelessWidget {
  final String imagePath;
  final String date;
  final String diseaseName;
  final bool isTreatmentCompleted;
  final VoidCallback onTreatmentRequest;
  final VoidCallback onTreatmentComplete;

  const DiseaseRecord({
    required this.imagePath,
    required this.date,
    required this.diseaseName,
    required this.isTreatmentCompleted,
    required this.onTreatmentRequest,
    required this.onTreatmentComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
            SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(date,
                      style: TextStyle(
                          fontSize: 14, color: Color(0xff787878))),
                ),
                GestureDetector(
                  onTap: () {
                    // 클릭 시 PlantClinicChat 페이지로 이동하면서 병 이름 전달
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantClinicChat(
                          diseaseName: diseaseName, // 넘길 병 이름
                        ),
                      ),
                    );
                  },
                  child: Text(
                    diseaseName,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff595959),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: isTreatmentCompleted
                  ? null
                  : () {
                // 버튼 클릭 시 상태에 따른 동작
                if (isTreatmentCompleted) {
                  // 치료완료 동작
                  onTreatmentComplete();
                } else {
                  // 치료요망 동작
                  onTreatmentRequest();
                }
              },
              child: Text(
                isTreatmentCompleted ? '치료완료' : '치료요망',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isTreatmentCompleted
                    ? Color(0xff6fb348) // 치료완료 색상
                    : Color(0xfffc5230), // 치료요망 색상
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffeeeeee),
            width: 1,
          ),
        ),
      ),
    );
  }
}
