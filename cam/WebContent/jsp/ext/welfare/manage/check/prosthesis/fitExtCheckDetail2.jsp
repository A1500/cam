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

<link href="css/prosthesisapply2.css" type="text/css" rel="stylesheet" />
<style type="text/css"> 
	label {
		font-size: 14.0pt;
		font-family: 宋体;
	} 
	div {
		font-size: 14.0pt;
		font-family: 宋体;
	} 
</style> 

<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	var certIndex = 1;
 	var certpIndex = 1;
 	var index=1;
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
				//职工证书情况
				
				var year = new Date().getYear();
				
				var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
				wealWorkerDataSet.setParameter("TASK_CODE@=", taskCode);
				wealWorkerDataSet.setParameter("CERT_SITUATION@=","1");
				wealWorkerDataSet.setParameter("CERT_TIME@>=",getPreDate());
				wealWorkerDataSet.load();
				wealWorkerDataSet.on('load',function(ds){
					if(ds.getCount()>0){
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
					}
				});
				
				var wealWorkerDataSet2 = L5.DatasetMgr.lookup("wealWorkerDataSet2");
				wealWorkerDataSet2.setParameter("TASK_CODE@=", taskCode);
				wealWorkerDataSet2.setParameter("CERT_ORTHOSIS_SITUATION@=","1");
				wealWorkerDataSet2.setParameter("CERT_ORTHOSIS_TIME@>=",getPreDate());
				wealWorkerDataSet2.load();
				wealWorkerDataSet2.on('load',function(ds){
					if(ds.getCount()>0){
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
					}
				});
				var wealWorkerDataSet1 = L5.DatasetMgr.lookup("wealWorkerDataSet1");
				wealWorkerDataSet1.setParameter("TASK_CODE@=", taskCode);
				wealWorkerDataSet1.setParameter("CERT_SPECIAL_SITUATION@=","1");
				wealWorkerDataSet1.setParameter("CERT_SPECIAL_TIME@>=",getPreDate());
				wealWorkerDataSet1.load();
				wealWorkerDataSet1.on('load',function(ds){
					if(ds.getCount()>0){
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
						}
					}
				});
				
				//设施信息
				var wealFitDeviceDataSet = L5.DatasetMgr.lookup("wealFitDeviceDataSet");
				wealFitDeviceDataSet.setParameter("TASK_CODE@=", taskCode);
				wealFitDeviceDataSet.load();
				wealFitDeviceDataSet.on('load',function(ds){
					if(ds.getCount()>0){
						for(var i=0;i<ds.getCount();i++){
							var otr=tjb1.insertRow();//插入一个tr 
					 		 var ocel1=otr.insertCell(0);//插入一个td   
					 		 ocel1.innerHTML="<div align='center'>"+
					 			ds.getAt(i).get('deviceName')
					 		 +"</div>";
										     		
					 		 var otrr=tjb2.insertRow();
					 		 var ocel2=otrr.insertCell(0);//插入一个td 
					 		 ocel2.innerHTML="<div align='center'>&nbsp;"+ds.getAt(i).get('deviceNum')+"</div>"; 
					 		 if(ds.getCount()!=i+1){
						 			ocel1.className="td";
						 			ocel2.className="td";
						 		 }
					 		 index++;
						}
					}
				});
				//生产能力信息
				var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
				wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
				wealFitProductivepowerDataSet.load();
				wealFitProductivepowerDataSet.on('load',function(ds){
				
				var productNumTotle=0;
				var productValueTotle=0;
					if(ds.getCount()>0){
						for(var i=0;i<ds.getCount();i++){
							var otr=pntable.insertRow();//插入一个tr 
					 		 var ocel1=otr.insertCell(0);//插入一个td   
					 		 ocel1.innerHTML="<div align='center'>"+ds.getAt(i).get('productName')+"</div>"; 
					 		 var otrr=pnnumtable.insertRow();
					 		 var ocel2=otrr.insertCell(0);//插入一个td 
					 		ocel2.innerHTML="<div align='center'>"+ds.getAt(i).get('productNum')+"</div>";   
					 		 var otrrr=pvtable.insertRow();
					 		 var ocel3=otrrr.insertCell(0);
					 		ocel3.innerHTML="<div align='center'>"+ds.getAt(i).get('productValue')+"</div>";   
					 		if(ds.getCount()!=i+1){
					 			ocel1.className="td";
					 			ocel2.className="td";
					 			ocel3.className="td";
					 		 }
					 		 
							productNumTotle+=ds.getAt(i).get('productNum');
							productValueTotle+=ds.getAt(i).get('productValue');
						}
					}
					document.getElementById("productNumT").innerHTML=productNumTotle+" 个";
					document.getElementById("productValueT").innerHTML=productValueTotle+" 万元";
				});
			}
		});
 	}
 	function getPreDate(){
		var date=new Date();
		var year=date.getFullYear()-1;
		return year+"-01-01";
	}
 	//明细页面翻页功能键
	function backPageD(){
		var data = new L5.Map();
		var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheckDetail1.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
		//明细页面翻页功能键
	function nextPage(){
		var data = new L5.Map();
		var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheckDetail3.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	//上一页
	function lastPageD(){
		var data = new L5.Map();
		var url='jsp/ext/welfare/manage/check/prosthesis/fitExtCheckDetail1.jsp';
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
	<model:dataset id="wealFitDeviceDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitDeviceQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitDevice"></model:record>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="wealFitProductivepowerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
		<model:params>
			<model:param name="CERT_CODE@<>" value=''></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="wealWorkerDataSet1" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<model:dataset id="wealWorkerDataSet2" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
	<!-- 设施字典表 -->
	<model:dataset id="deviceDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_FITDEVICE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPageD()"/>
	<input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPageD()"/>
</div>


<form method="post" onsubmit="return false" id="form">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center id="tab"
	border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		
		<TR vAlign=top>
			<TD vAlign=top height=522>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=900 border=0 id="toadd" dataset="wealFitInfoDataSet">
				<tbody>
					<tr>
					    <td width="186" class=unnamed1 height="30" colspan="3"><div align="center">企业名称</div></td>
					    <td colspan="8" class=unnamed5><div align="left">
					     &nbsp;<label  name="企业名称" id="companyName" field="companyName" size=70/>
					    </div></td>
					  </tr>
					  <tr>
					    <td class=unnamed6 height="30" colspan="3"><div align="center" >注册地址</div></td>
					    <td colspan="3" class=unnamed2><div align="left">
					      &nbsp;<label  name="注册地址" style="width:120px" id="address" field="address" size=50/>
					    	</div>
					    </td>
					    <td class=unnamed2 height="30" colspan="2"><div align="center" >邮编</diouv></td>
					    <td colspan="3" class=unnamed2><div align="left">
					     &nbsp;<label  name="邮编" id="postCode" field="postCode"  />
					    	</div>
					    </td>
					    
					    
					  </tr>
					  <!-- 法人代表 身份证号 -->
					  <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">法人代表</div></td>
					  	<td colspan="3" class=unnamed2>
					  		&nbsp;<label  name="法人代表" id="legalPeople" field="legalPeople"/>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">身份证号</div></td>
					  	<td colspan="3" class=unnamed6>
					  		&nbsp;<label  name="身份证号" id="legalIdCard" field="legalIdCard"size="40"/>
					  	</td>
					  </tr>
					  <!-- 固定电话 手机 -->
					   <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">固定电话</div></td>
					  	<td colspan="3" class=unnamed2>
					  		&nbsp;<label  name="固定电话" id="legalPhone" field="legalPhone"/>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">手&nbsp;机</div></td>
					  	<td colspan="3" class=unnamed6>
					  		&nbsp;<label  name="手机" id="legalTelphone" field="legalTelphone"/>
					  	</td>
					  </tr>
					  <!-- 电子邮箱 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3" ><div align="center">电子邮箱</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      &nbsp;<label  name="电子邮箱" id="legalEmail" field="legalEmail" size=50/>
					    </div></td>
					  </tr>
					   <!-- 经办人   身份证号  固定电话 手机-->
					     <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">经&nbsp;办&nbsp;人</div></td>
					  	<td colspan="3" class=unnamed2>
					  		&nbsp;<label  name="经办人" id="agentPeople" field="agentPeople"/>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">身份证号</div></td>
					  	<td colspan="3" class=unnamed6>
					  		&nbsp;<label  name="身份证号" id="agentIdCard" field="agentIdCard" size="40"/>
					  	</td>
					  </tr>
					  <!-- 固定电话 手机 -->
					   <tr>
					  	<td colspan="3" class=unnamed6 height="30"><div align="center">固定电话</div></td>
					  	<td colspan="3" class=unnamed2>
					  		&nbsp;<label  name="固定电话" id="agentPhone" field="agentPhone"/>
					  		
					  	</td>
					  	<td colspan="2" class=unnamed3 height="30"><div align="center">手&nbsp;机</div></td>
					  	<td colspan="3" class=unnamed6>
					  		&nbsp;<label  name="手机" id="agentTelphone" field="agentTelphone"/>
					  	</td>
					  </tr>
					  <!-- 电子邮箱 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3"><div align="center">电子邮箱</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      &nbsp;<label  name="电子邮箱" id="agentEmail" field="agentEmail" size=50/>
					    </div></td>
					  </tr>
					 <!-- 网站地址 -->
					  <tr>
					  	<td class=unnamed6 height="30" colspan="3"><div align="center">网站地址</div></td>
					    <td colspan="8" class=unnamed2><div align="left">
					      &nbsp;<label  name="网站地址" id="webAddress" field="webAddress" size=50/>
					    </div></td>
					  </tr>
					  <tr>
					    <td class=unnamed6 height="30" colspan="3"><div align="center">经济性质</div></td>
					    <td colspan="3" class=unnamed2>
					    &nbsp;<label   id="economicNatureCode" field="economicNatureCode" dataset="ecoDataSet" size=50/>
					    </td>
					    <td class=unnamed3 height="30" colspan="2"><div align="center">组织机构代码</div></td>
					    <td colspan="3" class=unnamed6>
					      &nbsp;<label  name="组织机构代码" id="organCode" field="organCode" size=50/>
					    </td>
					    
					    <tr>
					    <td class=unnamed6 colspan="3" height="30" ><div align="center">营业执照编号</div></td>
					    <td colspan="3" class=unnamed2>
					      &nbsp;<label  name="营业执照编号" id="licenseCode" field="licenseCode" />
					   </td>
					    
					    <td colspan="2" class=unnamed3 height="30" ><div align="center">税务登记编号</div></td>
					    <td colspan="3" class=unnamed6>&nbsp;<label  name="税务登记编号" id="registrationCode" field="registrationCode" /></td>
					  </tr>
					  <tr>
					  	<td colspan="3" class=unnamed6 height="30" ><div align="center">注册资金(万元)</div></td>
					    <td colspan="8" class=unnamed2>&nbsp;<label  name="注册资金" id="regFund" field="regFund" /></td>
					  </tr>
					  
					   <tr>
					  	<td colspan="3" class=unnamed6 height="30" ><div align="center">经营范围</div></td>
					    <td colspan="8" class=unnamed2>&nbsp;<label type="text" vname="经营范围" id="businessScope" field="businessScope" style="width:70%" /><font color="red">*</font></td>
					  </tr>
						
					 <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">总经营面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed2>
						  		&nbsp;<label  name="总经营面积" id="operateArea" field="operateArea"/>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">制作间面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed6>
						  		&nbsp;<label  name="制作间面积" id="productArea" field="productArea"/>
						  	</td>
						  </tr> 	
						  
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">康复室面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed2>
						  		&nbsp;<label  name="康复室面积" id="recoveryArea" field="recoveryArea"/>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">接待室面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed6>
						  		&nbsp;<label  name="接待室面积" id="receptionArea" field="receptionArea"/>
						  	</td>
						  </tr> 
						  
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">训练厅面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed2>
						  		&nbsp;<label  name="训练厅面积" id="trainArea" field="trainArea"/>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3 height="30" ><div align="center">理疗室面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed6>
						  		&nbsp;<label  name="理疗室面积" id="treatmentArea" field="treatmentArea"/>
						  	</td>
						  </tr> 
						   <tr>
						  	<td colspan="3" class=unnamed6 height="30" ><div align="center">办公面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed2>
						  		&nbsp;<label  name="办公面积" id="workArea" field="workArea"/>
						  		
						  	</td>
						  	<td colspan="2" class=unnamed3  ><div align="center">休闲区面积（㎡）</div></td>
						  	<td colspan="3" class=unnamed6>
						  		&nbsp;<label  name="休闲区面积" id="leisureArea" field="leisureArea"/>
						  	</td>
						  </tr>				
						   <tr>
						  	<td class=unnamed6 height="30"  colspan="3"><div align="center">其&nbsp;它（㎡）</div></td>
						    <td colspan="8" class=unnamed2><div align="left">
						      &nbsp;<label  name="其它" id="otherArea" size=50 field="otherArea"/>
						    </div></td>
						  </tr>
						  
							 <tr >
							    <td  rowspan="2" class=unnamed6 height="30" colspan="2"><div align="center">职工人数<br></div></td>
							    <td colspan="3" class=unnamed2 height="30"><div align="center">合计</div></td>
							    <td colspan="2" class=unnamed3 height="30"><div align="center">非生产人员</div></td>
							    <td colspan="2" class=unnamed6 height="30"><div align="center">生产人员</div></td>
							    <td colspan="2" class=unnamed2 height="30"><div align="center">其中残疾职工</div></td>
							  </tr>
							  <tr>
							    <td colspan="3" class=unnamed2 height="30"><div align="center">
							      &nbsp;<label  name="合计" id="totalNum" />
							    </div></td>
							    <td colspan="2" class=unnamed3 align="center" height="30">&nbsp;<label  name="非生产人员" id="noProNum" /></td>
							    <td colspan="2" class=unnamed6 align="center">&nbsp;<label  name="生产人员" id="proNum" /></td>
							    <td colspan="2" class=unnamed2 align="center">&nbsp;<label  name="残疾职工" id="disNum" /></td>
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
							    	&nbsp;
							    </div></td>
							 	 
							  </tr>
							 <!-- 添加按钮 -->
							 <tr >
							  	
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
							    	&nbsp;
							    </div></td>
							 	 
							  </tr>
							 <!-- 添加按钮 -->
							 <tr >
							  	
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
							    	&nbsp;
							    </div></td>
							 	
							  </tr>
							  
							  <tr >
							    <td colspan="2" class=unnamed6 height="30"><div align="center"><table id="tzs1" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2 ><div align="center"><table id="tzs2" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2 ><div align="center"><table id="tzs3" style="width:100%;height:100%"></table></div></td>
							    <td colspan="3" class=unnamed2><div align="center"><table id="tzs4" style="width:100%;height:100%"></table></div></td>
							  </tr>
							  
							  
							  
								
							  <tr>
							    <td colspan="11" class=unnamed6 height="30"><div align="left">装配假肢矫形器基本设施</div></td>
							  </tr>			
							 <tr>
							 	<td colspan="8" class=unnamed6 height="30"><div align="center">名称</div></td>
							 	<td colspan="3" class=unnamed2 height="30"><div align="center">数量(个)
							 		&nbsp;
							 	</div></td>
							 	
							 </tr>
						  	
						  	<!-- 按钮添加 -->
						  	 <tr>
							 	<td colspan="8" class=unnamed6 height="30"><div align="center"><table id="tjb1" style="width:100%;height:100%"></table></div></td>
							 	<td colspan="3" class=unnamed2 height="30"><div align="center"><table id="tjb2" style="width:100%;height:100%"></table></div></td>
							 	
							 </tr>
					<tr>
					    <td rowspan="8" class=unnamed6 colspan="2"><div align="center">主<br />要<br />产<br />品<br /></div></td>
					    <td colspan="4" class=unnamed2 rowspan="2"><div align="center">产品名称</div></td>
					    <td colspan="6" class=unnamed2 height="30"><div align="center">年生产能力</div>
					    	<tr>
					    		<td class=unnamed2 height="30" colspan="2"><div align="center">数量</div></td>
					    		<td class=unnamed2 colspan="3"><div align="center">产值（万元）</div></td>
					    	</tr>
					    </td>
					</tr>
					<tr>
					  	<td colspan="4" class="unnamed2" ><div align="center">(合计)</div></td>
					  	<td colspan="3" class="unnamed2"><div align="center">&nbsp;<label  name="数量" id="productNumT" /></div></td>
					  	<td colspan="3" class="unnamed2"><div align="center">&nbsp;<label  name="产值" id="productValueT" /></div></td>
					</tr>
					<tr>
					  	<td colspan="4" class="unnamed2"><div align="center"><table id="pntable" style="width:100%;height:100%"></table></div></td>
					  	<td colspan="2" class="unnamed2"><div align="center"><table id="pnnumtable" style="width:100%;height:100%"></table></div></td>
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
	<input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPageD()"/>
	<input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPageD()"/>
</div>
</body>
</html>
