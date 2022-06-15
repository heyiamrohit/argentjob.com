import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
////import '../widget/detailscreen.dart';

class Terms_And_Condition extends StatelessWidget {
  // const TermsAndConditon({ Key? key }) : super(key: key);
  static const routeName = '/Terms_And_Condition';

  @override
  Widget build(BuildContext context) {
    const htmlData = r"""
<pre><h2>     Rules and Regulations</h2> 

1. सिर्फ दो प्रकार के लोग अपना Job एवं Interview पोस्ट कर सकते हैं| 
   (a) जाब का मालिक हो 
   (b) company का वेतन प्राप्त व्यकति हो |

2. आपके पास 1 दिन का काम हो या 4 दिन का एवं 10 दिन का काम हो या 20 दिन का | दुकान का काम हो या company का, घर का काम हो या फैक्ट्री का आप job पोस्ट कर सकते हो |

3. एक समय में एक ही job या interview को apply किया जा सकता है इसलिए आप उस job interview apply करे जिसे आप दिए गए समय एवं तारिख पर join कर सके |  join करने के 2-3 घंटे बाद आप दूसरी job या interview में apply कर सकते हैं।

4. किसी भी job या interview में apply करने से पहले दिए गए काम एवं लोकेशन के बारे में अच्छी तरह से जानकारी प्राप्त कर ले | सिर्फ पैसे को देखकर apply न करें क्योंकि यह argentjob.com application सही काम एवं समय पर payment दिलाने के कार्य षेत्र में प्रयास रत् है इसके अलावा यह application किसी भी प्रकार की कोई जिम्मेदारी नहीं लेती है विशेष कर यह सलाह लड़कियो, एवं लड़कों को दी जाती है।

5. argentjob application में ली गई आपकी पर्सनल जानकारी एवं आई डी आपको आई डी number प्रदान करने के• लिए एवं फ्राड कम करने के लिए लिया गया है यह 100% सुरक्षित है | आप 24 घंटे पहले apply कर सकते हैं, आप 12 घंटे पहले अपनी job cansil कर सकते हैं एवं 8 घंटे पहले आप apply किए हुए person को select एवं rejecte कर सकते हैं।

6. आप अपने दिए गए समय एवं तारीख पर यदि वेतन प्रदान नहीं करते या सिलेक्ट व्यक्ति समय पर ज्वाइन नहीं करता या दूसरा काम दिया जाता है  तो व्यक्ति अपनी शिकायत कर सकता है जिसे ब्लैक Black list किया जा सकता है| एवं फाइन चार्ज भी लग सकता है |

7. वेतन संबंधी शिकायत पर पहले आपको worker को वेतन प्रदान करना होगा एवं शिकायत फार्म भरकर आपको submit करना होगा उसके बाद fine charge 500₹ देना होगा तब आपकी आइ डी को blacklist से हटा दिया जाएगा |

8. समय पर job join न करने की शिकायत पर आपको शिकायत फार्म भरकर submit करना होगा एवं  fine charge 500₹ देना होगा | तब आपकी आइ डी को blacklist से हटा दिया जाएगा |

9. कोई व्यक्ति यदि किसी की झूठी शिकायत करता है या जिस व्यक्ति की 5 शिकायत हो जाती है तो उसे 15 दिन के लिए blacklist कर दिया जाएगा यदि शिकायत लिस्ट अपनी सीमा पार करती है तो fine charge तीन गुना अधिक बढ़ा दिया जाएगा |

10. argebtjob application यह सभी के लिए है सभी के सहयोग के लिए है | Argent = silver, अतः इसका सभी लोग सही से एवं ईमानदारी से चादी की तरह उपयोग करे|                   


1. Only two types of people can post jobs 
   (a) job owner 
   (b) company salaried person

2. You have 1 day work or 4 days and 10 days work or 20 days.

3.Only one job or interview can be applied at a time, so you can apply for that job or interview, which you can join on the given time and date, after two-three hours of joining, you can apply for another job or interview.

4.Before applying in any job or interview, get a good information about the given work and location, then do not apply after looking at the value of money because this urgent job application is trying to get the right work and timely payment.

5. Your personal information and ID taken in the urgent job application has been taken to provide you the ID number and reduce fraud, it is 100% secure, you can cancel your job 12 hours in advance, you can apply 24 hours before and You can select and reject the people who applied 8 hours ago.

6.If you do not provide the salary on your given time and date or the selected person does not join on time or is given another job, then the person can make his complaint which can be blacklisted.

7. On salary related complaint, first you will have to provide salary to the worker and you will have to submit by filling the complaint form, after that fine charge ₹ 500 will have to be paid then your ID will be removed from the black list.

8. On the complaint of not joining the job on time, you will have to fill the complaint form and submit the complaint charge ₹ 500, then your ID will be removed from the black list.

9. If a person makes a false complaint against someone else or the person who has 5 complaints, he will be blacklisted for 15 days, if the complaint crosses his limit, the fine will be increased by 3 times

10. ArgentJob  This application is for everyone, it is for everyone's cooperation. Argent =  silver, so everyone should use it properly and responsibly like silver, thank you.

              Thankyou.

</pre>
""";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Argent Job',
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(
                data: htmlData,
              ),
            ),
          ],
        ),
      ),
      //decoration: TextDecoration.underline,
      //decorationStyle: TextDe
      //
      //corationStyle.solid,
    );
  }
}
