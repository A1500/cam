<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="../../apply/prosthesisQualification/css/prosthesisapply2.css" type="text/css" rel="stylesheet" />
<style type="text/css"> 
	label{
		font-size: 12pt;
		font-family: 宋体;
	} 
	div{
		font-size: 12pt;
		font-family: 宋体;
	} 
</style>
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	var certIndex = 1;
 	var certpIndex = 1;
 	var cpIndex=1;
 	var index=1;
 	var saveFalg=true;
 	function init(){
 		var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
		wealFitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
		wealFitInfoDataSet.load();
		wealFitInfoDataSet.on("load",function(ds){
			if(ds.getCount==0){
				wealFitInfoDataSet.newRecord();
			}else{
				//职工统计信息
				var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitWorkerQueryCmd");
				command.setParameter("taskCode", taskCode);
				command.execute("queryFitWorkerSum");
				var totalNum=command.getReturn("totalNum");
				var disNum=command.getReturn("disNum");
				var noProNum=command.getReturn("noProNum");
				var proNum=command.getReturn("proNum");
				document.getElementById("totalNum").innerHTML=totalNum==null?"0":totalNum;
				document.getElementById("disNum").innerHTML=disNum==null?"0":disNum;
				document.getElementById("noProNum").innerHTML=noProNum==null?"0":noProNum;
				document.getElementById("proNum").innerHTML=proNum==null?"0":proNum;
				var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
				wealWorkerDataSet.on('load',function(ds){
					for(var i=0;i<ds.getCount();i++){
							var otr=table1.insertRow();//插入一个tr 
					 		 var ocel1=otr.insertCell(0);//插入一个td   
					 		 ocel1.innerHTML="<div align='center' >"+ds.getAt(i).get('name')+"</div>";  
					 		 var otrr=table2.insertRow();
					 		 var ocel2=otrr.insertCell(0);//插入一个td 
					 		 ocel2.innerHTML="<div align='center'>"+ds.getAt(i).get('idCard')+"</div>"; 
					 		 var otrrr=table3.insertRow();
					 		 var ocel3=otrrr.insertCell(0);
					 		 ocel3.innerHTML="<div align='center'>"+ds.getAt(i).get('certCode')+"</div>";
					 		  var ot=table4.insertRow();
					 		 var ocel4=ot.insertCell(0);
					 		ocel4.innerHTML="<div align='center'>"+ds.getAt(i).get('certDate')+"</div>";
					 		if(ds.getCount()!=i+1){
					 			ocel1.className="td";
					 			ocel2.className="td";
					 			ocel3.className="td";
					 			ocel4.className="td";
					 		 }
					}
				});
				var wealWorkerDataSet2 = L5.DatasetMgr.lookup("wealWorkerDataSet2");
				wealWorkerDataSet2.on('load',function(ds){
					for(var i=0;i<ds.getCount();i++){
							var otr=table5.insertRow();//插入一个tr 
					 		 var ocel1=otr.insertCell(0);//插入一个td   
					 		 ocel1.innerHTML="<div align='center' >"+ds.getAt(i).get('name')+"</div>";  
					 		 var otrr=table6.insertRow();
					 		 var ocel2=otrr.insertCell(0);//插入一个td 
					 		 ocel2.innerHTML="<div align='center'>"+ds.getAt(i).get('idCard')+"</div>"; 
					 		 var otrrr=table7.insertRow();
					 		 var ocel3=otrrr.insertCell(0);
					 		 ocel3.innerHTML="<div align='center'>"+ds.getAt(i).get('certOrthosisCode')+"</div>";
					 		  var ot=table8.insertRow();
					 		 var ocel4=ot.insertCell(0);
					 		ocel4.innerHTML="<div align='center'>"+ds.getAt(i).get('certOrthosisDate')+"</div>";
					 		if(ds.getCount()!=i+1){
					 			ocel1.className="td";
					 			ocel2.className="td";
					 			ocel3.className="td";
					 			ocel4.className="td";
					 		 }
					}
				});
				var wealWorkerDataSet1 = L5.DatasetMgr.lookup("wealWorkerDataSet1");
				wealWorkerDataSet1.on('load',function(ds){
					for(var i=0;i<ds.getCount();i++){
						
						var otr=tzs1.insertRow();//插入一个tr 
				 		 var ocel1=otr.insertCell(0);//插入一个td   
				 		 ocel1.innerHTML="<div align='center'>"+ds.getAt(i).get('name')+"</div>";  
				 		 var otrr=tzs2.insertRow();
				 		 var ocel2=otrr.insertCell(0);//插入一个td 
				 		 ocel2.innerHTML="<div align='center'>"+ds.getAt(i).get('idCard')+"</div>"; 
				 		 var otrrr=tzs3.insertRow();
				 		 var ocel3=otrrr.insertCell(0);
				 		 ocel3.innerHTML="<div align='center'>"+ds.getAt(i).get('certSpecialCode')+"</div>";
				 		  var ot=tzs4.insertRow();
				 		 var ocel4=ot.insertCell(0);
				 		ocel4.innerHTML="<div align='center'>"+ds.getAt(i).get('certSpecialDate')+"</div>";
				 		if(ds.getCount()!=i+1){
				 			ocel1.className="td";
				 			ocel2.className="td";
				 			ocel3.className="td";
				 			ocel4.className="td";
				 		 }
				 		 certpIndex++;
					}
					certpIndex=1;
				}); 
				//职工证书情况
				 workCondion();
				
				//设施信息
				var wealFitDeviceDataSet = L5.DatasetMgr.lookup("wealFitDeviceDataSet");
				wealFitDeviceDataSet.setParameter("TASK_CODE@=", taskCode);
				wealFitDeviceDataSet.load();
				//生产能力信息
				var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
				wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
				wealFitProductivepowerDataSet.load();
				
			}
		});
		wealFitDeviceDataSet.on('load',function(ds){
			if(ds.getCount()>0){
				for(var i=0;i<ds.getCount();i++){
					var otr=dntable.insertRow();//插入一个tr 
			 		 var ocel1=otr.insertCell(0);//插入一个td   
			 		 ocel1.innerHTML="<div align='center'><label  id='deviceName"+i+"' /></div>";  
			 		 var otrr=dnnumtable.insertRow();
			 		 var ocel2=otrr.insertCell(0);//插入一个td 
			 		 ocel2.innerHTML="<div align='center'><label  id='deviceNum"+i+"' name='deviceNum'/></div>";
			 		  
			 		if(ds.getCount()!=i+1){
			 			ocel1.className="td";
			 			ocel2.className="td";
			 		 }
					document.getElementById("deviceName"+i).innerHTML=ds.getAt(i).get('deviceName');
					document.getElementById("deviceNum"+i).innerHTML=ds.getAt(i).get('deviceNum');
					
					
					index=1;
					index=index+ds.getCount();
				}
				
			}
			
		});
		wealFitProductivepowerDataSet.on('load',function(ds){
			var productNumTotle=0;
			var productValueTotle=0;
			if(ds.getCount()>0){
				for(var i=0;i<ds.getCount();i++){
					var otr=pntable.insertRow();//插入一个tr 
			 		 var ocel1=otr.insertCell(0);//插入一个td   
			 		 ocel1.innerHTML="<div align='center'><label  id='productName"+i+"' /></div>";  
			 		 var otrr=pnnumtable.insertRow();
			 		 var ocel2=otrr.insertCell(0);//插入一个td 
			 		 ocel2.innerHTML="<div align='center'><label  id='productNum"+i+"' name='productNum'/></div>"; 
			 		 var otrrr=pvtable.insertRow();
			 		 var ocel3=otrrr.insertCell(0);
			 		 ocel3.innerHTML="<div align='center'><label  id='productValue"+i+"' name='productValue'/></div>";
			 		if(ds.getCount()!=i+1){
			 			ocel1.className="td";
			 			ocel2.className="td";
			 			ocel3.className="td";
			 		 }
					document.getElementById("productName"+i).innerHTML=ds.getAt(i).get('productName');
					//document.getElementById("productId"+i).value=ds.getAt(i).get('produceId');
					document.getElementById("productNum"+i).innerHTML=ds.getAt(i).get('productNum');
					document.getElementById("productValue"+i).innerHTML=ds.getAt(i).get('productValue');
					productNumTotle+=ds.getAt(i).get('productNum');
					productValueTotle+=ds.getAt(i).get('productValue');
					
					cpIndex=1;
					cpIndex=cpIndex+ds.getCount();
				}
				
			}
			document.getElementById("productNumT").innerHTML=productNumTotle+" 个";
			document.getElementById("productValueT").innerHTML=productValueTotle+" 万元";
			
		});
 	}
 	function workCondion(){
 		var rowNum=table1.rows.length;
 	     for (i=0;i<rowNum;i++)
 	     {
 	    	table1.deleteRow(0);
 	    	table2.deleteRow(0);
 	    	table3.deleteRow(0);
 	    	table4.deleteRow(0);
 	     }
 	     var rowNum=table5.rows.length;
 	     for (i=0;i<rowNum;i++)
 	     {
 	    	table5.deleteRow(0);
 	    	table6.deleteRow(0);
 	    	table7.deleteRow(0);
 	    	table8.deleteRow(0);
 	     }
 	    var rowNum=tzs1.rows.length;
	     for (i=0;i<rowNum;i++)
	     {
	    	 tzs1.deleteRow(0);
	    	 tzs2.deleteRow(0);
	    	 tzs3.deleteRow(0);
	    	 tzs4.deleteRow(0);
	     }
 		//职工证书情况
 		
 		var year  = new Date().getDate();
 		
		var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
		wealWorkerDataSet.setParameter("TASK_CODE@=", taskCode);
		wealWorkerDataSet.setParameter("CERT_SITUATION@=","1");
		wealWorkerDataSet.setParameter("CERT_TIME@>=",getPreDate());
		wealWorkerDataSet.load();
		
		var wealWorkerDataSet2 = L5.DatasetMgr.lookup("wealWorkerDataSet2");
		wealWorkerDataSet2.setParameter("TASK_CODE@=", taskCode);
		wealWorkerDataSet2.setParameter("CERT_ORTHOSIS_SITUATION@=","1");
		wealWorkerDataSet2.setParameter("CERT_ORTHOSIS_TIME@>=",getPreDate());
		wealWorkerDataSet2.load();
		
		var wealWorkerDataSet1 = L5.DatasetMgr.lookup("wealWorkerDataSet1");
		wealWorkerDataSet1.setParameter("TASK_CODE@=", taskCode);
		wealWorkerDataSet1.setParameter("CERT_SPECIAL_SITUATION@=","1");
		wealWorkerDataSet1.setParameter("CERT_SPECIAL_TIME@>=",getPreDate());
		wealWorkerDataSet1.load();
		
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitWorkerQueryCmd");
		command.setParameter("taskCode", taskCode);
		command.execute("queryFitWorkerSum");
		var totalNum=command.getReturn("totalNum");
		var disNum=command.getReturn("disNum");
		var noProNum=command.getReturn("noProNum");
		var proNum=command.getReturn("proNum");
		document.getElementById("totalNum").innerHTML=totalNum==null?"0":totalNum;
		document.getElementById("disNum").innerHTML=disNum==null?"0":disNum;
		document.getElementById("noProNum").innerHTML=noProNum==null?"0":noProNum;
		document.getElementById("proNum").innerHTML=proNum==null?"0":proNum;
		
 	}
 	function deviceCondion(){
 		var rowNum=dnnumtable.rows.length;
 	     for (i=0;i<rowNum;i++)
 	     {
 	    	dnnumtable.deleteRow(0);
 	    	dntable.deleteRow(0);
 	     }
	     var wealFitDeviceDataSet = L5.DatasetMgr.lookup("wealFitDeviceDataSet");
		 wealFitDeviceDataSet.setParameter("TASK_CODE@=", taskCode);
		 wealFitDeviceDataSet.load();
 	}
 	function productCondion(){
 		
 		var rowNum=pnnumtable.rows.length;
 	     for (i=0;i<rowNum;i++)
 	     {
 	    	pnnumtable.deleteRow(0);
 	    	pntable.deleteRow(0);
 	    	pvtable.deleteRow(0);
 	     }
	     var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
			wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
			wealFitProductivepowerDataSet.load();
		
 	}
 	  function save(){
 		 if(!saveFalg){
 			 alert("正在保存,请稍后!");
 		 }
 		saveFalg=false;
 		var info= validateInfo();
 		if(info){
 			alert(info);
 			return "break";
 		}
 		 
		var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
		var fitInfoValidate = wealFitInfoDataSet.isValidate();
		if(fitInfoValidate != true){
			L5.Msg.alert("提示",fitInfoValidate);
			return "break";
		}
		var fitInfoRecord=wealFitInfoDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("fitInfoRecord", fitInfoRecord);
		command.execute("saveQualificationInfo");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
		saveFalg=true;
	}
	function showWorkerWin(){
		var width = 1200;
		var height = 600;
		var url="../../apply/prosthesisQualification/wealworker.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		workCondion();
	}
	function showDeviceWin(){
		var width = 1200;
		var height = 600;
		var url="../../apply/prosthesisQualification/wealDevice.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		deviceCondion();
	}
	function showProductWin(){
		var width = 1200;
		var height = 600;
		var url="../../apply/prosthesisQualification/wealProduct.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		productCondion();
		
	}
	function productNumTotal(obj){
		if(isNaN(obj.value)){
			alert("请正确输入产品数量!"+obj.value);
			return;
		}
		var total=0;
		var productNums = document.getElementsByName("productNum");
		for(var j =0;j<productNums.length;j++){
			total+=parseInt(productNums[j].value);
		}
		document.getElementById("productNumT").value=total;
	}
	function productValueTotal(){
		
	}
	function validateInfo(){
		var its = document.getElementsByTagName("input");
		for(var i=0;i<its.length;i++){
			var vname= its[i].getAttribute("vname");
			if(vname&&its[i].value==""){
				return vname+"不能为空!";
			}
		}
		var sel = document.getElementById("economicNatureCode");
		if(sel.value==""){
			var vname= sel.getAttribute("vname");
			return vname+"不能为空!"; 
		}
		//总经营面积校验
		var operateArea = parseInt(document.getElementById("operateArea").value);
		var productArea = parseInt(document.getElementById("productArea").value);
		var recoveryArea = parseInt(document.getElementById("recoveryArea").value);
		var receptionArea = parseInt(document.getElementById("receptionArea").value);
		var trainArea = parseInt(document.getElementById("trainArea").value);
		var otherArea = parseInt(document.getElementById("otherArea").value);
		var treatmentArea = parseInt(document.getElementById("treatmentArea").value);
		var leisureArea = parseInt(document.getElementById("leisureArea").value);
		var workArea = parseInt(document.getElementById("workArea").value);
		if(operateArea!=productArea+recoveryArea+receptionArea+trainArea+otherArea+treatmentArea+leisureArea+workArea){
			return "各活动室的面积总和应等于总经营面积";
		}
		var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
		var wealWorkerDataSet2 = L5.DatasetMgr.lookup("wealWorkerDataSet2");
		if((wealWorkerDataSet.getCount()+wealWorkerDataSet2.getCount())<1){
			return "假肢矫形器职业资格证书至少有一人执有!";
		}
		var wealWorkerDataSet1 = L5.DatasetMgr.lookup("wealWorkerDataSet1");
		if(wealWorkerDataSet1.getCount()<2){
			return "假肢矫形器生产装配特有工种职业资格证书至少有两人执有!";
		}
		var flag=true;
		for(var i=0;i<index-1;i++){
			if(document.getElementById("deviceName"+i).value!=""){
				flag=false;
			}
		}
		if(flag){
			return "请填写装配假肢矫形器基本设施信息!";
		}
		var flagS=true;
		for(var i=0;i<cpIndex-1;i++){
			if(document.getElementById("productName"+i).value!=""){
				flagS=false;
			}
		}
		if(flagS){
			return "请填写生产能力信息!";
		}
		return false;
	}
	function checkArea(value){
		 if(value<120){
		 	alert("总经营面积不得小于120㎡");
		 	document.getElementById("operateArea").value="";
		 }
	}
	function getPreDate(){
		var date=new Date();
		var year=date.getFullYear()-1;
		return year+"-01-01";
	}
	
	//页面跳转
	function backPageY(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/yearlyCheck/info/prosthesisapply1.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}

	function lastPageJ(page){
		if(save() == "break"){
			return;
		}
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/yearlyCheck/info/prosthesisapply'+page+'.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	function nextPageD(){
		if(save() == "break"){
			return;
		}
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/yearlyCheck/info/prosthesisapply3.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	
	
</script>

</head>

<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealFitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 设施信息表 -->
	<model:dataset id="wealFitDeviceDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitDeviceQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitDevice"></model:record>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="wealFitProductivepowerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
		<model:params>
			<model:param name="CERT_CODE@<>" value=''></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="wealWorkerDataSet1" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<model:dataset id="wealWorkerDataSet2" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<!-- 设施字典表 
	<model:dataset id="deviceDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_FITDEVICE'></model:param>
		</model:params>
	</model:dataset>
	-->

	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="dicFitdeviceDs" cmd="com.inspur.cams.welfare.config.device.cmd.WealDicFitdeviceQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.welfare.config.device.dao.WealDicFitdevice"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageD()"/>
	<input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPageJ('1')"/>
	<input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;"  onclick="save()"/>
	<input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backPageY();"/>
</div>


<form method="post" onsubmit="return false"  dataset="wealFitInfoDataSet">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center id="tab"
	border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		
		<TR vAlign=top>
			<TD vAlign=top height=522>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=900 border=0 id="toadd" >
				<tbody>
					<tr>
					    <td width="186" class=unnamed1 height="30" colspan="3"><div align="center">企业名称</div></td>
					    <td colspan="8" class=unnamed5><div align="left">
					      <input type="text" vname="企业名称" id="companyName" field="companyName" size=50/><font color="red">*</font>
					    </div></td>
					  </tr>
					  <tr>
					    <td class=unnamed6 height="30" colspan="3"><div align="center" >注册地址</div></td>
					    <td colspan="3" class=unnamed2><div align="left">
					      <input type="text" vname="注册地址" id="address" field="address" size=50/><font color="red">*</font>
					    	</div>
					    </td>
					    <td colspan="2" class=unnamed3 height="30" ><div align="center" >邮编</div></td>
					    <td colspan="3" class=unnamed6>
					      <input type="text" vname="邮编" id="postCode" field="postCode"  /><font color="red">*</font>
					    </td>
					    
					    
					  </tr>
					  <!-- 法人代表 身份证号 -->
					  <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">法人代表</div></td>
					  	<td colspan="3" class=unnamed2>
					  		<input type="text" vname="法人代表" id="legalPeople" field="legalPeople" size=50/><font color="red">*</font>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">身份证号</div></td>
					  	<td colspan="3" class=unnamed6>
					  		<input type="text" vname="身份证号" id="legalIdCard" field="legalIdCard" /><font color="red">*</font>
					  	</td>
					  </tr>
					  <!-- 固定电话 手机 -->
					   <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">固定电话</div></td>
					  	<td colspan="3" class=unnamed2>
					  		<input type="text" vname="固定电话" id="legalPhone" field="legalPhone" size=50/><font color="red">*</font>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">手&nbsp;机</div></td>
					  	<td colspan="3" class=unnamed6>
					  		<input type="text" vname="手机" id="legalTelphone" field="legalTelphone"/><font color="red">*</font>
					  	</td>
					  </tr>
					  <!-- 电子邮箱 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3" ><div align="center">电子邮箱</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      <input type="text" vname="电子邮箱" id="legalEmail" field="legalEmail" size=50/><font color="red">*</font>
					    </div></td>
					  </tr>
					   <!-- 经办人   身份证号  固定电话 手机-->
					     <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">经&nbsp;办&nbsp;人</div></td>
					  	<td colspan="3" class=unnamed2>
					  		<input type="text" vname="经办人" id="agentPeople" field="agentPeople" size=50/><font color="red">*</font>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">身份证号</div></td>
					  	<td colspan="3" class=unnamed6>
					  		<input type="text" vname="身份证号" id="agentIdCard" field="agentIdCard" /><font color="red">*</font>
					  	</td>
					  </tr>
					  <!-- 固定电话 手机 -->
					   <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">固定电话</div></td>
					  	<td colspan="3" class=unnamed2>
					  		<input type="text" vname="固定电话" id="agentPhone" field="agentPhone" size=50/><font color="red">*</font>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">手&nbsp;机</div></td>
					  	<td colspan="3" class=unnamed6>
					  		<input type="text" vname="手机" id="agentTelphone" field="agentTelphone"/><font color="red">*</font>
					  	</td>
					  </tr>
					  <!-- 电子邮箱 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3"><div align="center">电子邮箱</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      <input type="text" vname="电子邮箱" id="agentEmail" field="agentEmail" size=50/><font color="red">*</font>
					    </div></td>
					  </tr>
					 <!-- 网站地址 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3"><div align="center">网站地址</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      <input type="text" vname="网站地址" id="webAddress" field="webAddress" size=50/><font color="red">*</font>
					    </div></td>
					  </tr>
					  <tr>
					    <td class=unnamed6 height="30" colspan="3"><div align="center">经济性质</div></td>
					    <td colspan="1" class=unnamed2>
					     <select id="economicNatureCode" field="economicNatureCode" vname="经济性质" style="width:95%">
					     	<option dataset="ecoDataSet" ></option>
					     </select><font color="red">*</font>
					    </td>
					   <td colspan="1" class=unnamed3 height="30" ><div align="center">注册资金(万元)</div></td>
					    <td colspan="1" class=unnamed6><input type="text" vname="注册资金" id="regFund" field="regFund" /><font color="red">*</font></td>
					    <td class=unnamed3 height="30" colspan="4"><div align="center">初次认定时间</div></td>
					    <td colspan="1" class=unnamed6>
					      &nbsp;<label name="初次认定时间" id="cognizanceDate" field="cognizanceDate"/>
					    </td>
					    
					    <tr>
					    <td class=unnamed6 colspan="3" height="30" ><div align="center">营业执照编号</div></td>
					    <td colspan="1" class=unnamed2>
					      <input type="text" name="营业执照编号" id="licenseCode" field="licenseCode" size=50/><font color="red">*</font>
					   </td>
					    
					    <td colspan="1" class=unnamed3 height="30" ><div align="center">税务登记编号</div></td>
					    <td colspan="1" class=unnamed6><input type="text" name="税务登记编号" id="registrationCode" field="registrationCode" /><font color="red">*</font></td>
					     <td class=unnamed3 height="30" colspan="4"><div align="center">组织机构代码</div></td>
					    <td colspan="1" class=unnamed6>
					      <input type="text" name="组织机构代码" id="organCode" field="organCode"/><font color="red">*</font>
					    </td>
					  </tr>
					   <tr >
						   <td class=unnamed6 colspan="3" align="center" height="100">
								年度经营状况(万元)
						   </td>
						   <td class=unnamed8 colspan="8" height="100">
						   		<table  cellSpacing=0 cellPadding=0 style="border-collapse:collapse" width="100%" border=-1>
						   		<tbody>
						   			<tr>
						   				<td class=unnamed5 height="30">经营收入</td>
						   				<td class=unnamed5><input field="incomeYear" vname="经营收入" type="text"></input><font color="red">*</font></td>
						   				<td class=unnamed5 height="30">利润</td>
						   				<td class=unnamed5><input type="text" vname="利润" field="profitYear" ></input><font color="red">*</font></td>
						   			</tr>
						   			<tr><td class=unnamed5 height="30">审计情况</td>
						   			<td class=unnamed5 height="30" colspan="3"><input vname="审计情况" type="text" field="operateSituation"></input><font color="red">*</font></td>
						   			</tr>
						   			<tr><td class=unnamed5 height="30">增值税总额</td>
						   				<td class=unnamed5 height="30"><input  type="text" vname="增值税总额" field="addedTaxYear"></input><font color="red">*</font></td>
						   				<td class=unnamed5 height="30">所得税总额</td>
						   				<td class=unnamed5 height="30"><input  type="text" vname="所得税总额" field="incomeTaxYear"></input><font color="red">*</font></td>
						   			</tr>
						   			<tr>
							   			<td class=unnamed5 height="30">应减免税金总额</td>
						   				<td class=unnamed5 height="30"><input  type="text" vname="应减免税金总额" field="shouldredueTaxYear"></input><font color="red">*</font></td>
						   				<td class=unnamed5 height="30">实际减免税金总额</td>
						   				<td class=unnamed5 height="30"><input  type="text" vname="实际减免税总额" field="realredueTaxYear"></input><font color="red">*</font></td>
									</tr>
									</tbody>
						   		</table>
						   </td>
					  </tr>
						
					 <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">总经营面积（㎡）</div></td>
						  	<td colspan="2" class=unnamed2>
						  		<input type="text" vname="总经营面积" id="operateArea" field="operateArea" onblur="checkArea(this.value)" size=50/><font color="red">*</font>
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">制作间面积（㎡）</div></td>
						  	<td colspan="4" class=unnamed6>
						  		<input type="text" vname="制作间面积" id="productArea" field="productArea"/><font color="red">*</font>
						  	</td>
						  </tr> 	
						  
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">康复室面积（㎡）</div></td>
						  	<td colspan="2" class=unnamed2>
						  		<input type="text" vname="康复室面积" id="recoveryArea" field="recoveryArea" size=50/><font color="red">*</font>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">接待室面积（㎡）</div></td>
						  	<td colspan="4" class=unnamed6>
						  		<input type="text" vname="接待室面积" id="receptionArea" field="receptionArea"/><font color="red">*</font>
						  	</td>
						  </tr> 
						  
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">训练厅面积（㎡）</div></td>
						  	<td colspan="2" class=unnamed2>
						  		<input type="text" vname="训练厅面积" id="trainArea" field="trainArea" size=50/><font color="red">*</font>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">理疗室面积（㎡）</div></td>
						  	<td colspan="4" class=unnamed6>
						  		<input type="text" vname="理疗室面积" id="treatmentArea" field="treatmentArea"/><font color="red">*</font>
						  	</td>
						  </tr> 
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">办公面积（㎡）</div></td>
						  	<td colspan="2" class=unnamed2>
						  		<input type="text" vname="办公面积" id="workArea" field="workArea" size=50/><font color="red">*</font>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3  ><div align="center">休闲区面积（㎡）</div></td>
						  	<td colspan="4" class=unnamed6>
						  		<input type="text" vname="休闲区面积" id="leisureArea" field="leisureArea"/><font color="red">*</font>
						  	</td>
						  </tr>				
						   <tr>
						  	<td class=unnamed6 height="30"  colspan="3"><div align="center">其&nbsp;它（㎡）</div></td>
						    <td colspan="8" class=unnamed2><div align="left">
						      <input type="text" vname="其它" id="otherArea" size=50 field="otherArea"/><font color="red">*</font>
						    </div></td>
						  </tr>
						  
							 <tr >
							    <td  rowspan="2" class=unnamed6 height="30" colspan="3"><div align="center">职工人数<br>
							    <input id="showWorker" value="职工信息" type="button" onclick="showWorkerWin()"/></div></td>
							    <td colspan="1" class=unnamed2 height="30"><div align="center">合计</div></td>
							    <td colspan="2" class=unnamed3 height="30"><div align="center">非生产人员</div></td>
							    <td colspan="4" class=unnamed6 height="30"><div align="center">生产人员</div></td>
							    <td colspan="1" class=unnamed2 height="30"><div align="center">其中残疾职工</div></td>
							  </tr>
							  <tr>
							    <td colspan="1" class=unnamed2 height="30"><div align="center">
							      <label type="text" name="合计" id="totalNum" />
							    </div></td>
							    <td colspan="2" class=unnamed3 align="center" height="30"><label type="text" name="非生产人员" id="noProNum" /></td>
							    <td colspan="4" class=unnamed6 align="center"><label type="text" name="生产人员" id="proNum" /></td>
							    <td colspan="4" class=unnamed2 align="center"><label type="text" name="残疾职工" id="disNum" /></td>
							  </tr>
							  <tr>
					<!--假肢矫形器职业资格证书执有情况  -->
							  <tr>
							    <td colspan="11" class=unnamed6 height="30"><div align="left">假肢矫形器职业资格证书执有情况（至少有一人）</div></td>
							  </tr>
							  <tr>
							    <td colspan="11" class=unnamed6 height="30"><div align="left">假肢制作师职业资格证书执有情况</div></td>
							  </tr>
							  <tr>
							    <td colspan="2" class=unnamed6 height="30"><div align="center">姓名</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">身份证号码</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">证书编号</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">发证时间
							    </div></td>
							 	 
							  </tr>
							 <tr>
							  	
							  		 <td colspan="2" class=unnamed6 height="30" id="td1"><div align="center">
							  		 	<table id="table1" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="td2"><div align="center">
							  		 	<table id="table2" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="td3"><div align="center">
							  		 	<table id="table3" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="td4"><div align="center">
							  		 	<table id="table4" style="width:100%;height:100%"></table>
							  		 </div></td>
							  
							  </tr>
							  <tr>
							    <td colspan="11" class=unnamed6 height="30"><div align="left">矫形器制作师职业资格证书执有情况</div></td>
							  </tr>
							  <tr>
							    <td colspan="2" class=unnamed6 height="30"><div align="center">姓名</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">身份证号码</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">证书编号</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">发证时间
							    </div></td>
							 	 
							  </tr>
							 <tr>
							  	
							  		 <td colspan="2" class=unnamed6 height="30" id="tb1"><div align="center">
							  		 	<table id="table5" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="tb2"><div align="center">
							  		 	<table id="table6" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="tb3"><div align="center">
							  		 	<table id="table7" style="width:100%;height:100%"></table>
							  		 </div></td>
							  		 <td colspan="3" class=unnamed2 height="30" id="tb4"><div align="center">
							  		 	<table id="table8" style="width:100%;height:100%"></table>
							  		 </div></td>
							  
							  </tr>
							  
							<!--证书执有情况   添加  -->
							<tr>
							 <td colspan="11" class=unnamed6 height="30"><div align="left">假肢矫形器生产装配特有工种职业资格证书执有情况（至少有两人）</div></td>
							  </tr>
							  <tr>
							    <td colspan="2" class=unnamed6 height="30"><div align="center">姓名</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">身份证号码</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">证书编号</div></td>
							    <td colspan="3" class=unnamed2 align="center"><div align="center">发证时间  
							    </div></td>
							 	
							  <!--</tr>
							  <tr id="tbl21">
							    <td colspan="2" class=unnamed6 height="30"><div align="center">
							      <input type="text" name="姓名1" id="nameSpe0" />
							    </div></td>
							    <td colspan="3" class=unnamed2 align="center"><input type="text" name="身份证号1" id="idCardSpe0" /></td>
							    <td colspan="3" class=unnamed2 align="center"><input type="text" name="证书编号1" id="certSpecialCode0" /></td>
							    <td colspan="3" class=unnamed2 align="center"><input type="text" name="发证时间1" id="certSpecialDate0" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="text-align: center"/></td>
							  </tr>
							   -->
							  <tr>
							    <td colspan="2" class=unnamed6 height="30"><div align="center"><table id="tzs1" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2 ><div align="center"><table id="tzs2" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2 ><div align="center"><table id="tzs3" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2><div align="center"><table id="tzs4" style="width:100%;height:100%"></table></div></td>
							  </tr>
							  
							  
							  
								
							  <tr>
							    <td colspan="11" class=unnamed6 height="30"><div align="left">装配假肢矫形器基本设施  <input type="button" value="设施信息" onclick="showDeviceWin()"/></div></td>
							  </tr>			
							 <tr>
							 	<td colspan="8" class=unnamed6 height="30"><div align="center">名称</div></td>
							 	<td colspan="3" class=unnamed2 height="30"><div align="center">数量(个)
							 	</div></td>
							 	
							 </tr>
						  	<tr>
							  	<td colspan="8" class="unnamed6"><div align="center"><table id="dntable" style="width:100%;height:100%"></table></div></td>
							  	<td colspan="3" class="unnamed2"><div align="center"><table id="dnnumtable" style="width:100%;height:100%"></table></div></td>
							</tr>
						<tr>
						 <td rowspan="8" class=unnamed6 colspan="2"><div align="center">主<br />要<br />产<br />品<br /></div></td>
					    <td colspan="3" class=unnamed2 rowspan="2"><div align="center">产品名称</div></td>
					    <td colspan="7" class=unnamed2 height="30"><div align="center">年生产能力</div>
					    	<tr>
					    		<td class=unnamed2 height="30" colspan="3"><div align="center">数量</div></td>
					    		<td class=unnamed2 colspan="3"><div align="center">产值（万元）<input type="button" value="产品信息" onclick="showProductWin()" /></div></td>
					    	</tr>
					    </td>
					</tr>
					<tr>
					  	<td colspan="3" class="unnamed2" ><div align="center">(合计)</div></td>
					  	<td colspan="3" class="unnamed2"><div align="center"><label name="数量" id="productNumT" ></label></div></td>
					  	<td colspan="3" class="unnamed2"><div align="center"><label name="产值" id="productValueT"/></div></td>
					</tr>
					<!-- <tr>
					  	<td colspan="4" class="unnamed2"><div align="center"><input type="text" name="产品名称" id="productName0" /><input type="hidden" name="产值" id="productId0"/></div></td>
					  	<td colspan="2" class="unnamed2"><div align="center"><input type="text" name="数量" id="productNum0" name="productNum" onblur="productNumTotal(this)"/></div></td>
					  	<td colspan="3" class="unnamed2"><div align="center"><input type="text" name="产值" id="productValue0" name="productValue" onblur="productValueTotal"/></div></td>
					</tr> -->
					<tr>
					  	<td colspan="3" class="unnamed2"><div align="center"><table id="pntable" style="width:100%;height:100%"></table></div></td>
					  	<td colspan="3" class="unnamed2"><div align="center"><table id="pnnumtable" style="width:100%;height:100%"></table></div></td>
					  	<td colspan="3" class="unnamed2"><div align="center"><table id="pvtable" style="width:100%;height:100%"></table></div></td>
					</tr>
					
			</TABLE>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>第2页</td>
		</tr>
</TABLE>
</form>
<div id="float" >
	<input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageD()"/>
	<input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPageJ('1')"/>
	<input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;"  onclick="save()"/>
	<input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backPageY();"/>
</div>

</body>
</html>
