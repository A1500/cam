var pieData = value = "<pieSource>";
function init() {
//	fisCremationInfoSumDs.on('load',function(){
//		alert(fisCremationInfoSumDs.getCount())
//	});
//	fisCremationInfoSumDs.load();
	
	var fisFuneralDeadInfoDS = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS");
	fisFuneralDeadInfoDS.setParameter("qPopulace", "370000000000");
	fisFuneralDeadInfoDS.setParameter("qStartTime", "2013-01-01");
	fisFuneralDeadInfoDS.setParameter("qEndTime","2013-12-31");
	fisFuneralDeadInfoDS.on('load',function(){
		if(fisFuneralDeadInfoDS.getCount()>1) {
			for(var i=1;i<fisFuneralDeadInfoDS.getCount(); i++) {
				var rec = fisFuneralDeadInfoDS.getAt(i);
				pieData+="<root key=\""+rec.get("NAME")+"\">";
				pieData+="<node field=\"0至35岁\" value=\""+rec.get("NUM36")+"\" />";
				pieData+="<node field=\"36至49岁\" value=\""+rec.get("NUM50")+"\" />";
				pieData+="<node field=\"50至59岁\" value=\""+rec.get("NUM60")+"\" />";
				pieData+="<node field=\"60至69岁\" value=\""+rec.get("NUM70")+"\" />";
				pieData+="<node field=\"70至79岁\" value=\""+rec.get("NUM80")+"\" />";
//				pieData+="<node field=\"80至89岁\" value=\""+rec.get("NUM90")+"\" />";
				pieData+="<node field=\"80岁以上\" value=\""+rec.get("NUM100")+"\" />";
				pieData+="</root>";
			}
		}
		pieData+="</pieSource>";
		_tId = 'main2';
		_tData = pieData;
		tRenderPieChart();
	});
	fisFuneralDeadInfoDS.load();
	
	initFis();
}

function initFis() {
	var ops = {
		height : 527,
		nowrap : true,
		autoRowHeight : false,
		striped : true,
		sortName : 'code',
		sortOrder : 'desc',
		loader : dcLoader,
		url : '/command/ajax/com.inspur.cams.fis.base.cmd.FisCremationInfoSumQueryCommand/queyAllSum',
		remoteSort : false,
		idField : 'DIM',
		frozenColumns : [[{
					field : 'ORGAN_NAME',
					title : '地区',
					width : 50
				}]],	
		columns : [[
				{
					title : '<font style="font-weight: bold;">殡仪馆</font>',
					colspan : 7
				}, {
					title : '<font style="font-weight: bold;">公墓</font>',
					colspan : 4
				}
		        ],[
				{
					field : 'B_NUMS',
					title : '单位数(个)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_PERSON',
					title : '职工人数(人)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATION_MACHINE',
					title : '火化炉数(台)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATIONS',
					title : '处理遗体数(具)',
					width : 120,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATIONS_RATE',
					title : '火化率(％)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_EMPLACING',
					title : '穴位数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CEMETERY',
					title : '安葬数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_NUMS',
					title : '单位数(个)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_PERSON',
					title : '职工人数(人)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_EMPLACING',
					title : '穴位数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_CEMETERY',
					title : '安葬数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}]],
		pagination : false,
		rownumbers : true
	};
	$('#nongcun').datagrid(ops);
//	$('#nongcun').datagrid('load');//Grid列表数据加载
}
//获取项目根路径
function getProjectName(){
	var curWwwPath=window.document.location.href;
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	var localhostPaht=curWwwPath.substring(0,pos);
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	return projectName;
}