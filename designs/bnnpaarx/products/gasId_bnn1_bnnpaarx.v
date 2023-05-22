
















module gasId_bnn1_bnnpaarx #(

parameter FEAT_CNT = 128,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 52416'h070e073d0712073c0713073b0710073a070a0739071107380700073707070736071607350714073407080733070f07320709073106ec07300704072f06fe072e070b072d0705072c0706072b0701072a06f90729070d0728070c072706f5072606fd072506f2072406fa072306ff07220702072106f6072006fc071f06ee071e0703071d06f4071c06e9071b06fb071a06f0071906f8071806f1071706e5071506e006f706d706f306c606ef06b606ed06c206eb06cf06ea06aa06e806bd06e706da06e606c706e406c306e306b706e206b206e106ac06df06ba06de06a606dd06bb06dc06b406db06b306d906b106d8069d06d606c106d506b906d4068d06d306b506d206ae06d106a806d006bc06ce069b06cd068606cc06a506cb068806ca069e06c9069006c806a406c506ad06c4069206c0069c06bf068706be067e06b8067606b0067106af069806ab069406a9067206a7068006a3066c06a2068e06a1065106a0068b069f0660069a06770699067d069706750696066a069506630693067906910666068f066b068c0656068a06670689067c068506420684065b0683064a0682065d0681063d067f064e067b064b067a06480678065c067406550673064306700652066f0650066e0640066d061e066906490668063206650644066406360662064d0661062e065f0639065e0647065a0608065906450658064106570624065406370653062c064f060f064c0607064605f3063f061f063e060e063c0612063b061c063a0613063806100635061806340614063306050631060006300615062f0606062d05e2062b0609062a05fc062905f2062805fa06270611062605cf062505df06230603062205ea062105f5062005f7061d05fb061b05f4061a05ed061905f1061705ec061605e6060d05e1060c05e4060b05ef060a05cd060405bc060205dc060105d405ff05db05fe05e805fd05bb05f905e905f805dd05f605d705f005da05ee05d105eb05d205e705c205e505a605e305b605e0057b05de05be05d9058305d805c305d605c405d505b805d305ac05d0059f05ce05a505cc059205cb055e05ca05a105c905b205c805c105c7059d05c605a805c505aa05c005a005bf059305bd05a705ba056a05b905b105b7058205b5059105b4058a05b305a205b0059605af057605ae058005ad058605ab058805a9057405a4059005a30578059e0561059c0567059b054f059a0572059905700598058b0597058d0595058705940522058f055f058e0521058c056b05890564058505250584057705810552057f0566057e0551057d052e057c0553057a05260579056205750557057305430571055b056f054c056e0569056d0549056c05320568054b0565053c0563051c05600547055d0501055c0545055a053505590546055804fe0556053b0555052d055405360550053a054e0513054d0538054a0530054805170544051a0542050a0541052305400503053f052a053e0509053d05190539052805370500053404ea0533052f05310516052c04f7052b050d0529050505270514052404fa05200507051f04df051e0508051d04e4051b04e8051804e7051504d6051204e5051104ee051004d2050f0502050e04f1050c0504050b04f3050604ce04ff04d304fd04eb04fc04e904fb04de04f904c604f804db04f604c804f504e304f404d404f204cd04f004c904ef04c504ed04da04ec04bc04e6049e04e204c404e104b104e004be04dd04cc04dc049c04d904b304d804a704d704bd04d504cb04d104bb04d0047d04cf046704ca04a604c704b004c3047f04c2049104c104a204c0049b04bf048104ba049004b904aa04b8049504b704a104b604a404b5047a04b4049404b204a904af049204ae048704ad048204ac049304ab049804a8047704a5049d04a3046804a00457049f0486049a047404990488049704530496048c048f0484048e0460048d046d048b0458048a0485048904430483044904800465047e044b047c0464047b04660479046f047804460476042804750461047303fc0472044d047104390470045f046e0429046c045c046b0448046a0447046904180463045204620433045e0401045d044a045b03e1045a0435045904300456043e0455041d0454044c04510425045003d6044f03ff044e042f044504240444042e044203dc0441042a044003f6043f03f9043d03f4043c0421043b0412043a04040438041f0437042d043604170434040904320414043103ec042c0426042b041c0427040e042303e7042203e00420040f041e03d1041b040c041a03fe04190413041603cd041503ed041103f004100408040d03d2040b03ea040a03f8040703f2040603c8040503d0040303f3040203da040003e203fd03ce03fb03ee03fa03f103f703d203f503be03ef03c803eb03c003e903bd03e803c603e603d903e503cf03e403d403e303c903df03b703de03b003dd03ce03db03c403d803cc03d703d303d503d003d503c503d403cb03d303ca03d1039f03cf03c903cd03b503cc03a603cb03bb03ca03be03c7039003c703c303c603b203c503b603c403ba03c303bf03c203b403c203bb03c103b903c103a703c003b503bf03ac03bd03ba03bc038003bc03b103b903b103b8037903b803a103b7039d03b603a303b4039403b203aa03b003ad03ae03a903ae036003ad039c03ac03a503ab03a403ab03a303aa037d03a903a403a8038c03a803a603a7039f03a5038803a2036803a2039403a10388039d0395039c0397039b0380039b0392039a0381039a03950399038f039903920398037603980393039703870396037a0396037403930366039103630391037f0390038e038f0371038e038a038d0384038d0377038c0385038a0356038703840385037f0383036f038303780382036c038203710381037b037d0372037c0370037c0367037b0361037a03690379035c0378034d0377036e03760367037503650375037203740365037303640373034f0370035b036f034f036e035c036c0363036b0342036b0361036903530368034e036603510364034e036203450362032b03600354035f032c035f0351035b0343035a0324035a034c03590346035903560358033f0358033d0355033903550349035403350353034d0352031f0352030a034c0348034a0321034a034103490342034803300347032d034703270346033f0345033703430304034103300340032203400332033d0336033b0320033b0335033903030337031603360324033303020333030503320325033103140331032b032e0314032e0328032d02ea032c0312032802cc0327030c032503190322030a032103180320030d031f03070319031703180309031702940316030f03130309031302fc03120307031002f80310030d030f02ee030c02eb030602c6030602d503050303030402db030202fc030102f7030102fe030002fb030002ef02fe02cf02fb02de02fa02dd02fa02dd02f802ef02f702ca02f602c902f602f102f302b802f302d402f102d602f002cb02f0029902ee02bb02eb02aa02ea02e202e5028f02e502dc02e2027202de02d202dc02bc02db027202d602ce02d502ac02d4029102d202cc02d002cb02d002c902cf02bc02ce02b502ca02bd02c7029002c702b102c602b702c002a702c0023c02bd02b402bb02b202bb02b302ba02b002b9022d02b6025e02af02aa02ae029502ad027002ab021702aa029302a9029502a802a202a6029d02a5029202a4028702a3029002a1024102a0027b029f0283029e0278029d025d029d0280029c026c029b0299029a0298029902750297028a029602810295027d0290028d028e028b028c027e028902850288028402860261028202790280025802800274027f0256027c0279027a02500279027602780260027802340277025102760221027602130273026f0272020302710269026e0217026d0200026b0244026a026502680244026702640266025c026302410262021b025f0246025b021e025a0248025902350257024c0256023e025602340254023d0253024f02520239024d0245024b01e0024a021602490237024702370243023e023f0238023b0230023801430235022e0231020302300224022f022a022e01ed022d01e60228020f0227019a0227020a022202060222021302210215021f0219021e021b021d01c9021d01f0021a020e02150210021401e0021201d1021201fd021101f802110203020f0208020901f6020901f1020601f7020101c0020101fb020001e201fe01db01fc01ed01fb01d801fa016901f801ee01f601ed01f601d001f401ec01f2018f01ef01e101e801e101e501c001e400fb01e401d801e201c201df01d701dd01c901d501c801d3016301d2019101d101c401cc01c801ca017e01ca004601c700f901c601c301c501b401c301a201ba01b301b8019e01b701a601b6019d01b5017a01b401b101b3017c01b001a501af017f01a6017101a4018201a00198019d0181019b0102019900d4019801500197013001950126019301150191016701900189018d0160018a014301850155017e0161017d0153017c016a0179014e017900710176014f0173010f0170016b016d015d016c01670169015e01620151015c0158015b00830156010f0155012f015400d001500146014e00d1014d0135014b012d014b00ea014a0107014900360148013a014701230147012f014600f6013d0137013c007e013800c00136011e013000b6012e0118012b00f00129004e012900660128011b011c0047011a00130119010c01180112011700ed011100fa011000e6010d008e010b009d010a002a010800f7010100ec00f500a100f300e200f1009900ea00c700e8003900e7003d00e500d700e400a800e2004500e100b400dc004900dc004400ce00b000c9008e00c4001200b4009600ae00aa00ac002200ac008200a8002e00a60077009f0019009b007b00980064009500670091006d008f00740089004c006e0019006c001c0065002d0060001f0057001a0054000500450002003b0009002d001e002c00180028000a0028001100200017001c0008001b00020014031d03b3032903af02f203a002df039e02e4038b02d7038902e0038602d1037e02cd036d0263036a0289035e02e1035d02ba0357029f03500226034b02e703440229033e02a8033c02ff033a02050338021503340246032f022c032a028f03260235032302d9031e01f4031c01ce031b02c5031a01be03150240031102be030e02c8030b028b030802b702fd024902f9019c02f5022202f402b102ed02a902ec02b202e9023802e802d302e601aa02e302c302da02b402d801bb02c401d902c2028c02c1027302bf014c02b9027b02b801ef02b6016f02b5029602b3023202b0025102af01cd02ae01ab02ad01db02ac00fe02ab020d02a7023402a601b902a5017b02a4023e02a3008c02a2023302a101cc02a0024c029e0267029c01f5029b01fc029a0282029802570297011b02940268029302250292027c0291015a028e009c028d0260028a01ff028801700287017f0286021c02850184028402400283027e02810236027f01ec027d01b6027a01fe02770124027501d4027402300271024a027001fc026f0068026e0265026d0079026c0242026b01e5026a0140026901ba0266004302640248026201dc026101a9025f0168025e0226025d013b025c011d025b011f025a00330259024b025802020254021802530197025200f402500157024f00c5024d017402470032024500260244022c0242020c0241019b0237021e023601ac023301f202320207022e0059022d0182022b0034022b007a022900780227008a022500e702210127021d0178021c012c021b00cd02180144021701420213020b021201710211017d020f0073020d01e7020c01bb020b01ed020901a3020701c102060089020501a20204018302040173020301bf01fe01a101f9012b01f7003701f701ef01f6003601f401ea01f3016101f2019f01f000be01f001ae01ee00e001ee017501ec01c501eb015c01e8002901e8006101e5008801df01dd01de019001da01a701d7010701d3011501d2018e01d0006001cb011601c701a101c6019f01c4010301c100e501bf012301be016301b8004d01b300b901af01a801ad013c01ad016d01ac012a01aa018401a7009a01a6014101a30158019c018a019b017b019a00cc0199006601990165019800ee019600e60194016a018f015d018d0152018b001d018901190188014a018700f101870122018601600182013e01800172017b0161017700a601760094017100fb016f0127016b001f016b0166016901530162003d01590097015800e0015600f9015400fe015200f8015100c0014f0129014d000201490051014800a00145000e0141007e013d0121013900d90137009d0135012e013300ed012d0105012c00c60124008c011e004c01180047011500f601140062010e00b1010d00b30106009f010600030101006a0100008b00eb006d00eb00c700e2003000e1005700dc00a700d5003300d4009000c1003e00b9008f00b4009500b0004600ad002300ab00a000a9009e00a1004e009c00760097001b0096004200800044007a002a0070004b006a000b0049001e0031000e002c00080009015f025501ff024e01b102430099023f0112023d019e023c0196023b00fa023901e7023101ea022f01ab022a006b0228013402240015021f01bc021a0063021902000216013602140050021000aa020e0147020a008a020801c4020200cd0201016601fb00ad01f9018301f8008b01f5013001f301ae01eb011301e400ce01e2014901e1009101df01d001dd002801db008201d700b601d6005c01d600cb01d3016d01d201a501cf012501cf016801cc01bd01c700b701c6017401c5000c01c1002e01bf013201be00f701bb01b501b7018901b200b201b0013101ae017001a9010801a801540197007e0195003401940079018f0062018e0137018c0022018c000a018b0013018a00e3018000c4017e000f017d00f40175000501730148016c0117016a01330169009b015c012a0156014c01510110014f012c014e0051014d0139014a00d301420128013f0047013d00680134009e0132008f0121011d012000d701200066011b0075011a002d010f00d9010500930102003600f1001100ea003d00e700d700e1005700d1008600cf001c00c6001400b9007000b3004000ac006700a8001500a6005800a4005300a1006a009a00190093006100920046008e0083008900180075001a0065000900600012005c000b0032000e001401e0023a01bc022301de0220002001fd01ba01fa014b01f101a901e6003101dc015e01da01ca01d900fe01d801b701d401ce01d1003e01cd003001cb018801c9009401c8017c01c3012e01bd015501b8018501b501a001b3016701b1009d01b0007801ad012201ab00c701a8015301a4007401a400d001a00111019701460193005001920054018600cc0178015d0177014001720045016e002901640119015a012f01450076013c00e8013a011c013801230136006e0128010d01250077011e00d401180104011000e00108006d0106005900fa001f00f800a200f000b200e600bf00d6004a00c8008500c5000000c2004d00b1001d0095003a007d00100041002c003b018f01e900ca01e300ed01d5000f01c2004e01c001a601b901a101b600b001b2019301af01aa01ac012601a700bb01a5009801a3015b019f00be019b0188019901000196015001940144018c0071018a00b70189013501860021017a013b0165009f00f700a900f600ce00f500ae00ee005200da005a00d2008d00a500390097004800960006004f00070035019201b4001701a2010e019e0183019c018e0198017a0195017c018b017b0185017d018201650178015901770016016900bd0159005f00ff005b00fc00e900f2005d00ef007f00df00b800de006f00dd007c00db002400d8002f00bc003c00af0001008400040081006900720038005e003f005600270055000d00250184019a01730187017001800167017e00540172015d016d0150016a0026015300ba00fd008700b5014d019d016601900174018d016b017500b1017101560168015a015c0136015b01440155014f015401350151016c0191015e017f014b016f00c5016e00a90164012e0161012c01580149014e00a6014a0140014800650146013b014500cd013c001f012801520179014c017601420163003201470132013d00e00137006d013400c7012f00b9012500a1012300770118004e00f5007400b000990181013801620016016000f0015f009201410130013a013301390079012600ae012200340120007e011e0110011900ee010e006900f200570071000f0014012a0157010d0121008b011b007a010800d00106002800f6000600cf0062008e005c008c005d006f0013003d012d01430131013f004c0129009b0127011d012400c6011c001e011500db00fc000500e6002d00e100d200da00a400d8003f00d6003e00ce00af00bc000d00a50095009d003500870020006a003b005300e3013e00ac012b00be011a002a01170082011100a2010f00df00ff001500f8009800e8001d00e7003800de009100d9007d00ba005e00b8007600b7006600b60088008900810084005f007f00090078002c005100010004000a011f00b3011200590105008f00fe003a00fd009600ed009c00ea000700b5005500a70003009a005b007c0048004a002f003c0114011600eb011300c400fa003700f700dd00ef001800d700c800ca001a00c9006700bd0033009f000e0094004100900025008d0061008a0073007b0060006800300050001c00460040004300260036006b010700d10104004401020039010000bb00f1007200e9002700d5008000c2005600bf006e00ad0052005a0047004b00000042007500dc00c000cc001100cb001000c1000b00b2000200a8002900a0002200930064006c002400580023002b010a010c0103010b00830101002100e2007000aa002e009e0045008500b4010900f400fb00e400ec00a300ab004f0086004900630031004d0019001b00d400f900d300f30008000c001200c3001700e5 ;
localparam YMAP = 640'h07500759074a07650741074e07540745075a074c074b0762075b0751074f075e07480764074907440761073e073f0763075f074d0755075d07460747075607420740076007530758075c075707520743;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam PAAR1 = 3136'h00a900ad00a600ac00a500aa00a300a700a000a4009e00a2009700a1009a009f0095009d0099009c0096009b00940098008c0093008d0092008e0091008800900085008f0089008b0086008a00840087007c00860080008500800084007d007e0056007e0073007d0076007c0076007800730078006f0072006c007100680070006b006e004a006d0063006a0062006600600061005b005c004d005500280045001e004300230033001c002100810083007f00820079007b0075007a00710077006b007400490072006d00700002006f000a006e0065006c003d00650037003f001f003a00260034000d0031001a002f002c002e00080027000500200038006a006200680011006600610063003900600029003c001000210001001400670069005f00640047005e005c005d0032005b002a00560030004f000c004e002d00480007004200090035000f001700120015000400060058005a00570059004600550044004b001b0025000b00220000001d00530054005100520041005000240040001300160003000e ;
localparam YMAP1 = 96'h00ab00b000a800b100af00ae;
localparam ADDCNT1 = $bits(PAAR1) / 32;
localparam FULLCNT1 = ADDCNT1 + (HIDDEN_CNT * 2);
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

wire signed [INDEX_BITS:0] node [FULLCNT-1:0];

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[i] = feature_array[i];
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[FEAT_CNT+i] = -feature_array[i];
endgenerate

integer j;
generate
for(i=0;i<ADDCNT;i=i+1) begin
    localparam op1 = PAAR0[i*32+:16];
    localparam op2 = PAAR0[i*32+16+:16];
    localparam nodeloc = (2 * FEAT_CNT) + i;
    assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    assign hidden[i] = node[YMAP[i*16+:16]] >= 0;
end
endgenerate

/* initial begin */
/*     #10 */
/*     for(j=0;j<FULLCNT;j=j+1) */
/*         $display("%d | %d", j, node[j]); */
/* end */

wire unsigned [SUM_BITS-1:0] xnode [FULLCNT1-1:0];

generate
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[i] = hidden[i];
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[HIDDEN_CNT+i] = hidden_n[i];
for(i=0;i<ADDCNT1;i=i+1) begin
    localparam op1 = PAAR1[i*32+:16];
    localparam op2 = PAAR1[i*32+16+:16];
    localparam nodeloc = (2 * HIDDEN_CNT) + i;
    assign xnode[nodeloc] = xnode[op1] + xnode[op2];
end
for(i=0;i<CLASS_CNT;i=i+1) begin
    assign scores[i*SUM_BITS+:SUM_BITS] = xnode[YMAP1[i*16+:16]];
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
