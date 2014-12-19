<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>优抚对象定期认证</title>
<next:ScriptManager />
	<script>
		var peopleId="<%=request.getParameter("peopleId")%>";
		var objectType="<%=request.getParameter("objectType")%>"
	</script>
<script type="text/javascript" src="reguIdenti_apptable.js"></script>
</head>
<body>
<%
	int objectType = Integer.parseInt(request.getParameter("objectType"));//优抚类别ID
	String typeCode = null;//方法名
	String docpath = null;//模板地址
	
	if(objectType == 11){//残疾军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
		
	}if(objectType == 12){//伤残国家机关工作人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
		
	}if(objectType == 13){//伤残人民警察
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
		
	}if(objectType == 14){//伤残民兵民工
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}if(objectType == 15){//因战因公伤残人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityZG_apptable.doc";
		
	}if(objectType == 21){//烈士家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantLS_apptable.doc";
		
	}if(objectType == 22){//因公牺牲军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantYG_apptable.doc";
	
	}if(objectType == 23){//病故军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantBG_apptable.doc";
		
	}if(objectType == 41){//在乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilized_apptable.doc";
		
	}if(objectType == 42){//带病回乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilizedIllness_apptable.doc";
		
	}if(objectType == 51){//参战
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/war_apptable.doc";
		
	}if(objectType == 61){//参试
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/tested_apptable.doc";
		
	}
	
%>
<input type="hidden" id="docpath" value="<%=docpath %>"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="<%=request.getParameter("objectType")%>" />
</body>  
</html> 
