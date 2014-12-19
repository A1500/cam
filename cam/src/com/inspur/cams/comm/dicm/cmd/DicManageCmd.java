package com.inspur.cams.comm.dicm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.data.DicManage;
import com.inspur.cams.comm.dicm.domain.IDicManageDomain;


/***
 * 字典信息维护command
 * @author luguosui
 * @date 2011-8-31
 */
public class DicManageCmd extends BaseAjaxCommand {
	
	@Reference
	private IDicManageDomain dicManageDomain=ScaComponentFactory.getService(IDicManageDomain.class, "DicManageDomain/DicManageDomain");

	public void insert(){
		Record record=(Record)getParameter("record");
		DicManage dicManage=(DicManage)record.toBean(DicManage.class);
		dicManageDomain.insert(dicManage);
	}
	
	public void save(){
		Record[] records=(Record[])getParameter("records");
		List<DicManage> list =new ArrayList<DicManage>();
		
		for(int i=0;i<records.length;i++){
			DicManage dicManage=(DicManage)records[i].toBean(DicManage.class);
			list.add(dicManage);
		}
		dicManageDomain.save(list);
	}
	
	public void update(){
		Record record = (Record)getParameter("record");
		DicManage dicManage=(DicManage)record.toBean(DicManage.class);
		dicManageDomain.update(dicManage);
	}
}
