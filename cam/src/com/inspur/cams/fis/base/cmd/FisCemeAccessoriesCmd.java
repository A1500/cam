package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeAccessories;
import com.inspur.cams.fis.base.domain.IFisCemeAccessoriesDomain;

/**
 * 公墓审批附件表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeAccessoriesCmd extends BaseAjaxCommand {

	private IFisCemeAccessoriesDomain fisCemeAccessoriesDomain = ScaComponentFactory
			.getService(IFisCemeAccessoriesDomain.class, "fisCemeAccessoriesDomain/fisCemeAccessoriesDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeAccessories fisCemeAccessories = (FisCemeAccessories) record.toBean(FisCemeAccessories.class);
		fisCemeAccessoriesDomain.insert(fisCemeAccessories);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeAccessories fisCemeAccessories = (FisCemeAccessories) record.toBean(FisCemeAccessories.class);
		fisCemeAccessoriesDomain.update(fisCemeAccessories);
	}
	
	// 删除
	public void delete() {
		String accessoriesId = (String) getParameter("accessoriesId");
		fisCemeAccessoriesDomain.delete(accessoriesId);
	}
	
	public void deleteAll(){
		ParameterSet pset = getParameterSet();
		fisCemeAccessoriesDomain.deleteAll(pset);
	}
	
}