var isCreateRC = false;
function init(){
	var fisColumnInfoDataSet=L5.DatasetMgr.lookup("fisColumnInfoDataSet");
	fisColumnInfoDataSet.setParameter("PAGE_ID", "cremationFuneral71");
	
	
	var currentT = document.getElementById("currentT");
	
	fisColumnInfoDataSet.on('load',function(){
		if(fisColumnInfoDataSet.getCount()>0) {
			for(var i=0; i<fisColumnInfoDataSet.getCount(); i++) {
				fisColumnInfoDataSet.getAt(i).get
				
				if(!isCreateRC) {
					createRowCol("currentT",17,9);
					isCreateRC = true;
				}
			}
		}
	});
	//currentT
	fisColumnInfoDataSet.load();
}

//对table追加指定数量的行和列
function createRowCol(tableName, rows, cols) {
	var table = document.getElementById(tableName);
	for (var i = 0; i < rows; i++) {
		var tempRow = table.insertRow(-1); // 行
		for (var j = 0; j < cols; j++) {
			var td = document.createElement("td");
			td.id = i + "TD" + j;
			tempRow.appendChild(td);
		}
	}
}


function query(){
	var fisColumnInfoDataSet=L5.DatasetMgr.lookup("fisColumnInfoDataSet");
	fisColumnInfoDataSet.setParameter("PAGE_ID", "cremationFuneral71");
	fisColumnInfoDataSet.load();
}




function exportExcel(){
}