function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			  organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
			  organName =info.userDepOrganName;
			}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
	//		 deptId = mrmBasePersonCommand.getReturn("deptId");
	//		 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
			if(deptId=="" || deptId==null){
				ds.newRecord();
				alert("没有对应的婚姻登记处！");
				return false;
			
			}
		if(organCode!=null && organCode.length>4){//获得上级organName
			var dicCityQueryCommand = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			dicCityQueryCommand.setParameter("id",organCode.substring(0,4)+"00000000");
			var organDs=dicCityQueryCommand.execute("getOrganInfoById");
			if (!dicCityQueryCommand.error) {
				fOrganName= dicCityQueryCommand.getReturn("fOrganName");
			}
		 }
    ds.setParameter("DEPT_CODE@=",deptId);
 	ds.load();
 	ds.on("load",function(){
 	//机构性质
 		if(ds.getAt(0).get("types")=="01"){
 			document.getElementById("xz1").style.display="";
 			document.getElementById("xz2").style.display="none";
 			document.getElementById("xz3").style.display="none";
 		}
 		if(ds.getAt(0).get("types")=="02"){
 			document.getElementById("xz2").style.display="";
 			document.getElementById("xz1").style.display="none";
 			document.getElementById("xz3").style.display="none";
 		}
 		if(ds.getAt(0).get("types")=="03"){
 			document.getElementById("xz3").style.display="";
 			document.getElementById("xz2").style.display="none";
 			document.getElementById("xz1").style.display="none";
 		}
 		if(ds.getAt(0).get("types")==""){
 			document.getElementById("xz1").style.display="none";
 			document.getElementById("xz2").style.display="none";
 			document.getElementById("xz3").style.display="none";
 		}
 		
 		//辖区人口
 		ds.getAt(0).set("deptNumRy",ds.getAt(0).get("deptNumRy")/10000);
 		//时间默认当天
 		document.getElementById("creatDate").value=myDate.toLocaleDateString();
 		//处理机构名称
 		ds.getAt(0).set("deptName","山东省"+ds.getAt(0).get("deptName"));
 		
 		 //复印机
 		if(ds.getAt(0).get("fyj")<1){
 			document.getElementById("fyj").style.display="none";
 		}
 		//传真机
 		if(ds.getAt(0).get("czj")<1){
 			document.getElementById("czj").style.display="none";
 		}
 		//扫描仪
 		if(ds.getAt(0).get("smy")<1){
 			document.getElementById("smy").style.display="none";
 		}
 		//电视机
 		if(ds.getAt(0).get("dsj")<1){
 			document.getElementById("dsj").style.display="none";
 		}
 		//服务评价系统
 		if(ds.getAt(0).get("fwpjxt")<1){
 			document.getElementById("fwpjxt").style.display="none";
 		}
 		//叫号机
 		if(ds.getAt(0).get("jhj")<1){
 			document.getElementById("jhj").style.display="none";
 		}
 		//电子显示屏
 		if(ds.getAt(0).get("dzxsp")<1){
 			document.getElementById("dzxsp").style.display="none";
 		}
 		//监控设备
 		if(ds.getAt(0).get("jksb")<1){
 			document.getElementById("jksb").style.display="none";
 		}
 		//无障碍通道
 		if(ds.getAt(0).get("wzatd")<1){//无
 			document.getElementById("wzatd1").style.display="none";
 			document.getElementById("wzatd2").style.display="";
 		}else{
 			document.getElementById("wzatd1").style.display="";
 			document.getElementById("wzatd2").style.display="none";
 		}
 		//卫生间位置
 		if(ds.getAt(0).get("wc")=="01"){
 			document.getElementById("station1").style.display="";
 			document.getElementById("station2").style.display="none";
 			document.getElementById("station3").style.display="none";
 		}
 		if(ds.getAt(0).get("wc")=="02"){
 			document.getElementById("station2").style.display="";
 			document.getElementById("station1").style.display="none";
 			document.getElementById("station3").style.display="none";
 		}
 		if(ds.getAt(0).get("wc")=="03"){
 			document.getElementById("station3").style.display="";
 			document.getElementById("station2").style.display="none";
 			document.getElementById("station1").style.display="none";
 		}
 		if(ds.getAt(0).get("wc")==""){
 			document.getElementById("station1").style.display="none";
 			document.getElementById("station2").style.display="none";
 			document.getElementById("station3").style.display="none";
 		}
 			//辅导员信息
  		if(ds.getAt(0).get("zfgmNum")<1)
  		{
 			document.getElementById("zfgmSpan").style.display="none";
 		}
 		if(ds.getAt(0).get("zyzNum")<1 && ds.getAt(0).get("gkzmNum")<1)
 		{
 			document.getElementById("zyzSpan").style.display="none";
 		}
 		//其他情况
 		if(ds.getAt(0).get("qtqksc")!=""){
 			ds.getAt(0).set("qtqksc","其他情况："+ds.getAt(0).get("qtqksc"));
 		} 
	});
	
	

	L5.QuickTips.init(); 
}

function getShowText(level){

}
function checkLevel(){

 	var applyLevel=document.getElementById("applyLevel").value;//3A、4A、5A
 	//机构性质
 	var xz1dis=document.getElementById("xz1").style.display=="none";//机构性质：非行政机关
 	var xz2dis=document.getElementById("xz2").style.display=="none";//机构性质：非参公管理事业单位
 	var xz3dis=document.getElementById("xz3").style.display=="none";//机构性质：非全额拨款事业单位
 	//候登大厅、结婚登记区
 	var AllNum=document.getElementById("AllNum").innerHTML;//年工作量
 	var divorceNum=document.getElementById("divorceNum").innerHTML;//年离婚登记量
 	var marryNum=document.getElementById("marryNum").innerHTML;//年结婚登记量
 	var attestNum=document.getElementById("attestNum").innerHTML;//(无)出具证明量
 	var marryWindow=document.getElementById("marryWindow").innerHTML;//结婚登记窗口
 	var marryArea=document.getElementById("marryArea").innerHTML;//候登大厅、结婚登记使用面积和
 	var hdChair=document.getElementById("hdChair").innerHTML;//候登座椅
 	var tbChair=document.getElementById("tbChair").innerHTML;//填表座椅
 	
 	var lhArea=document.getElementById("lhArea").innerHTML;//离婚登记区面积
 	var lhWindow=document.getElementById("lhWindow").innerHTML;//离婚登记区窗口
 	
 	var jianShu=document.getElementById("jianShu").innerHTML;//婚姻家庭辅导室间数
 	var fdsArea=document.getElementById("fdsArea").innerHTML;//婚姻家庭辅导室使用面积
 	
 	var bzdtArea=document.getElementById("bzdtArea").innerHTML;//颁证大厅使用面积
 	var qyglx=document.getElementById("qyglx").innerHTML;//亲友观礼席
 	
 	var computer=document.getElementById("computer").innerHTML;//电脑
 	var printer=document.getElementById("printer").innerHTML;//打印机
 	var cardReader=document.getElementById("cardReader").innerHTML;//身份识别系统
 	
 	//复印机、传真机、扫描仪、电视机
 	var fyj=document.getElementById("fyj").style.display=="none";//复印机
 	var czj=document.getElementById("czj").style.display=="none";//传真机
 	var smy=document.getElementById("smy").style.display=="none";//扫描仪
 	var dsj=document.getElementById("dsj").style.display=="none";//电视机
 	
 	var jhj=document.getElementById("jhj").style.display=="none";//排队叫号系统
 	var dzxsp=document.getElementById("dzxsp").style.display=="none";//电子滚动显示屏
 	var fwpjxt=document.getElementById("fwpjxt").style.display=="none";//服务评价系统
 	var jksb=document.getElementById("jksb").style.display=="none";//监控系统
 	//设备件数
 	var fyjNum="";
 	if(fyj==true){
          fyjNum="没有"
       }else{fyjNum="有"
       }
    var czjNum="";
    if(czj==true){
          czjNum="没有"
       }else{czjNum="有"
       }
    var smyNum="";
    if(smy==true){
          smyNum="没有"
       }else{smyNum="有"
       }
    var dsjNum="";
    if(dsj==true){
          dsjNum="没有"
       }else{dsjNum="有"
       }
       
    var jhjNum="";//排队叫号系统
       if(jhj==true){
          jhjNum="没有"
       }else{jhjNum="有"
       }
 	var dzxspNum="";  //电子滚动显示屏
 	 if(dzxsp==true){
          dzxspNum="没有"
       }else{dzxspNum="有"
       }
 	var fwpjxtNum=""; //服务评价系统
 	 if(fwpjxt==true){
          fwpjxtNum="没有"
       }else{fwpjxtNum="有"
       }
 	var jksbNum=""; //监控系统
 	 if(jksb==true){
          jksbNum="没有"
       }else{jksbNum="有"
       }
 	
 	var window=Number(marryWindow)+Number(lhWindow);//所有的窗口
 	var djyNum=document.getElementById("djyNum").innerHTML;//登记员总人数
 	var bzyNum=document.getElementById("bzyNum").innerHTML;//颁证员员总人数
 	var xzbzNum=document.getElementById("xzbzNum").innerHTML;//行政编制总人数
 	var cgglNum=document.getElementById("cgglNum").innerHTML;//参公管理总人数
 	var qebkNum=document.getElementById("qebkNum").innerHTML;//全额拨款总人数
 	var deptNumRy=document.getElementById("deptNumRy").innerHTML;//辖区人口数
 	
 	var fdyNum=document.getElementById("fdyNum").innerHTML;//辅导员人数
 //	var zfgmSpan=document.getElementById("zfgmSpan").style.display=="none";//是否政府购买
 	var wlyyqysj=document.getElementById("wlyyqysj").innerHTML;//网络预约系统启动时间
 	var wlyyl=document.getElementById("wlyyl").innerHTML;//网络预约总量
 	var sndyyl=document.getElementById("sndyyl").innerHTML;//上年度网络预约量
 	
 	
 	var message3a="";
 	var message4a="";
 	var message5a="";
 	//机构性质区域jgDiv
 	var jgDiv3a="系统审查不通过：(注：国家3A级婚姻登记机关机构性质应当是经编制部门批复成立的行政机关，或参照公务员法管理的事业单位，或全额拨款事业单位)"
 	var jgDiv4a="系统审查不通过：(注：国家4A级婚姻登记机关机构性质应当是经编制部门批复成立的行政机关，或参照公务员法管理的事业单位)"
 	var jgDiv5a="系统审查不通过：(注：国家5A级婚姻登记机关机构性质应当是经编制部门批复成立的行政机关)"
 	//年工作量与候登大厅、结婚登记使用面积、候登座椅、填表座椅关系
 	//年工作量与候登大厅、结婚登记使用面积、候登座椅、填表座椅关系
 	var maAreaDiv3a1="系统审查不通过：(注:年工作量10000对（件）以下的，候登大厅、结婚登记使用面积不低于120㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var maAreaDiv3a2="系统审查不通过：(注:年工作量10000对（件）以上的，候登大厅、结婚登记区使用不低于180㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var hdtbchair3a1="系统审查不通过：(注:年工作量5000对（件）以下的，候登座椅不少于8座,，填表座椅不少于4座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair3a2="系统审查不通过：(注:年工作量5000-10000对（件）的，候登座椅不少于16座，填表座椅不少于8座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair3a3="系统审查不通过：(注:年工作量10000对（件）以上的，候登座椅不少于24座，填表座椅不少于12座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	
 	var maAreaDiv4a1="系统审查不通过：(注:年工作量10000对（件）以下的，候登大厅、结婚登记使用面积不低于150㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var maAreaDiv4a2="系统审查不通过：(注:年工作量10000对（件）以上的，候登大厅、结婚登记区使用不低于220㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var hdtbchair4a1="系统审查不通过：(注:年工作量5000对（件）以下的，候登座椅不少于10座,，填表座椅不少于6座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair4a2="系统审查不通过：(注:年工作量5000-10000对（件）的，候登座椅不少于20座，填表座椅不少于12座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair4a3="系统审查不通过：(注:年工作量10000对（件）以上的，候登座椅不少于30座，填表座椅不少于18座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	
 	var maAreaDiv5a1="系统审查不通过：(注:年工作量10000对（件）以下的，候登大厅、结婚登记使用面积不低于200㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var maAreaDiv5a2="系统审查不通过：(注:年工作量10000对（件）以上的，候登大厅、结婚登记区使用不低于300㎡)"+"；目前情况：年工作量"+AllNum+",使用面积"+marryArea+"㎡.";
 	var hdtbchair5a1="系统审查不通过：(注:年工作量5000对（件）以下的，候登座椅不少于12座,，填表座椅不少于8座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair5a2="系统审查不通过：(注:年工作量5000-10000对（件）的，候登座椅不少于24座，填表座椅不少于16座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	var hdtbchair5a3="系统审查不通过:(注:年工作量10000对（件）以上的，候登座椅不少于36座，填表座椅不少于24座)"+"；目前情况：年工作量"+AllNum+",候登座椅"+hdChair+"座,填表座椅"+tbChair+"座.";
 	
 	//结婚登记窗口区域maWinDiv
 	var maWinDiv31="系统审查不通过：(注:年结婚登记量、出具证明量5000对（件）以下的，结婚登记窗口不少于2个)" +"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryNum+"个." ;
 	var maWinDiv32="系统审查不通过：(注:年结婚登记量、出具证明量5000-10000对（件）的，不少于3个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	var maWinDiv33="系统审查不通过：(注:年结婚登记量、出具证明量10000对（件）以上的，不少于4个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	var maWinDiv41="系统审查不通过：(注:年结婚登记量、出具证明量5000对（件）以下的，结婚登记窗口不少于3个)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryNum+"个." ;
 	var maWinDiv42="系统审查不通过：(注:年结婚登记量、出具证明量5000-10000对（件）的，不少于4个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	var maWinDiv43="系统审查不通过：(注:年结婚登记量、出具证明量10000对（件）以上的，不少于5个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	var maWinDiv51="系统审查不通过：(注:年结婚登记量、出具证明量5000对（件）以下的，结婚登记窗口不少于4个)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryNum+"个." ;
 	var maWinDiv52="系统审查不通过：(注:年结婚登记量、出具证明量5000-10000对（件）的，不少于5个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	var maWinDiv53="系统审查不通过：(注:年结婚登记量、出具证明量10000对（件）以上的，不少于6个结婚登记窗口)"+"；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个." ;
 	
 	//离婚登记量与使用面积、离婚登记窗口关系
 	var diAreaDiv3a1="系统审查不通过：(注:年离婚登记量2000对以下的，使用面积不低于15㎡)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡." ;
 	var diAreaDiv3a2="系统审查不通过：(注:年离婚登记量2000-4000对的，使用面积不低于25㎡，不少于2个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	var diAreaDiv3a3="系统审查不通过：(注:年离婚登记量4000对以上的，使用面积不低于40㎡，不少于3个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	
 	var diAreaDiv4a1="系统审查不通过：(注:年离婚登记量2000对以下的，使用面积不低于15㎡)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个";
 	var diAreaDiv4a2="系统审查不通过：(注:2000-4000对的，使用面积不低于35㎡，不少于2个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	var diAreaDiv4a3="系统审查不通过：(注:4000对以上的，使用面积不低于50㎡，不少于3个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	
 	var diAreaDiv5a1="系统审查不通过：(注:年离婚登记量2000对以下的，使用面积不低于15㎡)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	var diAreaDiv5a2="系统审查不通过：(注:2000-4000对的，使用面积不低于45㎡，不少于2个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	var diAreaDiv5a3="系统审查不通过：(注:4000对以上的，使用面积不低于60㎡，不少于3个相对独立的离婚登记窗口)"+"；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个.";
 	//婚姻家庭辅导室
 	var fdsDiv34a="系统审查不通过：(注:婚姻家庭辅导室有独立的房间，使用面积不低于15㎡)"+"；目前情况：婚姻家庭辅导室"+jianShu+"间,使用面积"+fdsArea+"㎡.";
 	var fdsDiv5a="系统审查不通过：(注:5A要有2间独立的婚姻家庭辅导室，每间使用面积不低于15㎡)"+"；目前情况：婚姻家庭辅导室"+jianShu+"间,使用面积"+fdsArea+"㎡.";
 	//颁证大厅
 	var bzdtDiv3a="系统审查不通过：(注:使用面积不低于60㎡，亲友观礼席位不少于8座)"+"；目前情况：颁证大厅使用面积"+bzdtArea+"㎡,亲友观礼席"+qyglx+"座.";
 	var bzdtDiv4a="系统审查不通过：(注:使用面积不低于100㎡，亲友观礼席位不少于12座)"+"；目前情况：颁证大厅使用面积"+bzdtArea+"㎡,亲友观礼席"+qyglx+"座.";
 	var bzdtDiv5a="系统审查不通过：(注:使用面积不低于180㎡，亲友观礼席位不少于20座)"+"；目前情况：颁证大厅使用面积"+bzdtArea+"㎡,亲友观礼席"+qyglx+"座.";
 	//	计算机、打印机、身份识别系统
 	var threeResDivAll="系统审查不通过：(注:每个登记窗口一台计算机、一套证件及纸张打印机，未与公安部门身份信息联网的，每个登记窗口一套身份证识别系统)"+"；目前情况：计算机"+computer+"台,打印机"+printer+"座,身份识别系统"+cardReader+"套.";
 	var fourResDivAll="系统审查不通过：(注:复印机、传真机、扫描仪、电视机每个至少一台)"+"；目前情况："+fyjNum+"复印机,"+czjNum+"传真机,"+smyNum+"扫描仪,"+dsjNum+"电视机.";
 	var lFourResDivAll3a="系统审查不通过：(注:3A年工作量在5000对（件）以上的，必须配有排队叫号系统和电子滚动显示屏)"+"；目前情况："+jhjNum+"排队叫号系统,"+dzxspNum+"电子滚动显示屏.";
 	var lFourResDivAll4a="系统审查不通过：(注:4A以上必须配置排队叫号系统、电子滚动显示屏和服务评价系统)"+"目前情况："+jhjNum+"排队叫号系统,"+dzxspNum+"电子滚动显示屏.";
 	var lFourResDivAll5a="系统审查不通过：(注:5A必须配置排队叫号系统、电子滚动显示屏、服务评价系统和配备具有拍摄功能的监控系统)"+"目前情况："+jhjNum+"排队叫号系统,"+dzxspNum+"电子滚动显示屏,"+fwpjxtNum+"服务评价系统,"+jksbNum+"监控系统.";
 	//户籍人数与婚姻登记员的关系
 	var djyDivAll1="系统审查不通过：(注:办理内地居民婚姻登记的机关，辖区户籍人口30万以下的，至少配4名婚姻登记员)"+"；目前情况：辖区户籍人口"+deptNumRy+"人,婚姻登记员"+djyNum+"名.";
 	var djyDivAll2="系统审查不通过：(注:办理内地居民婚姻登记的机关，至少配4名婚姻登记员；辖区户籍人口30万以上的市辖区，每增加8万户籍人口，配备1名婚姻登记员)"+"；目前情况：辖区户籍人口"+deptNumRy+"人,婚姻登记员"+djyNum+"名.";
 	var djyDivAll3="系统审查不通过：(注:办理内地居民婚姻登记的机关，至少配4名婚姻登记员；辖区户籍人口30万以上的县、县级市，每增加10万户籍人口增配1名婚姻登记员)"+"；目前情况：辖区户籍人口"+deptNumRy+"人,婚姻登记员"+djyNum+"名.";
 	//年工作量与婚姻登记员的关系
 	var djyDivAll4="系统审查不通过：(注:办理涉外、涉港澳台和华侨婚姻登记的登记机关，年工作量500对（件）以下的，至少配2名婚姻登记员)"+"；目前情况：年工作量"+AllNum+"人,婚姻登记员"+djyNum+"名.";
 	var djyDivAll5="系统审查不通过：(注:办理涉外、涉港澳台和华侨婚姻登记的登记机关，年工作量500－1500对（件）的，至少配3名婚姻登记员)"+"；目前情况：年工作量"+AllNum+"人,婚姻登记员"+djyNum+"名.";
 	var djyDivAll6="系统审查不通过：(注:办理涉外、涉港澳台和华侨婚姻登记的登记机关，年工作量1500对（件）以上的，至少配4名婚姻登记员)"+"；目前情况：年工作量"+AllNum+"人,婚姻登记员"+djyNum+"名.";
 	//年结婚登记量与婚姻颁证员的关系
 	var bzyDivAll="系统审查不通过：(注:婚姻登记机关年结婚登记量5000对以下的，至少配2名婚姻颁证员)"+"；目前情况：年结婚登记量"+marryNum+"人,婚姻颁证员"+bzyNum+"名.";
 	var bzyDivAll3a="系统审查不通过：(注:婚姻登记机关年结婚登记量5000对以上的，每增加5000对增配1名婚姻颁证员)"+"；目前情况：年结婚登记量"+marryNum+"人,婚姻颁证员"+bzyNum+"名.";
 	var bzyDivAll4a="系统审查不通过：(注:婚姻登记机关,至少配2名婚姻颁证员;年结婚登记量5000对以上的，每增加4000对,增配1名婚姻颁证员)"+"；目前情况：年结婚登记量"+marryNum+"人,婚姻颁证员"+bzyNum+"名.";
 	var bzyDivAll5a="系统审查不通过：(注:婚姻登记机关,至少配2名婚姻颁证员;年结婚登记量5000对以上的，每增加3000对,增配1名婚姻颁证员)"+"；目前情况：年结婚登记量"+marryNum+"人,婚姻颁证员"+bzyNum+"名.";
 	//辅导员数量
 	var fdyDiv34a="系统审查不通过：(注:婚姻登记机关配有1名或1名以上通过政府购买服务等方式聘用或通过公开招募志愿者等方式招募的婚姻家庭辅导员。婚姻家庭辅导员应具有以下资格之一：社工资格；心理咨询师资格；婚姻家庭咨询师资格；律师资格)"+"；目前情况：婚姻家庭辅导员"+fdyNum+"名.";
 	var fdyDiv5a="系统审查不通过：(注:婚姻登记机关配有2名或2名以上通过政府购买服务等方式聘用或通过公开招募志愿者等方式招募的婚姻家庭辅导员。婚姻家庭辅导员应具有以下资格之一：社工资格；心理咨询师资格；婚姻家庭咨询师资格；律师资格)"+"；目前情况：婚姻家庭辅导员"+fdyNum+"名.";
 	//网络预约系统
 	var wlyyDiv3a="系统审查不通过：(注:国家3A级婚姻登记机关要开通网络预约系统，实现预约系统与婚姻登记系统数据交换，确保优先为预约者办理登记)"+"；目前情况：未开通网络预约系统.";
 	var wlyyDiv4a="系统审查不通过：(注:国家4A级婚姻登记机关网络预约办理登记量不低于当年登记量的10%)"+"；目前情况：网络预约办理登记量"+wlyyl+"件,当年登记量"+sndyyl+"件.";
 	var wlyyDiv5a="系统审查不通过：(注:国家5A级婚姻登记机关网络预约办理登记量不低于当年登记量的20%)"+"；目前情况：网络预约办理登记量"+wlyyl+"件,当年登记量"+sndyyl+"件.";
 	
 	//-------------3A、4A、5A都要遵守---------------
 	//-------------户籍人数与婚姻登记员的关系---------------
 	if(organCode.substring(4,10)!="000000"){//办理内地居民婚姻登记的机关
	 	if(deptNumRy<30){
	 		if(djyNum<4){
	 			document.getElementById("djyDiva").innerHTML=djyDivAll1;
	 			message3a+=djyDivAll1+"<br>";
	 			message4a+=djyDivAll1+"<br>";
	 			message5a+=djyDivAll1+"<br>";
	 		}
	 	}
	 	if(deptNumRy>=30){
	 		var organC=parseInt(organCode.substring(4,6));//判断市辖区
	 		if(organC<20){//市辖级登陆
		 		if(djyNum<Math.floor(4+(deptNumRy-30)/8)){
			 		document.getElementById("djyDiva").innerHTML=djyDivAll2;
		 			message3a+=djyDivAll2+"<br>";
		 			message4a+=djyDivAll2+"<br>";
		 			message5a+=djyDivAll2+"<br>";
		 		}
		 	}else{
		 		if(djyNum<Math.floor(4+(deptNumRy-30)/10)){//县
			 			document.getElementById("djyDiva").innerHTML=djyDivAll3;
			 			message3a+=djyDivAll3+"<br>";
			 			message4a+=djyDivAll3+"<br>";
			 			message5a+=djyDivAll3+"<br>";
		 		}
		 	
		 	}
		 	
	 	}
 	}
 	//-------------年工作量与婚姻登记员的关系---------------
 	if(organCode.substring(4,10)=="000000"){//办理涉外、涉港澳台和华侨婚姻登记的登记机关
 		if(AllNum<500){
 			if(djyNum<2){
	 			document.getElementById("djyDivb").innerHTML=djyDivAll4;
		 		message3a+=djyDivAll4+"<br>";
		 		message4a+=djyDivAll4+"<br>";
		 		message5a+=djyDivAll4+"<br>";
 			}
 		}
 		if(AllNum>=500 && AllNum<=1500){
 			if(djyNum<3){
	 			document.getElementById("djyDivb").innerHTML=djyDivAll5;
		 		message3a+=djyDivAll5+"<br>";
		 		message4a+=djyDivAll5+"<br>";
		 		message5a+=djyDivAll5+"<br>";
 			}
 		}
 		if(AllNum>1500){
 			if(djyNum<4){
	 			document.getElementById("djyDivb").innerHTML=djyDivAll1;
		 		message3a+=djyDivAll6+"<br>";
		 		message4a+=djyDivAll6+"<br>";
		 		message5a+=djyDivAll6+"<br>";
 			}
 		}
 	}
 	//--------------年结婚登记量<5000与婚姻颁证员的关系-----------
 	if(marryNum<5000){
 		if(bzyNum<2){
 		    document.getElementById("bzyDiv").innerHTML=bzyDivAll;
	 		message3a+=bzyDivAll+"<br>";
	 		message4a+=bzyDivAll+"<br>";
	 		message5a+=bzyDivAll+"<br>";
 		}
 	}
 	if(applyLevel=="3A"){//-------------3A---------------
 		//------------------机构性质------------------
 		if( xz1dis &&  xz2dis && xz3dis){
 			document.getElementById("jgDiv").innerHTML=jgDiv3a;
 			message3a+=jgDiv3a+"<br>";
 		} 
 		//年结婚登记量与颁证员的关系
 		if(marryNum>=5000){
	 		if(bzyNum<Math.floor(2+(marryNum-5000)/5000)){
	 			document.getElementById("bzyDiv").innerHTML=bzyDivAll3a;
		 		message3a+=bzyDivAll3a+"<br>";
	 		}
 	    }
 		//-------------------辅导员数量-----------------
 		if(fdyNum<1){
 			document.getElementById("fdyDiv").innerHTML=fdyDiv34a;
 			message3a+=fdyDiv34a+"<br>";
 		}
 		//-----年结婚登记量、出具证明量与结婚登记窗口关系---
 		if(marryNum<5000){
	 		if(marryWindow<2){
	 			document.getElementById("maWinDiv").innerHTML=maWinDiv31;
	 			message3a+=maWinDiv31+"<br>";
	 		}
 		}
 		if(((marryNum>=5000 && marryNum<=10000)|| (attestNum>=5000 && attestNum<=10000)) && marryWindow<3){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv32;
 			message3a+=maWinDiv32+"<br>";
 		}
 		if((marryNum>10000 || attestNum>10000) && marryWindow<4){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv33;
 			message3a+=maWinDiv33+"<br>";
 		}
 		//------年工作量与面积与座椅关系-------------------
 		if(AllNum<10000){//使用面积不得小于120
 			if(marryArea<120){
	 			document.getElementById("maAreaDiv").innerHTML=maAreaDiv3a1;
	 			message3a+=maAreaDiv3a1+"<br>";
 			}
 		}
 		if(AllNum>=10000){
 			if(marryArea<180){//使用面积不得小于180
 				document.getElementById("maAreaDiv").innerHTML=maAreaDiv3a2;
 				message3a+=maAreaDiv3a2+"<br>";
 			}
 		}
 		if(AllNum<5000){//使用面积不得小于120
 			if(hdChair<8 || tbChair<4){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair3a1;
 				message3a+=hdtbchair3a1+"<br>";
 			}
 		}
 		if(AllNum>=5000 && AllNum<=10000){
 			if(hdChair<16 || tbChair<8){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair3a2;
 				message3a+=hdtbchair3a2+"<br>";
 			}
 		}
 		if(AllNum>10000){
 			if(hdChair<24 || tbChair<12){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair3a3;
 				message3a+=hdtbchair3a3+"<br>";
 			}
 		}
 		//--------年离婚登记量与离婚登记区面积、离婚登记区座椅关系---
 		if(divorceNum<2000){
 			if(lhArea<15){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv3a1;
 				message3a+=diAreaDiv3a1+"<br>";
 			}
 		}
 		//alert(divorceNum);
 		if(divorceNum>=2000 && divorceNum<=4000){
 			if(lhArea<25 || lhWindow<2){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv3a2;
 				message3a+=diAreaDiv3a2+"<br>";
 			}
 		}
 		if(divorceNum>4000){
 			if(lhArea<40 || lhWindow<3){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv3a3;
 				message3a+=diAreaDiv3a3+"<br>";
 			}
 		}
 	   //--------婚姻家庭辅导室间数、面积要求--------------
 	   if(jianShu<1 || fdsArea<15){
 	   			document.getElementById("fdsDiv").innerHTML=fdsDiv34a;
 				message3a+=fdsDiv34a+"<br>";
 	   }
 	   //--------颁证大厅面积、亲友观礼席要求--------------
 		if(bzdtArea<60 || qyglx<8){
 				document.getElementById("bzdtDiv").innerHTML=bzdtDiv3a;
 				message3a+=bzdtDiv3a+"<br>";
 		}
 		//--------电脑、打印机、读卡器与窗口关系 
 	 
 	   if(computer<window || printer<window){
 	   			document.getElementById("threeResDiv").innerHTML=threeResDivAll;
 				message3a+=threeResDivAll+"<br>";
 	   }
 	   //--------复印机、传真机、扫描仪、电视机每个至少一台
 		if(fyj || czj || smy || dsj){
 		  	    document.getElementById("fourResDiv").innerHTML=fourResDivAll;
 				message3a+=fourResDivAll+"<br>";
 		}
 		//--------排队叫号系统、电子显示屏、服务评价系统、监控系统
 		if(AllNum>=5000){
 			if(jhj || dzxsp){
 				document.getElementById("lFourResDiv").innerHTML=lFourResDivAll3a;
 				message3a+=lFourResDivAll3a+"<br>";
 			}
 		}
 		//----------------网络预约量----------------------
 		if(wlyyqysj==""){//已经开启网络预约系统
 		  	    document.getElementById("wlyyDiv").innerHTML=wlyyDiv3a;
 				message3a+=wlyyDiv3a+"<br>";
 		}
 	   //---------输出3A申报结果-------------------------
 	   msg=message3a;//打印校验
 		/**
		  *  校验信息
		  *  事件处理：关闭window
		  *  licb 2012-02-22
		  **/
        var message3aText = "";
	    var message3aArr = message3a.split("<br>");
	    for (var i = 0; i < message3aArr.length-1; i++){
	    	if(i > 0) message3aText = message3aText + "<br>";
	        message3aText = message3aText +(i+1)+ "、"+ message3aArr[i];
	    }
 	   
 		if(message3a!=""){
 			wShow(ds.getAt(0).get("deptName")+"申请国家3A级婚姻登记机关<br>不符合标准项如下：<br>",message3aText);
 			return false;
 		}else{
 			alert("符合国家3A级婚姻登记机关评定标准，可打印申报表！");
 		}
 	}
 	if(applyLevel=="4A"){//-------------4A---------------
 		if(!xz3dis){//机构性质
 			document.getElementById("jgDiv").innerHTML=jgDiv4a;
 			message4a+=jgDiv4a+"<br>";
 		} 
 		//-------------年结婚登记量与婚姻颁证员的关系---------------
 		if(marryNum>=5000){
	 		if(bzyNum<Math.floor(2+(marryNum-5000)/4000)){
	 			document.getElementById("bzyDiv").innerHTML=bzyDivAll4a;
		 		message4a+=bzyDivAll4a+"<br>";
	 		}
 	    }
 	    
 	    //-------------------辅导员数量-----------------
 		if(fdyNum<1){
 			document.getElementById("fdyDiv").innerHTML=fdyDiv34a;
 			message4a+=fdyDiv34a+"<br>";
 		}
 		//年结婚登记量、出具证明量与结婚登记窗口关系
 		if(marryNum<5000){
	 		if(marryWindow<3){
	 			document.getElementById("maWinDiv").innerHTML=maWinDiv41;
	 			message4a+=maWinDiv41+"<br>";
	 		}
 		}
 		if(((marryNum>=5000 && marryNum<=10000)|| (attestNum>=5000 && attestNum<=10000)) && marryWindow<4){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv42;
 			message4a+=maWinDiv42+"<br>";
 		}
 		if((marryNum>10000 || attestNum>10000) && marryWindow<5){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv43;
 			message4a+=maWinDiv43+"<br>";
 		}
 		//年工作量与面积与座椅关系
 		if(AllNum<10000){//使用面积不得小于150
 			if(marryArea<150){
	 			document.getElementById("maAreaDiv").innerHTML=maAreaDiv4a1;
	 			message4a+=maAreaDiv4a1+"<br>";
 			}
 		}
 		if(AllNum>=10000){
 			if(marryArea<220){//使用面积不得小于220
 				document.getElementById("maAreaDiv").innerHTML=maAreaDiv4a2;
 				message4a+=maAreaDiv4a2+"<br>";
 			}
 		}
 		if(AllNum<5000){
 			if(hdChair<10 || tbChair<6){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair4a1;
 				message4a+=hdtbchair4a1+"<br>";
 			}
 		}
 		if(AllNum>=5000 && AllNum<=10000){
 			if(hdChair<20 || tbChair<12){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair4a2;
 				message4a+=hdtbchair4a2+"<br>";
 			}
 		}
 		if(AllNum>10000){
 			if(hdChair<30 || tbChair<18){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair5a3;
 				 message4a+=hdtbchair4a3+"<br>";
 			}
 		}
 		//--------年离婚登记量与离婚登记区面积、离婚登记区座椅关系---
 		if(divorceNum<2000){
 			if(lhArea<15){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv4a1;
 				message4a+=diAreaDiv4a1+"<br>";
 			}
 		}
 		if(divorceNum>=2000 && divorceNum<=4000){
 			if(lhArea<35 || lhWindow<2){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv4a2;
 				message4a+=diAreaDiv4a2+"<br>";
 			}
 		}
 		if(divorceNum>4000){
 			if(lhArea<50 || lhWindow<3){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv4a3;
 				message4a+=diAreaDiv4a3+"<br>";
 			}
 		}
 	    //--------婚姻家庭辅导室间数、面积要求--------------
 	   if(jianShu<1 || fdsArea<15){
 	   			document.getElementById("fdsDiv").innerHTML=fdsDiv34a;
 				message4a+=fdsDiv34a+"<br>";
 	   }
 	   //--------颁证大厅面积、亲友观礼席要求--------------
 		if(bzdtArea<100 || qyglx<12){
 				document.getElementById("bzdtDiv").innerHTML=bzdtDiv4a;
 				message4a+=bzdtDiv4a+"<br>";
 		}
 		//--------电脑、打印机、读卡器与窗口关系 
 	 
 	   if(computer<window || printer<window){
 	   			document.getElementById("threeResDiv").innerHTML=threeResDivAll;
 				message4a+=threeResDivAll+"<br>";
 	   }
    	//--------复印机、传真机、扫描仪、电视机每个至少一台
 		if(fyj || czj || smy || dsj){
 		  	    document.getElementById("fourResDiv").innerHTML=fourResDivAll;
 				message4a+=fourResDivAll+"<br>";
 		}
 		//--------排队叫号系统、电子显示屏、服务评价系统、监控系统
 			if(jhj || dzxsp || fwpjxt){
 				document.getElementById("lFourResDiv").innerHTML=lFourResDivAll4a;
 				message4a+=lFourResDivAll4a+"<br>";
 			}
 		//----------------网络预约量----------------------
 		if(wlyyl*10<sndyyl){//网络预约办理登记量不低于当年登记量的10%
 		  	    document.getElementById("wlyyDiv").innerHTML=wlyyDiv4a;
 				message4a+=wlyyDiv4a+"<br>";
 		}
 		//输出4A申报结果
 		msg=message4a;//打印校验
 		/**
		  *  校验信息
		  *  事件处理：关闭window
		  *  licb 2012-02-22
		  **/
        var message4aText = "";
	    var message4aArr = message4a.split("<br>");
	    for (var i = 0; i < message4aArr.length-1; i++){
	    	if(i > 0) message4aText = message4aText + "<br>";
	        message4aText = message4aText +(i+1)+ "、"+ message4aArr[i];
	    }
 	   
 		if(message4a!=""){
 			wShow(ds.getAt(0).get("deptName")+"申请国家4A级婚姻登记机关<br>不符合标准项如下：<br>",message4aText);
 			//alert(deptName+"申请国家4A级婚姻登记机关，不符合标准项如下：\n\n"+message4a);
 			return false;
 		}else{
 			alert("符合国家4A级婚姻登记机关评定标准，可打印申报表！");
 		}
 	}
 	
 	if(applyLevel=="5A"){//-------------5A---------------
 		if(xz1dis){//机构性质
 			document.getElementById("jgDiv").innerHTML=jgDiv5a;
 			message5a+=jgDiv5a+"<br>";
 		}
 		//-------------年结婚登记量与婚姻颁证员的关系---------------
 		if(marryNum>=5000){
	 		if(bzyNum<Math.floor(2+(marryNum-5000)/3000)){
	 			document.getElementById("bzyDiv").innerHTML=bzyDivAll5a;
		 		message5a+=bzyDivAll5a+"<br>";
	 		}
 	    }
 	    
 	    //-------------------辅导员数量-----------------
 		if(fdyNum<2){
 			document.getElementById("fdyDiv").innerHTML=fdyDiv5a;
 			message5a+=fdyDiv5a+"<br>";
 		}
 		//年结婚登记量、出具证明量与结婚登记窗口关系
 		if(marryNum<5000){
	 		if(marryWindow<4){
	 			document.getElementById("maWinDiv").innerHTML=maWinDiv51;
	 			message5a+=maWinDiv51+"<br>";
	 		}
 		}
 		if(((marryNum>=5000 && marryNum<=10000)|| (attestNum>=5000 && attestNum<=10000)) && marryWindow<5){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv52;
 			message5a+=maWinDiv52+"<br>";
 		}
 		if((marryNum>10000 || attestNum>10000) && marryWindow<6){
 			document.getElementById("maWinDiv").innerHTML=maWinDiv53;
 			message5a+=maWinDiv53+"<br>";
 		}
 		//年工作量与面积与座椅关系
 		if(AllNum<10000){//使用面积不得小于120
 			if(marryArea<200){
	 			document.getElementById("maAreaDiv").innerHTML=maAreaDiv5a1;
	 			message5a+=maAreaDiv5a1+"<br>";
 			}
 		}
 		if(AllNum>=10000){
 			if(marryArea<300){//使用面积不得小于300
 				document.getElementById("maAreaDiv").innerHTML=maAreaDiv5a2;
 				message5a+=maAreaDiv5a2+"<br>";
 			}
 		}	
 		if(AllNum<5000){
 			if(hdChair<12 || tbChair<8){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair5a1;
 				message5a+=hdtbchair5a1+"<br>";
 			}
 		}
 		if(AllNum>=5000 && AllNum<=10000){
 			if(hdChair<24 || tbChair<16){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair5a2;
 				message5a+=hdtbchair5a2+"<br>";
 			}
 		}
 		
 		if(AllNum>10000){
 			if(hdChair<36 || tbChair<24){
 				document.getElementById("hdtbchiarDiv").innerHTML=hdtbchair5a3;
 				message5a+=hdtbchair5a3+"<br>";
 			}
 		}
 		
 		//--------年离婚登记量与离婚登记区面积、离婚登记区座椅关系---
 		if(divorceNum<2000){
 			if(lhArea<15){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv5a1;
 				message5a+=diAreaDiv5a1+"<br>";
 			}
 		}
 		if(divorceNum>=2000 && divorceNum<=4000){
 			if(lhArea<35 || lhWindow<2){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv5a2;
 				message5a+=diAreaDiv5a2+"<br>";
 			}
 		}
 		if(divorceNum>4000){
 			if(lhArea<50 || lhWindow<3){
 				document.getElementById("lhAreaWinDiv").innerHTML=diAreaDiv5a3;
 				message5a+=diAreaDiv5a3+"<br>";
 			}
 		}
 	  //--------婚姻家庭辅导室间数、面积要求--------------
 	   if(jianShu<2 || fdsArea<30){
 	   			document.getElementById("fdsDiv").innerHTML=fdsDiv5a;
 				message5a+=fdsDiv5a+"<br>";
 	   }
 	   //--------颁证大厅面积、亲友观礼席要求--------------
 		if(bzdtArea<180 || qyglx<20){
 				document.getElementById("bzdtDiv").innerHTML=bzdtDiv5a;
 				message5a+=bzdtDiv5a+"<br>";
 		}
 	   //--------电脑、打印机、读卡器与窗口关系 
 	 
 	   if(computer<window || printer<window){
 	   			document.getElementById("threeResDiv").innerHTML=threeResDivAll;
 				message5a+=threeResDivAll+"<br>";
 	   }
 	   //--------复印机、传真机、扫描仪、电视机每个至少一台
 		if(fyj || czj || smy || dsj){
 		  	    document.getElementById("fourResDiv").innerHTML=fourResDivAll;
 				message5a+=fourResDivAll+"<br>";
 		}
 		//--------排队叫号系统、电子显示屏、服务评价系统、监控系统
 			if(jhj || dzxsp || fwpjxt || jksb){
 				document.getElementById("lFourResDiv").innerHTML=lFourResDivAll5a;
 				message5a+=lFourResDivAll5a+"<br>";
 			}
 		//----------------网络预约量----------------------
 		if(wlyyl*5<sndyyl){//网络预约办理登记量不低于当年登记量的10%
 		  	    document.getElementById("wlyyDiv").innerHTML=wlyyDiv5a;
 				message5a+=wlyyDiv5a+"<br>";
 		}
 		//输出5A申报结果
 		msg=message5a;//打印校验
 		/**
		  *  校验信息
		  *  事件处理：关闭window
		  *  licb 2012-02-22
		  **/
        var message5aText = "";
	    var message5aArr = message5a.split("<br>");
	    for (var i = 0; i < message5aArr.length-1; i++){
	    	if(i > 0) message5aText = message5aText + "<br>";
	        message5aText = message5aText +(i+1)+ "、"+ message5aArr[i];
	    }
 		if(message5a!=""){
 			wShow(ds.getAt(0).get("deptName")+"申请国家5A级婚姻登记机关<br>不符合标准项如下：<br>",message5aText);
 			//alert(deptName+"申请国家5A级婚姻登记机关，不符合标准项如下：\n"+message5a);
 			return false;
 		}else{
 			alert("符合国家5A级婚姻登记机关评定标准，可打印申报表！");
 			}
 			
 			
 	}
 	//-------------3A、4A、5A都要遵守---------------
 	
}
function printWord(){
	//alert("尚未实现导出功能！");
	document.getElementById("docpath").value = "jsp/cams/marry/reports/marry.fr3";
	document.getElementById("deptId").value = deptId; 
	var url="../../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}

function wShow(title,results){
	//alert("尚未实现导出功能！");
	  var res = escape(encodeURIComponent(results));
	  var tit = escape(encodeURIComponent(title));
	 results=results+"<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+myDate.toLocaleDateString();
	var win=L5.getCmp('cueWin');
	win.show();
	document.getElementById("cue_title").innerHTML='<br><font size="4" color="red">'+title+'</font>';
	document.getElementById("cue_content").innerHTML='<font size="4" color="red">'+results+'</font>';
	
	//var url=L5.webPath+"/jsp/cams/marry/dept/level/applyResult.jsp?results="+results+"&title="+tit;
	
	//var width = 1024;
	//var height = 768;
    //window.open(url,window,"scrollbars:yes;status:no;width:"+width+"px;height:"+height+"px;resizable:no");
    //window.open (url, 'newwindow', 'height=768, width=1024, top=100, left=100, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
	//window.close();
}
 function back()
 {	 	var url='jsp/cams/marry/dept/mrm_organ_edit.jsp';
		var text = '等级评定信息表';
		L5.forward(url,text);	 
 }

/**
* 登记机关jsp调用
*/
function func_djjg(){
var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp?organCode=370100000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
if(revalue!=""&&revalue!=undefined){
var list = revalue.split(";");
 ds.getCurrent().set("deptId",list[0]);
 ds.getCurrent().set("deptName",list[1]);
 //document.getElementById("deptId").value=list[0];
 
}
} 

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

var printTitle;
//打印预览调用方法
function printBill(){
if(msg=="noCheck"){
	L5.Msg.alert("提示","请先校验！");
	return false;
}else if(msg!=""){
	L5.Msg.alert("提示","校验不通过，无法打印！");
	return false;
}
//else{

   //	alert("----");
	var printDataset=L5.DatasetMgr.lookup("ds");
	/*
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		var value = records[i].get('servedMilitaryRegion');
		 
	}	
	*/
	doPrint(printDataset);
//}
}
// 打印方法传递的record
function doPrint(printDataset){
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/marry/reports/MarryApp.fr3');
}


function cleanDiv(){
	//var divs=document.getElementsByTagName()getElementByTag("div");
	//alert(divs.length);

}
/**
 *  校验按钮后弹出的window--打印
 *  事件处理：打印审查信息
 *  licb 2012-02-22
 **/
function save_win(){
	 window.print();
}
 /**
 *  校验按钮后弹出的window--关闭
 *  事件处理：关闭window
 *  licb 2012-02-22
 **/
 function close_win(){
    var cueWin=L5.getCmp("cueWin");
	cueWin.hide();
 }

function cleanDiv1(){
	document.getElementById("jgDiv").innerHTML="";
	document.getElementById("djyDiva").innerHTML="";
	document.getElementById("djyDivb").innerHTML="";
	document.getElementById("bzyDiv").innerHTML="";
	
	document.getElementById("fdyDiv").innerHTML="";
	document.getElementById("maWinDiv").innerHTML="";
	document.getElementById("maAreaDiv").innerHTML="";
	document.getElementById("hdtbchiarDiv").innerHTML="";
	document.getElementById("lhAreaWinDiv").innerHTML="";
	document.getElementById("fdsDiv").innerHTML="";
	document.getElementById("bzdtDiv").innerHTML="";
	
	document.getElementById("threeResDiv").innerHTML="";
	document.getElementById("fourResDiv").innerHTML="";
	
	document.getElementById("lFourResDiv").innerHTML="";
	document.getElementById("wlyyDiv").innerHTML="";
	document.getElementById("fourResDiv").innerHTML="";
	document.getElementById("fourResDiv").innerHTML="";
	

}

function cleanDiv(){
    msg="noCheck";
	cleanDiv1();
	document.getElementById("jgDiv").style.display="none";
	document.getElementById("djyDiva").style.display="none";
	document.getElementById("djyDivb").style.display="none";
	document.getElementById("bzyDiv").style.display="none";
	
	document.getElementById("fdyDiv").style.display="none";
	document.getElementById("maWinDiv").style.display="none";
	document.getElementById("maAreaDiv").style.display="none";
	document.getElementById("hdtbchiarDiv").style.display="none";
	document.getElementById("lhAreaWinDiv").style.display="none";
	document.getElementById("fdsDiv").style.display="none";
	document.getElementById("bzdtDiv").style.display="none";
	
	document.getElementById("threeResDiv").style.display="none";
	document.getElementById("fourResDiv").style.display="none";
	
	document.getElementById("lFourResDiv").style.display="none";
	document.getElementById("wlyyDiv").style.display="none";
	document.getElementById("fourResDiv").style.display="none";
	document.getElementById("fourResDiv").style.display="none";
    message3a="";
 	message4a="";
 	message5a="";

}

function showDiv(){
	document.getElementById("jgDiv").style.display="";
	document.getElementById("djyDiva").style.display="";
	document.getElementById("djyDivb").style.display="";
	document.getElementById("bzyDiv").style.display="";
	
	document.getElementById("fdyDiv").style.display="";
	document.getElementById("maWinDiv").style.display="";
	document.getElementById("maAreaDiv").style.display="";
	document.getElementById("hdtbchiarDiv").style.display="";
	document.getElementById("lhAreaWinDiv").style.display="";
	document.getElementById("fdsDiv").style.display="";
	document.getElementById("bzdtDiv").style.display="";
	
	document.getElementById("threeResDiv").style.display="";
	document.getElementById("fourResDiv").style.display="";
	
	document.getElementById("lFourResDiv").style.display="";
	document.getElementById("wlyyDiv").style.display="";
	document.getElementById("fourResDiv").style.display="";
	document.getElementById("fourResDiv").style.display="";
	checkLevel();

}