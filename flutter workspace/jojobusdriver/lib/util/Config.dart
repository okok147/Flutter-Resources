import 'dart:ui';

final ADMINKEY =
    "4j8nOXvpRkPCBbFF2GoiUrCfddVe7EygnGTWjhytL7dfKPqSNjMnHbWVjGt8yPOKe1iG69MRyRPVqIUXg2X0irW8s61ptprztUTlxj7YVOm8q7LEUBaIB4vzcFonXzoi";
const APIKEY =
    "4j8nOXvpRkPwefwefCBbFF2GoiUrCfddVe7EygnGTWjhytL7dfKPqSNjMnHbWVjGt8yPOKe1iG69MRyRPVqIUXg2X0irW8s61ptprztUTlxj7YVOm8q7LEUBaIB4vzcFonXzoi";
// const BASEURL = "http://god.ibasezero.com:55477/";
// const BASEURL = "http://192.168.1.6:55477/";
// const BASEURL = "http://192.168.1.112:55477/";

const bool _kReleaseMode = const bool.fromEnvironment("dart.vm.product");
const BASEURL = !_kReleaseMode  && false
    ? "http://192.168.0.107:55818/"
    : "http://api2.jojobus.com.hk/";
// const BASEURL = !_kReleaseMode?"http://god.ibasezero.com:55818/":"http://god.ibasezero.com:55818/";
const VERSION = "1.952";

// String TOKEN = "HPVEUIE1pw1imcuOxgkxbtcuBOehJeqEwoHjOeMYwJHaZFVOSCyNwe31yEmP10Fi";
final MainColor = Color(0xFF0071BC);
