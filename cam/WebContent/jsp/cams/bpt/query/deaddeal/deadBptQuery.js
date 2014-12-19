var ops;
function init() {
	/*byorgands.load();
	byorgands.setParameter("organCode","370000000000");
	byorgands.on('load',initChange);*/
	bymonthds.setParameter("organCode",organCode);
	bymonthds.load();
	bymonthds.on('load',initMarryYearChart);
	initChange();
}

function initMarryYearChart(){
	var chart;
	 chart = new Highcharts.Chart({
         chart: {
             renderTo: 'chart',
             type: 'column',
             margin: [ 50, 50, 100, 80]
         },
         title: {
             text: '火化未注销优抚对象情况'
         },
         xAxis: {
             categories: [
                 '3个月内',
                 '3-6个月',
                 '6-9个月',
                 '9-12个月',
                 '一年以上',
             ],
             labels: {
                 rotation: -45,
                 align: 'right',
                 style: {
                     fontSize: '13px',
                     fontFamily: 'Verdana, sans-serif'
                 }
             }
         },
         yAxis: {
             min: 0,
             title: {
                 text: '优抚对象人数 (人)'
             }
         },
         legend: {
             enabled: false
         },
         tooltip: {
             formatter: function() {
                 return '已死亡'+ this.x +'优抚对象共: '+ Highcharts.numberFormat(this.y, 0) +
                     ' 人';
             }
         },
         plotOptions: { 
             series: { 
                 cursor: 'pointer', 
                 events: { 
                     click: function(e) { 
                    	 if(e.point.category=='3个月内'){
                    		 bptObjectDetailMonth("three");
                    	 }else if(e.point.category=='3-6个月'){
                    		 bptObjectDetailMonth("six");
                    	 }else if(e.point.category=='6-9个月'){
                    		 bptObjectDetailMonth("nine");
                    	 }else if(e.point.category=='9-12个月'){
                    		 bptObjectDetailMonth("year");
                    	 }else if(e.point.category=='一年以上'){
                    		 bptObjectDetailMonth("thanyear");
                    	 }
                    	 
                     } 
                 } 
             } 
         }, 
         series: [{
             name: 'Population',
             data: [parseInt(bymonthds.get("D3NUM")), 
                    parseInt(bymonthds.get("D6NUM")),
                    parseInt(bymonthds.get("D9NUM")), 
                    parseInt(bymonthds.get("D12NUM")),
                    parseInt(bymonthds.get("DSNUM"))],
             dataLabels: {
                 enabled: false,
                 rotation: -90,
                 color: '#FF00FF',
                 align: 'right',
                 x: -1,
                 y: 10,
                 style: {
                     fontSize: '12px',
                     fontFamily: 'Verdana, sans-serif'
                 }
             }
         }]
     });
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
function initChange() {
	/*var table ='<table><tr class="datagrid-header" ><td class="datagrid-header-rownumber">&nbsp</td><td class="datagrid-cell">地区</td><td class="datagrid-cell">伤残</td><td class="datagrid-cell">三属</td><td class="datagrid-cell">在乡</td><td class="datagrid-cell">带病</td><td class="datagrid-cell">参战</td><td class="datagrid-cell">参试</td><td class="datagrid-cell">60岁</td><td class="datagrid-cell">老列子女</td></tr>';
	for(var i=0;i<byorgands.getCount();i++){
		table+='<tr><td>'+(i+1)+'</td><td id="organ"><a href="#">'+byorgands.getAt(i).get("ORGAN_NAME")+'</a></td><td><a href="#">'+byorgands.getAt(i).get("DISABILITY");
		table+='</a></td><td><a href="#">'+byorgands.getAt(i).get("DEPENDANT")+'</a></td><td><a href="#">'+byorgands.getAt(i).get("DEMOBILIED");
		table+='</a></td><td><a href="#">'+byorgands.getAt(i).get("DEMOBILIZEDILLNESS")+'</a></td><td><a href="#">'+byorgands.getAt(i).get("WAR");
		table+='</a></td><td><a href="#">'+byorgands.getAt(i).get("TESTED")+'</a></td><td><a href="#">'+byorgands.getAt(i).get("SOLDIER");
		table+='</a></td><td><a href="#">'+byorgands.getAt(i).get("MARTYR")+'</a></td></tr>';
	}
	table+='</table>';
	document.getElementById('change').innerHTML=table;
*/	
	ops = {
			height : 600,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			sortName : 'ORGAN_CODE',
			sortOrder : 'asc',
			loader : dcLoader,
			dim : organCode,
			url : '/command/ajax/com.inspur.cams.bpt.query.cmd.DeadBptObjectQueryCmd/queryDeadBptObjectByOrgan',
			remoteSort : false,
			//idField : 'ORGAN_CODE',
			//frozenColumns : [[]],	
			columns : [[{
						field : 'ORGAN_NAME',
						title : '地区',
						width : 100,
						formatter:diqu
					},{
						field : 'YALL',
						title : '优抚人员合计',
						width : 80,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'all'");
						}
					},{
						field : 'DISABILITY',
						title : '伤残合计',
						width : 55,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'sc'");
						}
					}, {
						field : 'DEPENDANT',
						title : '三属合计',
						width : 55,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'ss'");
						}
					}, {
						field : 'DEMOBILIED',
						title : '在乡复员军人合计',
						width : 105,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'zx'");
						}
					}, {
						field : 'DEMOBILIZEDILLNESS',
						title : '带病回乡军人合计',
						width : 105,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'db'");
						}
					}, {
						field : 'WAR',
						title : '参战人员合计',
						width : 80,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'cz'");
						}
					}, {
						field : 'TESTED',
						title : '参试人员合计',
						width : 80,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'cs'");
						}
					}, {
						field : 'SOLDIER',
						title : '60岁退役士兵合计',
						width : 105,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'ls'");
						}
					}, {
						field : 'MARTYR',
						title : '部分烈士子女合计',
						width : 100,
						align : 'right',
						formatter:function (value,record){
							return renshu(value,record.ORGAN_CODE,"'ll'");
						}
					}]],
			pagination : false,
			rownumbers : true,
			toolbar:[{

				id:'btnadd',

				text:'返回',

				iconCls:'icon-add',

				handler:function(){

					$('#btnsave').linkbutton('enable');
					var oc=ops.dim+'';
					if(oc.substring(4,12)=='00000000'&&organCode.substring(2,12)=='0000000000'){
						rload(oc.substring(0,2)+"0000000000");
					}else if(oc.substring(6,12)=='000000'&&organCode.substring(4,12)=='00000000'){
						rload(oc.substring(0,4)+"00000000");
					}

				}

			}]
		};
	$('#change').datagrid(ops);
	//$('#change').datagrid('load');//Grid列表数据加载
}
function renshu(value,organCode,objectType){
	return '<a href="#"  onclick="bptObjectDetailOrgan('+organCode+','+objectType+')">'+value+'</a>';
}
function diqu(value,record){
	return '<a href="#" onclick="rload('+record.ORGAN_CODE+')">'+value+'</a>';
}
function rload(value){
	ops.dim=value;
	$('#change').data().datagrid.cache="";
	$('#change').datagrid(ops);
	
}

function bptObjectDetailOrgan(organCode,objectType){
	var url=L5.webPath+'/jsp/cams/bpt/query/deaddeal/deadQuery.jsp?organCode='+organCode+'&objectType='+objectType+'&queryType=organCode';
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function bptObjectDetailMonth(time){
	var url=L5.webPath+'/jsp/cams/bpt/query/deaddeal/deadQuery.jsp?time='+time+'&queryType=month&organCode='+organCode;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
