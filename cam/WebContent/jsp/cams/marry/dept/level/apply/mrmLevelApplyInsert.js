var jgxz="";
var wsj="";
//复印机、传真机、扫描仪、电视机
var fyj="1";
var czj="2";
var smy="3";
var dsj="4";
var dn="9";
var dyj="10";
var sfsbxt="11";
var jhj="5";//排队叫号系统
var dzxsp="6";//电子滚动显示屏
var fwpjxt="7";//服务评价系统
var jksb="8";//监控系统
var happlyLevel="";

var hiscreatDate = "";

function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginName ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
	  	userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	  	organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
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
 		hiscreatDate = ds.getAt(0).get("createDate");
 		//机构性质
 		if(ds.getAt(0).get("types")=="01"){
 			$("xz1").style.display="";
 			$("xz2").style.display="none";
 			$("xz3").style.display="none";
 			jgxz="1";
 		}
 		if(ds.getAt(0).get("types")=="02"){
 			$("xz2").style.display="";
 			$("xz1").style.display="none";
 			$("xz3").style.display="none";
 			jgxz="2";
 		}
 		if(ds.getAt(0).get("types")=="03"){
 			$("xz3").style.display="";
 			$("xz2").style.display="none";
 			$("xz1").style.display="none";
 			jgxz="3";
 		}
 		if(ds.getAt(0).get("types")==""){
 			$("xz1").style.display="none";
 			$("xz2").style.display="none";
 			$("xz3").style.display="none";
 		}
 		
 		//辖区人口
 		ds.getAt(0).set("deptNumRy",ds.getAt(0).get("deptNumRy")/10000);
 		//时间默认当天
 		$("creatDate").value=myDate.toLocaleDateString();
 		//处理机构名称
 		//ds.getAt(0).set("deptName","山东省"+cityName+ds.getAt(0).get("deptName"));
 		ds.getAt(0).set("deptName",ds.getAt(0).get("deptName"));
 		
 		 //复印机
 		if(ds.getAt(0).get("fyj")<1){
 			$("fyj").style.display="none";
 			fyj="";
 		}
 		//传真机
 		if(ds.getAt(0).get("czj")<1){
 			$("czj").style.display="none";
 			czj="";
 		}
 		//扫描仪
 		if(ds.getAt(0).get("smy")<1){
 			$("smy").style.display="none";
 			smy="";
 		}
 		//电视机
 		if(ds.getAt(0).get("dsj")<1){
 			$("dsj").style.display="none";
 			dsj="";
 		}
 		//叫号机
 		if(ds.getAt(0).get("jhj")<1){
 			$("jhj").style.display="none";
 			jhj="";
 		}
 		//电子显示屏
 		if(ds.getAt(0).get("dzxsp")<1){
 			$("dzxsp").style.display="none";
 			dzxsp="";
 		}
 		//服务评价系统
 		if(ds.getAt(0).get("fwpjxt")<1){
 			$("fwpjxt").style.display="none";
 			fwpjxt="";
 		}
 		//监控设备
 		if(ds.getAt(0).get("jksb")<1){
 			$("jksb").style.display="none";
 			jksb="";
 		}
 		//无障碍通道
 		if(ds.getAt(0).get("wzatd")<1){//无
 			$("wzatd1").style.display="none";
 			$("wzatd2").style.display="";
 		}else{
 			$("wzatd1").style.display="";
 			$("wzatd2").style.display="none";
 		}
 		//卫生间位置
		$("station1").style.display="none";
		$("station2").style.display="none";
		$("station3").style.display="none";
		var wc=ds.getAt(0).get("wc");
 		if(wc && wc.indexOf("01")>-1){
 			$("station1").style.display="";
 			wsj+="1";
 		}
 		if(wc && wc.indexOf("02")>-1){
 			$("station2").style.display="";
 			wsj+="2";
 		}
 		if(wc && wc.indexOf("03")>-1){
 			$("station3").style.display="";
 			wsj+="3";
 		}
 		//辅导员信息
  		if(ds.getAt(0).get("zfgmNum")<1)
  		{
 			$("zfgmSpan").style.display="none";
 		}
 		if(ds.getAt(0).get("zyzNum")<1 && ds.getAt(0).get("gkzmNum")<1)
 		{
 			$("zyzSpan").style.display="none";
 		}
 		//其他情况
 		if(ds.getAt(0).get("qtqksc")!=""){
 			ds.getAt(0).set("qtqksc","其他情况："+ds.getAt(0).get("qtqksc"));
 		} 
		var applyDs=L5.DatasetMgr.lookup("applyDs");
		if(method=="UPDATE"){
		    applyDs.setParameter("APPLY_ID@=",applyId);
		 	applyDs.load();
		}else{
			applyDs.newRecord({"applyType":"1","applyTime":curDate});
			//加载电子档案
			mrmElectronicDataSet_load1();
		}
 	
	});
	
 	applyDs.on("load",function(){
 		var applyRecord=applyDs.getAt(0);
 		var recod=ds.getAt(0);
 		$("applyLevel").value=applyRecord.get("applyLevel");
 		recod.set("townOpinionId",applyRecord.get("townOpinionId"));
 		$("townOpinion").value=applyRecord.get("townOpinion");
 		recod.set("cityOpinionId",applyRecord.get("cityOpinionId"));
 		$("cityOpinion").value=applyRecord.get("cityOpinion");
 		recod.set("provinceOpinionId",applyRecord.get("provinceOpinionId"));
 		$("provinceOpinion").value=applyRecord.get("provinceOpinion");
 		recod.set("departmentOpinionId",applyRecord.get("departmentOpinionId"));
 		$("departmentOpinion").value=applyRecord.get("departmentOpinion");
		var townAuditTime=applyRecord.get("townAuditTime");
		if(townAuditTime && townAuditTime.length>10){
			$("townAuditTime").innerHTML=townAuditTime.substring(0,4)+"年 "+townAuditTime.substring(5,7)+"月 "+townAuditTime.substring(8,10)+"日";
		}
		var cityAuditTime=applyRecord.get("cityAuditTime");
		if(cityAuditTime && cityAuditTime.length>10){
			$("cityAuditTime").innerHTML=cityAuditTime.substring(0,4)+"年 "+cityAuditTime.substring(5,7)+"月 "+cityAuditTime.substring(8,10)+"日";
		}
		var provinceAuditTime=applyRecord.get("provinceAuditTime");
		if(provinceAuditTime && provinceAuditTime.length>10){
			$("provinceAuditTime").innerHTML=provinceAuditTime.substring(0,4)+"年 "+provinceAuditTime.substring(5,7)+"月 "
			+provinceAuditTime.substring(8,10)+"日";
		}
		var departmentAuditTime=applyRecord.get("departmentAuditTime");
		if(departmentAuditTime && departmentAuditTime.length>10){
			$("departmentAuditTime").innerHTML=departmentAuditTime.substring(0,4)+"年 "+departmentAuditTime.substring(5,7)+"月 "
			+departmentAuditTime.substring(8,10)+"日";
		}
		
		//加载电子档案
		mrmElectronicDataSet_load();
		happlyLevel=applyRecord.get("applyLevel");
		
 	});
 	
	
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	 	
	//过滤等级
	evaluLevelDataSet.filterBy(function(record, id){
		if(record.get('value') != '00' ){
			return record;
		}
	});
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("DEPT_CODE",deptId);
	queryDs.load();
	var basePersonDs = L5.DatasetMgr.lookup("basePersonDs");
	basePersonDs.setParameter("DEPT_ID",deptId);
	basePersonDs.setParameter("MRM_BASE_PERSON.NAME@not like","%婚姻%");
	basePersonDs.load();
	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",writeTable);
	compareDs.setParameter("APPLY_ID@=",applyId);
	compareDs.load();
	L5.QuickTips.init(); 
	
}

function getShowText(level){

}
function checkLevel(){

	
 	var applyLevel=$("applyLevel").value;//3A、4A、5A
 	//候登大厅、结婚登记区
 	var AllNum=$("AllNum").innerHTML;//年工作量
 	var divorceNum=$("divorceNum").innerHTML;//年离婚登记量
 	var marryNum=$("marryNum").innerHTML;//年结婚登记量
 	var attestNum=$("attestNum").innerHTML;//(无)出具证明量
 	var marryWindow=$("marryWindow").innerHTML;//结婚登记窗口
 	var marryArea=$("marryArea").innerHTML;//候登大厅、结婚登记使用面积和
 	var hdChair=$("hdChair").innerHTML;//候登座椅
 	var tbChair=$("tbChair").innerHTML;//填表座椅
 	
 	var lhArea=$("lhArea").innerHTML;//离婚登记区面积
 	var lhWindow=$("lhWindow").innerHTML;//离婚登记区窗口
 	
 	var jianShu=$("jianShu").innerHTML;//婚姻家庭辅导室间数
 	var fdsArea=$("fdsArea").innerHTML;//婚姻家庭辅导室使用面积
 	
 	var bzdtArea=$("bzdtArea").innerHTML;//颁证大厅使用面积
 	var qyglx=$("qyglx").innerHTML;//亲友观礼席
 	
 	var computer=$("computer").innerHTML;//电脑
 	var printer=$("printer").innerHTML;//打印机
 	var cardReader=$("cardReader").innerHTML;//身份识别系统
 	

 	
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
 	var djyNum=$("djyNum").innerHTML;//登记员总人数
 	var bzyNum=$("bzyNum").innerHTML;//颁证员员总人数
 	var xzbzNum=$("xzbzNum").innerHTML;//行政编制总人数
 	var cgglNum=$("cgglNum").innerHTML;//参公管理总人数
 	var qebkNum=$("qebkNum").innerHTML;//全额拨款总人数
 	var deptNumRy=$("deptNumRy").innerHTML;//辖区人口数
 	
 	var fdyNum=$("fdyNum").innerHTML;//辅导员人数
 //	var zfgmSpan=$("zfgmSpan").style.display=="none";//是否政府购买
 	var wlyyqysj=$("wlyyqysj").innerHTML;//网络预约系统启动时间
 	var wlyyl=$("wlyyl").innerHTML;//网络预约总量
 	var sndyyl=$("sndyyl").innerHTML;//上年度网络预约量
 	
 	
 	var djyXzbz="";
 	var djyCggl="";
 	var djyQebk="";
	var note3="";
 	
	var standardDs=L5.DatasetMgr.lookup("standardDs");
	//standardDs.removeAll();
	standardDs.setParameter("STANDARD_LEVEL@=",applyLevel);
	standardDs.load();
	standardDs.on("load",loadStandardDs);
}	
function loadStandardDs(standardDs){ 
	standardDs.un("load",loadStandardDs);		
 	var applyLevel=$("applyLevel").value;//3A、4A、5A
 	//候登大厅、结婚登记区
 	var AllNum=$("AllNum").innerHTML;//年工作量
 	var divorceNum=$("divorceNum").innerHTML;//年离婚登记量
 	var marryNum=$("marryNum").innerHTML;//年结婚登记量
 	var attestNum=$("attestNum").innerHTML;//(无)出具证明量
 	var marryWindow=$("marryWindow").innerHTML;//结婚登记窗口
 	var marryArea=$("marryArea").innerHTML;//候登大厅、结婚登记使用面积和
 	var hdChair=$("hdChair").innerHTML;//候登座椅
 	var tbChair=$("tbChair").innerHTML;//填表座椅
 	
 	var lhArea=$("lhArea").innerHTML;//离婚登记区面积
 	var lhWindow=$("lhWindow").innerHTML;//离婚登记区窗口
 	
 	var jianShu=$("jianShu").innerHTML;//婚姻家庭辅导室间数
 	var fdsArea=$("fdsArea").innerHTML;//婚姻家庭辅导室使用面积
 	
 	var bzdtArea=$("bzdtArea").innerHTML;//颁证大厅使用面积
 	var qyglx=$("qyglx").innerHTML;//亲友观礼席
 	
 	var computer=$("computer").innerHTML;//电脑
 	var printer=$("printer").innerHTML;//打印机
 	var cardReader=$("cardReader").innerHTML;//身份识别系统
 	

 	
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
 	var djyNum=$("djyNum").innerHTML;//登记员总人数
 	var bzyNum=$("bzyNum").innerHTML;//颁证员员总人数
 	var xzbzNum=$("xzbzNum").innerHTML;//行政编制总人数
 	var cgglNum=$("cgglNum").innerHTML;//参公管理总人数
 	var qebkNum=$("qebkNum").innerHTML;//全额拨款总人数
 	var deptNumRy=$("deptNumRy").innerHTML;//辖区人口数
 	
 	var fdyNum=$("fdyNum").innerHTML;//辅导员人数
 //	var zfgmSpan=$("zfgmSpan").style.display=="none";//是否政府购买
 	var wlyyqysj=$("wlyyqysj").innerHTML;//网络预约系统启动时间
 	var wlyyl=$("wlyyl").innerHTML;//网络预约总量
 	var sndyyl=$("sndyyl").innerHTML;//上年度网络预约量
 	
 	
 	var djyXzbz="";
 	var djyCggl="";
 	var djyQebk="";
	var note3="";
	 	var message="";
		for(var i=1;i<=standardDs.getCount();i++){	
		 	//机构性质
			if(i==1){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note").replace(";","，或");
		 		var n=jgxz;
		 		if(!eval(famula)){
				 	var div='<font color="green">'+"(注:机构性质为"+note+")；"+'</font>'+"目前情况："+$("xz"+n).innerHTML+"。";
		 			$("jgDiv").innerHTML=div;
		 			message+=div+"<br>";
	 			}
			} 
		 	//婚姻登记员编制
			if(i==3){
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
					 	var div='<font color="green">'+"(注:婚姻登记员为"+note+")；"+'</font>'+"目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			$("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
				if(djyCggl){
			 		var n=djyCggl;
			 		if(!eval(famula)){
					 	var div='<font color="green">'+"(注:婚姻登记员为"+note+")；"+'</font>'+"目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			$("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
				if(djyQebk){
			 		var n=djyQebk;
			 		if(!eval(famula)){
					 	var div='<font color="green">'+"(注:婚姻登记员为"+note+")；"+'</font>'+"目前情况：行政编制"+xzbzNum+"人，参照公务员法管理的事业编制"
					 	+cgglNum+"人，全额拨款事业编制"+qebkNum+"人。";
			 			$("djyBzDiv").innerHTML=div;
			 			message+=div+"<br>";
			 			continue;
		 			}
				}
			} 
			//婚姻登记员配置
			/*if(i==3){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
 				if(ds.getAt(0).get("foreign")=="0"){//办理内地居民婚姻登记的机关
 					//alert(i);
 					note3=note;
			 		if(deptNumRy>=con1 && deptNumRy<con2){
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：辖区户籍人口"+deptNumRy+"万人，婚姻登记员"+djyNum+"名。";
				 			$("djyDiva").innerHTML=div;
				 			message+=div+"<br>";
			 			}
			 		}
		 		}
			}*/
			if(i==4){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var con1=parseInt(record.get("con1"));
				var con2=parseInt(record.get("con2"));
 				if(ds.getAt(0).get("foreign")=="0"){//办理内地居民婚姻登记的机关
			 		if(deptNumRy>=con1 && deptNumRy<con2 && parseInt(organCode.substring(4,6))<20){//判断市辖区
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：辖区户籍人口"+deptNumRy+"万人，婚姻登记员"+djyNum+"名。";
				 			$("djyDiva").innerHTML=div;
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
 				if(ds.getAt(0).get("foreign")=="0"){//办理内地居民婚姻登记的机关
			 		if(deptNumRy>=con1 && deptNumRy<con2 && parseInt(organCode.substring(4,6))>=20){
				 		var n=djyNum;
				 		var r=deptNumRy;
				 		if(!eval(famula)){
						 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：辖区户籍人口"+deptNumRy+"万人，婚姻登记员"+djyNum+"名。";
				 			$("djyDiva").innerHTML=div;
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
 				if(ds.getAt(0).get("foreign")!="0"){//办理涉外、涉港澳台和华侨婚姻登记的登记机关	
			 		if(AllNum>=con1 && AllNum<con2){
				 		var n=djyNum;
				 		if(!eval(famula)){
						 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年工作量"+AllNum+"对（件），婚姻登记员"+djyNum+"名。";
				 			$("djyDivb").innerHTML=div;
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
					 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年结婚登记量"+marryNum+"对，婚姻颁证员"+bzyNum+"名。";
			 			$("bzyDiv").innerHTML=div;
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
				 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：婚姻家庭辅导员"+fdyNum+"名。";
		 			$("fdyDiv").innerHTML=div;
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
					 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年工作量"+AllNum+"对（件），使用面积"+marryArea+"㎡。";
			 			$("maAreaDiv").innerHTML=div;
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
					 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年工作量"+AllNum+"对（件），候登座椅"+hdChair+"座，填表座椅"+tbChair+"座。";
			 			$("hdtbchiarDiv").innerHTML=div;
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
					 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年结婚登记量"+marryNum+"对，出具证明量"+attestNum+"对，结婚登记窗口"+marryWindow+"个。" ;
			 			$("maWinDiv").innerHTML=div;
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
					 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：年离婚登记量"+divorceNum+"对，离婚登记区面积"+lhArea+"㎡，离婚登记窗口"+lhWindow+"个。";
			 			$("lhAreaWinDiv").innerHTML=div;
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
				 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：婚姻家庭辅导室"+jianShu+"间，使用面积"+fdsArea+"㎡。";
					$("fdsDiv").innerHTML=div;
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
				 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：颁证大厅使用面积"+bzdtArea+"㎡，亲友观礼席"+qyglx+"座。";
					$("bzdtDiv").innerHTML=div;
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
				 	var div='<font color="green">'+"(注:婚姻登记机关应配有"+notes+"每个至少一台（套）)"+"；"+'</font>'+"目前情况："+nums+"。";
					$("fourResDiv").innerHTML=div;
					message+=div+"<br>";
				}
			 	if(notesWin){
				 	var div='<font color="green">'+"(注:婚姻登记机关应配有"+notesWin+")；"+'</font>'+"目前情况："+numsWin+"。";
					$("threeResDiv").innerHTML=div;
					message+=div+"<br>";
				}
			}
			//网络预约
			if(i==27){
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
		 		var n=parseInt(wlyyl/sndyyl*100);
		 		if(!n){
		 			n=0;
		 		}
			  	if(!eval(famula)){	
				 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：网络预约登记量共计"+wlyyl+"对，上年度登记量"+sndyyl+"对，网络预约登记量占上年度登记量的"+n+"%。";
				 	if(!wlyyqysj || wlyyqysj>myDate){
				 		div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：没有启用网络预约系统。";
				 	}
					$("wlyyDiv").innerHTML=div;
					message+=div+"<br>";
		 		}
			}
	 		//历史数据补录
			if(i==28){
		 		var blsj=$("blsj").innerHTML;
				var record=standardDs.getAt(i-1);
				var famula=record.get("famula");
				var note=record.get("note");
				var n=blsj;
				
				if(hiscreatDate == ''){
					alert("请在基本信息菜单中填写对应的婚姻登记处的成立时间！");
					return false;
				}
				
				famula = "n<="+hiscreatDate.substring(0,4);
				note = "将本辖区"+hiscreatDate+"以来保存的所有婚姻登记档案录入婚姻登记信息系统";
				if(!n){
		 			n=9999;
		 		}else{
		 			n=n.substring(0,4);
		 		}
			  	if(!eval(famula)){	
				 	var div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：没有补录历史数据。";
				 	if(blsj){
				 		div='<font color="green">'+"(注:"+note+")；"+'</font>'+"目前情况：婚姻登记历史数据已补录至"+blsj+"。";
				 	}
					$("blsjDiv").innerHTML=div;
					message+=div+"<br>";
		 		}
 			}
		}
 		//卫生间
 		if(applyLevel=="01" && (wsj=="" || wsj.indexOf("2")<0 && wsj.indexOf("3")<0)){
 			var div;
 			if(wsj!=""){
			 	div='<font color="green">'+"(注:婚姻登记机关所在楼内设有男女卫生间，有明显指示牌)；"+'</font>'+"目前情况：卫生间设在";
			 	for(var i=1;i<=3;i++){
			 		if(wsj.indexOf(i)>-1){
				 		div+=$("station"+i).innerHTML;
			 		}
			 	}
			 	div+="。";
 			}else{
 				div='<font color="green">'+"(注:婚姻登记机关所在楼内设有男女卫生间，有明显指示牌)；"+'</font>'+"目前情况：没有卫生间。";
 			}		 	
			$("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="02" && (wsj=="" || wsj.indexOf("2")<0)){
 			var div;
 			if(wsj!=""){
			 	div='<font color="green">'+"(注:婚姻登记机关所在楼层设有男女卫生间，有明显指示牌)；"+'</font>'+"目前情况：卫生间设在";
			 	for(var i=1;i<=3;i++){
			 		if(wsj.indexOf(i)>-1){
				 		div+=$("station"+i).innerHTML;
			 		}
			 	}
			 	div+="。";
 			}else{			 	
 				div='<font color="green">'+"(注:婚姻登记机关所在楼层设有男女卫生间，有明显指示牌)；"+'</font>'+"目前情况：没有卫生间。";
 			}		 	
			$("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="03" && wsj==""){
 			var div='<font color="green">'+"(注:婚姻登记机关内设有男女卫生间，干净整洁，有明显指示牌)；"+'</font>'+"目前情况：没有卫生间。";
			$("wsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//无障碍通道
 		if(applyLevel=="02" && $("wzatd1").style.display=="none"){
		 	var div='<font color="green">'+"(注:婚姻登记机关设有无障碍通道或提供无障碍登记服务)；"+'</font>'+"目前情况："+$("wzatd2").innerHTML+"。";
			$("wzatdDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		if(applyLevel=="03" && $("wzatd1").style.display=="none"){
		 	var div='<font color="green">'+"(注:婚姻登记机关设有无障碍通道)；"+'</font>'+"目前情况："+$("wzatd2").innerHTML+"。";
			$("wzatdDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//在线登记
 		var zxsj=$("zxsj").innerHTML;
 		if(!zxsj || zxsj>myDate){
		 	var div='<font color="green">'+"(注:通过省级婚姻登记工作平台实现实时在线登记)；"+'</font>'+"目前情况：没有实现在线登记。";
			$("zxsjDiv").innerHTML=div;
			message+=div+"<br>";
 		}
 		//数据交换
 		var lwsj=$("lwsj").innerHTML;
 		if(applyLevel!="01" && (!lwsj || lwsj>myDate)){
		 	var div='<font color="green">'+"(注:婚姻登记数据通过部省两级婚姻登记数据交换实现全国联网)；"+'</font>'+"目前情况：没有实现部省两级婚姻登记数据交换共享。";
			$("lwsjDiv").innerHTML=div;
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
 			wShow(ds.getAt(0).get("deptName")+"申请"+getDicText(evaluLevelDataSet,_$("applyLevel"))+"婚姻登记机关<br>不符合标准项如下：<br>",message3aText,
 			myDate.toLocaleDateString());
 			return false;
 		}else{
 			alert("符合"+getDicText(evaluLevelDataSet,_$("applyLevel"))+"婚姻登记机关评定标准，可打印申报表！");
 			//var win=L5.getCmp('cueWin');
 			//win.show();
 			//win.hide();
 		}
}
function printWord(){
	//alert("尚未实现导出功能！");
	$("docpath").value = "jsp/cams/marry/reports/marry.fr3";
	$("deptId").value = deptId; 
	var url="../../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}

function wShow(title,results,date){
	//alert("尚未实现导出功能！");
	  var res = escape(encodeURIComponent(results));
	  var tit = escape(encodeURIComponent(title));
	var win=L5.getCmp('cueWin');
	win.show();
	$("cue_title").innerHTML='<br><font size="4" color="red">'+title+'</font>';
	$("cue_content").innerHTML='<font size="4" color="red">'+results+'</font>';
	$("cue_date").innerHTML='<br><font size="4" color="red">'+date+'</font>';
	
	//var url=L5.webPath+"/jsp/cams/marry/dept/level/applyResult.jsp?results="+results+"&title="+tit;
	
	//var width = 1024;
	//var height = 768;
    //window.open(url,window,"scrollbars:yes;status:no;width:"+width+"px;height:"+height+"px;resizable:no");
    //window.open (url, 'newwindow', 'height=768, width=1024, top=100, left=100, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no')
	//window.close();
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
		//$("deptId").value=list[0];
	 
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
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/marry/reports/mInsert.fr3');
}


function cleanDiv(){
	
	
	//var divs=document.getElementsByTagName()getElementByTag("div");
	//alert(divs.length);

}
function clickShowHref(){
	var records=basePersonDs.getAllRecords();
	var result="";
	for(var i=0;i<records.length;i++){
		var record=records[i];
		if(record.get("name")!="平阴县民政局婚姻登记处管理员"){
		   result+='<a id="download" target=_blank href=../../../person/mrm_baseperson_print.jsp?personId='+record.get("personId")+'>'+record.get("name")+'</a>';
		   result+=',';
		}
	}
	return result;
}

function catalogName(){
	return "婚姻登记员有关材料复印件";
}
/**
 *  校验按钮后弹出的window--打印
 *  事件处理：打印审查信息
 *  licb 2012-02-22
 **/
function save_win(){	
	if($("cue_content").innerHTML.length>2000){
		L5.Msg.alert("提示","不符合标准项过长，不能保存！");
		return false;		
	}
	var applyDs=L5.DatasetMgr.lookup("applyDs");
	var applyRecord=applyDs.getCurrent();
	setApplyRecord();
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	command.execute("insert");
	if (!command.error) {
		var applyIdReturn=command.getReturn("applyId");
		if(applyId=="null"){
			applyId=applyIdReturn;
			applyDs.set("applyId",applyIdReturn);
		}
		var url="../../../words/mrmCheckResult.jsp?applyId="+applyIdReturn
		+"&cueTitle="+encodeURIComponent(encodeURIComponent(
		ds.getAt(0).get("deptName")+"申请"+getDicText(evaluLevelDataSet,_$("applyLevel"))+"婚姻登记机关"))
		+"&cueDate="+encodeURIComponent(encodeURIComponent(myDate.toLocaleDateString()));
		window.open(url);
	}	
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
	$("jgDiv").innerHTML="";
	$("djyDiva").innerHTML="";
	$("djyDivb").innerHTML="";
	$("bzyDiv").innerHTML="";
	
	$("fdyDiv").innerHTML="";
	$("maWinDiv").innerHTML="";
	$("maAreaDiv").innerHTML="";
	$("hdtbchiarDiv").innerHTML="";
	$("lhAreaWinDiv").innerHTML="";
	$("fdsDiv").innerHTML="";
	$("bzdtDiv").innerHTML="";
	
	$("threeResDiv").innerHTML="";
	$("fourResDiv").innerHTML="";
	
	$("wlyyDiv").innerHTML="";
	$("fourResDiv").innerHTML="";
	$("fourResDiv").innerHTML="";
	

}

function cleanDiv(){
    msg="noCheck";
	cleanDiv1();
	$("jgDiv").style.display="none";
	$("djyDiva").style.display="none";
	$("djyDivb").style.display="none";
	$("bzyDiv").style.display="none";
	
	$("fdyDiv").style.display="none";
	$("maWinDiv").style.display="none";
	$("maAreaDiv").style.display="none";
	$("hdtbchiarDiv").style.display="none";
	$("lhAreaWinDiv").style.display="none";
	$("fdsDiv").style.display="none";
	$("bzdtDiv").style.display="none";
	
	$("threeResDiv").style.display="none";
	$("fourResDiv").style.display="none";
	
	$("wlyyDiv").style.display="none";
	$("fourResDiv").style.display="none";
	$("fourResDiv").style.display="none";
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("DEPT_CODE",deptId);
	queryDs.load();
	queryDs.on('load',function(){
		if(queryDs.getCurrent().get("skinValue")==_$("applyLevel")){
			L5.Msg.alert('提示',"该登记处已申报当前等级，不能重复申报");
			return false;
		}
		if(queryDs.getCurrent().get("skinValue")>_$("applyLevel")){
			L5.Msg.alert('提示',"您所选申报等级低于当前登记处已申报等级，请先提交取消申报");
			return false;
		}
		condition();
	});
    message="";
    
}

function showDiv(){
	if(!_$("applyLevel")){
		L5.Msg.alert("提示","请选择申报等级！");
		return false;
	}
	$("jgDiv").style.display="";
	$("djyDiva").style.display="";
	$("djyDivb").style.display="";
	$("bzyDiv").style.display="";
	
	$("fdyDiv").style.display="";
	$("maWinDiv").style.display="";
	$("maAreaDiv").style.display="";
	$("hdtbchiarDiv").style.display="";
	$("lhAreaWinDiv").style.display="";
	$("fdsDiv").style.display="";
	$("bzdtDiv").style.display="";
	
	$("threeResDiv").style.display="";
	$("fourResDiv").style.display="";
	
	$("wlyyDiv").style.display="";
	$("fourResDiv").style.display="";
	$("fourResDiv").style.display="";
	checkLevel();

}
//保存
function save(){
	//alert(document.getElementById('creatDate').value);
	if(msg=="noCheck"){
		L5.Msg.alert("提示","请先校验！");
		return false;
	}
	if(compareDs.getCount()<1){
		L5.Msg.alert("提示","请填写对照表");
		return false;
	}
	if($("cue_content") && $("cue_content").innerHTML.length>2000){
		L5.Msg.alert("提示","不符合标准项过长，不能保存！");
		return false;		
	}
	var  rs = compareDs.getAllRecords()
	for (var i=0;i<rs.length;i++) { 
		if (len(rs[i].get("actural"))>1000) { 
			alert(rs[i].get("chapter")+"输入的文字应小于500字");
			return false;
		} 
	} 
	var applyDs=L5.DatasetMgr.lookup("applyDs");
	var applyRecord=applyDs.getCurrent();
	setApplyRecord();
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	if(method=="INSERT"){
		command.execute("insert");
	}else{
		command.execute("insertu");
	}
	var b=savecompare();
	if (!command.error&&b) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
}
//提交
function submit(){
	if(msg=="noCheck"){
		L5.Msg.alert("提示","请先校验！");
		return false;
	}else if(msg!=""){
		L5.Msg.alert("提示","校验不通过，无法提交！");
		return false;
	}
	var applyQueryDataSet=L5.DatasetMgr.lookup("applyQueryDataSet");
    applyQueryDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyQueryDataSet.setParameter("CHECK_STATUS@IN","11,21,31,32,41,42,52");
	applyQueryDataSet.setParameter("APPLY_TYPE",'1');
 	applyQueryDataSet.load();
 	applyQueryDataSet.on("load",function(ds){
 		if(ds.getCount()>0){
			L5.Msg.alert("提示","存在审核状态为“在审”的申报，不能提交！");
			return false; 			
 		}
 		
		if(msg=="noCheck"){
			L5.Msg.alert("提示","请先校验！");
			return false;
		}
		if($("cue_content") && $("cue_content").innerHTML.length>2000){
			L5.Msg.alert("提示","不符合标准项过长，不能保存！");
			return false;		
		}
		var applyDs=L5.DatasetMgr.lookup("applyDs");
		var applyRecord=applyDs.getCurrent();
		setApplyRecord();
		var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
		command.setParameter("applyRecord",applyRecord);
		var b=savecompare();
		if(method=="INSERT"){
		    command.execute("insertAndSend");
		}else{
			command.execute("insertuAndSend");
		}
		
		if (!command.error&&b) {
			L5.Msg.alert('提示',"提交成功!",function(){
				back();
			});
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	});	
}
function setApplyRecord(){
	var record=ds.getCurrent();
	var applyDs=L5.DatasetMgr.lookup("applyDs");
	var applyRecord=applyDs.getCurrent();
	if(method=="INSERT"){
        //申请婚姻登记机关代码
	    applyRecord.set("applyId",appId);
	}
	// 申请婚姻登记机关
	applyRecord.set("organCode",deptId);
	// 申请婚姻登记机关名称
	applyRecord.set("organName",record.get("deptName"));
	// 申请婚姻登记机关级别
	applyRecord.set("organLevel",organCode.indexOf("000000"));
	// 申请等级
	applyRecord.set("applyLevel",_$("applyLevel"));
	// 对外人工或语音咨询电话
	applyRecord.set("phone",record.get("deptTel"));
	// 外网地址
	applyRecord.set("web",record.get("homeUrl"));
	// 机构性质
	applyRecord.set("organType",jgxz);
	
	//applyRecord.set("dealOrganType",organType);
	
	// 上年度工作经费
	applyRecord.set("found",record.get("lastYearBudget"));
	// 本年度工作经费
	applyRecord.set("yearFound",record.get("thisYearBudget"));
	// 辖区户籍人口数
	applyRecord.set("populateNum",record.get("deptNumRy"));
	// 婚姻登记员人数
	applyRecord.set("marriageRegNum",record.get("djyNum"));
	// 取得颁证资格人数
	applyRecord.set("hasQualifyNum",record.get("bzyNum"));
	// 婚姻登记员行政编制人数
	applyRecord.set("regOneNum",record.get("xzbzNum"));
	// 婚姻登记员参照公务员法管理事业编制人数
	applyRecord.set("regTwoNum",record.get("cgglNum"));
	// 婚姻登记员全额拨款事业编制人数
	applyRecord.set("regThreeNum",record.get("qebkNum"));
	// 上年度工作量
	applyRecord.set("workNum",record.get("AllNum"));
	// 结婚登记数量
	applyRecord.set("marriageNum",record.get("marryNum"));
	// 离婚登记数量
	applyRecord.set("divorceNum",record.get("divorceNum"));
	// 补发数量
	applyRecord.set("supplyNum",record.get("reissueNum"));
	// 出具证明数量
	applyRecord.set("certNum",record.get("attestNum"));
	// 辅导员人数
	applyRecord.set("tutorNum",record.get("fdyNum"));
	// 辅导员来源方式
	applyRecord.set("tutorSource",(record.get("zfgmNum")>=1?"1":"")+((record.get("zyzNum")>=1 || record.get("gkzmNum")>=1)?"2":""));
	// 辅导员来源方式说明
	applyRecord.set("tutorSourceNote",record.get("qtqksc").substring(record.get("qtqksc").indexOf("：")+1));		
	// 候登大厅面积
	applyRecord.set("waitArea",record.get("marryArea"));
	// 结婚登记窗口个数
	applyRecord.set("marriageWinNum",record.get("marryWindow"));
	// 候登座椅数量
	applyRecord.set("waitSeatNum",record.get("hdChair"));
	// 填表座椅数量
	applyRecord.set("writeSeatNum",record.get("tbChair"));
	// 离婚登记室面积
	applyRecord.set("divorceArea",record.get("lhArea"));
	// 离婚登记窗口数量
	applyRecord.set("divorceWinNum",record.get("lhWindow"));
	// 婚姻家庭辅导室间数
	applyRecord.set("tutorRoomNum",record.get("jianShu"));
	// 婚姻家庭辅导室面积
	applyRecord.set("tutorRoomArea",record.get("fdsArea"));
	// 颁证大厅面积
	applyRecord.set("presentArea",record.get("bzdtArea"));
	// 亲友观礼坐席个数
	applyRecord.set("friendSeatNum",record.get("qyglx"));		
	// 卫生间位置
	applyRecord.set("wcNum",record.get("wc"));
	// 有无无障碍通道
	applyRecord.set("hasAccessiblePathway",record.get("wzatd"));		
	// 电脑数量
	applyRecord.set("computeNum",record.get("computer"));
	// 打印机数量
	applyRecord.set("printerNum",record.get("printer"));
	// 身份识别系统数量
	applyRecord.set("identifyNum",record.get("cardReader"));
	// 配有设备
	applyRecord.set("equipment",getChoice(fyj)+getChoice(czj)+getChoice(smy)+getChoice(dsj)
	+getChoice(jhj)+getChoice(dzxsp)+getChoice(fwpjxt)+getChoice(jksb));
	// 实现在线登记时间
	applyRecord.set("onlineDate",getDateLen(record.get("zxsj"),7));
	// 实现数据交互时间
	applyRecord.set("dataChargeDate",getDateLen(record.get("lwsj"),7));
	// 历史数据补录至年份
	applyRecord.set("hisDataDate",record.get("blsj"));
	// 数据量
	applyRecord.set("dataNum",record.get("blNum"));
	// 网络预约启动时间
	applyRecord.set("bookingDate",getDateLen(record.get("wlyyqysj"),7));
	// 网络预约数量
	applyRecord.set("allBookingNum",record.get("wlyyl"));
	// 上年度预约数量
	applyRecord.set("bookingNum",record.get("sndyyl"));	
	
	applyRecord.set("townOrganName",organName);		
	applyRecord.set("cityOrganName",cityName+"民政局");		
	applyRecord.set("provinceOrganName","山东省民政厅");		
	applyRecord.set("departmentOrganName","中华人民共和国民政部");		
		
	// 系统审查结果
	if($("cue_content")){
		applyRecord.set("result",$("cue_content").innerHTML);		
	}
}
//返回
function back(){
 	history.go(-1);
}
function undo(){
	if(method=="INSERT"){
		var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
		command.setParameter("applyId",appId);
		command.execute("deleteElec");
	}
	history.go(-1);
}
function getDateLen(val,len){
	return val?(val.length>=len?val.substring(0,len):""):"";
}
function getChoice(val){
	return val?val:"";
}

//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}
//判定婚姻登记机关等级评定标准是否符合
function condition(){
	if(method=="UPDATE"){
		compareDs.setParameter("APPLY_ID@=",applyId);
		compareDs.load();
		compareDs.on("load",updateRecord);
		
	}else{
		var applyLevel=$("applyLevel").value;
		var conditionDs=L5.DatasetMgr.lookup("conditionDs");
		//standardDs.removeAll();
		conditionDs.setParameter("STANDARD_LEVEL@=",applyLevel);
		conditionDs.load();
		conditionDs.on("load",removeRecord);
	}
	
 	
}
function updateRecord(){
	var applyLevel=$("applyLevel").value;
	var conditionDs=L5.DatasetMgr.lookup("conditionDs");
	//standardDs.removeAll();
	conditionDs.setParameter("STANDARD_LEVEL@=",applyLevel);
	conditionDs.load();
	conditionDs.on("load",function(){
		var conditionDs=L5.DatasetMgr.lookup("conditionDs");
		var AllNum=parseInt($("AllNum").innerHTML);//年工作量
		var record=ds.getCurrent();
	 	var deptNumRy=parseInt($("deptNumRy").innerHTML);//辖区户籍人口
	 	var marryNum=parseInt(record.get("marryNum"));//年结婚登记量
	 	var attestNum=parseInt(record.get("attestNum"));//(无)出具证明量
	 	var divorceNum=parseInt(record.get("divorceNum"));//离婚
	 	var ars = new Array();
	 	var count=0;
		for(var i=0;i<conditionDs.getCount();i++){	
			
			if(conditionDs.getAt(i).get("type")=="4.1.3.2" && parseInt(organCode.substring(4,6))>=20
					&&conditionDs.getAt(i).get("seq")!="5"){
				continue;
			}else if(conditionDs.getAt(i).get("type")=="4.1.3.2" && parseInt(organCode.substring(4,6))<20//判断市辖区
					&&conditionDs.getAt(i).get("seq")!="4"){
				continue;
			}else if(conditionDs.getAt(i).get("type")=="4.1.3.3"  &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum &&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
				continue;
			}else  if(conditionDs.getAt(i).get("type")=="4.1.4.2" &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=marryNum&&parseInt(conditionDs.getAt(i).get("con2"))>marryNum)){
				continue;
			}else if(conditionDs.getAt(i).get("type")=="4.2.1.5" &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum&&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
				continue;
			}else  if(conditionDs.getAt(i).get("type")=="4.2.2.4" &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum&&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
				continue;
			}else  if(conditionDs.getAt(i).get("type")=="4.2.3.4" &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=marryNum+attestNum &&parseInt(conditionDs.getAt(i).get("con2"))>marryNum+attestNum)){
				continue;
			}else  if(conditionDs.getAt(i).get("type")=="4.2.4.2" &&
					!(parseInt(conditionDs.getAt(i).get("con1"))<=divorceNum&&parseInt(conditionDs.getAt(i).get("con2"))>divorceNum)){
				continue;
			}else{
				compareDs.getAt(count).set("chapter",conditionDs.getAt(i).get("type"));
				compareDs.getAt(count).set("require",conditionDs.getAt(i).get("note"));
				count++;
				//compareDs.add(conditionDs.getAt(i));
			}
			
		}
	});
		
	//writeTable();
}
function removeRecord(){
	var conditionDs=L5.DatasetMgr.lookup("conditionDs");
	var AllNum=parseInt($("AllNum").innerHTML);//年工作量
	var record=ds.getCurrent();
 	var deptNumRy=parseInt($("deptNumRy").innerHTML);//辖区户籍人口
 	var marryNum=parseInt(record.get("marryNum"));//年结婚登记量
 	var attestNum=parseInt(record.get("attestNum"));//(无)出具证明量
 	var divorceNum=parseInt(record.get("divorceNum"));//离婚
 	var ars = new Array();
 	var count=1;
 	compareDs.removeAll();
	for(var i=0;i<conditionDs.getCount();i++){	
		
		if(conditionDs.getAt(i).get("type")=="4.1.3.2" && parseInt(organCode.substring(4,6))>=20
				&&conditionDs.getAt(i).get("seq")!="5"){
			continue;
		}else if(conditionDs.getAt(i).get("type")=="4.1.3.2" && parseInt(organCode.substring(4,6))<20//判断市辖区
				&&conditionDs.getAt(i).get("seq")!="4"){
			continue;
		}else if(conditionDs.getAt(i).get("type")=="4.1.3.3"  &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum &&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
			continue;
		}else  if(conditionDs.getAt(i).get("type")=="4.1.4.2" &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=marryNum&&parseInt(conditionDs.getAt(i).get("con2"))>marryNum)){
			continue;
		}else if(conditionDs.getAt(i).get("type")=="4.2.1.5" &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum&&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
			continue;
		}else  if(conditionDs.getAt(i).get("type")=="4.2.2.4" &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=AllNum&&parseInt(conditionDs.getAt(i).get("con2"))>AllNum)){
			continue;
		}else  if(conditionDs.getAt(i).get("type")=="4.2.3.4" &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=marryNum+attestNum &&parseInt(conditionDs.getAt(i).get("con2"))>marryNum+attestNum)){
			continue;
		}else  if(conditionDs.getAt(i).get("type")=="4.2.4.2" &&
				!(parseInt(conditionDs.getAt(i).get("con1"))<=divorceNum&&parseInt(conditionDs.getAt(i).get("con2"))>divorceNum)){
			continue;
		}else{
			
			compareDs.newRecord({"applyId":appId,"chapter":conditionDs.getAt(i).get("type"),
				"seq":charLeftAll("0",count,2),"compareId":"",
				"require":conditionDs.getAt(i).get("note"),"actural":""});
			count++;
			//compareDs.add(conditionDs.getAt(i));
		}
		
	}
	//writeTable();
}
function writeTable(){
	var t=$("dzb");
	var len = t.rows.length; 
    for(var i = 0;i < len;i++){
    	t.deleteRow(0);

    }

	var r = t.insertRow();
	 var t1=r.insertCell();
	 if(compareDs.getCount()<1){
		 t1.innerHTML= "请选择申报等级!";
		 t1.align="center";
		 return;
	 }
	 t1.innerHTML= "序号";
	 t1.align="center";
	 var t2=r.insertCell();
	 t2.innerHTML= "章节号";
	 t2.align="center";
	 var t3=r.insertCell();
	 t3.innerHTML= $("applyLevel").options[$("applyLevel").selectedIndex].text+"标准要求";
	 t3.align="center";
	 t3.width="120";
	 var t4=r.insertCell();
	 t4.innerHTML= "实际完成情况";
	 t4.align="center";
	 t4.width="360";
	for(var i=1;i<=compareDs.getCount();i++){	
		var r = t.insertRow();
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("seq");
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("chapter");
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("require");
		 r.insertCell().innerHTML= '<textarea align="left" rows="3"cols="40" style="font-size:17px;width:100%;overflow:hidden;border:0" onblur="addActoral(this)">'+
		 	compareDs.getAt(i-1).get("actural")+'</textarea>';
	}
}
function addActoral(o){
	var compareDs=L5.DatasetMgr.lookup("compareDs");
	var a =o.parentNode.previousSibling.previousSibling.previousSibling.innerHTML;
	compareDs.getAt(compareDs.find("seq",a,0)).set("actural",o.value);
	if(len(o.value)>1000){
		alert("输入的文字应小于500字");
	}
}
function len(s) { 
	var l = 0; 
	var a = s.split(""); 
	for (var i=0;i<a.length;i++) { 
		if (a[i].charCodeAt(0)<299) { 
			l++; 
		} else { 
			l+=2; 
		} 
	} 
	return l; 
}
function savecompare(){
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmOrganStandardCompareCommand");
	command.setParameter("records",compareDs.getAllRecords());
	
	if(method=="INSERT"){
	    command.execute("batchInsert");
	}else{
		command.execute("batchUpdate");
	}
	if (!command.error) {
		return true;
	}else{
		return false;
	}
}
function charLeftAll(char,s,num){
	var ss=s+"";
	var v="";
	for(var i=0;i<num-ss.length;i++){
		v+=char;
	}
	v+=ss;
	return v;
	
}
function wordcontorl(){ 
	var WordApp=new ActiveXObject("Word.Application"); 
	var wdCharacter=1 
	var wdOrientLandscape = 1 
	WordApp.Application.Visible=true; //执行完成之后是否弹出已经生成的word 
	var myDoc=WordApp.Documents.Add();//创建新的空文档 
	//WordApp.ActiveDocument.PageSetup.Orientation = wdOrientLandscape;//页面方向设置为横向 
	WordApp.Selection.ParagraphFormat.Alignment=1; //1居中对齐,0为居右 
	//WordApp. Selection.Font.Bold=true; 
	WordApp.Selection.Font.Size=20; 
	WordApp.Selection.TypeText("婚姻登记机关基本情况和等级标准要求对照表"); 
	WordApp.Selection.MoveRight(wdCharacter);　　　　//光标右移字符 
	WordApp.Selection.TypeParagraph();　　　　　　　　　//插入段落 
	WordApp.Selection.Font.Size=12; 
	//WordApp. Selection.TypeText("-----朱漪编写"); //分行插入日期 
	WordApp.Selection.TypeParagraph();　　　　　　　　　//插入段落 
	var myTable=myDoc.Tables.Add (WordApp.Selection.Range,compareDs.getCount()+1,4); //8行7列的表格 
	
	myTable.Columns.Item(1).SetWidth(30, '');
	myTable.Columns.Item(2).SetWidth(50, '');
	myTable.Columns.Item(3).SetWidth(260, '');
	myTable.Columns.Item(4).SetWidth(100, '');


	
	
	myTable.Style="网格型" 
	var aa = "孟佳标题"; 
	var TableRange; //以下为给表格中的单元格赋值 
	
	with (myTable.Cell(1,1).Range) { 
		font.Size = 12; 
		InsertAfter("序号"); 
	} 
	with (myTable.Cell(1,2).Range) { 
		font.Size = 12; 
		InsertAfter("章节号"); 
	} 
	with (myTable.Cell(1,3).Range) { 
		font.Size = 12; 
		InsertAfter( $("applyLevel").options[$("applyLevel").selectedIndex].text+"标准要求"); 
	} 
	with (myTable.Cell(1,4).Range) { 
		font.Size = 12; 
		InsertAfter("实际完成情况"); 
	}
	 
	

	
	for (i =0;i<compareDs.getCount() ;i++) { 
		
			
			with (myTable.Cell(i+2,1).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("seq")); 
				ParagraphFormat.Alignment =1;  //设置对齐方式 水平对齐
			} 
			with (myTable.Cell(i+2,2).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("chapter")); 
			} 
			with (myTable.Cell(i+2,3).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("require")); 
			} 
			with (myTable.Cell(i+2,4).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("actural")); 
			}
	} 
	row_count = 0; 
	col_count = 0;
	//myDoc.Protect(1); 
} 