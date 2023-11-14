import Text "mo:base/Text";
import Char "mo:base/Char";
import Nat8 "mo:base/Nat8";
import Float "mo:base/Float";
import Nat32 "mo:base/Nat32";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";
import TrieSet "mo:base/TrieSet";
import Result "mo:base/Result";
import Hash "mo:base/Hash";
import Debug "mo:base/Debug";
import Fuzz "mo:fuzz";

module {
       public let wine_data: [[dataMember]] =  [[#number(14.2), #number(1.7), #number(2.4), #number(15.6), #number(127.0), #number(2.8), #number(3.1), #number(0.3), #number(2.3), #number(5.6), #number(1.0), #number(3.9), #number(1065.0), #symbol("0")],
                  [#number(13.2), #number(1.8), #number(2.1), #number(11.2), #number(100.0), #number(2.6), #number(2.8), #number(0.3), #number(1.3), #number(4.4), #number(1.1), #number(3.4), #number(1050.0), #symbol("0")],
                  [#number(13.2), #number(2.4), #number(2.7), #number(18.6), #number(101.0), #number(2.8), #number(3.2), #number(0.3), #number(2.8), #number(5.7), #number(1.0), #number(3.2), #number(1185.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.5), #number(16.8), #number(113.0), #number(3.9), #number(3.5), #number(0.2), #number(2.2), #number(7.8), #number(0.9), #number(3.5), #number(1480.0), #symbol("0")],
                  [#number(13.2), #number(2.6), #number(2.9), #number(21.0), #number(118.0), #number(2.8), #number(2.7), #number(0.4), #number(1.8), #number(4.3), #number(1.0), #number(2.9), #number(735.0), #symbol("0")],
                  [#number(14.2), #number(1.8), #number(2.5), #number(15.2), #number(112.0), #number(3.3), #number(3.4), #number(0.3), #number(2.0), #number(6.8), #number(1.1), #number(2.9), #number(1450.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.5), #number(14.6), #number(96.0), #number(2.5), #number(2.5), #number(0.3), #number(2.0), #number(5.2), #number(1.0), #number(3.6), #number(1290.0), #symbol("0")],
                  [#number(14.1), #number(2.1), #number(2.6), #number(17.6), #number(121.0), #number(2.6), #number(2.5), #number(0.3), #number(1.2), #number(5.0), #number(1.1), #number(3.6), #number(1295.0), #symbol("0")],
                  [#number(14.8), #number(1.6), #number(2.2), #number(14.0), #number(97.0), #number(2.8), #number(3.0), #number(0.3), #number(2.0), #number(5.2), #number(1.1), #number(2.9), #number(1045.0), #symbol("0")],
                  [#number(13.9), #number(1.4), #number(2.3), #number(16.0), #number(98.0), #number(3.0), #number(3.1), #number(0.2), #number(1.9), #number(7.2), #number(1.0), #number(3.5), #number(1045.0), #symbol("0")],
                  [#number(14.1), #number(2.2), #number(2.3), #number(18.0), #number(105.0), #number(3.0), #number(3.3), #number(0.2), #number(2.4), #number(5.8), #number(1.2), #number(3.2), #number(1510.0), #symbol("0")],
                  [#number(14.1), #number(1.5), #number(2.3), #number(16.8), #number(95.0), #number(2.2), #number(2.4), #number(0.3), #number(1.6), #number(5.0), #number(1.2), #number(2.8), #number(1280.0), #symbol("0")],
                  [#number(13.8), #number(1.7), #number(2.4), #number(16.0), #number(89.0), #number(2.6), #number(2.8), #number(0.3), #number(1.8), #number(5.6), #number(1.1), #number(2.9), #number(1320.0), #symbol("0")],
                  [#number(14.8), #number(1.7), #number(2.4), #number(11.4), #number(91.0), #number(3.1), #number(3.7), #number(0.4), #number(2.8), #number(5.4), #number(1.2), #number(2.7), #number(1150.0), #symbol("0")],
                  [#number(14.4), #number(1.9), #number(2.4), #number(12.0), #number(102.0), #number(3.3), #number(3.6), #number(0.3), #number(3.0), #number(7.5), #number(1.2), #number(3.0), #number(1547.0), #symbol("0")],
                  [#number(13.6), #number(1.8), #number(2.7), #number(17.2), #number(112.0), #number(2.9), #number(2.9), #number(0.3), #number(1.5), #number(7.3), #number(1.3), #number(2.9), #number(1310.0), #symbol("0")],
                  [#number(14.3), #number(1.9), #number(2.7), #number(20.0), #number(120.0), #number(2.8), #number(3.1), #number(0.3), #number(2.0), #number(6.2), #number(1.1), #number(2.6), #number(1280.0), #symbol("0")],
                  [#number(13.8), #number(1.6), #number(2.6), #number(20.0), #number(115.0), #number(3.0), #number(3.4), #number(0.4), #number(1.7), #number(6.6), #number(1.1), #number(2.6), #number(1130.0), #symbol("0")],
                  [#number(14.2), #number(1.6), #number(2.5), #number(16.5), #number(108.0), #number(3.3), #number(3.9), #number(0.3), #number(1.9), #number(8.7), #number(1.2), #number(2.8), #number(1680.0), #symbol("0")],
                  [#number(13.6), #number(3.1), #number(2.6), #number(15.2), #number(116.0), #number(2.7), #number(3.0), #number(0.2), #number(1.7), #number(5.1), #number(1.0), #number(3.4), #number(845.0), #symbol("0")],
                  [#number(14.1), #number(1.6), #number(2.3), #number(16.0), #number(126.0), #number(3.0), #number(3.2), #number(0.2), #number(2.1), #number(5.7), #number(1.1), #number(3.7), #number(780.0), #symbol("0")],
                  [#number(12.9), #number(3.8), #number(2.6), #number(18.6), #number(102.0), #number(2.4), #number(2.4), #number(0.2), #number(2.0), #number(4.5), #number(1.0), #number(3.5), #number(770.0), #symbol("0")],
                  [#number(13.7), #number(1.9), #number(2.4), #number(16.6), #number(101.0), #number(2.6), #number(2.9), #number(0.3), #number(1.7), #number(3.8), #number(1.1), #number(4.0), #number(1035.0), #symbol("0")],
                  [#number(12.8), #number(1.6), #number(2.5), #number(17.8), #number(95.0), #number(2.5), #number(2.4), #number(0.3), #number(1.5), #number(3.9), #number(1.1), #number(3.6), #number(1015.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.6), #number(20.0), #number(96.0), #number(2.5), #number(2.6), #number(0.3), #number(1.7), #number(3.5), #number(1.1), #number(3.8), #number(845.0), #symbol("0")],
                  [#number(13.1), #number(2.0), #number(3.2), #number(25.0), #number(124.0), #number(2.6), #number(2.7), #number(0.5), #number(1.9), #number(3.6), #number(1.1), #number(3.2), #number(830.0), #symbol("0")],
                  [#number(13.4), #number(1.8), #number(2.6), #number(16.1), #number(93.0), #number(2.9), #number(2.9), #number(0.3), #number(1.4), #number(4.8), #number(0.9), #number(3.2), #number(1195.0), #symbol("0")],
                  [#number(13.3), #number(1.7), #number(2.1), #number(17.0), #number(94.0), #number(2.4), #number(2.2), #number(0.3), #number(1.4), #number(4.0), #number(1.0), #number(2.8), #number(1285.0), #symbol("0")],
                  [#number(13.9), #number(1.9), #number(2.8), #number(19.4), #number(107.0), #number(3.0), #number(3.0), #number(0.4), #number(1.8), #number(4.5), #number(1.2), #number(3.4), #number(915.0), #symbol("0")],
                  [#number(14.0), #number(1.7), #number(2.2), #number(16.0), #number(96.0), #number(2.6), #number(2.3), #number(0.3), #number(2.0), #number(4.7), #number(1.0), #number(3.6), #number(1035.0), #symbol("0")],
                  [#number(13.7), #number(1.5), #number(2.7), #number(22.5), #number(101.0), #number(3.0), #number(3.2), #number(0.3), #number(2.4), #number(5.7), #number(1.2), #number(2.7), #number(1285.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.4), #number(19.1), #number(106.0), #number(2.9), #number(3.2), #number(0.2), #number(1.9), #number(6.9), #number(1.1), #number(2.9), #number(1515.0), #symbol("0")],
                  [#number(13.7), #number(1.8), #number(2.4), #number(17.2), #number(104.0), #number(2.4), #number(2.7), #number(0.4), #number(2.0), #number(3.8), #number(1.2), #number(2.9), #number(990.0), #symbol("0")],
                  [#number(13.8), #number(1.5), #number(2.7), #number(19.5), #number(132.0), #number(3.0), #number(2.7), #number(0.5), #number(1.4), #number(5.4), #number(1.2), #number(3.0), #number(1235.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.6), #number(19.0), #number(110.0), #number(2.4), #number(2.5), #number(0.3), #number(1.5), #number(4.2), #number(1.1), #number(2.9), #number(1095.0), #symbol("0")],
                  [#number(13.5), #number(1.8), #number(2.4), #number(20.5), #number(100.0), #number(2.7), #number(3.0), #number(0.3), #number(1.9), #number(5.1), #number(1.0), #number(3.5), #number(920.0), #symbol("0")],
                  [#number(13.3), #number(1.6), #number(2.8), #number(15.5), #number(110.0), #number(2.6), #number(2.7), #number(0.3), #number(1.4), #number(4.6), #number(1.1), #number(2.8), #number(880.0), #symbol("0")],
                  [#number(13.1), #number(1.6), #number(2.5), #number(18.0), #number(98.0), #number(2.5), #number(2.4), #number(0.3), #number(1.4), #number(4.2), #number(1.1), #number(2.5), #number(1105.0), #symbol("0")],
                  [#number(13.1), #number(1.5), #number(2.1), #number(15.5), #number(98.0), #number(2.4), #number(2.6), #number(0.3), #number(1.4), #number(3.7), #number(1.2), #number(2.7), #number(1020.0), #symbol("0")],
                  [#number(14.2), #number(4.0), #number(2.5), #number(13.2), #number(128.0), #number(3.0), #number(3.0), #number(0.2), #number(2.1), #number(5.1), #number(0.9), #number(3.5), #number(760.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.3), #number(16.2), #number(117.0), #number(3.1), #number(3.3), #number(0.3), #number(2.3), #number(6.1), #number(0.9), #number(3.4), #number(795.0), #symbol("0")],
                  [#number(13.4), #number(3.8), #number(2.1), #number(18.8), #number(90.0), #number(2.5), #number(2.7), #number(0.3), #number(1.5), #number(4.3), #number(0.9), #number(3.0), #number(1035.0), #symbol("0")],
                  [#number(13.9), #number(1.9), #number(2.6), #number(15.0), #number(101.0), #number(3.2), #number(3.6), #number(0.2), #number(1.7), #number(5.4), #number(0.9), #number(3.6), #number(1095.0), #symbol("0")],
                  [#number(13.2), #number(4.0), #number(2.3), #number(17.5), #number(103.0), #number(2.6), #number(2.6), #number(0.3), #number(1.7), #number(4.4), #number(0.8), #number(3.0), #number(680.0), #symbol("0")],
                  [#number(13.1), #number(1.8), #number(2.1), #number(17.0), #number(107.0), #number(3.0), #number(3.0), #number(0.3), #number(2.0), #number(5.0), #number(0.9), #number(3.4), #number(885.0), #symbol("0")],
                  [#number(14.2), #number(4.0), #number(2.4), #number(18.9), #number(111.0), #number(2.9), #number(2.6), #number(0.3), #number(1.2), #number(5.2), #number(0.9), #number(3.3), #number(1080.0), #symbol("0")],
                  [#number(14.4), #number(3.6), #number(2.3), #number(16.0), #number(102.0), #number(3.2), #number(3.2), #number(0.3), #number(2.2), #number(4.9), #number(1.0), #number(3.4), #number(1065.0), #symbol("0")],
                  [#number(13.9), #number(1.7), #number(2.1), #number(16.0), #number(101.0), #number(3.1), #number(3.4), #number(0.2), #number(2.1), #number(6.1), #number(0.9), #number(3.3), #number(985.0), #symbol("0")],
                  [#number(14.1), #number(2.0), #number(2.4), #number(18.8), #number(103.0), #number(2.8), #number(2.9), #number(0.3), #number(2.4), #number(6.2), #number(1.1), #number(2.8), #number(1060.0), #symbol("0")],
                  [#number(13.9), #number(1.7), #number(2.3), #number(17.4), #number(108.0), #number(2.9), #number(3.5), #number(0.3), #number(2.1), #number(8.9), #number(1.1), #number(3.1), #number(1260.0), #symbol("0")],
                  [#number(13.1), #number(1.7), #number(2.0), #number(12.4), #number(92.0), #number(2.7), #number(3.3), #number(0.2), #number(2.9), #number(7.2), #number(1.1), #number(2.9), #number(1150.0), #symbol("0")],
                  [#number(13.8), #number(1.6), #number(2.6), #number(17.2), #number(94.0), #number(2.5), #number(3.0), #number(0.2), #number(2.3), #number(5.6), #number(1.2), #number(3.4), #number(1265.0), #symbol("0")],
                  [#number(13.8), #number(1.8), #number(2.4), #number(14.0), #number(111.0), #number(3.9), #number(3.7), #number(0.3), #number(1.9), #number(7.0), #number(1.0), #number(3.3), #number(1190.0), #symbol("0")],
                  [#number(13.8), #number(1.9), #number(2.7), #number(17.1), #number(115.0), #number(3.0), #number(2.8), #number(0.4), #number(1.7), #number(6.3), #number(1.1), #number(2.9), #number(1375.0), #symbol("0")],
                  [#number(13.7), #number(1.7), #number(2.2), #number(16.4), #number(118.0), #number(2.6), #number(2.9), #number(0.2), #number(1.6), #number(5.8), #number(0.9), #number(3.2), #number(1060.0), #symbol("0")],
                  [#number(13.6), #number(1.7), #number(2.5), #number(20.5), #number(116.0), #number(3.0), #number(2.8), #number(0.2), #number(2.5), #number(6.2), #number(1.0), #number(3.0), #number(1120.0), #symbol("0")],
                  [#number(14.2), #number(1.7), #number(2.3), #number(16.3), #number(118.0), #number(3.2), #number(3.0), #number(0.3), #number(2.0), #number(6.4), #number(0.9), #number(3.3), #number(970.0), #symbol("0")],
                  [#number(13.3), #number(2.0), #number(2.7), #number(16.8), #number(102.0), #number(3.0), #number(3.2), #number(0.3), #number(1.7), #number(6.0), #number(1.1), #number(2.8), #number(1270.0), #symbol("0")],
                  [#number(13.7), #number(1.4), #number(2.5), #number(16.7), #number(108.0), #number(3.4), #number(3.7), #number(0.2), #number(2.0), #number(6.8), #number(0.9), #number(2.9), #number(1285.0), #symbol("0")],
                  [#number(12.4), #number(0.9), #number(1.4), #number(10.6), #number(88.0), #number(2.0), #number(0.6), #number(0.3), #number(0.4), #number(1.9), #number(1.1), #number(1.8), #number(520.0), #symbol("1")],
                  [#number(12.3), #number(1.1), #number(2.3), #number(16.0), #number(101.0), #number(2.0), #number(1.1), #number(0.6), #number(0.4), #number(3.3), #number(1.2), #number(1.7), #number(680.0), #symbol("1")],
                  [#number(12.6), #number(1.4), #number(2.0), #number(16.8), #number(100.0), #number(2.0), #number(1.4), #number(0.5), #number(0.6), #number(5.8), #number(1.0), #number(1.6), #number(450.0), #symbol("1")],
                  [#number(13.7), #number(1.2), #number(1.9), #number(18.0), #number(94.0), #number(2.1), #number(1.8), #number(0.3), #number(0.7), #number(3.8), #number(1.2), #number(2.5), #number(630.0), #symbol("1")],
                  [#number(12.4), #number(1.1), #number(2.2), #number(19.0), #number(87.0), #number(3.5), #number(3.1), #number(0.2), #number(1.9), #number(4.5), #number(1.2), #number(2.9), #number(420.0), #symbol("1")],
                  [#number(12.2), #number(1.4), #number(2.5), #number(19.0), #number(104.0), #number(1.9), #number(1.8), #number(0.5), #number(1.0), #number(3.0), #number(1.4), #number(2.2), #number(355.0), #symbol("1")],
                  [#number(12.4), #number(1.2), #number(2.6), #number(18.1), #number(98.0), #number(2.4), #number(2.6), #number(0.4), #number(2.1), #number(4.6), #number(1.2), #number(2.3), #number(678.0), #symbol("1")],
                  [#number(13.1), #number(1.0), #number(1.7), #number(15.0), #number(78.0), #number(3.0), #number(3.2), #number(0.3), #number(2.3), #number(5.3), #number(1.1), #number(3.2), #number(502.0), #symbol("1")],
                  [#number(12.4), #number(1.2), #number(1.9), #number(19.6), #number(78.0), #number(2.1), #number(2.0), #number(0.3), #number(1.0), #number(4.7), #number(1.1), #number(3.5), #number(510.0), #symbol("1")],
                  [#number(13.3), #number(0.9), #number(2.4), #number(17.0), #number(110.0), #number(2.5), #number(1.3), #number(0.6), #number(0.4), #number(3.2), #number(1.0), #number(1.9), #number(750.0), #symbol("1")],
                  [#number(12.2), #number(1.2), #number(1.8), #number(16.8), #number(151.0), #number(1.9), #number(1.3), #number(0.1), #number(2.5), #number(2.9), #number(1.3), #number(3.1), #number(718.0), #symbol("1")],
                  [#number(12.3), #number(1.6), #number(2.2), #number(20.4), #number(103.0), #number(1.1), #number(1.0), #number(0.4), #number(1.5), #number(3.0), #number(0.9), #number(1.8), #number(870.0), #symbol("1")],
                  [#number(13.9), #number(1.5), #number(2.7), #number(25.0), #number(86.0), #number(3.0), #number(2.9), #number(0.2), #number(1.9), #number(3.4), #number(1.4), #number(3.2), #number(410.0), #symbol("1")],
                  [#number(13.5), #number(1.7), #number(2.2), #number(24.0), #number(87.0), #number(1.9), #number(1.8), #number(0.3), #number(1.0), #number(3.7), #number(1.0), #number(2.8), #number(472.0), #symbol("1")],
                  [#number(13.0), #number(1.7), #number(2.6), #number(30.0), #number(139.0), #number(3.3), #number(2.9), #number(0.2), #number(2.0), #number(3.4), #number(1.3), #number(3.5), #number(985.0), #symbol("1")],
                  [#number(12.0), #number(1.1), #number(2.3), #number(21.0), #number(101.0), #number(3.4), #number(2.1), #number(0.1), #number(1.6), #number(3.2), #number(1.0), #number(3.1), #number(886.0), #symbol("1")],
                  [#number(11.7), #number(1.9), #number(1.9), #number(16.0), #number(97.0), #number(1.6), #number(1.6), #number(0.3), #number(1.1), #number(3.8), #number(1.2), #number(2.1), #number(428.0), #symbol("1")],
                  [#number(13.0), #number(0.9), #number(1.7), #number(16.0), #number(86.0), #number(1.9), #number(2.0), #number(0.2), #number(1.5), #number(4.6), #number(1.2), #number(2.5), #number(392.0), #symbol("1")],
                  [#number(11.8), #number(2.9), #number(2.2), #number(18.0), #number(112.0), #number(1.7), #number(1.3), #number(0.4), #number(0.9), #number(2.6), #number(1.0), #number(2.5), #number(500.0), #symbol("1")],
                  [#number(12.3), #number(1.0), #number(1.9), #number(14.8), #number(136.0), #number(1.9), #number(1.9), #number(0.3), #number(2.8), #number(3.4), #number(1.1), #number(2.3), #number(750.0), #symbol("1")],
                  [#number(12.7), #number(3.9), #number(2.4), #number(23.0), #number(101.0), #number(2.8), #number(2.5), #number(0.4), #number(1.9), #number(2.6), #number(1.2), #number(3.1), #number(463.0), #symbol("1")],
                  [#number(12.0), #number(0.9), #number(2.0), #number(19.0), #number(86.0), #number(2.4), #number(2.3), #number(0.3), #number(1.4), #number(2.5), #number(1.4), #number(3.1), #number(278.0), #symbol("1")],
                  [#number(12.7), #number(1.8), #number(2.2), #number(18.8), #number(86.0), #number(2.2), #number(2.5), #number(0.3), #number(1.8), #number(3.9), #number(1.2), #number(3.1), #number(714.0), #symbol("1")],
                  [#number(12.1), #number(1.1), #number(2.5), #number(24.0), #number(78.0), #number(2.0), #number(1.6), #number(0.4), #number(1.4), #number(2.2), #number(1.3), #number(2.7), #number(630.0), #symbol("1")],
                  [#number(13.1), #number(3.9), #number(2.3), #number(22.5), #number(85.0), #number(1.6), #number(1.6), #number(0.6), #number(1.6), #number(4.8), #number(0.8), #number(2.0), #number(515.0), #symbol("1")],
                  [#number(11.8), #number(0.9), #number(2.6), #number(18.0), #number(94.0), #number(2.2), #number(2.2), #number(0.2), #number(2.4), #number(3.0), #number(0.8), #number(3.1), #number(520.0), #symbol("1")],
                  [#number(12.7), #number(1.0), #number(2.2), #number(18.0), #number(99.0), #number(2.2), #number(1.9), #number(0.3), #number(1.5), #number(2.6), #number(1.2), #number(3.2), #number(450.0), #symbol("1")],
                  [#number(12.2), #number(1.6), #number(2.3), #number(22.8), #number(90.0), #number(1.8), #number(1.7), #number(0.4), #number(1.6), #number(2.5), #number(1.3), #number(2.3), #number(495.0), #symbol("1")],
                  [#number(11.7), #number(1.7), #number(2.6), #number(26.0), #number(88.0), #number(1.9), #number(1.6), #number(0.4), #number(1.3), #number(2.6), #number(1.4), #number(3.2), #number(562.0), #symbol("1")],
                  [#number(11.6), #number(2.1), #number(2.5), #number(21.6), #number(84.0), #number(1.9), #number(1.7), #number(0.5), #number(1.4), #number(2.8), #number(1.0), #number(2.8), #number(680.0), #symbol("1")],
                  [#number(12.1), #number(1.3), #number(2.3), #number(23.6), #number(70.0), #number(2.2), #number(1.6), #number(0.4), #number(1.4), #number(1.7), #number(1.1), #number(3.2), #number(625.0), #symbol("1")],
                  [#number(12.1), #number(1.8), #number(2.3), #number(18.5), #number(81.0), #number(1.6), #number(1.5), #number(0.5), #number(1.6), #number(2.4), #number(1.1), #number(2.3), #number(480.0), #symbol("1")],
                  [#number(12.0), #number(1.5), #number(2.4), #number(22.0), #number(86.0), #number(1.4), #number(1.2), #number(0.5), #number(1.6), #number(3.6), #number(1.1), #number(2.6), #number(450.0), #symbol("1")],
                  [#number(12.7), #number(1.5), #number(2.3), #number(20.7), #number(80.0), #number(1.4), #number(1.5), #number(0.6), #number(1.6), #number(3.0), #number(1.0), #number(2.1), #number(495.0), #symbol("1")],
                  [#number(12.3), #number(2.8), #number(2.2), #number(18.0), #number(88.0), #number(2.5), #number(2.2), #number(0.2), #number(2.0), #number(2.1), #number(1.1), #number(3.3), #number(290.0), #symbol("1")],
                  [#number(11.6), #number(2.0), #number(2.3), #number(18.0), #number(98.0), #number(3.0), #number(2.3), #number(0.2), #number(1.4), #number(3.2), #number(1.2), #number(3.0), #number(345.0), #symbol("1")],
                  [#number(12.5), #number(1.5), #number(2.2), #number(19.0), #number(162.0), #number(2.5), #number(2.3), #number(0.3), #number(3.3), #number(2.6), #number(1.2), #number(2.6), #number(937.0), #symbol("1")],
                  [#number(11.8), #number(2.1), #number(2.7), #number(21.5), #number(134.0), #number(1.6), #number(1.0), #number(0.1), #number(1.6), #number(2.5), #number(0.9), #number(2.3), #number(625.0), #symbol("1")],
                  [#number(12.3), #number(1.4), #number(2.0), #number(16.0), #number(85.0), #number(2.5), #number(2.5), #number(0.3), #number(1.8), #number(2.9), #number(1.2), #number(2.7), #number(428.0), #symbol("1")],
                  [#number(12.4), #number(1.1), #number(2.1), #number(18.5), #number(88.0), #number(3.5), #number(3.8), #number(0.2), #number(1.9), #number(4.5), #number(1.0), #number(2.8), #number(660.0), #symbol("1")],
                  [#number(12.3), #number(3.2), #number(2.2), #number(18.0), #number(88.0), #number(2.9), #number(3.0), #number(0.5), #number(2.8), #number(2.3), #number(1.4), #number(2.8), #number(406.0), #symbol("1")],
                  [#number(12.1), #number(2.1), #number(1.7), #number(17.5), #number(97.0), #number(2.2), #number(2.2), #number(0.3), #number(1.4), #number(3.3), #number(1.3), #number(3.0), #number(710.0), #symbol("1")],
                  [#number(12.6), #number(1.3), #number(1.9), #number(18.5), #number(88.0), #number(1.4), #number(1.4), #number(0.3), #number(1.4), #number(2.5), #number(1.0), #number(2.8), #number(562.0), #symbol("1")],
                  [#number(12.3), #number(2.5), #number(2.5), #number(21.0), #number(98.0), #number(2.6), #number(2.1), #number(0.3), #number(1.3), #number(2.8), #number(0.8), #number(3.4), #number(438.0), #symbol("1")],
                  [#number(11.8), #number(1.7), #number(1.9), #number(19.5), #number(86.0), #number(2.5), #number(1.6), #number(0.4), #number(1.4), #number(2.1), #number(0.9), #number(2.4), #number(415.0), #symbol("1")],
                  [#number(12.5), #number(1.7), #number(2.0), #number(20.5), #number(85.0), #number(2.2), #number(1.9), #number(0.3), #number(1.5), #number(2.9), #number(1.0), #number(3.6), #number(672.0), #symbol("1")],
                  [#number(12.4), #number(2.5), #number(2.3), #number(22.0), #number(90.0), #number(1.7), #number(1.8), #number(0.7), #number(1.4), #number(2.7), #number(0.9), #number(3.3), #number(315.0), #symbol("1")],
                  [#number(12.2), #number(1.7), #number(2.1), #number(19.0), #number(80.0), #number(1.6), #number(2.0), #number(0.4), #number(1.6), #number(3.4), #number(1.0), #number(3.2), #number(510.0), #symbol("1")],
                  [#number(12.7), #number(1.8), #number(2.3), #number(22.5), #number(84.0), #number(1.4), #number(1.8), #number(0.5), #number(1.6), #number(3.3), #number(0.9), #number(2.4), #number(488.0), #symbol("1")],
                  [#number(12.2), #number(1.3), #number(1.9), #number(19.0), #number(92.0), #number(2.4), #number(2.0), #number(0.4), #number(2.1), #number(2.7), #number(0.9), #number(3.0), #number(312.0), #symbol("1")],
                  [#number(11.6), #number(1.4), #number(2.7), #number(20.0), #number(94.0), #number(2.7), #number(2.9), #number(0.3), #number(2.5), #number(2.6), #number(1.0), #number(3.3), #number(680.0), #symbol("1")],
                  [#number(11.5), #number(3.7), #number(1.8), #number(19.5), #number(107.0), #number(3.2), #number(2.6), #number(0.2), #number(3.6), #number(2.9), #number(0.8), #number(2.8), #number(562.0), #symbol("1")],
                  [#number(12.5), #number(2.4), #number(2.2), #number(21.0), #number(88.0), #number(2.5), #number(2.3), #number(0.3), #number(1.2), #number(2.0), #number(0.9), #number(2.8), #number(325.0), #symbol("1")],
                  [#number(11.8), #number(2.7), #number(2.9), #number(20.0), #number(103.0), #number(1.8), #number(2.0), #number(0.6), #number(1.1), #number(3.8), #number(1.2), #number(2.5), #number(607.0), #symbol("1")],
                  [#number(11.4), #number(0.7), #number(2.5), #number(21.0), #number(88.0), #number(2.5), #number(2.0), #number(0.4), #number(1.4), #number(3.1), #number(1.1), #number(2.3), #number(434.0), #symbol("1")],
                  [#number(12.1), #number(1.4), #number(2.5), #number(22.5), #number(84.0), #number(2.6), #number(2.3), #number(0.4), #number(1.0), #number(2.9), #number(0.9), #number(3.2), #number(385.0), #symbol("1")],
                  [#number(11.0), #number(1.5), #number(2.2), #number(21.5), #number(85.0), #number(2.5), #number(2.2), #number(0.5), #number(2.0), #number(1.9), #number(1.7), #number(2.9), #number(407.0), #symbol("1")],
                  [#number(11.8), #number(1.5), #number(2.0), #number(20.8), #number(86.0), #number(2.0), #number(1.6), #number(0.3), #number(1.5), #number(1.9), #number(0.9), #number(3.3), #number(495.0), #symbol("1")],
                  [#number(12.4), #number(1.6), #number(2.2), #number(22.5), #number(108.0), #number(2.0), #number(2.1), #number(0.3), #number(1.6), #number(2.1), #number(1.1), #number(3.0), #number(345.0), #symbol("1")],
                  [#number(12.8), #number(3.4), #number(2.0), #number(16.0), #number(80.0), #number(1.6), #number(1.2), #number(0.4), #number(0.8), #number(3.4), #number(0.7), #number(2.1), #number(372.0), #symbol("1")],
                  [#number(12.0), #number(3.4), #number(2.0), #number(19.0), #number(87.0), #number(2.0), #number(1.6), #number(0.4), #number(1.9), #number(1.3), #number(0.9), #number(3.0), #number(564.0), #symbol("1")],
                  [#number(11.4), #number(2.4), #number(2.4), #number(20.0), #number(96.0), #number(2.9), #number(2.8), #number(0.3), #number(1.8), #number(3.2), #number(0.8), #number(3.4), #number(625.0), #symbol("1")],
                  [#number(11.6), #number(2.0), #number(3.2), #number(28.5), #number(119.0), #number(3.2), #number(5.1), #number(0.5), #number(1.9), #number(6.0), #number(0.9), #number(3.7), #number(465.0), #symbol("1")],
                  [#number(12.4), #number(4.4), #number(2.7), #number(26.5), #number(102.0), #number(2.2), #number(2.1), #number(0.4), #number(1.7), #number(2.1), #number(0.9), #number(3.1), #number(365.0), #symbol("1")],
                  [#number(13.1), #number(5.8), #number(2.1), #number(21.5), #number(86.0), #number(2.6), #number(2.6), #number(0.3), #number(2.0), #number(2.6), #number(0.7), #number(3.1), #number(380.0), #symbol("1")],
                  [#number(11.9), #number(4.3), #number(2.4), #number(21.0), #number(82.0), #number(2.9), #number(3.0), #number(0.2), #number(2.9), #number(2.8), #number(0.8), #number(3.6), #number(380.0), #symbol("1")],
                  [#number(12.1), #number(2.2), #number(2.2), #number(21.0), #number(85.0), #number(2.6), #number(2.6), #number(0.4), #number(1.4), #number(2.8), #number(0.9), #number(3.3), #number(378.0), #symbol("1")],
                  [#number(12.4), #number(1.5), #number(2.3), #number(21.5), #number(86.0), #number(2.7), #number(3.1), #number(0.4), #number(1.8), #number(3.9), #number(0.7), #number(2.8), #number(352.0), #symbol("1")],
                  [#number(11.8), #number(2.1), #number(2.8), #number(28.5), #number(92.0), #number(2.1), #number(2.2), #number(0.6), #number(1.8), #number(3.0), #number(1.0), #number(2.4), #number(466.0), #symbol("1")],
                  [#number(12.4), #number(1.6), #number(2.3), #number(24.5), #number(88.0), #number(2.2), #number(2.5), #number(0.4), #number(1.9), #number(2.1), #number(0.9), #number(2.8), #number(342.0), #symbol("1")],
                  [#number(12.0), #number(4.3), #number(2.4), #number(22.0), #number(80.0), #number(2.1), #number(1.8), #number(0.4), #number(1.4), #number(2.6), #number(0.8), #number(2.6), #number(580.0), #symbol("1")],
                  [#number(12.9), #number(1.4), #number(2.3), #number(18.0), #number(122.0), #number(1.5), #number(1.2), #number(0.2), #number(0.9), #number(4.1), #number(0.8), #number(1.3), #number(630.0), #symbol("2")],
                  [#number(12.9), #number(3.0), #number(2.4), #number(20.0), #number(104.0), #number(1.3), #number(1.2), #number(0.2), #number(0.8), #number(5.4), #number(0.7), #number(1.4), #number(530.0), #symbol("2")],
                  [#number(12.8), #number(2.3), #number(2.4), #number(24.0), #number(98.0), #number(1.1), #number(1.1), #number(0.3), #number(0.8), #number(5.7), #number(0.7), #number(1.4), #number(560.0), #symbol("2")],
                  [#number(12.7), #number(3.5), #number(2.4), #number(21.5), #number(106.0), #number(1.7), #number(1.2), #number(0.2), #number(0.8), #number(5.0), #number(0.8), #number(1.3), #number(600.0), #symbol("2")],
                  [#number(12.5), #number(1.2), #number(2.2), #number(17.5), #number(85.0), #number(2.0), #number(0.6), #number(0.6), #number(1.2), #number(5.5), #number(0.8), #number(1.5), #number(650.0), #symbol("2")],
                  [#number(12.6), #number(2.5), #number(2.2), #number(18.5), #number(94.0), #number(1.6), #number(0.7), #number(0.6), #number(0.9), #number(7.1), #number(0.7), #number(1.6), #number(695.0), #symbol("2")],
                  [#number(12.2), #number(4.7), #number(2.5), #number(21.0), #number(89.0), #number(1.4), #number(0.5), #number(0.5), #number(0.8), #number(3.9), #number(0.8), #number(1.3), #number(720.0), #symbol("2")],
                  [#number(12.5), #number(5.5), #number(2.6), #number(25.0), #number(96.0), #number(1.8), #number(0.6), #number(0.6), #number(1.1), #number(5.0), #number(0.8), #number(1.7), #number(515.0), #symbol("2")],
                  [#number(13.5), #number(3.6), #number(2.2), #number(19.5), #number(88.0), #number(1.6), #number(0.5), #number(0.6), #number(0.9), #number(5.7), #number(0.8), #number(1.8), #number(580.0), #symbol("2")],
                  [#number(12.8), #number(3.0), #number(2.6), #number(24.0), #number(101.0), #number(2.3), #number(0.6), #number(0.5), #number(0.8), #number(4.9), #number(0.9), #number(2.1), #number(590.0), #symbol("2")],
                  [#number(12.9), #number(2.8), #number(2.7), #number(21.0), #number(96.0), #number(1.5), #number(0.5), #number(0.5), #number(0.8), #number(4.6), #number(0.8), #number(2.3), #number(600.0), #symbol("2")],
                  [#number(13.4), #number(2.6), #number(2.4), #number(20.0), #number(89.0), #number(1.4), #number(0.5), #number(0.4), #number(0.6), #number(5.6), #number(0.7), #number(2.5), #number(780.0), #symbol("2")],
                  [#number(13.5), #number(3.2), #number(2.7), #number(23.5), #number(97.0), #number(1.6), #number(0.5), #number(0.5), #number(0.6), #number(4.3), #number(0.9), #number(2.1), #number(520.0), #symbol("2")],
                  [#number(13.6), #number(5.0), #number(2.4), #number(20.0), #number(92.0), #number(2.0), #number(0.8), #number(0.5), #number(1.0), #number(4.4), #number(0.9), #number(2.0), #number(550.0), #symbol("2")],
                  [#number(12.2), #number(3.9), #number(2.2), #number(18.5), #number(112.0), #number(1.4), #number(0.8), #number(0.3), #number(1.1), #number(8.2), #number(0.7), #number(2.0), #number(855.0), #symbol("2")],
                  [#number(13.2), #number(3.6), #number(2.1), #number(21.0), #number(102.0), #number(1.5), #number(0.6), #number(0.4), #number(1.3), #number(4.0), #number(0.6), #number(1.7), #number(830.0), #symbol("2")],
                  [#number(13.9), #number(5.0), #number(2.2), #number(20.0), #number(80.0), #number(1.0), #number(0.3), #number(0.4), #number(0.7), #number(4.9), #number(0.6), #number(1.3), #number(415.0), #symbol("2")],
                  [#number(12.9), #number(4.6), #number(2.5), #number(21.5), #number(86.0), #number(1.7), #number(0.7), #number(0.5), #number(0.9), #number(7.7), #number(0.5), #number(1.9), #number(625.0), #symbol("2")],
                  [#number(13.3), #number(3.2), #number(2.4), #number(21.5), #number(92.0), #number(1.9), #number(0.8), #number(0.5), #number(1.2), #number(8.4), #number(0.6), #number(1.6), #number(650.0), #symbol("2")],
                  [#number(13.1), #number(3.9), #number(2.4), #number(21.5), #number(113.0), #number(1.4), #number(1.4), #number(0.3), #number(1.1), #number(9.4), #number(0.6), #number(1.3), #number(550.0), #symbol("2")],
                  [#number(13.5), #number(3.1), #number(2.6), #number(24.0), #number(123.0), #number(1.4), #number(1.6), #number(0.2), #number(1.2), #number(8.6), #number(0.6), #number(1.3), #number(500.0), #symbol("2")],
                  [#number(12.8), #number(2.7), #number(2.5), #number(22.0), #number(112.0), #number(1.5), #number(1.4), #number(0.2), #number(1.3), #number(10.8), #number(0.5), #number(1.5), #number(480.0), #symbol("2")],
                  [#number(13.1), #number(1.9), #number(2.8), #number(25.5), #number(116.0), #number(2.2), #number(1.3), #number(0.3), #number(1.6), #number(7.1), #number(0.6), #number(1.3), #number(425.0), #symbol("2")],
                  [#number(13.2), #number(3.3), #number(2.3), #number(18.5), #number(98.0), #number(1.8), #number(0.8), #number(0.6), #number(1.9), #number(10.5), #number(0.6), #number(1.5), #number(675.0), #symbol("2")],
                  [#number(12.6), #number(1.3), #number(2.1), #number(20.0), #number(103.0), #number(1.5), #number(0.6), #number(0.5), #number(1.4), #number(7.6), #number(0.6), #number(1.6), #number(640.0), #symbol("2")],
                  [#number(13.2), #number(5.2), #number(2.3), #number(22.0), #number(93.0), #number(1.7), #number(0.6), #number(0.6), #number(1.6), #number(7.9), #number(0.6), #number(1.5), #number(725.0), #symbol("2")],
                  [#number(13.8), #number(4.1), #number(2.4), #number(19.5), #number(89.0), #number(1.8), #number(0.8), #number(0.5), #number(1.6), #number(9.0), #number(0.6), #number(1.6), #number(480.0), #symbol("2")],
                  [#number(12.4), #number(3.0), #number(2.6), #number(27.0), #number(97.0), #number(1.9), #number(0.6), #number(0.6), #number(1.1), #number(7.5), #number(0.7), #number(1.7), #number(880.0), #symbol("2")],
                  [#number(14.3), #number(1.7), #number(2.7), #number(25.0), #number(98.0), #number(2.8), #number(1.3), #number(0.5), #number(2.7), #number(13.0), #number(0.6), #number(2.0), #number(660.0), #symbol("2")],
                  [#number(13.5), #number(1.7), #number(2.6), #number(22.5), #number(89.0), #number(2.6), #number(1.1), #number(0.5), #number(2.3), #number(11.8), #number(0.6), #number(1.8), #number(620.0), #symbol("2")],
                  [#number(12.4), #number(3.8), #number(2.4), #number(21.0), #number(88.0), #number(2.3), #number(0.9), #number(0.5), #number(1.0), #number(7.7), #number(0.6), #number(1.6), #number(520.0), #symbol("2")],
                  [#number(13.7), #number(3.3), #number(2.5), #number(20.0), #number(107.0), #number(1.8), #number(0.6), #number(0.5), #number(0.8), #number(5.9), #number(1.0), #number(1.8), #number(680.0), #symbol("2")],
                  [#number(12.8), #number(3.3), #number(2.6), #number(22.0), #number(106.0), #number(1.6), #number(0.6), #number(0.6), #number(1.0), #number(5.6), #number(0.9), #number(2.1), #number(570.0), #symbol("2")],
                  [#number(13.0), #number(3.5), #number(2.4), #number(18.5), #number(106.0), #number(1.4), #number(0.7), #number(0.4), #number(0.9), #number(5.3), #number(0.7), #number(1.8), #number(675.0), #symbol("2")],
                  [#number(13.8), #number(2.8), #number(2.3), #number(22.0), #number(90.0), #number(1.4), #number(0.7), #number(0.4), #number(1.0), #number(9.6), #number(0.7), #number(1.7), #number(615.0), #symbol("2")],
                  [#number(13.7), #number(4.4), #number(2.3), #number(22.5), #number(88.0), #number(1.3), #number(0.5), #number(0.5), #number(1.1), #number(6.6), #number(0.8), #number(1.8), #number(520.0), #symbol("2")],
                  [#number(13.4), #number(3.7), #number(2.6), #number(23.0), #number(111.0), #number(1.7), #number(0.9), #number(0.4), #number(1.5), #number(10.7), #number(0.8), #number(1.6), #number(695.0), #symbol("2")],
                  [#number(12.8), #number(3.4), #number(2.3), #number(19.5), #number(88.0), #number(1.5), #number(0.7), #number(0.4), #number(1.0), #number(10.3), #number(0.7), #number(1.8), #number(685.0), #symbol("2")],
                  [#number(13.6), #number(2.6), #number(2.7), #number(24.5), #number(105.0), #number(1.6), #number(0.8), #number(0.4), #number(1.5), #number(8.7), #number(0.7), #number(1.8), #number(750.0), #symbol("2")],
                  [#number(13.4), #number(4.6), #number(2.9), #number(25.0), #number(112.0), #number(2.0), #number(1.0), #number(0.3), #number(1.1), #number(8.5), #number(0.7), #number(1.9), #number(630.0), #symbol("2")],
                  [#number(12.2), #number(3.0), #number(2.3), #number(19.0), #number(96.0), #number(1.2), #number(0.5), #number(0.4), #number(0.7), #number(5.5), #number(0.7), #number(1.8), #number(510.0), #symbol("2")],
                  [#number(12.8), #number(2.4), #number(2.3), #number(19.5), #number(86.0), #number(1.4), #number(0.5), #number(0.5), #number(0.6), #number(9.9), #number(0.6), #number(1.6), #number(470.0), #symbol("2")],
                  [#number(14.2), #number(2.5), #number(2.5), #number(20.0), #number(91.0), #number(1.7), #number(0.7), #number(0.4), #number(1.2), #number(9.7), #number(0.6), #number(1.7), #number(660.0), #symbol("2")],
                  [#number(13.7), #number(5.7), #number(2.5), #number(20.5), #number(95.0), #number(1.7), #number(0.6), #number(0.5), #number(1.1), #number(7.7), #number(0.6), #number(1.7), #number(740.0), #symbol("2")],
                  [#number(13.4), #number(3.9), #number(2.5), #number(23.0), #number(102.0), #number(1.8), #number(0.8), #number(0.4), #number(1.4), #number(7.3), #number(0.7), #number(1.6), #number(750.0), #symbol("2")],
                  [#number(13.3), #number(4.3), #number(2.3), #number(20.0), #number(120.0), #number(1.6), #number(0.7), #number(0.4), #number(1.4), #number(10.2), #number(0.6), #number(1.6), #number(835.0), #symbol("2")],
                  [#number(13.2), #number(2.6), #number(2.4), #number(20.0), #number(120.0), #number(1.6), #number(0.7), #number(0.5), #number(1.5), #number(9.3), #number(0.6), #number(1.6), #number(840.0), #symbol("2")],
                  [#number(14.1), #number(4.1), #number(2.7), #number(24.5), #number(96.0), #number(2.0), #number(0.8), #number(0.6), #number(1.4), #number(9.2), #number(0.6), #number(1.6), #number(560.0), #symbol("2")]];

    public let iris_data: [[dataMember]] =  [[#number(5.1), #number(3.5), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.0), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.7), #number(3.2), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(4.6), #number(3.1), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.6), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(5.4), #number(3.9), #number(1.7), #number(0.4), #symbol("0")],
                                      [#number(4.6), #number(3.4), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.0), #number(3.4), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(4.4), #number(2.9), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.1), #number(1.5), #number(0.1), #symbol("0")],
                                      [#number(5.4), #number(3.7), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.4), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.0), #number(1.4), #number(0.1), #symbol("0")],
                                      [#number(4.3), #number(3.0), #number(1.1), #number(0.1), #symbol("0")],
                                      [#number(5.8), #number(4.0), #number(1.2), #number(0.2), #symbol("0")],
                                      [#number(5.7), #number(4.4), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(5.4), #number(3.9), #number(1.3), #number(0.4), #symbol("0")],
                                      [#number(5.1), #number(3.5), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.7), #number(3.8), #number(1.7), #number(0.3), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.5), #number(0.3), #symbol("0")],
                                      [#number(5.4), #number(3.4), #number(1.7), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.7), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(4.6), #number(3.6), #number(1.0), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.3), #number(1.7), #number(0.5), #symbol("0")],
                                      [#number(4.8), #number(3.4), #number(1.9), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.0), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.4), #number(1.6), #number(0.4), #symbol("0")],
                                      [#number(5.2), #number(3.5), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.2), #number(3.4), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.7), #number(3.2), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.8), #number(3.1), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(5.4), #number(3.4), #number(1.5), #number(0.4), #symbol("0")],
                                      [#number(5.2), #number(4.1), #number(1.5), #number(0.1), #symbol("0")],
                                      [#number(5.5), #number(4.2), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.1), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.2), #number(1.2), #number(0.2), #symbol("0")],
                                      [#number(5.5), #number(3.5), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(4.9), #number(3.6), #number(1.4), #number(0.1), #symbol("0")],
                                      [#number(4.4), #number(3.0), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(5.1), #number(3.4), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.5), #number(1.3), #number(0.3), #symbol("0")],
                                      [#number(4.5), #number(2.3), #number(1.3), #number(0.3), #symbol("0")],
                                      [#number(4.4), #number(3.2), #number(1.3), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.5), #number(1.6), #number(0.6), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.9), #number(0.4), #symbol("0")],
                                      [#number(4.8), #number(3.0), #number(1.4), #number(0.3), #symbol("0")],
                                      [#number(5.1), #number(3.8), #number(1.6), #number(0.2), #symbol("0")],
                                      [#number(4.6), #number(3.2), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(5.3), #number(3.7), #number(1.5), #number(0.2), #symbol("0")],
                                      [#number(5.0), #number(3.3), #number(1.4), #number(0.2), #symbol("0")],
                                      [#number(7.0), #number(3.2), #number(4.7), #number(1.4), #symbol("1")],
                                      [#number(6.4), #number(3.2), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(6.9), #number(3.1), #number(4.9), #number(1.5), #symbol("1")],
                                      [#number(5.5), #number(2.3), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(6.5), #number(2.8), #number(4.6), #number(1.5), #symbol("1")],
                                      [#number(5.7), #number(2.8), #number(4.5), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(3.3), #number(4.7), #number(1.6), #symbol("1")],
                                      [#number(4.9), #number(2.4), #number(3.3), #number(1.0), #symbol("1")],
                                      [#number(6.6), #number(2.9), #number(4.6), #number(1.3), #symbol("1")],
                                      [#number(5.2), #number(2.7), #number(3.9), #number(1.4), #symbol("1")],
                                      [#number(5.0), #number(2.0), #number(3.5), #number(1.0), #symbol("1")],
                                      [#number(5.9), #number(3.0), #number(4.2), #number(1.5), #symbol("1")],
                                      [#number(6.0), #number(2.2), #number(4.0), #number(1.0), #symbol("1")],
                                      [#number(6.1), #number(2.9), #number(4.7), #number(1.4), #symbol("1")],
                                      [#number(5.6), #number(2.9), #number(3.6), #number(1.3), #symbol("1")],
                                      [#number(6.7), #number(3.1), #number(4.4), #number(1.4), #symbol("1")],
                                      [#number(5.6), #number(3.0), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.8), #number(2.7), #number(4.1), #number(1.0), #symbol("1")],
                                      [#number(6.2), #number(2.2), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.6), #number(2.5), #number(3.9), #number(1.1), #symbol("1")],
                                      [#number(5.9), #number(3.2), #number(4.8), #number(1.8), #symbol("1")],
                                      [#number(6.1), #number(2.8), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(2.5), #number(4.9), #number(1.5), #symbol("1")],
                                      [#number(6.1), #number(2.8), #number(4.7), #number(1.2), #symbol("1")],
                                      [#number(6.4), #number(2.9), #number(4.3), #number(1.3), #symbol("1")],
                                      [#number(6.6), #number(3.0), #number(4.4), #number(1.4), #symbol("1")],
                                      [#number(6.8), #number(2.8), #number(4.8), #number(1.4), #symbol("1")],
                                      [#number(6.7), #number(3.0), #number(5.0), #number(1.7), #symbol("1")],
                                      [#number(6.0), #number(2.9), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(5.7), #number(2.6), #number(3.5), #number(1.0), #symbol("1")],
                                      [#number(5.5), #number(2.4), #number(3.8), #number(1.1), #symbol("1")],
                                      [#number(5.5), #number(2.4), #number(3.7), #number(1.0), #symbol("1")],
                                      [#number(5.8), #number(2.7), #number(3.9), #number(1.2), #symbol("1")],
                                      [#number(6.0), #number(2.7), #number(5.1), #number(1.6), #symbol("1")],
                                      [#number(5.4), #number(3.0), #number(4.5), #number(1.5), #symbol("1")],
                                      [#number(6.0), #number(3.4), #number(4.5), #number(1.6), #symbol("1")],
                                      [#number(6.7), #number(3.1), #number(4.7), #number(1.5), #symbol("1")],
                                      [#number(6.3), #number(2.3), #number(4.4), #number(1.3), #symbol("1")],
                                      [#number(5.6), #number(3.0), #number(4.1), #number(1.3), #symbol("1")],
                                      [#number(5.5), #number(2.5), #number(4.0), #number(1.3), #symbol("1")],
                                      [#number(5.5), #number(2.6), #number(4.4), #number(1.2), #symbol("1")],
                                      [#number(6.1), #number(3.0), #number(4.6), #number(1.4), #symbol("1")],
                                      [#number(5.8), #number(2.6), #number(4.0), #number(1.2), #symbol("1")],
                                      [#number(5.0), #number(2.3), #number(3.3), #number(1.0), #symbol("1")],
                                      [#number(5.6), #number(2.7), #number(4.2), #number(1.3), #symbol("1")],
                                      [#number(5.7), #number(3.0), #number(4.2), #number(1.2), #symbol("1")],
                                      [#number(5.7), #number(2.9), #number(4.2), #number(1.3), #symbol("1")],
                                      [#number(6.2), #number(2.9), #number(4.3), #number(1.3), #symbol("1")],
                                      [#number(5.1), #number(2.5), #number(3.0), #number(1.1), #symbol("1")],
                                      [#number(5.7), #number(2.8), #number(4.1), #number(1.3), #symbol("1")],
                                      [#number(6.3), #number(3.3), #number(6.0), #number(2.5), #symbol("2")],
                                      [#number(5.8), #number(2.7), #number(5.1), #number(1.9), #symbol("2")],
                                      [#number(7.1), #number(3.0), #number(5.9), #number(2.1), #symbol("2")],
                                      [#number(6.3), #number(2.9), #number(5.6), #number(1.8), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.8), #number(2.2), #symbol("2")],
                                      [#number(7.6), #number(3.0), #number(6.6), #number(2.1), #symbol("2")],
                                      [#number(4.9), #number(2.5), #number(4.5), #number(1.7), #symbol("2")],
                                      [#number(7.3), #number(2.9), #number(6.3), #number(1.8), #symbol("2")],
                                      [#number(6.7), #number(2.5), #number(5.8), #number(1.8), #symbol("2")],
                                      [#number(7.2), #number(3.6), #number(6.1), #number(2.5), #symbol("2")],
                                      [#number(6.5), #number(3.2), #number(5.1), #number(2.0), #symbol("2")],
                                      [#number(6.4), #number(2.7), #number(5.3), #number(1.9), #symbol("2")],
                                      [#number(6.8), #number(3.0), #number(5.5), #number(2.1), #symbol("2")],
                                      [#number(5.7), #number(2.5), #number(5.0), #number(2.0), #symbol("2")],
                                      [#number(5.8), #number(2.8), #number(5.1), #number(2.4), #symbol("2")],
                                      [#number(6.4), #number(3.2), #number(5.3), #number(2.3), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.5), #number(1.8), #symbol("2")],
                                      [#number(7.7), #number(3.8), #number(6.7), #number(2.2), #symbol("2")],
                                      [#number(7.7), #number(2.6), #number(6.9), #number(2.3), #symbol("2")],
                                      [#number(6.0), #number(2.2), #number(5.0), #number(1.5), #symbol("2")],
                                      [#number(6.9), #number(3.2), #number(5.7), #number(2.3), #symbol("2")],
                                      [#number(5.6), #number(2.8), #number(4.9), #number(2.0), #symbol("2")],
                                      [#number(7.7), #number(2.8), #number(6.7), #number(2.0), #symbol("2")],
                                      [#number(6.3), #number(2.7), #number(4.9), #number(1.8), #symbol("2")],
                                      [#number(6.7), #number(3.3), #number(5.7), #number(2.1), #symbol("2")],
                                      [#number(7.2), #number(3.2), #number(6.0), #number(1.8), #symbol("2")],
                                      [#number(6.2), #number(2.8), #number(4.8), #number(1.8), #symbol("2")],
                                      [#number(6.1), #number(3.0), #number(4.9), #number(1.8), #symbol("2")],
                                      [#number(6.4), #number(2.8), #number(5.6), #number(2.1), #symbol("2")],
                                      [#number(7.2), #number(3.0), #number(5.8), #number(1.6), #symbol("2")],
                                      [#number(7.4), #number(2.8), #number(6.1), #number(1.9), #symbol("2")],
                                      [#number(7.9), #number(3.8), #number(6.4), #number(2.0), #symbol("2")],
                                      [#number(6.4), #number(2.8), #number(5.6), #number(2.2), #symbol("2")],
                                      [#number(6.3), #number(2.8), #number(5.1), #number(1.5), #symbol("2")],
                                      [#number(6.1), #number(2.6), #number(5.6), #number(1.4), #symbol("2")],
                                      [#number(7.7), #number(3.0), #number(6.1), #number(2.3), #symbol("2")],
                                      [#number(6.3), #number(3.4), #number(5.6), #number(2.4), #symbol("2")],
                                      [#number(6.4), #number(3.1), #number(5.5), #number(1.8), #symbol("2")],
                                      [#number(6.0), #number(3.0), #number(4.8), #number(1.8), #symbol("2")],
                                      [#number(6.9), #number(3.1), #number(5.4), #number(2.1), #symbol("2")],
                                      [#number(6.7), #number(3.1), #number(5.6), #number(2.4), #symbol("2")],
                                      [#number(6.9), #number(3.1), #number(5.1), #number(2.3), #symbol("2")],
                                      [#number(5.8), #number(2.7), #number(5.1), #number(1.9), #symbol("2")],
                                      [#number(6.8), #number(3.2), #number(5.9), #number(2.3), #symbol("2")],
                                      [#number(6.7), #number(3.3), #number(5.7), #number(2.5), #symbol("2")],
                                      [#number(6.7), #number(3.0), #number(5.2), #number(2.3), #symbol("2")],
                                      [#number(6.3), #number(2.5), #number(5.0), #number(1.9), #symbol("2")],
                                      [#number(6.5), #number(3.0), #number(5.2), #number(2.0), #symbol("2")],
                                      [#number(6.2), #number(3.4), #number(5.4), #number(2.3), #symbol("2")],
                                      [#number(5.9), #number(3.0), #number(5.1), #number(1.8), #symbol("2")]];

    public let dummy_classification_data: [[dataMember]] = [[#symbol("0"), #number(1), #number(2), #symbol("0")],
                                          [#symbol("0"), #number(2), #number(3), #symbol("0")],
                                          [#symbol("0"), #number(5), #number(4), #symbol("1")],
                                          [#symbol("0"), #number(8), #number(5), #symbol("1")],
                                          [#symbol("1"), #number(5), #number(2), #symbol("1")],
                                          [#symbol("1"), #number(6), #number(3), #symbol("1")],
                                          [#symbol("1"), #number(3), #number(4), #symbol("0")],
                                          [#symbol("1"), #number(4), #number(5), #symbol("1")]];

    public let diabetes_data: [[dataMember]] = [[#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(151.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(75.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(141.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(206.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(135.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(97.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(138.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(63.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(110.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(310.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(101.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(69.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(179.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(185.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(118.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(171.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(166.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(144.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(97.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(168.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(68.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(49.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(68.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(245.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(184.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(202.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(137.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(85.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(131.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(0.1), #number(0.1), #number(283.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(129.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(59.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(341.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(87.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(65.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(0.0), #number(0.0), #number(102.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(265.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(276.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(252.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(90.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(100.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(55.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(61.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(0.1), #number(92.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(259.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(53.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(190.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(142.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(75.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(142.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(155.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(225.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(59.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(104.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(182.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(128.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(52.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(37.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.1), #number(0.2), #number(-0.1), #number(-0.0), #number(-0.1), #number(170.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(170.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(61.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(144.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(52.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(128.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(71.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(163.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(150.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(97.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(160.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(178.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(48.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(270.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(202.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(111.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(85.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(42.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(170.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(200.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(252.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(113.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(143.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(51.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(52.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(210.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(65.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(141.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(55.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(134.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(42.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(111.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(98.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(164.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(48.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(96.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(90.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(162.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(150.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(279.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(92.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.1), #number(83.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(128.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(102.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(302.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(198.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(95.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(53.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(134.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(144.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(232.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(-0.0), #number(0.1), #number(81.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(104.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(59.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(246.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(297.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(258.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(229.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(275.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(281.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(179.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(200.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(200.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(173.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(180.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.2), #number(0.2), #number(-0.1), #number(0.2), #number(0.0), #number(0.1), #number(84.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(121.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(161.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(99.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(109.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(115.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(268.0)],
                                              [#number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(274.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(158.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(107.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(83.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(103.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(0.1), #number(272.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(85.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(280.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(336.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(281.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(118.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.1), #number(317.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(235.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(60.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(174.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(259.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(178.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(128.0)],
                                              [#number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(96.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(126.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(288.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(88.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.1), #number(292.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(71.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(197.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(186.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(25.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(84.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(96.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(195.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(53.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(217.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(172.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(131.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(214.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(59.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(70.0)],
                                              [#number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(220.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(268.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(152.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(47.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(74.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(295.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(101.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(151.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(127.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(237.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.0), #number(225.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(81.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(151.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(107.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(64.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(138.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(185.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(265.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(-0.0), #number(101.0)],
                                              [#number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(137.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(143.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(141.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(79.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(292.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(178.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(91.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(116.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(86.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(122.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(72.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(129.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(142.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(90.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(158.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(39.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(196.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(222.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(277.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(99.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(196.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(202.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(155.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(77.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(191.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(70.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(73.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(49.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(65.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(263.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(248.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(296.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(214.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(185.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(78.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(93.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(252.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(150.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(77.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(0.0), #number(208.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(77.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(108.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(160.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(53.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(-0.1), #number(0.2), #number(0.2), #number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(220.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(154.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(259.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(90.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(246.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(0.0), #number(124.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(67.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(72.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(257.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(262.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(275.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(177.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(71.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(47.0)],
                                              [#number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(187.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(125.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(78.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(51.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(258.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(215.0)],
                                              [#number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(303.0)],
                                              [#number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.0), #number(243.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(91.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(150.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(310.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(153.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.2), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(346.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(63.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(-0.0), #number(0.1), #number(89.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(50.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.0), #number(0.2), #number(-0.1), #number(-0.1), #number(-0.0), #number(39.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.2), #number(-0.1), #number(-0.0), #number(0.0), #number(103.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(308.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(116.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(145.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(74.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(45.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(115.0)],
                                              [#number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.1), #number(264.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.2), #number(-0.1), #number(-0.0), #number(-0.0), #number(87.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(202.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(127.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(182.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(241.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(66.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(94.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(283.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(64.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(102.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(200.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(265.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(94.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(230.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(181.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(156.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(233.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(60.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(219.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(80.0)],
                                              [#number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(68.0)],
                                              [#number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(332.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(248.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(84.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(200.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(55.0)],
                                              [#number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(85.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(89.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(31.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(129.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(83.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(275.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(65.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(198.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(236.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(253.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(-0.1), #number(124.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(44.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(172.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(114.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(142.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(109.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(180.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(144.0)],
                                              [#number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(163.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(147.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(97.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(220.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(190.0)],
                                              [#number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(109.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(191.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(122.0)],
                                              [#number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(230.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(0.2), #number(0.1), #number(0.1), #number(242.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(248.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(249.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(192.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(131.0)],
                                              [#number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(237.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(78.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(135.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(244.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(199.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(0.0), #number(270.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(164.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(72.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(96.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(306.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(91.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(214.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(95.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(216.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(263.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(178.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(113.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(200.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(139.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(139.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(88.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(148.0)],
                                              [#number(0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(88.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(243.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(71.0)],
                                              [#number(0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(77.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(0.0), #number(109.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.1), #number(0.1), #number(272.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(60.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(54.0)],
                                              [#number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(221.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(90.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(311.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(281.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(182.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(321.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(0.0), #number(0.0), #number(0.0), #number(58.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(262.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(206.0)],
                                              [#number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(233.0)],
                                              [#number(-0.0), #number(0.1), #number(0.2), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(242.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(123.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(167.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(63.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(197.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(71.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(168.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(140.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(217.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(121.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(-0.1), #number(235.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(245.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(40.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(52.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(104.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(132.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(88.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(69.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(219.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(72.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(201.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(110.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(51.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(277.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(63.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(118.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(69.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(0.1), #number(0.1), #number(0.0), #number(273.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(258.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(43.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(198.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(242.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(232.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(175.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(93.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(168.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.0), #number(275.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(293.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(281.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(72.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(140.0)],
                                              [#number(0.1), #number(-0.0), #number(-0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.0), #number(189.0)],
                                              [#number(-0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(181.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(-0.0), #number(209.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(136.0)],
                                              [#number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(261.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(113.0)],
                                              [#number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.1), #number(0.0), #number(131.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(174.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(257.0)],
                                              [#number(-0.1), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(55.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.1), #number(0.1), #number(0.1), #number(-0.0), #number(-0.0), #number(0.0), #number(84.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(42.0)],
                                              [#number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(0.1), #number(146.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.1), #number(0.0), #number(0.0), #number(212.0)],
                                              [#number(-0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(233.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.1), #number(0.1), #number(0.0), #number(-0.0), #number(91.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(111.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.1), #number(0.0), #number(-0.1), #number(-0.0), #number(-0.1), #number(152.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(0.1), #number(120.0)],
                                              [#number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(67.0)],
                                              [#number(0.0), #number(0.1), #number(0.1), #number(0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(310.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(94.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(183.0)],
                                              [#number(0.1), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(66.0)],
                                              [#number(0.0), #number(-0.0), #number(0.1), #number(-0.0), #number(0.1), #number(0.0), #number(-0.0), #number(0.0), #number(0.1), #number(0.1), #number(173.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.0), #number(0.0), #number(0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(-0.0), #number(72.0)],
                                              [#number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(49.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(64.0)],
                                              [#number(-0.1), #number(-0.0), #number(-0.1), #number(-0.1), #number(-0.0), #number(-0.0), #number(0.1), #number(-0.1), #number(-0.1), #number(-0.0), #number(48.0)],
                                              [#number(0.0), #number(0.1), #number(0.0), #number(0.1), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(178.0)],
                                              [#number(-0.0), #number(0.1), #number(-0.0), #number(-0.1), #number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(0.0), #number(104.0)],
                                              [#number(0.0), #number(0.1), #number(-0.0), #number(0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(-0.0), #number(0.0), #number(132.0)],
                                              [#number(-0.0), #number(-0.0), #number(0.0), #number(0.0), #number(0.0), #number(0.0), #number(-0.0), #number(0.0), #number(0.0), #number(-0.0), #number(220.0)],
                                              [#number(-0.0), #number(-0.0), #number(-0.1), #number(-0.1), #number(0.1), #number(0.0), #number(0.2), #number(-0.0), #number(-0.0), #number(0.0), #number(57.0)]];

    public type MotokoLearnError = {
      #notAllYsAreSymbol;
      #sizeMissmatchXY;
      #notAllYsymbols;
      #notExactly2UniqueXSymbols;
      #notAllNumbers;
      #noBestGiniError;
    };

    public type dataMember = {
        #number : Float;
        #symbol : Text; 
    };

    public func symbolVecToTextVec(ys: [dataMember]):  Result.Result<[Text], MotokoLearnError> {
      let aux = ys[0];
      let textBuf = Buffer.Buffer<Text>(ys.size());
      
      for (i in Iter.range(0, ys.size() - 1)) {
        let aux = ys[i];
        switch (aux) {
          case (#symbol s) {
              textBuf.add(s);
          };
          case (#number s) { 
            return #err(#notAllYsAreSymbol);
          };
        };
      };

      return #ok(Buffer.toArray(textBuf));
    };

    public func printSample(x: [dataMember]): (Text) {
      var x_text: Text = "";
      for (i in Iter.range(0, x.size() - 1)) {
        
        switch (x[i]) {
          case (#symbol(sym)) {
            x_text := x_text # sym;
          };
          case (#number(num)) {
            x_text := x_text # Float.toText(num);
          };
        };
        if (i < x.size()) {
          x_text := x_text #", "
        };
      }; 
      return x_text;
    };

    public func rows<T>(rs : [Nat], m : [[T]]) : [[T]] {
      Array.tabulate<[T]>(rs.size(), func r { m[rs[r]] });
    };
    
    public func rowsVector<T>(rs : [Nat], v : [T]) : [T] {
      Array.tabulate<T>(rs.size(), func r { v[rs[r]] });
    };

    public func removeRows<T>(rs : [Nat], m : [[T]]) : [[T]] {
      let rs2 = Buffer.Buffer<Nat>(m.size()); 
      for (i in Iter.range(0, m.size() - 1)) {
        let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
        switch(myindex) {
          case null rs2.add(i);
          case (_) {};
        };
      };
   
      let m2 = rows(Buffer.toArray(rs2), m);
      return m2;
    };

    public func removeRowsVector<T>(rs : [Nat], v : [T]) : [T] {
      let rs2 = Buffer.Buffer<Nat>(v.size()); 
      for (i in Iter.range(0, v.size() - 1)) {

        let myindex = Array.indexOf<Nat>(i, rs, Nat.equal);
        switch(myindex) {
          case null rs2.add(i);
          case (_) {};
        };
      };
      let v2 = rowsVector(Buffer.toArray(rs2), v);
      return v2;
    };

    public func cols<T>(cs : [Nat], m : [[T]]) : [[T]] {
      let ret = Array.tabulate<[T]>(m.size(), func r {
        Array.tabulate<T>(cs.size(), func c { m[r][cs[c]] }) });
      return ret;
    };

    public func ncols<T>(m : [[T]]) : Nat {
      // TODO: check all rows habve same number of elements
      m[0].size();
    };

    public func nrows<T>(m : [[T]]) : Nat {
      m.size();  
    };

    public func transpose<T>(m : [[T]]) : [[T]] {
      let myncols = ncols(m);
      let trans = Buffer.Buffer<[T]>(myncols); 
      for (i in Iter.range(0, myncols - 1)) {
        let ys = cols([i], m);
        let ys2 = Array.flatten(ys);
        trans.add(ys2);
      };
      Buffer.toArray(trans); 
    };
  
    public func linspace(xs_min: Float, xs_max: Float, num: Nat): [Float] {
      let ret = Buffer.Buffer<Float>(num);
      let A: Float = (xs_max-xs_min)/Float.fromInt(num);
      for (i in Iter.range(0, num - 1)) {
        ret.add(xs_min + Float.fromInt(i)*A)
      }; 
      Buffer.toArray(ret);
    };
    
    public func min(rs: [Float]) : Float {
      let aux = Array.sort(rs, Float.compare);
      aux[0];
    };

    public func minNat(rs: [Nat]) : Nat {
      let aux = Array.sort(rs, Nat.compare);
      aux[0];
    };

    public func max(rs: [Float]) : Float {
      let aux = Array.sort(rs, Float.compare);
      aux[rs.size()-1];
    };

    public func maxNat(rs: [Nat]) : Nat {
      let aux = Array.sort(rs, Nat.compare);
      aux[rs.size()-1];
    };

    public func sumTrues(rs: [Bool]) : Nat {
      let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 1; case false sumSoFar + 0});
      sum;
    };

    public func sumFalses(rs: [Bool]) : Nat {
      let sum = Array.foldLeft<Bool, Nat>(rs, 0, func(sumSoFar, x) = switch x {case true sumSoFar + 0; case false sumSoFar + 1});
      sum;
    };

    public func mean(rs: [Float]) : Float {
      let sum = Array.foldLeft<Float, Float>(rs, 0, func(sumSoFar, x) = sumSoFar + x);
      let ret : Float = sum/Float.fromInt(rs.size());
      ret;
    };

    public func median(rs: [Float]) : Float {
      let aux = Array.sort(rs, Float.compare);
      var ret: Float = 0;
      let pos = aux.size()/2;
      let rem = aux.size()%2;
      if (rem == 0) {
        ret := (aux[pos-1]+aux[pos])/2;
      } else {
        ret := aux[pos];
      };
      ret;
    };

    public func uniquesText(rs: [Text]): [Text] {
      let myset = TrieSet.fromArray<Text>(rs, Text.hash, Text.equal);
      let uniques = TrieSet.toArray(myset);
      return uniques;
    };

    public func log2(n: Float): Float {
      Float.log(n)/Float.log(2);
    };

    public func entropy(rs: [Text], y_uniques: [Text]): Float { 
      //let y_uniques = uniquesText(rs);
      var h_total: Float = 0.0;
      for (i in Iter.range(0,y_uniques.size()-1)) {
        let ys_y =  Array.filter<Text>(rs, func x = x == y_uniques[i]);
        let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(rs.size()); 
        let h_y = p_y * log2(p_y);
        h_total := h_total + h_y;
      };
      -h_total;
    };

    public func randomSample(min_: Nat, max_: Nat, nsamples_: Nat, withRepetition_: Bool, seed: Nat): [Nat] {
      let bufaux = Buffer.Buffer<Nat>(nsamples_);
      let fuzz = Fuzz.fromSeed(seed);
      if (withRepetition_ == false) {
        while (TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)).size() < nsamples_) { 
          let randNat: Nat = fuzz.nat.randomRange(min_, max_);
          bufaux.add(randNat);
        };
      }
      else {
        while (Buffer.toArray<Nat>(bufaux).size() < nsamples_) { 
          let randNat: Nat = fuzz.nat.randomRange(min_, max_);
          bufaux.add(randNat);
        };
      };
      let pos_vec = TrieSet.toArray<Nat>(TrieSet.fromArray<Nat>(Buffer.toArray<Nat>(bufaux),Hash.hash, Nat.equal)); 
      return pos_vec;
    };

    public type leafValue = {#number: Float;
                             #symbol: [Float]}; 
    public type BinTree = ?(?Nat, ?Float, leafValue, BinTree, BinTree); 
    public func nilTree() : BinTree = null;
    public func isTreeNil(bintree : BinTree) : Bool {
      switch bintree {
        case null { true };
        case _ { false }
      }
    };

    public func setLeftRightBranch(var_id : ?Nat,         // can be null when leaf
                            th : ?Float,           // can be null when leaf
                            value : leafValue,
                            leftTree : BinTree, 
                            rightTree : BinTree) : BinTree {
      ?(var_id, th, value, leftTree, rightTree);
    };

       func checkAllSymbol(y : [dataMember]): (Bool) {
      for (i in Iter.range(0, y.size() - 1)) {
        switch(y[i]) {
          case (#number(num)) {
            return false;
          };
          case (_) {
            //donothing
          };
        };
      };
      return true;
    };

    public func gini(y: [Text], y_uniques: [Text]): (Float) {
      var g_total: Float = 0.0;
      for (i in Iter.range(0,y_uniques.size()-1)) {
        let ys_y =  Array.filter<Text>(y, func x = x == y_uniques[i]);
        let p_y = Float.fromInt(ys_y.size()) / Float.fromInt(y.size()); 
        let g_y = p_y * (1 - p_y);
        g_total := g_total + g_y;
      };
      return g_total;
    };

    public func mse(y: [Float]): (Float) {
      let mymean: Float = mean(y);
      var g_total: Float = 0.0;
      for (i in Iter.range(0,y.size()-1)) {
        let aux: Float =  (y[i]-mymean)**2;
        g_total := g_total + aux;
      };
      return g_total;
    };
  
    public func rmse(yhat: Float, y: Float): (Float) {
      let ret: Float =  Float.sqrt((yhat-y)**2);
      return ret;
    };

    public let NUM_CHECKS_GINI : Nat = 10;
    public let X_UNIQUES : [Text] = ["0","1"];

    func computeFeatureGini(xcol: [dataMember],y:[Text],y_uniques:[Text]): Result.Result<(Float,Float), MotokoLearnError> {
      // check whether this a nueric or a symbolic feature
      let aux: dataMember = xcol[0];
      switch(aux) {
        case (#number(num)) {
          let xs = dataMemberVectorToFloatVector(xcol);
          switch (xs) {
            case (#ok(xs_num)) {
              let xs_min = min(xs_num);
              let xs_max = max(xs_num);
              let th_vec: [Float] = linspace(xs_min,xs_max,NUM_CHECKS_GINI); // NUM_CHECKS_GINI : Nat = 10; it should be a private constant of the future module
              let ginis = Buffer.Buffer<Float>(th_vec.size());
              for (i in Iter.range(0, th_vec.size() - 1)) {
                let th = th_vec[i];
                let ret_xi = Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= th));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi_l = Buffer.Buffer<Text>(ret_xi_size);
                let ret_yi_r = Buffer.Buffer<Text>(ret_xi.size()-ret_xi_size);
                var gini_l: Float = 0;
                var gini_r: Float = 0;
                var weight_l: Float = 0;
                var weight_r: Float = 0;
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==true) {
                      ret_yi_l.add(y[j]);
                    }
                  };
                  gini_l := gini(Buffer.toArray(ret_yi_l), y_uniques);
                  weight_l := Float.fromInt(Buffer.toArray(ret_yi_l).size())/Float.fromInt(y.size());
                };
                if ( (ret_xi.size()-ret_xi_size) > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==false) {
                      ret_yi_r.add(y[j]);
                    }
                  };
                  gini_r := gini(Buffer.toArray(ret_yi_r), y_uniques);
                  weight_r := Float.fromInt(Buffer.toArray(ret_yi_r).size())/Float.fromInt(y.size());
                };
                ginis.add(weight_l*gini_l+weight_r*gini_r);
              }; 
              let bestgini = min(Buffer.toArray(ginis));
              let bestth_i: ?Nat = Array.indexOf<Float>(bestgini, Buffer.toArray(ginis), Float.equal);
              let bestth_ix: Nat = switch bestth_i {
                case null 0;
                case (?Nat) Nat;
              };
              return #ok(bestgini,th_vec[bestth_ix]);
            };
            case (#err(err)) {
              // TBD
            }
          };

          return (#ok(0,0)); //TBD
        };
        case (#symbol(sym)) {
          let xs = dataMemberVectorToTextVector(xcol);
          switch (xs) {
            case (#ok(xs_text)) {
              let ginis = Buffer.Buffer<Float>(2);
              let weigths = Buffer.Buffer<Float>(2);
              for (i in Iter.range(0, 2 - 1)) {
                let ret_xi = Array.mapEntries<Text, Bool>(xs_text, func (xx, ii) = Text.equal(xx,X_UNIQUES[i]));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi = Buffer.Buffer<Text>(ret_xi_size);
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]) {
                      ret_yi.add(y[j]);
                    }
                  };
                  let gini_aux: Float = gini(Buffer.toArray(ret_yi), y_uniques);
                  ginis.add(gini_aux);
                  weigths.add(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size()));
                }
                else { // case x_uniques[i] does not exist in xcol, then weight is 0
                  ginis.add(0);
                  weigths.add(0);
                };
              };
              let ws = Buffer.toArray(weigths);
              let gs = Buffer.toArray(ginis);
              return #ok(ws[0]*gs[0]+ws[1]*gs[1],0);
            };
            case (#err(xs_text)) {
              return #err(#notAllYsymbols);
            };
          };
        };
      };
    };
    
    func computeFeatureMSE(xcol: [dataMember],y:[Float]): Result.Result<(Float,Float), MotokoLearnError> {
      // check whether this a nueric or a symbolic feature
      let aux: dataMember = xcol[0];
      switch(aux) {
        case (#number(num)) {
          let xs = dataMemberVectorToFloatVector(xcol);
          switch (xs) {
            case (#ok(xs_num)) {
              let xs_min = min(xs_num);
              let xs_max = max(xs_num);
              let th_vec: [Float] = linspace(xs_min,xs_max,NUM_CHECKS_GINI); // NUM_CHECKS_GINI : Nat = 10; it should be a private constant of the future module
              let ginis = Buffer.Buffer<Float>(th_vec.size());
              for (i in Iter.range(0, th_vec.size() - 1)) {
                let th = th_vec[i];
                let ret_xi = Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= th));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi_l = Buffer.Buffer<Float>(ret_xi_size);
                let ret_yi_r = Buffer.Buffer<Float>(ret_xi.size()-ret_xi_size);
                var gini_l: Float = 0;
                var gini_r: Float = 0;
                var weight_l: Float = 0;
                var weight_r: Float = 0;
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==true) {
                      ret_yi_l.add(y[j]);
                    }
                  };
                  gini_l := mse(Buffer.toArray(ret_yi_l));
                  weight_l := Float.fromInt(Buffer.toArray(ret_yi_l).size())/Float.fromInt(y.size());
                };
                if ( (ret_xi.size()-ret_xi_size) > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]==false) {
                      ret_yi_r.add(y[j]);
                    }
                  };
                  gini_r := mse(Buffer.toArray(ret_yi_r));
                  weight_r := Float.fromInt(Buffer.toArray(ret_yi_r).size())/Float.fromInt(y.size());
                };
                ginis.add(weight_l*gini_l+weight_r*gini_r);
              }; 
              let bestgini = min(Buffer.toArray(ginis));
              let bestth_i: ?Nat = Array.indexOf<Float>(bestgini, Buffer.toArray(ginis), Float.equal);
              let bestth_ix: Nat = switch bestth_i {
                case null 0;
                case (?Nat) Nat;
              };
              return #ok(bestgini,th_vec[bestth_ix]);
            };
            case (#err(err)) {
              // TBD
            }
          };

          return (#ok(0,0)); //TBD
        };
        case (#symbol(sym)) {
          let xs = dataMemberVectorToTextVector(xcol);
          switch (xs) {
            case (#ok(xs_text)) {
              let ginis = Buffer.Buffer<Float>(2);
              let weigths = Buffer.Buffer<Float>(2);
              for (i in Iter.range(0, 2 - 1)) {
                let ret_xi = Array.mapEntries<Text, Bool>(xs_text, func (xx, ii) = Text.equal(xx,X_UNIQUES[i]));
                let ret_xi_size: Nat = Array.filter<Bool>(ret_xi, func xx = xx == true).size();
                let ret_yi = Buffer.Buffer<Float>(ret_xi_size);
                if (ret_xi_size > 0) {
                  for (j in Iter.range(0, ret_xi.size() - 1)) {
                    if (ret_xi[j]) {
                      ret_yi.add(y[j]);
                    }
                  };
                  
                  let gini_aux: Float = mse(Buffer.toArray(ret_yi));
                  ginis.add(gini_aux);
                  weigths.add(Float.fromInt(Buffer.toArray(ret_yi).size())/Float.fromInt(y.size()));
                }
                else { // case x_uniques[i] does not exist in xcol, then weight is 0
                  ginis.add(0);
                  weigths.add(0);
                };
              };
              let ws = Buffer.toArray(weigths);
              let gs = Buffer.toArray(ginis);
              return #ok(ws[0]*gs[0]+ws[1]*gs[1],0);
            };
            case (#err(xs_text)) {
              return #err(#notAllYsymbols);
            };
          };
        };
      };
    };

    public func computeThLeftRightNumeric(x: [dataMember], bestth: Float): ([Nat], [Nat]) {
      let xs = dataMemberVectorToFloatVector(x);
      switch (xs) {
        case (#ok(xs_num)) {
          let ret_xi: [Bool]= Array.mapEntries<Float, Bool>(xs_num, func (xx, ii) = (xx <= bestth));
          let sumtrues = sumTrues(ret_xi);
          let left_i = Buffer.Buffer<Nat>(sumtrues);
          let right_i = Buffer.Buffer<Nat>(ret_xi.size()-sumtrues);
          for (j in Iter.range(0, ret_xi.size() - 1)) {
            if (ret_xi[j]==true) left_i.add(j)
            else right_i.add(j);
          };
          return (Buffer.toArray(left_i),Buffer.toArray(right_i));
        };
        case (_) {return ([0],[0]);};
      };
    };

    public func computeLeftRightSymbolic(x: [dataMember]): ([Nat], [Nat]) {
      let xs = dataMemberVectorToTextVector(x);
      switch (xs) {
        case (#ok(xs_sym)) {
          let ret_xi: [Bool] = Array.mapEntries<Text, Bool>(xs_sym, func (xx, ii) = Text.equal(xx,X_UNIQUES[0]));
          let sumtrues = sumTrues(ret_xi);
          let left_i = Buffer.Buffer<Nat>(sumtrues);
          let right_i = Buffer.Buffer<Nat>(ret_xi.size()-sumtrues);
          for (j in Iter.range(0, ret_xi.size() - 1)) {
            if (ret_xi[j]==true) left_i.add(j)
            else right_i.add(j);
          };
         
          return (Buffer.toArray(left_i),Buffer.toArray(right_i));
        };
        case (_) {return ([0],[0]);};
      };
    };

    public func dataMemberVectorToTextVector(y: [dataMember]): Result.Result<[Text], MotokoLearnError> {
      let ysize = y.size();
      let ret = Buffer.Buffer<Text>(ysize); 
      for (i in Iter.range(0, ysize - 1)) {
        let aux = y[i];
        switch(aux) {
          case (#symbol(sym)) {
            ret.add(sym);
          };
          case (_) {
            return #err(#notAllYsymbols);
          };
        };
      };   
      return #ok(Buffer.toArray(ret)); 
    };

    public func dataMemberVectorToFloatVector(y: [dataMember]): Result.Result<[Float], MotokoLearnError> {
      let ysize = y.size();
      let ret = Buffer.Buffer<Float>(ysize); 
      for (i in Iter.range(0, ysize - 1)) {
        let aux = y[i];
        switch(aux) {
          case (#number(num)) {
            ret.add(num);
          };
          case (_) {
            return #err(#notAllNumbers);
          };
        };
      };   
      return #ok(Buffer.toArray(ret)); 
    };  

    public func fitClassification(x : [[dataMember]], 
                           y : [Text], 
                           current_depth : Nat, 
                           y_uniques: [Text], 
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat]): Result.Result<BinTree, MotokoLearnError> {
      // check size of x is at least the minimum size and we are not at the deepest level allowed
      let probs = Buffer.Buffer<Float>(y_uniques.size());
      for (i in Iter.range(0, y_uniques.size() - 1)) { 
          let num_ys: Nat = Array.filter<Text>(y, func x = x == y_uniques[i]).size();
          let prob = Float.fromInt(num_ys) / Float.fromInt(y.size());
          probs.add(prob);
        };
     
      let node_entropy = entropy(y, y_uniques);
      let x_ncols = transpose(x).size();   // if we only have 1 feature, we finish branch 
     
      if (x.size() <= min_node_data_size or current_depth >= max_depth or node_entropy==0 or x_ncols == 1) {
        let leafNode: BinTree  = setLeftRightBranch(null, null, #symbol(Buffer.toArray(probs)), nilTree(), nilTree());
        return #ok(leafNode);
      };
      // create node  
      // for all features
      let xt = transpose(x);
      let ginis = Buffer.Buffer<Float>(xt.size());
      let ths = Buffer.Buffer<Float>(xt.size());
      for (i in Iter.range(0, xt.size() - 1)) {
        let xcol = xt[i];
        let gini = computeFeatureGini(xcol,y,y_uniques);
        switch (gini) {
          case (#ok(gini_float, th_float)) {
            ginis.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      }; 
      // compute gini index of the
      let ginis_array = Buffer.toArray(ginis);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(ginis_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, ginis_array, Float.equal);
      if (bestcol==null) {
        return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
        case null 0;
        case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([xbestcol], x))[0];

      let (left_rows,right_rows) = switch (myx[0]) {
        case (#number(num)) computeThLeftRightNumeric(myx, bestth);
        case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };

      let x2 = removeRows([xbestcol], x);
      
      // pick the true col_id from col_ids
      let true_colid: Nat = col_ids[xbestcol];
      
      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = removeRowsVector([xbestcol], col_ids);
 
      let next_x: [[dataMember]] = transpose(removeRows([xbestcol], transpose(x))); 

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let leftNode_aux  = fitClassification(x_left, y_left, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);
      let rightNode_aux  = fitClassification(x_right, y_right, current_depth + 1, y_uniques, max_depth, min_node_data_size, next_col_ids);
      let leftNode = switch leftNode_aux {
        case (#ok(leftNode)) leftNode;
        case (#err(err)) return leftNode_aux;
      };
      let rightNode = switch rightNode_aux {
        case (#ok(rightNode)) rightNode;
        case (#err(err)) return rightNode_aux;
      };
      let thisNode: BinTree = setLeftRightBranch(?true_colid, ?bestth, #symbol(Buffer.toArray(probs)), leftNode, rightNode);
      
      return #ok(thisNode);
    };   

    public func fitRegression(x : [[dataMember]], 
                           y : [Float], 
                           current_depth : Nat,  
                           max_depth: Nat, 
                           min_node_data_size: Nat,
                           col_ids: [Nat]): Result.Result<BinTree, MotokoLearnError> {

      // For regression predictive modeling problems the cost function that is minimized to choose split points is the sum squared error 
      //     across all training samples that fall within the rectangle: sum(y – prediction)^2
     
      let y_mean: Float = mean(y); 

      let x_ncols = transpose(x).size();
      if (x.size() <= min_node_data_size or current_depth >= max_depth or x_ncols == 1) {
         let leafNode: BinTree  = setLeftRightBranch(null, null, #number(y_mean), nilTree(), nilTree());
         return #ok(leafNode);
      }; 
      // create node  
      // for all features
      let xt = transpose(x);
      let mses = Buffer.Buffer<Float>(xt.size());
      let ths = Buffer.Buffer<Float>(xt.size());
      for (i in Iter.range(0, xt.size() - 1)) {
        let xcol = xt[i];
        let mse = computeFeatureMSE(xcol,y); 
        switch (mse) {
          case (#ok(gini_float, th_float)) {
            mses.add(gini_float);
            ths.add(th_float);
          };
          case (#err(err)) {
            return #err(err);
          };
        }; 
      }; 
      // // compute gini index of the
      let mses_array = Buffer.toArray(mses);
      let ths_array: [Float] = Buffer.toArray(ths);
      let bestgini = min(mses_array);
      let bestcol: ?Nat = Array.indexOf<Float>(bestgini, mses_array, Float.equal);
      if (bestcol==null) {
         return #err(#noBestGiniError);
      };
      let xbestcol : Nat = switch bestcol {
         case null 0;
         case (?Nat) Nat;
      };
      let bestth = ths_array[xbestcol];
      
      // recursive call left and right and connect to node and return 
      let myx = transpose(cols<dataMember>([xbestcol], x))[0];
      
      let (left_rows,right_rows) = switch (myx[0]) {
         case (#number(num)) computeThLeftRightNumeric(myx, bestth);
         case (#symbol(sym)) computeLeftRightSymbolic(myx);
      };

      let x2 = removeRows([xbestcol], x);      
      // pick the true col_id from col_ids
      let true_colid: Nat = col_ids[xbestcol];
      // remove "true_colid" from col_ids before passing recursively
      let next_col_ids: [Nat] = removeRowsVector([xbestcol], col_ids);
  
      let next_x: [[dataMember]] = transpose(removeRows([xbestcol], transpose(x)));

      let x_left = rows(left_rows,next_x);
      let y_left = rowsVector(left_rows,y);
      let x_right = rows(right_rows,next_x);
      let y_right = rowsVector(right_rows,y);

      let lsize_zero:Bool = Nat.equal(x_left.size(),0);
      let leftNode_aux  = switch (lsize_zero) {
        case (true) #ok(nilTree());
        case (false) fitRegression(x_left, y_left, current_depth + 1, max_depth, min_node_data_size, next_col_ids);
      };
      let rsize_zero:Bool = Nat.equal(x_right.size(),0);
      let rightNode_aux  = switch (rsize_zero) {
        case (true) #ok(nilTree());
        case _ fitRegression(x_right, y_right, current_depth + 1, max_depth, min_node_data_size, next_col_ids);
      };
      
      let leftNode = switch leftNode_aux {
         case (#ok(leftNode)) leftNode;
         case (#err(err)) return leftNode_aux;
      };
      let rightNode = switch rightNode_aux {
         case (#ok(rightNode)) rightNode;
         case (#err(err)) return rightNode_aux;
      };

      let thisNode: BinTree = setLeftRightBranch(?true_colid, ?bestth, #number(y_mean), leftNode, rightNode);
      return #ok(thisNode);
    };   

    // 
    // Inference code
    //

    public func isLeftNode(feature_: dataMember, th_: Float): (Bool) { 
      switch feature_ {
        case (#number(num)) {
          if (num <= th_) {
            return true;
          }
          else {
            return false;
          };
        };
        case (#symbol(txt)) {
          if (Text.equal(txt, "0")) {
            return true;
          }
          else {
            return false;
          }
        };
      };
    };

    public func predictTreeClassification(x : [dataMember], bintree : BinTree) : ([Float]) {       
      switch bintree {
        case null {
          Debug.print("UNEXPECTED: we should not get here");
          return [0,0,0];
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          let isNL = isTreeNil(bl);
          let isNR = isTreeNil(br);
          switch (isNL, isNR) {
            case (true, true) {
              switch xvalue {
                case (#symbol(vec)) {
                  return vec;
                };
                case (#number(num)) {
                  return [num];
                };
              };
            };
            case (true, false) {
              let vec = predictTreeClassification(x, br);
              return vec;
            };
            case (false, true) {
              let vec = predictTreeClassification(x, bl);
              return vec;
            };
            case (false, false) {
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              let feature: dataMember = x[var_id]; 
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };
              if (isLeftNode(feature, th)) {
                 let vec = predictTreeClassification(x, bl);
                 return vec;
               }
              else {
                 let vec = predictTreeClassification(x, br);
                 return vec;
              };
            }; 
          };
        };
      };
    };

    public func predictTreeRegression(x : [dataMember], bintree : BinTree) : ([Float]) {        
      switch bintree {
        case null {
          Debug.print("UNEXPECTED: we should never get here");
          return [0,0,0];
        };
        case (?(xvar_id,xth,xvalue,bl,br)) {
          let isNL = isTreeNil(bl);
          let isNR = isTreeNil(br);
          switch (isNL,isNR) {
            case (true, true) {
              switch xvalue {
                case (#symbol(vec)) {
                   return vec;
                };
                case (#number(num)) {
                  return [num];
                };
              };
            };
            case (true, false) {
              predictTreeRegression(x, br);
            };
            case (false, true) {
              predictTreeRegression(x, bl);
            };
            case (false, false) {
              let var_id : Nat = switch xvar_id {
                case null 0;
                case (?Nat) Nat;
              };
              let feature: dataMember = x[var_id]; 
              let th : Float = switch xth {
                  case null 0;
                  case (?Float) Float;
              };
              if (isLeftNode(feature, th)) {
                 predictTreeRegression(x, bl);
               }
              else {
                 predictTreeRegression(x, br);
              };
            }; 
          }; 
        };
      };
    };
};