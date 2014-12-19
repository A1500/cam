package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeChangeDetail;
import com.inspur.cams.fis.base.domain.IFisCemeChangeDetailDomain;

/**
 * 公墓信息变更备案明细表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeChangeDetailCmd extends BaseAjaxCommand {

	private IFisCemeChangeDetailDomain fisCemeChangeDetailDomain = ScaComponentFactory
			.getService(IFisCemeChangeDetailDomain.class, "fisCemeChangeDetailDomain/fisCemeChangeDetailDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeChangeDetail fisCemeChangeDetail = (FisCemeChangeDetail) record.toBean(FisCemeChangeDetail.class);
		fisCemeChangeDetailDomain.insert(fisCemeChangeDetail);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeChangeDetail fisCemeChangeDetail = (FisCemeChangeDetail) record.toBean(FisCemeChangeDetail.class);
		fisCemeChangeDetailDomain.update(fisCemeChangeDetail);
	}
	
	// 删除
	public void delete() {
		String detailId = (String) getParameter("detailId");
		fisCemeChangeDetailDomain.delete(detailId);
	}
	
}