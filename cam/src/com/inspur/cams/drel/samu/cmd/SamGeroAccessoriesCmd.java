package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.data.SamGeroAccessories;
import com.inspur.cams.drel.samu.domain.ISamGeroAccessoriesDomain;

/**
 * 敬老院附件信息表cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroAccessoriesCmd extends BaseAjaxCommand {

	private ISamGeroAccessoriesDomain samGeroAccessoriesDomain = ScaComponentFactory
			.getService(ISamGeroAccessoriesDomain.class, "samGeroAccessoriesDomain/samGeroAccessoriesDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		SamGeroAccessories samGeroAccessories = (SamGeroAccessories) record.toBean(SamGeroAccessories.class);
		samGeroAccessoriesDomain.insert(samGeroAccessories);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamGeroAccessories samGeroAccessories = (SamGeroAccessories) record.toBean(SamGeroAccessories.class);
		samGeroAccessoriesDomain.update(samGeroAccessories);
	}
	
	// 删除
	public void delete() {
		String accessoriesId = (String) getParameter("accessoriesId");
		samGeroAccessoriesDomain.delete(accessoriesId);
	}
	
}