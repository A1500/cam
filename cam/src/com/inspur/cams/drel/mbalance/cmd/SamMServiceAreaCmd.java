package com.inspur.cams.drel.mbalance.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.mbalance.data.SamMServiceArea;
import com.inspur.cams.drel.mbalance.domain.ISamMServiceAreaDomain;
/**
 * 医院入院备案对象属地配置command
 * @author lgs
 *
 */

public class SamMServiceAreaCmd extends BaseAjaxCommand{
	
	private ISamMServiceAreaDomain samMServiceAreaDomain=ScaComponentFactory.getService(ISamMServiceAreaDomain.class, "samMServiceAreaDomain/samMServiceAreaDomain");

	
	public void save(){
		Record[] records=(Record[])getParameter("records");
		
		List<SamMServiceArea> list=new ArrayList<SamMServiceArea>();
		
		for(int i=0;i<records.length;i++){
			SamMServiceArea dataBean=(SamMServiceArea)records[i].toBean(SamMServiceArea.class);
			list.add(dataBean);
		}
		samMServiceAreaDomain.save(list);
	}
	
	public void update(){
		Record record=(Record)getParameter("record");
		SamMServiceArea dataBean=(SamMServiceArea)record.toBean(SamMServiceArea.class);
		samMServiceAreaDomain.update(dataBean);
	}
	
	public void delete(){
		String[] delIds =(String[])getParameter("delIds");
		samMServiceAreaDomain.delete(delIds);
	}
}