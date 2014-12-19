<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />

<title>社会组织查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script language="javascript">
	function init(){
		var sorgCode = parent.document.myform.sorgCode.value;
		var cnName = parent.document.myform.cnName.value;
		somChangeDataSet.setParameter("SORG_CODE",sorgCode);
		somChangeDataSet.setParameter("CN_NAME",cnName);
		somChangeDataSet.setParameter("IF_BRANCH","0");
		somChangeDataSet.setParameter("MORG_AREA","370000000000");
		somChangeDataSet.setParameter("SORG_STATUS","22");
		somChangeDataSet.load();
		somChangeDataSet.on("load",function(ds){
			//alert(ds.getPageSize());
			document.getElementById("totalNum").innerHTML=ds.getTotalCount()+" 个";
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
	}
	
	function turnNext(){
		somChangeDataSet.turnNext();
	}
	function turnPre(){
		somChangeDataSet.turnPrev();
	}
	function turnLast(){
		somChangeDataSet.turnLast();
	}
	function turnFirst(){
		somChangeDataSet.turnFirst();
	}
	function turnPage(){
		somChangeDataSet.turnPage(document.getElementById("to_page").value);
	}
	
	function onSubmit(){
		somChangeDataSet.setParameter("IF_BRANCH@=","0");
		somChangeDataSet.setParameter("MORG_AREA@=","370000000000");
		somChangeDataSet.setParameter("CN_NAME@LIKE","%"+document.getElementsByName("cnName")[0].value+"%");
		somChangeDataSet.setParameter("SORG_CODE@=",document.getElementsByName("sorgCode")[0].value);
		somChangeDataSet.setParameter("SORG_TYPE@=",document.getElementsByName("sorgType")[0].value);
		somChangeDataSet.load();
		somChangeDataSet.on("load",function(ds){
			//alert(ds.getPageSize());
			document.getElementById("totalNum").innerHTML=ds.getTotalCount()+" 个";
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
	}

   
</script>
<script> 
	function SetWinHeight(obj)
{
	
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        {
            if (win.contentDocument && win.contentDocument.body.offsetHeight) 

                win.height = win.contentDocument.body.offsetHeight; 
            else if(win.Document && win.Document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight;
        }
    }
}
</script>
<body>

<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somChangeDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand" global="true" method="queryChangeInfo" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange">
			<model:field name="CN_NAME" type="string" />
			<model:field name="SORG_CODE" type="string" />
			<model:field name="CHANGE_ITEM" type="string" />
			<model:field name="CHANGE_BEFORE" type="string" />
			<model:field name="CHANGE_AFTER" type="string"/>
			<model:field name="AUDIT_TIME" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>	

<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd">
  <tr class="word-22">
    <td width="30%"  height="35" align="center" valign="middle" bgcolor="#d5e4eb">名称</td>
    <td width="20%"  align="center" valign="middle" bgcolor="#d5e4eb">变更类型</td>
    <td width="18%"  align="center" valign="middle" bgcolor="#d5e4eb">变更前</td>
    <td width="22%" align="center" valign="middle" bgcolor="#d5e4eb">变更后</td>
    <td width="10%" align="center" valign="middle" bgcolor="#d5e4eb">批准时间</td>
  </tr>
</table>
<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd"  dataset="somChangeDataSet">
  <tr  repeat="true" class="word-22">
    <td width="30%" height="35" align="center" valign="middle" bgcolor="#FFFFFF"><label field="CN_NAME" /></td>
    <td width="20%" align="center" valign="middle" bgcolor="#FFFFFF"><label  field="CHANGE_ITEM"/></td>
    <td width="18%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="CHANGE_BEFORE" /></td>
    <td width="22%" align="center" valign="middle" bgcolor="#FFFFFF">
	<label field="CHANGE_AFTER" /></td>
    <td width="10%" align="center" valign="middle" bgcolor="#FFFFFF">
    <label field="AUDIT_TIME"/></td>
  </tr>
</table>
<div class="bscx-div-8">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="41%" height="40" align="left">共有 <label id="totalNum" /></td>
        <td width="59%" align="right">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="page">
				<tr>
					<form name="searchOrgForm" action="searchOrgList.do?action=searchOrgList" method="post">
						<td align="left">
							<input type="hidden" name="orgName" value="">    	        
							<input type="hidden" name="corporateType" value="">
							<input type="hidden" name="managerDeptCode" value="">
							<input type="hidden" name="registrationNo" value="">
							<input type="hidden" name="page_flag" value="true">
							<input type="hidden" name="pagesize_key" value="result">
							<input type="hidden" name="goto_page" value="">
							<input type="hidden" name="current_page" value="1">
							<input type="hidden" name="total_count" value="2136">
							<td align="right">
								&nbsp;<a href="#" onclick="turnFirst()">首页</a>&nbsp;|&nbsp;<a href="#" onclick="turnPre();">上页</a>&nbsp;|&nbsp;<a href="#" onclick="turnNext();">下页</a>&nbsp;|&nbsp;<a href="#" onclick="turnLast();">末页</a>&nbsp;&nbsp;第<label id="currentPageNum" />&nbsp;转到<input type="text" id="to_page" size="2">页<button onclick="turnPage();">-&gt;</button>
							</td>
						</td>
					</form>
				</tr>
			</table>
 		</td>
      </tr>
</table>
</div>
</body>
</html>
