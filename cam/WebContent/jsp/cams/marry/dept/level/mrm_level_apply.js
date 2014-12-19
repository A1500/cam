var jgxz="";
var wsj="";
//复印机、传真机、扫描仪、电视机
var fyj="1";
var czj="2";
var smy="3";
var dsj="4";
var dn="5";
var dyj="6";
var sfsbxt="7";
var jhj="8";//排队叫号系统
var dzxsp="9";//电子滚动显示屏
var fwpjxt="10";//服务评价系统
var jksb="11";//监控系统
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
	 	deptId = mrmBasePersonCommand.getReturn("deptId");
	 	deptName= mrmBasePersonCommand.getReturn("deptName");
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
 			jgxz="1";
 		}
 		if(ds.getAt(0).get("types")=="02"){
 			document.getElementById("xz2").style.display="";
 			document.getElementById("xz1").style.display="none";
 			document.getElementById("xz3").style.display="none";
 			jgxz="2";
 		}
 		if(ds.getAt(0).get("types")=="03"){
 			document.getElementById("xz3").style.display="";
 			document.getElementById("xz2").style.display="none";
 			document.getElementById("xz1").style.display="none";
 			jgxz="3";
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
 			fyj="";
 		}
 		//传真机
 		if(ds.getAt(0).get("czj")<1){
 			document.getElementById("czj").style.display="none";
 			czj="";
 		}
 		//扫描仪
 		if(ds.getAt(0).get("smy")<1){
 			document.getElementById("smy").style.display="none";
 			smy="";
 		}
 		//电视机
 		if(ds.getAt(0).get("dsj")<1){
 			document.getElementById("dsj").style.display="none";
 			dsj="";
 		}
 		//叫号机
 		if(ds.getAt(0).get("jhj")<1){
 			document.getElementById("jhj").style.display="none";
 			jhj="";
 		}
 		//电子显示屏
 		if(ds.getAt(0).get("dzxsp")<1){
 			document.getElementById("dzxsp").style.display="none";
 			dzxsp="";
 		}
 		//服务评价系统
 		if(ds.getAt(0).get("fwpjxt")<1){
 			document.getElementById("fwpjxt").style.display="none";
 			fwpjxt="";
 		}
 		//监控设备
 		if(ds.getAt(0).get("jksb")<1){
 			document.getElementById("jksb").style.display="none";
 			jksb="";
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
 			wsj="1";
 		}
 		if(ds.getAt(0).get("wc")=="02"){
 			document.getElementById("station2").style.display="";
 			document.getElementById("station1").style.display="none";
 			document.getElementById("station3").style.display="none";
 			wsj="2";
 		}
 		if(ds.getAt(0).get("wc")=="03"){
 			document.getElementById("station3").style.display="";
 			document.getElementById("station2").style.display="none";
 			document.getElementById("station1").style.display="none";
 			wsj="3";
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
 	

 	
 	//设备件数
	var fyjNum="";
	if(fyj==""){
		fyjNum="没有"
	}else{
		fyjNum="有"
	}
	var czjNum="";
	if(czj==""){
		czjNum="没有"
	}else{
		czjNum="有"
	}
	var smyNum="";
	if(smy==""){
		smyNum="没有"
	}else{
		smyNum="有"
	}
	var dsjNum="";
	if(dsj==""){
		dsjNum="没有"
	}else{
		dsjNum="有"
	}
	     
	var jhjNum="";//排队叫号系统
	if(jhj==""){
		jhjNum="没有"
	}else{
		jhjNum="有"
	}
	var dzxspNum="";  //电子滚动显示屏
	if(dzxsp==""){
		dzxspNum="没有"
	}else{
		dzxspNum="有"
	}
	var fwpjxtNum=""; //服务评价系统
	if(fwpjxt==""){
		fwpjxtNum="没有"
	}else{
		fwpjxtNum="有"
	}
	var jksbNum=""; //监控系统
	if(jksb==""){
		jksbNum="没有"
	}else{
		jksbNum="有"
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
 	
 	
 	var message="";
 	var djyXzbz="";
 	var djyCggl="";
 	var djyQebk="";
	var note3="";
 	
	var standardDs=L5.DatasetMgr.lookup("standardDs");
	standardDs.setParameter("STANDARD_LEVEL@=",applyLevel);
	standardDs.load();
	standardDs.on("load",function(){
		for(var i=1;i<=standardDs.getCount();i++){	
		 	//机构性质
			if(i==1){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note").replace(";","，或");
		 		var n=jgxz;
		 		if(!eval(famula)){
				 	var div="系统审查不通过：(注:机构性质为"+note+")；目前情况："+$("xz"+n).innerHTML+"。";
		 			document.getElementById("jgDiv").innerHTML=div;
		 			message+=div+"<br>";
	 			}
			} 
		 	//婚姻登记员编制
			if(i==2){
				if($("xzbzNum").innerHTML>0){
					djyXzbz="1";
				}
				if($("cgglNum").innerHTML>0){
					djyCggl="2";
				}
				if($("qebkNum").innerHTML>0){
					djyQebk="3";
				}
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note").replace(";","，或");
				if(djyXzbz){
			 		var n=djyXzbz;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:婚姻登记员为"+note+")；目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			document.getElementById("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
				if(djyCggl){
			 		var n=djyCggl;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:婚姻登记员为"+note+")；目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			document.getElementById("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
				if(djyQebk){
			 		var n=djyQebk;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:婚姻登记员为"+note+")；目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			document.getElementById("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
			} 
			//婚姻登记员配置
			if(i==3){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
 				if(organCode.substring(4,10)!="000000"){//办理内地居民婚姻登记的机关
 					note3=note;
			 		if(deptNumRy>=con1 && deptNumRy<con2){
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div="系统审查不通过：(注:"+note+")；目前情况：辖区户籍人口"+deptNumRy+"万人,婚姻登记员"+djyNum+"名。";
				 			document.getElementById("djyDiva").innerHTML=div;
				 			message+=div+"<br>";
			 			}
			 		}
		 		}
			}
			if(i==4){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
 				if(organCode.substring(4,10)!="000000"){//办理内地居民婚姻登记的机关
			 		if(deptNumRy>=con1 && deptNumRy<con2 && parseInt(organCode.substring(4,6))<20){//判断市辖区
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div="系统审查不通过：(注:"+note3+"，"+note+")；目前情况：辖区户籍人口"+deptNumRy+"万人,婚姻登记员"+djyNum+"名。";
				 			document.getElementById("djyDiva").innerHTML=div;
				 			message+=div+"<br>";
			 			}
			 		}
		 		}
			}
			if(i==5){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
 				if(organCode.substring(4,10)!="000000"){//办理内地居民婚姻登记的机关
			 		if(deptNumRy>=con1 && deptNumRy<con2 && parseInt(organCode.substring(4,6))>=20){
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div="系统审查不通过：(注:"+note3+"，"+note+")；目前情况：辖区户籍人口"+deptNumRy+"万人,婚姻登记员"+djyNum+"名。";
				 			document.getElementById("djyDiva").innerHTML=div;
				 			message+=div+"<br>";
			 			}
			 		}
		 		}
			}
			//婚姻登记员涉外
			if(i==6 || i==7 || i==8){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if(organCode.substring(4,10)=="000000"){//办理涉外、涉港澳台和华侨婚姻登记的登记机关	
			 		if(AllNum>=con1 && AllNum<con2){
				 		var n=djyNum;
				 		if(!eval(famula)){
						 	var div="系统审查不通过：(注:"+note+")；目前情况：年工作量"+AllNum+"对（件）,婚姻登记员"+djyNum+"名。";
				 			document.getElementById("djyDivb").innerHTML=div;
				 			message+=div+"<br>";
			 			}
			 		}
				}
			}
			//婚姻颁证员		
			if(i==9 || i==10){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if(marryNum>=con1 && marryNum<con2){
			 		var n=bzyNum;
			 		var r=marryNum;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:"+note+")；目前情况：年结婚登记量"+marryNum+"对,婚姻颁证员"+bzyNum+"名。";
			 			document.getElementById("bzyDiv").innerHTML=div;
			 			message+=div+"<br>";
		 			}
		 		}
			}
			//婚姻家庭辅导员
			if(i==11){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
		 		var n=fdyNum;
		 		if(!eval(famula)){
				 	var div="系统审查不通过：(注:"+note+")；目前情况：婚姻家庭辅导员"+fdyNum+"名。";
		 			document.getElementById("fdyDiv").innerHTML=div;
		 			message+=div+"<br>";
		 		}
			}
			//环境布局面积
			if(i==13 || i==14){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if(AllNum>=con1 && AllNum<con2){
			 		var n=marryArea;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:"+note+")；目前情况：年工作量"+AllNum+"对（件）,使用面积"+marryArea+"㎡。";
			 			document.getElementById("maAreaDiv").innerHTML=div;
			 			message+=div+"<br>";
		 			}
		 		}
			}
			//候登大厅座椅
			if(i==15 || i==16 || i==17){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if(AllNum>=con1 && AllNum<con2){
			 		var n=hdChair;
			 		var r=tbChair;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:"+note+")；目前情况：年工作量"+AllNum+"对（件）,候登座椅"+hdChair+"座,填表座椅"+tbChair+"座。";
			 			document.getElementById("hdtbchiarDiv").innerHTML=div;
			 			message+=div+"<br>";
		 			}
		 		}
			}
			//结婚登记窗口
			if(i==18 || i==19 || i==20){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if((parseInt(marryNum)+parseInt(attestNum))>=con1 && (parseInt(marryNum)+parseInt(attestNum))<con2){
			 		var n=marryWindow;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:"+note+")；目前情况：年结婚登记量"+marryNum+"对,出具证明量"+attestNum+"对,结婚登记窗口"+marryWindow+"个。" ;
			 			document.getElementById("maWinDiv").innerHTML=div;
			 			message+=div+"<br>";
		 			}
		 		}
			}
			//离婚登记窗口
			if(i==21 || i==22 || i==23){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
		 		if(divorceNum>=con1 && divorceNum<con2){
			 		var n=lhArea;
			 		var r=lhWindow;
			 		if(!eval(famula)){
					 	var div="系统审查不通过：(注:"+note+")；目前情况：年离婚登记量"+divorceNum+"对,离婚登记区面积"+lhArea+"㎡,离婚登记窗口"+lhWindow+"个。";
			 			document.getElementById("lhAreaWinDiv").innerHTML=div;
			 			message+=div+"<br>";
		 			}
		 		}
			}
			//婚姻家庭辅导室
			if(i==24){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note").replace(";","，");
			  	var n=fdsArea;
			  	var r=jianShu;
			  	if(!eval(famula)){	
				 	var div="系统审查不通过：(注:"+note+")；目前情况：婚姻家庭辅导室"+jianShu+"间,使用面积"+fdsArea+"㎡。";
					document.getElementById("fdsDiv").innerHTML=div;
					message+=div+"<br>";
			  	}
			}
			//颁证大厅
			if(i==25){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
		 		var n=bzdtArea;
		 		var r=qyglx;
			  	if(!eval(famula)){	
				 	var div="系统审查不通过：(注:"+note+")；目前情况：颁证大厅使用面积"+bzdtArea+"㎡,亲友观礼席"+qyglx+"座。";
					document.getElementById("bzdtDiv").innerHTML=div;
					message+=div+"<br>";
		 		}
			}
			//设施配备
			if(i==26){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note").split(";");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
			 	var notes="";
			 	var nums="";
			 	var notesWin="";
			 	var numsWin="";
			 	for(var j=0;j<note.length;j++){
			 		if(note[j]=="复印机"){
				 		var n=fyj;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=fyjNum+"复印机";
				 		}
			 		}
			 		if(note[j]=="传真机"){
				 		var n=czj;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=czjNum+"传真机";
				 		}
			 		}
			 		if(note[j]=="扫描仪"){
				 		var n=smy;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=smyNum+"扫描仪";
				 		}
			 		}
			 		if(note[j]=="当事人等候观看的电视"){
				 		var n=dsj;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=dsjNum+"电视机";
				 		}
			 		}
			 		
			 		if(note[j].indexOf("排队叫号系统")>=0){
				 		var n=jhj;				 		
		 				if(AllNum>=con1 && AllNum<con2){
						  	if(!eval(famula)){	
						  		if(notes){
						  			notes+="、";
				 					nums+="，";
						  		}
							 	notes+=note[j];
				 				nums+=jhjNum+"排队叫号系统";
					 		}
				 		}
			 		}
			 		if(note[j].indexOf("电子滚动显示屏")>=0){
				 		var n=dzxsp;			 		
		 				if(AllNum>=con1 && AllNum<con2){
						  	if(!eval(famula)){	
						  		if(notes){
						  			notes+="、";
				 					nums+="，";
						  		}
							 	notes+=note[j];
				 				nums+=dzxspNum+"电子滚动显示屏";
					 		}
				 		}
			 		}
			 		if(note[j]=="服务评价系统"){
				 		var n=fwpjxt;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=fwpjxtNum+"服务评价系统";
				 		}
			 		}
			 		if(note[j]=="具有拍摄功能的监控系统"){
				 		var n=jksb;
					  	if(!eval(famula)){	
					  		if(notes){
					  			notes+="、";
			 					nums+="，";
					  		}
						 	notes+=note[j];
			 				nums+=jksbNum+"监控系统";
				 		}
			 		}
			 		
			 		if(note[j]=="每个登记窗口一台电脑"){
				 		var n=dn;
					  	if(eval(famula) && computer<window){
					  		if(notesWin){
					  			notesWin+="，";
			 					numsWin+="，";
					  		}
						 	notesWin+=note[j];
			 				numsWin+="电脑"+computer+"台";
				 		}
			 		}
			 		if(note[j]=="每个登记窗口一套证件及纸张打印机"){
				 		var n=dyj;
					  	if(eval(famula) && printer<window){	
					  		if(notesWin){
					  			notesWin+="，";
			 					numsWin+="，";
					  		}
						 	notesWin+=note[j];
			 				numsWin+="打印机"+printer+"台";
				 		}
			 		}
			 		if(note[j]=="未与公安部门身份信息联网的，每个登记窗口一套身份证识别系统"){
				 		var n=sfsbxt;
					  	if(eval(famula) && cardReader<window){	
					  		if(notesWin){
					  			notesWin+="，";
			 					numsWin+="，";
					  		}
						 	notesWin+=note[j];
			 				numsWin+="身份识别系统"+cardReader+"套";
				 		}
			 		}
			 	}
			 	if(notes){
				 	var div="系统审查不通过：(注:婚姻登记机关应配有"+notes+"每个至少一台（套）)"+"；目前情况："+nums+"。";
					document.getElementById("fourResDiv").innerHTML=div;
					message+=div+"<br>";
				}
			 	if(notesWin){
				 	var div="系统审查不通过：(注:婚姻登记机关应配有"+notesWin+")；目前情况："+numsWin+"。";
					document.getElementById("threeResDiv").innerHTML=div;
					message+=div+"<br>";
				}
			}
			//网络预约
			if(i==27){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
		 		var n=parseInt(wlyyl/sndyyl);
		 		if(!n){
		 			n=0;
		 		}
			  	if(!eval(famula)){	
				 	var div="系统审查不通过：(注:"+note+")；目前情况：网络预约登记量共计"+wlyyl+"对，上年度登记量"+sndyyl+"对，网络预约登记量占上年度登记量的"+n+"%。";
				 	if(!wlyyqysj || wlyyqysj>myDate){
				 		div="系统审查不通过：(注:"+note+")；目前情况：没有启用网络预约系统。";
				 	}
					document.getElementById("wlyyDiv").innerHTML=div;
					message+=div+"<br>";
		 		}
			}
		}
 		//卫生间
 		if(applyLevel=="3A" && wsj!="2" && wsj!="3"){
 			var div;
 			if(wsj!=""){
			 	div="系统审查不通过：(注:婚姻登记机关所在楼内设有男女卫生间，有明显指示牌)；目前情况：卫生间设在"+$("station"+wsj).innerHTML+"。";
 			}else{
 				div="系统审查不通过：(注:婚姻登记机关所在楼内设有男女卫生间，有明显指示牌)；目前情况：没有卫生间。";
 			}		 	
			document.getElementById("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="4A" && wsj!="2"){
 			var div;
 			if(wsj!=""){
			 	div="系统审查不通过：(注:婚姻登记机关所在楼层设有男女卫生间，有明显指示牌)；目前情况：卫生间设在"+$("station"+wsj).innerHTML+"。";
 			}else{			 	
 				div="系统审查不通过：(注:婚姻登记机关所在楼层设有男女卫生间，有明显指示牌)；目前情况：没有卫生间。";
 			}		 	
			document.getElementById("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="5A" && wsj==""){
 			var div="系统审查不通过：(注:婚姻登记机关内设有男女卫生间，干净整洁，有明显指示牌)；目前情况：没有卫生间。";
			document.getElementById("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//无障碍通道
 		if(applyLevel=="4A" && $("wzatd1").style.display=="none"){
		 	var div="系统审查不通过：(注:婚姻登记机关设有无障碍通道或提供无障碍登记服务)；目前情况："+$("wzatd2").innerHTML+"。";
			document.getElementById("wzatdDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="5A" && $("wzatd1").style.display=="none"){
		 	var div="系统审查不通过：(注:婚姻登记机关设有无障碍通道)；目前情况："+$("wzatd2").innerHTML+"。";
			document.getElementById("wzatdDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//在线登记
 		var zxsj=$("zxsj").innerHTML;
 		if(!zxsj || zxsj>myDate){
		 	var div="系统审查不通过：(注:通过省级婚姻登记工作平台实现实时在线登记)；目前情况：没有实现在线登记。";
			document.getElementById("zxsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//数据交换
 		var lwsj=$("lwsj").innerHTML;
 		if(applyLevel!="3A" && (!lwsj || lwsj>myDate)){
		 	var div="系统审查不通过：(注:婚姻登记数据通过部省两级婚姻登记数据交换实现全国联网)；目前情况：没有实现部省两级婚姻登记数据交换共享。";
			document.getElementById("lwsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//历史数据补录
 		var blsj=$("blsj").innerHTML;
 		var blsjBz;
 		var blsjVal;
 		if(applyLevel=="3A"){
 			blsjBz="1990-01-01";
 			blsjVal="1990年以来";
 		}else if(applyLevel=="3A"){
 			blsjBz="1970-01-01";
 			blsjVal="1970年以来";
 		}else{
 			blsjBz="1949-10-01";
 			blsjVal="解放后";
 		}
 		if(!blsj || blsj>blsjBz){
		 	var div="系统审查不通过：(注:将本辖区"+blsjVal+"保存的所有婚姻登记档案录入婚姻登记信息系统)；目前情况：没有补录历史数据。";
		 	if(blsj){
		 		div="系统审查不通过：(注:将本辖区"+blsjVal+"保存的所有婚姻登记档案录入婚姻登记信息系统)；目前情况：婚姻登记历史数据已补录至"+blsj+"。";
		 	}
			document.getElementById("blsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 	   	//---------输出3A申报结果-------------------------
 	   	msg=message;//打印校验
 		/**
		  *  校验信息
		  *  事件处理：关闭window
		  *  licb 2012-02-22
		  **/
        var message3aText = "";
	    var message3aArr = message.split("<br>");
	    for (var i = 0; i < message3aArr.length-1; i++){
	    	if(i > 0) message3aText = message3aText + "<br>";
	        message3aText = message3aText +(i+1)+ "、"+ message3aArr[i];
	    }
 	   
 		if(message!=""){
 			wShow(ds.getAt(0).get("deptName")+"申请国家"+applyLevel+"级婚姻登记机关<br>不符合标准项如下：<br>",message3aText);
 			return false;
 		}else{
 			alert("符合国家"+applyLevel+"级婚姻登记机关评定标准，可打印申报表！");
 		}
 	});		 	
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
	
	document.getElementById("wlyyDiv").style.display="none";
	document.getElementById("fourResDiv").style.display="none";
	document.getElementById("fourResDiv").style.display="none";
    message="";

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
	
	document.getElementById("wlyyDiv").style.display="";
	document.getElementById("fourResDiv").style.display="";
	document.getElementById("fourResDiv").style.display="";
	checkLevel();

}