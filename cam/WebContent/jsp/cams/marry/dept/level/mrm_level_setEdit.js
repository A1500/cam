var jgxzCount=0;
var hydjyCount=0;
var hjbjQyCount=0;
var sspbCount=0;
function init(){
	$("standardLevel").innerHTML=evaluLevel+"婚姻登记机关评定标准";
	ds.setParameter("STANDARD_LEVEL@=",standardLevel);
	ds.load();
	ds.on("load",function(ds){
		for(var i=1;i<=ds.getCount();i++){
			//机构性质
			if(i==1){
				jgxzCount=showChk(i,"jgxz");
			}
						
			//婚姻登记员
			if(i==3){
				hydjyCount=showChk(i,"hydjy");
			}
			//婚姻登记员配置
			/*if(i==3){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hydjyPzRk").length;j++){
					document.getElementsByName("hydjyPzRk")[j].value=record.get("con2");
				}
				$("hydjyPzSta").value=famula.substring(famula.indexOf("=")+1);
			}*/
			if(i==4){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hydjyPzAdd1").value=famula.substring(famula.indexOf("/")+1,famula.indexOf("+")-1);
				
				for(var j=0;j<document.getElementsByName("hydjyPzRk").length;j++){
					document.getElementsByName("hydjyPzRk")[j].value=famula.substring(famula.indexOf("-")+1,famula.indexOf(")"));
				}
				$("hydjyPzSta").value=famula.substring(famula.indexOf(">=")+2,famula.indexOf("&"));
			}
			if(i==5){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hydjyPzAdd2").value=famula.substring(famula.indexOf("/")+1,famula.indexOf("+")-1);
			}
			//婚姻登记员涉外
			if(i==6){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hydjySwGzlSta").length;j++){
					document.getElementsByName("hydjySwGzlSta")[j].value=record.get("con2");
				}
				$("hydjySw1").value=famula.substring(famula.indexOf("=")+1);
			}			
			if(i==7){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hydjySwGzlEnd").length;j++){
					document.getElementsByName("hydjySwGzlEnd")[j].value=record.get("con2");
				}
				$("hydjySw2").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==8){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hydjySw3").value=famula.substring(famula.indexOf("=")+1);
			}
			//婚姻颁证员			
			if(i==9){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hybzyDjl").length;j++){
					document.getElementsByName("hybzyDjl")[j].value=record.get("con2");
				}
				$("hybzy").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==10){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hybzyDjlAdd").value=famula.substring(famula.indexOf("/")+1,famula.indexOf("+")-1);
			}
			//婚姻家庭辅导员
			if(i==11){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hyjtfdy").length;j++){
					document.getElementsByName("hyjtfdy")[j].value=famula.substring(famula.indexOf("=")+1);
				}
			}
			
			//环境布局区域
			if(i==12){
				hjbjQyCount=showChk(i,"hjbjQy");
				var record=ds.getAt(i-1);
				for(var j=0;j<document.getElementsByName("hjbjQyHb").length;j++){
					document.getElementsByName("hjbjQyHb")[j].value=record.get("con3");
				}
			}
			//环境布局面积
			if(i==13){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hjbjMjGzl").length;j++){
					document.getElementsByName("hjbjMjGzl")[j].value=record.get("con2");
				}
				$("hjbjMj1").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==14){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hjbjMj2").value=famula.substring(famula.indexOf("=")+1);
			}
			//候登大厅座椅
			if(i==15){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hddtZySta").length;j++){
					document.getElementsByName("hddtZySta")[j].value=record.get("con2");
				}
				$("hddtZyHd1").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("hddtZyTb1").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			if(i==16){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("hddtZyEnd").length;j++){
					document.getElementsByName("hddtZyEnd")[j].value=record.get("con2");
				}
				$("hddtZyHd2").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("hddtZyTb2").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			if(i==17){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hddtZyHd3").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("hddtZyTb3").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			//结婚登记窗口
			if(i==18){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("jhdjCkSta").length;j++){
					document.getElementsByName("jhdjCkSta")[j].value=record.get("con2");
				}
				$("jhdjCk1").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==19){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("jhdjCkEnd").length;j++){
					document.getElementsByName("jhdjCkEnd")[j].value=record.get("con2");
				}
				$("jhdjCk2").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==20){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("jhdjCk3").value=famula.substring(famula.indexOf("=")+1);
			}
			//离婚登记窗口
			if(i==21){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("lhdjCkSta").length;j++){
					document.getElementsByName("lhdjCkSta")[j].value=record.get("con2");
				}
				$("lhdjMj1").value=famula.substring(famula.indexOf("=")+1);
			}
			if(i==22){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				for(var j=0;j<document.getElementsByName("lhdjCkEnd").length;j++){
					document.getElementsByName("lhdjCkEnd")[j].value=record.get("con2");
				}
				$("lhdjMj2").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("lhdjCk2").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			if(i==23){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("lhdjMj3").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("lhdjCk3").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			//婚姻家庭辅导室
			if(i==24){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("hyjtfdsMj").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("hyjtfds").value=famula.substring(famula.lastIndexOf("=")+1);			
			}
			//颁证大厅
			if(i==25){
				var record=ds.getAt(i-1);
				var famula=record.get("famula");
				$("bzdtMj").value=famula.substring(famula.indexOf("=")+1,famula.indexOf("&"));
				$("bzdtZw").value=famula.substring(famula.lastIndexOf("=")+1);
			}
			//设施配备
			if(i==26){
				sspbCount=showChk(i,"sspb");
				var record=ds.getAt(i-1);				
				if(document.getElementsByName("sspbGzl")[0]){
					for(var j=0;j<document.getElementsByName("sspbGzl").length;j++){
						document.getElementsByName("sspbGzl")[j].value=record.get("con1");
					}
				}
			}
			//信息化建设网络预约
			if(i==27){
				var record=ds.getAt(i-1);	
				var famula=record.get("famula");			
				$("wlyy").value=famula.substring(famula.indexOf("=")+1);
			}
			//信息化建设历史数据
			if(i==28){
				var record=ds.getAt(i-1);	
				var famula=record.get("famula");			
				$("lssj").value=famula.substring(famula.indexOf("=")+1);
			}
		}
	});
	
	//特邀颁证
	if(standardLevel=="01"){
		$("hywhTybz").innerHTML="";
		$("hywhJtfd").innerHTML="";
		$("hywhGzbs").innerHTML=level+".3.4.3 ";
		$("hywhXch").innerHTML=level+".3.4.4 ";
		$("hywhJbxb").innerHTML=level+".3.4.5 ";
		
	}else if(standardLevel=="02"){
		$("hywhTybz").innerHTML="建立市（区、县）长或其他特邀颁证师颁证制度，特邀颁证师名单及颁证日期对外公开。<br/>";
		$("hywhJtfd").innerHTML=level+".3.4.3 ";
		$("hywhGzbs").innerHTML=level+".3.4.4 ";
		$("hywhXch").innerHTML=level+".3.4.5 ";
		$("hywhJbxb").innerHTML=level+".3.4.6 ";
	}else{
		$("hywhTybz").innerHTML="建立市（区、县）长或其他特邀颁证师颁证制度，特邀颁证师名单及颁证日期对外公开。<br/>"
		+level+".3.4.3 免费向结婚当事人发放由市（区、县）长或其他特邀颁证师签名的新婚贺信、贺卡。<br/>";
		$("hywhJtfd").innerHTML=level+".3.4.4 ";
		$("hywhGzbs").innerHTML=level+".3.4.5 ";
		$("hywhXch").innerHTML=level+".3.4.6 ";
		$("hywhJbxb").innerHTML=level+".3.4.7 ";
	}
}
function save(){
	//机构性质
	if(jgxzCount<1){		
		L5.Msg.alert("提示","请填写“"+level+".1.1 机构性质”信息！");
		return false;
	}
	getChkValue(ds.getAt(0),"jgxz",3);
	
	//婚姻登记员
	if(hydjyCount<1){		
		L5.Msg.alert("提示","请填写“"+level+".1.3.1 姻登记员应为专职人员，其编制性质应符合以下要求之一”信息！");
		return false;
	}
	getChkValue(ds.getAt(2),"hydjy",3);
	//婚姻登记员配置
	var hydjyPzRk=document.getElementsByName("hydjyPzRk")[0].value;
	var hydjyPzSta=_$("hydjyPzSta");
	var hydjyPzAdd1=_$("hydjyPzAdd1");
	var hydjyPzAdd2=_$("hydjyPzAdd2");
	if(!hydjyPzRk || !hydjyPzSta || !hydjyPzAdd1 || !hydjyPzAdd2){		
		L5.Msg.alert("提示","请填写“"+level+".1.3.2 办理内地居民婚姻登记的登记机关，人员配置应符合以下要求”信息！");
		return false;
	}
	//var hydjyPz12Record=ds.getAt(2);
	var hydjyPz1Record=ds.getAt(3);
	var hydjyPz2Record=ds.getAt(4);
	/*hydjyPz12Record.set("con2",hydjyPzRk);
	hydjyPz12Record.set("famula","n>="+hydjyPzSta);
	hydjyPz12Record.set("note","辖区户籍人口"+hydjyPzRk+"万以下的，至少配备"+hydjyPzSta+"名婚姻登记员");*/
	//hydjyPz1Record.set("con1",hydjyPzRk);
	hydjyPz1Record.set("famula","n>="+hydjyPzSta+"&&n>=Math.floor((r-"+hydjyPzRk+")/"+hydjyPzAdd1+")+"+hydjyPzSta);
	hydjyPz1Record.set("note","辖区户籍人口"+hydjyPzRk+"万以下的，至少配备"+hydjyPzSta+"名婚姻登记员;辖区户籍人口"+hydjyPzRk+"万以上的市辖区，每增加"+hydjyPzAdd1+"万户籍人口增配1名婚姻登记员");
	//hydjyPz2Record.set("con1",hydjyPzRk);
	hydjyPz2Record.set("famula","n>="+hydjyPzSta+"&&n>=Math.floor((r-"+hydjyPzRk+")/"+hydjyPzAdd2+")+"+hydjyPzSta);
	hydjyPz2Record.set("note","辖区户籍人口"+hydjyPzRk+"万以下的，至少配备"+hydjyPzSta+"名婚姻登记员;辖区户籍人口"+hydjyPzRk+"万以上的县、县级市，每增加"+hydjyPzAdd2+"万户籍人口增配1名婚姻登记员");
	//婚姻登记员涉外
	var hydjySwGzlSta=document.getElementsByName("hydjySwGzlSta")[0].value;
	var hydjySwGzlEnd=document.getElementsByName("hydjySwGzlEnd")[0].value;
	var hydjySw1=_$("hydjySw1");
	var hydjySw2=_$("hydjySw2");
	var hydjySw3=_$("hydjySw3");
	if(!hydjySwGzlSta || !hydjySwGzlEnd || !hydjySw1 || !hydjySw2 || !hydjySw3){		
		L5.Msg.alert("提示","请填写“"+level+".1.3.3 办理涉外、涉港澳台和华侨婚姻登记的登记机关，人员配置应符合以下要求”信息！");
		return false;
	}
	var hydjySw1Record=ds.getAt(5);
	var hydjySw2Record=ds.getAt(6);
	var hydjySw3Record=ds.getAt(7);
	hydjySw1Record.set("con2",hydjySwGzlSta);
	hydjySw1Record.set("famula","n>="+hydjySw1);
	hydjySw1Record.set("note","年工作量"+hydjySwGzlSta+"对（件）以下的，至少配"+hydjySw1+"名婚姻登记员");
	hydjySw2Record.set("con1",hydjySwGzlSta);
	hydjySw2Record.set("con2",hydjySwGzlEnd);
	hydjySw2Record.set("famula","n>="+hydjySw2);
	hydjySw2Record.set("note","年工作量"+hydjySwGzlSta+"-"+hydjySwGzlEnd+"对（件）的，至少配"+hydjySw2+"名婚姻登记员");
	hydjySw3Record.set("con1",hydjySwGzlEnd);
	hydjySw3Record.set("famula","n>="+hydjySw3);
	hydjySw3Record.set("note","年工作量"+hydjySwGzlEnd+"对（件）以上的，至少配"+hydjySw3+"名婚姻登记员");
	//婚姻颁证员	
	var hybzyDjl=document.getElementsByName("hybzyDjl")[0].value;
	var hybzy=_$("hybzy");
	var hybzyDjlAdd=_$("hybzyDjlAdd");
	if(!hybzyDjl || !hybzy || !hybzyDjlAdd){		
		L5.Msg.alert("提示","请填写“"+level+".1.4.2 婚姻颁证员配置应符合以下要求”信息！");
		return false;
	}
	var hybzy1Record=ds.getAt(8);
	var hybzy2Record=ds.getAt(9);
	hybzy1Record.set("con2",hybzyDjl);
	hybzy1Record.set("famula","n>="+hybzy);
	hybzy1Record.set("note","年结婚登记量"+hybzyDjl+"对以下的，至少配"+hybzy+"名婚姻颁证员");
	hybzy2Record.set("con1",hybzyDjl);
	hybzy2Record.set("famula","n>=Math.floor((r-"+hybzyDjl+")/"+hybzyDjlAdd+")+"+hybzy);
	hybzy2Record.set("note","年结婚登记量"+hybzyDjl+"对以上的，每增加"+hybzyDjlAdd+"对增配1名婚姻颁证员");
	//婚姻家庭辅导员
	var hyjtfdy=document.getElementsByName("hyjtfdy")[0].value;
	if(!hyjtfdy){		
		L5.Msg.alert("提示","请填写“"+level+".1.5 婚姻家庭辅导员”信息！");
		return false;
	}
	var hyjtfdyRecord=ds.getAt(10);
	hyjtfdyRecord.set("famula","n>="+hyjtfdy);
	hyjtfdyRecord.set("note","婚姻登记机关配有"+hyjtfdy+"名或"+hyjtfdy+"名以上通过政府购买服务等方式聘用或通过公开招募志愿者方式招募的婚姻家庭辅导员");
	//环境布局区域
	if(hjbjQyCount<1){		
		L5.Msg.alert("提示","请填写“"+level+".2.1.4 婚姻登记机关场所应分为以下区域”信息！");
		return false;
	}
	getChkValue(ds.getAt(11),"hjbjQy",7);
	var hjbjQyHb=document.getElementsByName("hjbjQyHb")[0].value;
	if(!hjbjQyHb){		
		L5.Msg.alert("提示","请填写“"+level+".2.1.4 婚姻登记机关场所应分为以下区域”信息！");
		return false;
	}
	var hjbjQyRecord=ds.getAt(11);
	hjbjQyRecord.set("con3",hjbjQyHb);
	//环境布局面积
	var hjbjMjGzl=document.getElementsByName("hjbjMjGzl")[0].value;
	var hjbjMj1=_$("hjbjMj1");
	var hjbjMj2=_$("hjbjMj2");
	if(!hjbjMjGzl || !hjbjMj1 || !hjbjMj2){		
		L5.Msg.alert("提示","请填写“"+level+".2.1.5 候登大厅、结婚登记区面积要求”信息！");
		return false;
	}
	var hjbjMj1Record=ds.getAt(12);
	var hjbjMj2Record=ds.getAt(13);
	hjbjMj1Record.set("con2",hjbjMjGzl);
	hjbjMj1Record.set("famula","n>="+hjbjMj1);
	hjbjMj1Record.set("note","年工作量"+hjbjMjGzl+"对（件）以下的，使用面积不低于"+hjbjMj1+"㎡");
	hjbjMj2Record.set("con1",hjbjMjGzl);
	hjbjMj2Record.set("famula","n>="+hjbjMj2);
	hjbjMj2Record.set("note","年工作量"+hjbjMjGzl+"对（件）以上的，使用面积不低于"+hjbjMj2+"㎡");
	//候登大厅座椅
	var hddtZySta=document.getElementsByName("hddtZySta")[0].value;
	var hddtZyEnd=document.getElementsByName("hddtZyEnd")[0].value;
	var hddtZyHd1=_$("hddtZyHd1");
	var hddtZyHd2=_$("hddtZyHd2");
	var hddtZyHd3=_$("hddtZyHd3");
	var hddtZyTb1=_$("hddtZyTb1");
	var hddtZyTb2=_$("hddtZyTb2");
	var hddtZyTb3=_$("hddtZyTb3");
	if(!hddtZySta || !hddtZyEnd || !hddtZyHd1 || !hddtZyHd2 || !hddtZyHd3 || !hddtZyTb1 || !hddtZyTb2 || !hddtZyTb3){		
		L5.Msg.alert("提示","请填写“"+level+".2.2.4 候登大厅座椅配备要求”信息！");
		return false;
	}
	var hddtZy1Record=ds.getAt(14);
	var hddtZy2Record=ds.getAt(15);
	var hddtZy3Record=ds.getAt(16);
	hddtZy1Record.set("con2",hddtZySta);
	hddtZy1Record.set("famula","n>="+hddtZyHd1+"&&r>="+hddtZyTb1);
	hddtZy1Record.set("note","年工作量"+hddtZySta+"对（件）以下的，候等座椅不少于"+hddtZyHd1+"座，填表座椅不少于"+hddtZyTb1+"座");
	hddtZy2Record.set("con1",hddtZySta);
	hddtZy2Record.set("con2",hddtZyEnd);
	hddtZy2Record.set("famula","n>="+hddtZyHd2+"&&r>="+hddtZyTb2);
	hddtZy2Record.set("note","年工作量"+hddtZySta+"—"+hddtZyEnd+"对（件）的，候等座椅不少于"+hddtZyHd2+"座，填表座椅不少于"+hddtZyTb2+"座");
	hddtZy3Record.set("con1",hddtZyEnd);
	hddtZy3Record.set("famula","n>="+hddtZyHd3+"&&r>="+hddtZyTb3);
	hddtZy3Record.set("note","年工作量"+hddtZyEnd+"对（件）以上的，候等座椅不少于"+hddtZyHd3+"座，填表座椅不少于"+hddtZyTb3+"座");
	//结婚登记窗口
	var jhdjCkSta=document.getElementsByName("jhdjCkSta")[0].value;
	var jhdjCkEnd=document.getElementsByName("jhdjCkEnd")[0].value;
	var jhdjCk1=_$("jhdjCk1");
	var jhdjCk2=_$("jhdjCk2");
	var jhdjCk3=_$("jhdjCk3");
	if(!jhdjCkSta || !jhdjCkEnd || !jhdjCk1 || !jhdjCk2 || !jhdjCk3){		
		L5.Msg.alert("提示","请填写“"+level+".2.3.4 结婚登记窗口数量要求”信息！");
		return false;
	}
	var jhdjCk1Record=ds.getAt(17);
	var jhdjCk2Record=ds.getAt(18);
	var jhdjCk3Record=ds.getAt(19);
	jhdjCk1Record.set("con2",jhdjCkSta);
	jhdjCk1Record.set("famula","n>="+jhdjCk1);
	jhdjCk1Record.set("note","年结婚登记、出具证明量"+jhdjCkSta+"对（件）以下的，不少于"+jhdjCk1+"个结婚登记窗口");
	jhdjCk2Record.set("con1",jhdjCkSta);
	jhdjCk2Record.set("con2",jhdjCkEnd);
	jhdjCk2Record.set("famula","n>="+jhdjCk2);
	jhdjCk2Record.set("note","年结婚登记、出具证明量"+jhdjCkSta+"—"+jhdjCkEnd+"对（件）的，不少于"+jhdjCk2+"个结婚登记窗口");
	jhdjCk3Record.set("con1",jhdjCkEnd);
	jhdjCk3Record.set("famula","n>="+jhdjCk3);
	jhdjCk3Record.set("note","年结婚登记、出具证明量"+jhdjCkEnd+"对（件）以上的，不少于"+jhdjCk3+"个结婚登记窗口");
	//离婚登记窗口
	var lhdjCkSta=document.getElementsByName("lhdjCkSta")[0].value;
	var lhdjCkEnd=document.getElementsByName("lhdjCkEnd")[0].value;
	var lhdjMj1=_$("lhdjMj1");
	var lhdjMj2=_$("lhdjMj2");
	var lhdjMj3=_$("lhdjMj3");
	var lhdjCk2=_$("lhdjCk2");
	var lhdjCk3=_$("lhdjCk3");
	if(!lhdjCkSta || !lhdjCkEnd || !lhdjMj1 || !lhdjMj2 || !lhdjMj3 || !lhdjCk2 || !lhdjCk3){		
		L5.Msg.alert("提示","请填写“"+level+".2.4.2 离婚登记室面积及窗口数量要求”信息！");
		return false;
	}
	var lhdjCk1Record=ds.getAt(20);
	var lhdjCk2Record=ds.getAt(21);
	var lhdjCk3Record=ds.getAt(22);
	lhdjCk1Record.set("con2",lhdjCkSta);
	lhdjCk1Record.set("famula","n>="+lhdjMj1);
	lhdjCk1Record.set("note","年离婚登记量"+lhdjCkSta+"对以下的，使用面积不低于"+lhdjMj1+"㎡");
	lhdjCk2Record.set("con1",lhdjCkSta);
	lhdjCk2Record.set("con2",lhdjCkEnd);
	lhdjCk2Record.set("famula","n>="+lhdjMj2+"&&r>="+lhdjCk2);
	lhdjCk2Record.set("note","年离婚登记量"+lhdjCkSta+"—"+lhdjCkEnd+"对的，使用面积不低于"+lhdjMj2+"㎡，不少于"+lhdjCk2+"个相对独立的离婚登记窗口");
	lhdjCk3Record.set("con1",lhdjCkEnd);
	lhdjCk3Record.set("famula","n>="+lhdjMj3+"&&r>="+lhdjCk3);
	lhdjCk3Record.set("note","年离婚登记量"+lhdjCkEnd+"对以上的，使用面积不低于"+lhdjMj3+"㎡，不少于"+lhdjCk3+"个相对独立的离婚登记窗口");
	//婚姻家庭辅导室
	var hyjtfdsMj=_$("hyjtfdsMj");
	var hyjtfds=_$("hyjtfds");
	if(!hyjtfds || !hyjtfdsMj){		
		L5.Msg.alert("提示","请填写“"+level+".2.5 婚姻家庭辅导室”信息！");
		return false;
	}
	var hyjtfdsRecord=ds.getAt(23);
	hyjtfdsRecord.set("famula","n>="+hyjtfdsMj+"&&r>="+hyjtfds);
	hyjtfdsRecord.set("note","婚姻家庭辅导室使用面积不低于"+hyjtfdsMj+"㎡");
	//颁证大厅
	var bzdtMj=_$("bzdtMj");
	var bzdtZw=_$("bzdtZw");
	if(!bzdtMj || !bzdtZw){		
		L5.Msg.alert("提示","请填写“"+level+".2.6 颁证大厅”信息！");
		return false;
	}
	var hyjtfdsRecord=ds.getAt(24);
	hyjtfdsRecord.set("famula","n>="+bzdtMj+"&&r>="+bzdtZw);
	hyjtfdsRecord.set("note","有独立的颁证大厅，使用面积不低于"+bzdtMj+"㎡，亲友观礼席位不少于"+bzdtZw+"座");
	
	//设施配备
	if(sspbCount<1){		
		L5.Msg.alert("提示","请填写“"+level+"..2.9.1 婚姻登记机关应配有以下设备”信息！");
		return false;
	}
	getChkValue(ds.getAt(25),"sspb",11);	
	if(document.getElementsByName("sspbGzl")[0] && ($("sspbChk8").checked || $("sspbChk9").checked)){
		var sspbGzl=document.getElementsByName("sspbGzl")[0].value;
		if(!sspbGzl){		
			L5.Msg.alert("提示","请填写“"+level+"..2.9.1 婚姻登记机关应配有以下设备”信息！");	
			return false;
		}
		var sspbRecord=ds.getAt(25);
		sspbRecord.set("con1",sspbGzl);
		var note=sspbRecord.get("note");
		sspbRecord.set("note",note.replace(note.substring(note.indexOf("<"),note.indexOf(">")+1), document.getElementsByName("sspbGzl")[0].value)
		.replace(note.substring(note.lastIndexOf("<"),note.lastIndexOf(">")+1), document.getElementsByName("sspbGzl")[0].value) );
	}
	//信息化建设网络预约
	var wlyy=_$("wlyy");
	if(!wlyy){		
		L5.Msg.alert("提示","请填写“"+level+".3.3 信息化建设！");
		return false;
	}
	var wlyyRecord=ds.getAt(26);
	wlyyRecord.set("famula","n>="+wlyy);
	wlyyRecord.set("note","开通网络预约登记，实现预约系统与婚姻登记系统数据交换，确保优先为预约者办理登记，网络预约办理登记量不低于当年登记量的"+wlyy+"%");
	if(wlyy==0){
		wlyyRecord.set("note","开通网络预约登记，实现预约系统与婚姻登记系统数据交换，确保优先为预约者办理登记");
	}	
	//信息化建设历史数据
	var lssj=_$("lssj");
	if(!lssj){		
		L5.Msg.alert("提示","请填写“"+level+".3.3 信息化建设！");
		return false;
	}
	var lssjRecord=ds.getAt(27);
	lssjRecord.set("famula","n<="+lssj);
	lssjRecord.set("note","将本辖区"+lssj+"年以来保存的所有婚姻登记档案录入婚姻登记信息系统");
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmOrganStandardCommand");
	command.setParameter("records",ds.getAllRecords());
	command.execute("batchUpdate");
	if(!command.error){
		L5.Msg.alert('提示',"保存成功!",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function goBack(){
	history.go(-1);
}
function chkClk(op){
	if(op.checked){		
		if(op.value=="jgxz"){
			jgxzCount+=1;
		}
		if(op.value=="hydjy"){	
			hydjyCount+=1;
		}
		if(op.value=="hjbjQy"){
			hjbjQyCount+=1;
		}
		if(op.value=="sspb"){
			sspbCount+=1;
		}
	}else{		
		if(op.value=="jgxz"){
			jgxzCount-=1;
		}
		if(op.value=="hydjy"){	
			hydjyCount-=1;
		}
		if(op.value=="hjbjQy"){
			hjbjQyCount-=1;
		}
		if(op.value=="sspb"){
			sspbCount-=1;
		}
	}
}
//整数校验
function numCheck(op,len,def){
	var reg=new RegExp("^[1-9][0-9]{0,"+(len-1)+"}$");
	if(op.value){
		if(!reg.test(op.value) ){		
			if(def!=undefined){
				op.value=def;
			}else{
				L5.Msg.alert("提示","请输入正确的数字！");
				op.value="";
			}
		}
		if(op.name){
			for(var i=0;i<document.getElementsByName(op.name).length;i++){
				document.getElementsByName(op.name)[i].value=op.value;
			}
		}
	}
}
//显示checkbox
function showChk(i,op){
	var record=ds.getAt(i-1);
	var famula=record.get("famula").split("||");
	for(var i=0;i<famula.length;i++){
		$( op+"Chk"+famula[i].substring(famula[i].lastIndexOf("=")+1) ).checked=true;
	}
	return famula.length;
}
//获取checkbox的值，count数量
function getChkValue(record,op,len){
	var famula="";
	var note="";
	for(var i=1;i<=len;i++){
		if($( op+"Chk"+i ).checked){
			if(famula){
				famula+="||";
				note+=";";
			}
			famula+="n=="+i;
			note+=$(op+"Lbl"+i).innerHTML;
		}
	}
	record.set("famula",famula);
	record.set("note",note);	
}