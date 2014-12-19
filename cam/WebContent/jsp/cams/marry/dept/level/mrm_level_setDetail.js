function init(){
	$("standardLevel").innerHTML=evaluLevel+"婚姻登记机关评定标准";
	ds.setParameter("STANDARD_LEVEL@=",standardLevel);
	ds.load();
	ds.on("load",function(ds){
		for(var i=1;i<=ds.getCount();i++){
			//机构性质
			if(i==1){
				var record=ds.getAt(i-1);
				var note=record.get("note").split(";");
				if(note.length==1){			
					$("jgxz").innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记机关应为"+note[0]+"。";
				}else{
					$("jgxz").innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;婚姻登记机关机构性质应符合以下要求之一：<br/>";
					for(var j=0;j<note.length;j++){
						if(j>0){
							$("jgxz").innerHTML+="；<br/>";
						}
						$("jgxz").innerHTML+="&nbsp;&nbsp;&nbsp;&nbsp;——"+note[j];
						if(j==note.length-1){
							$("jgxz").innerHTML+="。";
						}
					}
				}
			}
						
			//婚姻登记员
			if(i==2){
				var record=ds.getAt(i-1);
				var note=record.get("note").split(";");
				if(note.length==1){			
					$("hydjy").innerHTML="婚姻登记员应为"+note[0]+"专职人员。";
				}else{
					$("hydjy").innerHTML="婚姻登记员应为专职人员，其编制性质应符合以下要求之一：<br/>";
					for(var j=0;j<note.length;j++){
						if(j>0){
							$("hydjy").innerHTML+="；<br/>";
						}
						$("hydjy").innerHTML+="&nbsp;&nbsp;&nbsp;&nbsp;——"+note[j];
						if(j==note.length-1){
							$("hydjy").innerHTML+="。";
						}
					}
				}
			}
			//婚姻登记员配置
			showLbl("hydjyPz",i,3,3);
			//婚姻登记员涉外
			showLbl("hydjySw",i,6,3);
			//婚姻颁证员	
			showLbl("hybzy",i,9,2);		
			//婚姻家庭辅导员
			showLbl("hyjtfdy",i,11,1);		
			
			//环境布局区域
			if(i==12){
				var record=ds.getAt(i-1);
				var note=record.get("note").split(";");
				$("hjbjQy").innerHTML="婚姻登记机关场所应分为以下区域：<br/>";
				for(var j=0;j<note.length;j++){
					if(j>0){
						$("hjbjQy").innerHTML+="；<br/>";
					}
					$("hjbjQy").innerHTML+="&nbsp;&nbsp;&nbsp;&nbsp;——"+note[j];
					if(j==note.length-1){
						$("hjbjQy").innerHTML+="。";
					}
				}
				$("hjbjQyHb1").innerHTML=record.get("con3");
				$("hjbjQyHb2").innerHTML=record.get("con3");
			}
			//环境布局面积
			showLbl("hjbjMj",i,13,2);		
			//候登大厅座椅
			showLbl("hddtZy",i,15,3);
			if(i==16){
				if($("hddtZySta")){					
					var record=ds.getAt(i-1);
					$("hddtZySta").innerHTML=record.get("con1");
				}
			}
			//结婚登记窗口
			showLbl("jhdjCk",i,18,3);
			//离婚登记窗口
			showLbl("lhdjMj",i,21,3);
			//婚姻家庭辅导室
			showLbl("hyjtfdsMj",i,24,1);
			if(i==24){
				if($("hyjtfds")){					
					var record=ds.getAt(i-1);
					var famula=record.get("famula");
					$("hyjtfds").innerHTML=famula.substring(famula.lastIndexOf("=")+1);
				}
			}
			//颁证大厅
			showLbl("bzdt",i,25,1);
			//设施配备
			if(i==26){
				var record=ds.getAt(i-1);
				var note=record.get("note").split(";");
				$("sspb").innerHTML="婚姻登记机关应配有以下设备：<br/>";
				for(var j=0;j<note.length;j++){
					if(j>0){
						$("sspb").innerHTML+="；<br/>";
					}
					$("sspb").innerHTML+="&nbsp;&nbsp;&nbsp;&nbsp;——"+note[j];
					if(j==note.length-1){
						$("sspb").innerHTML+="。";
					}
				}
			}	
			//信息化建设网络预约
			showLbl("wlyy",i,27,1);
			//信息化建设历史数据
			showLbl("lssj",i,28,1);
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
function goBack(){
	history.go(-1);
}
function showLbl(op,i,sta,len){
	var record=ds.getAt(i-1);
	for(var j=0;j<len;j++){
		if(i==sta+j){
			if(len==1){
				$(op).innerHTML=record.get("note");
			}else{
				$(op+(j+1)).innerHTML=record.get("note");
			}
		}
	}
}
