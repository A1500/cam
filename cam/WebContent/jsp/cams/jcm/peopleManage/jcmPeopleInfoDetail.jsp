<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>人员基本信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<%
	String peopleId = request.getParameter("peopleId");
	if(peopleId==null){
		peopleId = IdHelp.getUUID32();
	}
%>
<script type="text/javascript" src="jcmPeopleInfo.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleId='<%=peopleId%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
		<model:dataset id="jcmPeopleResumeDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleResumeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleResume"/>
	</model:dataset>
	<model:dataset id="jcmPeopleCompanyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleCompanyQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleCompany"/>
	</model:dataset>
	<model:dataset id="jcmPeopleExamDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleExamQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleExam"/>
	</model:dataset>
	
	
</model:datasets>
<next:Panel width="100%"  >
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>

<next:Panel title ="人员基本信息" width="100%" >
<next:Html>
<form id="form1" method="post" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:15%">姓名：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="姓名" id="peopleName" field="peopleName" maxlength="50" >李伟</label></td>
			<td class="FieldLabel" style="width:15%">性别：</td>
			<td class="FieldInput" style="width:18%" colspan="2" ><label  name="性别" id="peopleSex" field="peopleSex" maxlength="50" >男
			</label></td>
			<td  rowspan="4" >
				<IMG alt="" align="middle" src="data:image/jpg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAHwAaAMBEQACEQED
EQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAE
EQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZH
SElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1
tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAA
AAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGh
scEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlq
c3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV
1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AP7tpBFOty1uw3I0DGea33ShXJtw
d0ki4hDQsxA/eDg4Lgg6f1+m39d99Trcbdb9E1Lqm7tK3purWcdXrest7KrXVnceVGGjMInijb7I
tzE5dZPKkAKxzRBMEBiZGycKxYgL7v1+6/8AKvw7aIk2n3lxazhYHjwqSzNNDbXFvKBh0kSV1QFT
kFY2YAk4dsih/wBf1/Xq3dhLSEtN4xWtm/jlrdd7dbvvsk44rCAJdyCRku4XDNNJLOq3ABY42eWZ
SCFxwjNhnCxs2RQcfWXr2fd+Wu977avtd3ltfL8uNZpXsrpSUN9O8piuEzIWjgCFthZP3YOGUnJA
2k0Jtp3to9LX26LVvpr+vfKp9n0l+S9P66PYlQXEjQsoluJIJY4UnvRBb2ZyzggfvPtDrgDCeWXI
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
6vtlAeWNGLGByi+WDgqxUkHbz+bYn3JtQ922yvu3zLa3k31eq30v/RGX4istKlWUldc15P3bOpZ3
1fS3oo3XvIv+MPhD4Y8fTrqt7YWj3sITa8+HknfEjFXcKZDlPvFjt2g9ASWmlJtXu76ba9ddb9H0
7+Z95kvETyOtLEwXv1YKk5JdOeTW7Wzt83bVqN/PW/Z80drm4hTwvoFpZ3cKRT3CxCXa8fmLlt0G
YmbLHHV+ufkye7DylZ3nO9lZ3d7Rc1rr2ty2vu7tLmb+mxHiPOVCXMr90+7c+qbWqSbvvK6e0r+w
+BvBPhX4Z6NdJoFnY6c4RhfOFSCG5YDJYDYpbJjUA84zkNgc9TSdNuXvS3d32c0lpfXZ66ttXi2n
f86zPiGlmmMeIqQSSpwgr2bsnO7avfVOLd7aJKzs72fCus6v8RvGOneFPD0kU00soSS4kfzI7O13
urMxOeMqSn+yAMAZFelleG9q3eN7ab36uz3vaV79Gktdk3+ecS57TwkZ+xl7LRWcJWtq7cratZNt
zW6vGOurP128AeErfwX4U0nw9bv5xsYB585+5dXszebcSgAqXUy7/KyeI+Pm2/N9LaMI8kFGyS20
u1zJvdtbJbXSXV8zPwnG4p4qtWq1ZKftJPdvRc9R/e2/efl35mdlk7jhjgDPU8HLnIUZxnjr3IHb
nDmlz/F/y8UbXT0vJNWtZaLpo21reJ5sLqpaN1TveSVukp21Te9lp1T1bd7q8mxWdicZAKkcAEsD
nnA6ADGSCQ3OTna/n0T20u3pbW/S+vybszWbS6Jta6Rv/NqveV1yxbfVabNNFN497CWLKEcvsLK8
iEMAqnrncA5Hpg/MCMVTa99NWultvv27e70duibs2+JtKT5dOjafxWcrNWb9fRx1umyjFDa28Hlx
IYUt1SS1mjDPKI2UoSsQLM8zuHVouSAFLDgmlZ66bb76bJXdnrqr311Wj3foc8pylzXutNW3dd/w
0eu713K8l1MI3Z5Uto8qkkXEc5Z3ZYt0knAkuAN/l/fDMUALK4oBJvbX0T/zf3dO7Pi79sf9qLwP
+zD8JvGHxD8QPHM3huweXTtMlYefquu3DSta+GblDIrY1YYlUKBJKpLRBlCtW2GpqtKShapNWTjF
Nu99VpK94/a1u7q7V0OPuYXEOTStsnpza1Lbvzv6p3b3X8q37JXjD41/t3/Hr4q/tZ/GDXdUn8Gf
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
pLgPKmm6VYs5kCsk91dRoHjHmv8As/D+Dn7OLSSa5ZKTdus03a1ndrZdGm20kfz/AJ/joYqvUSnt
J6ylLfml52vZK6bbs2m7qTf4PzXc1rFC13JPOW3HykK+aBveM5CSEBi2Odxwu/uDX0/sa3NJOzSd
+a2u8tV9ppqz62b10jFv42pGilJcqvZNtvduU03a7avZecm4au13qfDz4jeKfhn40tr/AE3UNR03
yJ1mjutN1W703UI081ygS6spLWdoh1M0csUwONrYDU/ZKFOpzwlNdlF6x9+0d/m9t4rVpHnwTVaM
4raULLW28rJWae93v5aXufuj+zp/wVy/aT+HUVlpWoeMdR8aaDbi1WPTPF8tnqXlWaYUR22qNGNR
i8sfMpe4kJz+88wEiuSODo4iLcYtaRb5lbdz952VtY20eis95N39B4iaTbf3XvvNX3dl7m215RX2
W3/Vp+w7+07b/tSfBrSPHuoWR0i/uNQ1nRbvT4tclu7aS50i5t0mmtRJBGQrm4UxIXLCMS7o1yCf
ns2wcaEYyj7NJySsoWkpJzTbkmrqVrWSetrNta3SzCEZctTmtKSimmkvtttXTUHdavqr2XNdP8Tf
+C/+gNqHwt+FpWK6tZ4PiDqYOnaex/syGKTwzfxERQ4/1vHmyqG+fezYzknyMs/iP1tfrtK11fTy
6/Fq7H6hn6SVlq/ZrV3b0crX3stE7rZuV009f5G4Ph7cJBeahLGskstz5cTiOWHesUjQEIkg3ll8
sq6kY8xW+Yr81faRfuei9PtVPN269XutXZt/n7/iy30W/wAmlpd6txvfe11e61sP4GuRc20z2l2s
ce1rXymLF590hclAg8vIyduSyjjecgVcadKSu4puSV79W+dN9/O73u9Wua+yquMVFW6LdLZyf33l
8nfqrv8AXH/glx4+1j4R/tC+GLG4a+07Q/H+oWHhHXT5UywM8t3E3hy/Mu1RGzXrjcMfu0O0SsFb
dniKFOWHrpRV3SasrPS9S17pvX3bPeyWrestKFSXtIxppc3Mre87prmaVubu09btXbak7M/sa8Se
HbX4h6a2k2mj39jc6NfLqGl67cxrZzy3kKpbXNta2rnc2ntLKkTATFXWQzso2Mtfm+YZanGSUZbd
b33e7aVk9V11cld/EfpnD2c1MHUgqkn9m97xWvNGy169LNp6u7suXH0bwjrMcx03U4p47nYBeNNM
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
tfS+nz3vp//Z"/>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">身份证号：</td>
			<td class="FieldInput" style="width:18%"><label type="text" style="width:150" name="身份证号" id="peopleCard" field="peopleCard" maxlength="18" >330784192707125917</label></td>
			<td class="FieldLabel" style="width:15%">出生年月：</td>
			<td class="FieldInput" style="width:18%" colspan="2" ><label type="text"  name="出生年月" id="peopleBirthday" field="peopleBirthday" maxlength="50" >1927-07-12</label></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">政治面貌：</td>
			<td class="FieldInput" style="width:18%"><label   name="政治面貌" id="peoplePolitics" field="peoplePolitics" maxlength="50" >党员
				</label>
			</td>
			<td class="FieldLabel" style="width:15%">民族：</td>
			<td class="FieldInput" style="width:18%" colspan="2" ><label   name="民族" style="width:150" id="peopleNation" field="peopleNation" maxlength="50" >汉族
				</label>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">邮编：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="邮编" id="peopleEdu1" field="peopleEdu" maxlength="50">250000
			</label></td>
			<td class="FieldLabel" style="width:15%">联系电话：</td>
			<td class="FieldInput" style="width:18%" colspan="2" ><label type="text" name="联系电话" id="peopleEdu2" field="peopleEdu" maxlength="50">15820099001
			</label></td>
			
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">学历：</td>
			<td class="FieldInput" style="width:20%"><label type="text"  name="学历" id="peopleEdu3" field="peopleEdu" maxlength="50">硕士
			</label></td>
		
			<td class="FieldLabel" style="width:15%">专业：</td>
			<td class="FieldInput" style="width:18%"><label type="text"  name="专业" id="peopleEd2u" field="peopleEdu" maxlength="50">航天工程
			</label></td>
			<td class="FieldLabel" style="width:15%">文化程度：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="文化程度" id="peop3leEdu" field="peopleEdu" maxlength="50">硕士
			</label></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:15%">婚姻状况：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="婚姻状况" id="peopl4eEdu" field="peopleEdu" maxlength="50">已婚
			</label></td>
			<td class="FieldLabel" style="width:15%">毕业院校：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="毕业院校" id="peopleSchool" field="peopleSchool" maxlength="50" >清华大学</label></td>
			<td class="FieldLabel" style="width:18%">参加工作时间：</td>
			<td class="FieldInput" style="width:18%" ><label type="text" style="width:150" name="参加工作时间"  id="jobStartTime" field="jobStartTime" maxlength="50" >1930-09-01</label></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:18%" colspan="5"><label  type="text" style="width:100%" name="家庭住址" id="peopleAdress" field="peopleAdress"  >济南市历下区</label></td>
		</tr>
	</table>
</fieldset>
</form>

</next:Html>
</next:Panel>
<next:Panel title ="任职信息" width="100%" >
<next:Html>
	
<form id="form2" method="post"  onsubmit="return false" class="L5form">
<fieldset>
	<legend>任职信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:15%">部门：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="部门" id="peopleDepartment" field="peopleDepartment" maxlength="50" >婚姻登记处</label></td>
			<td class="FieldLabel" style="width:18%">职务：</td>
			<td class="FieldInput" style="width:18%"><label  name="职务" id="companyDuty" field="companyDuty" maxlength="50" >登记员
			</label></td>
			<td class="FieldLabel" style="width:18%">职称：</td>
			<td class="FieldInput" style="width:18%"><label type="text" style="width:150" name="职称" id="jobTitle" field="jobTitle" maxlength="50" />助理</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">房间号：</td>
			<td class="FieldInput" style="width:18%"><label type="text"  name="房间号" id="roomsNum" field="roomsNum" maxlength="50" />3001</td>
			<td class="FieldLabel" style="width:15%">人员编制性质：</td>
			<td class="FieldInput" style="width:18%"><label   name="人员编制性质" id="establishment" field="establishment" maxlength="50" >全供事业编制
				</label>
			</td>
			<td class="FieldLabel" style="width:18%">任职时间：</td>
			<td class="FieldInput" style="width:18%"><label   name="任职时间" style="width:150" id="dutyTime" field="dutyTime" maxlength="50" >2000-01-01
				</label>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">岗位状态：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="岗位状态" id="jobStatus" field="jobStatus" maxlength="50">在岗
			</label></td>
			<td class="FieldLabel" style="width:15%">专业资格：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="专业资格" id="qualification" field="qualification" maxlength="50" /></td>
		
			<td class="FieldLabel" style="width:15%">任职文号：</td>
			<td class="FieldInput" style="width:18%"><label type="text" name="任职文号" id="dutyNum" field="dutyNum" maxlength="50" />J20000102009</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">任职状态：</td>
			<td class="FieldInput" style="width:18%" colspan="5"><label type="text" style="width:150" name="任职状态"  id="dutyStatus" field="dutyStatus" maxlength="50" /></td>
		</tr>
		
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="resumeGrid" title="人员简历信息" dataset="jcmPeopleResumeDataSet" width="100%" stripeRows="true" height="300">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleId" header="人员主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="resumeId" header="简历主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="timeInfo" header="时间段" width="20%" sortable="false">
		</next:Column>
		<next:Column field="unit" header="单位" width="20%" sortable="false">
		</next:Column>
		<next:Column field="duitInfo" header="任职情况" width="20%" sortable="false">
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleResumeDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>


<next:EditGridPanel title="人员培训信息" id="examGrid" dataset="jcmPeopleExamDataSet" width="100%" stripeRows="true" height="300">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleExamId" hidden="true" header="培训主键" width="15%" sortable="false"></next:Column>
		<next:Column field="peopleId" hidden="true" header="人员主键" width="15%" sortable="false"></next:Column>
		<next:Column field="examYear" header="培训年度" width="15%" sortable="false"></next:Column>
		<next:Column field="examContent" header="培训内容" width="15%" sortable="false"></next:Column>
		<next:Column field="examTime" header="培训时间" width="15%" sortable="false"></next:Column>
		<next:Column field="examPlace" header="培训地点" width="15%" sortable="false"></next:Column>
		<next:Column field="isExam" header="是否考试" width="15%" sortable="false"></next:Column>
		<next:Column field="examRuslut" header="考试结果" width="15%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleExamDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

</next:Panel>
</body>
</html>