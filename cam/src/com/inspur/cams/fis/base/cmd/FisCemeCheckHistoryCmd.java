package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeCheckHistory;
import com.inspur.cams.fis.base.domain.IFisCemeCheckHistoryDomain;

/**
 * 公墓年检整改历史记录表cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckHistoryCmd extends BaseAjaxCommand {

	private IFisCemeCheckHistoryDomain fisCemeCheckHistoryDomain = ScaComponentFactory
			.getService(IFisCemeCheckHistoryDomain.class, "fisCemeCheckHistoryDomain/fisCemeCheckHistoryDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) record.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.insert(fisCemeCheckHistory);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeCheckHistory fisCemeCheckHistory = (FisCemeCheckHistory) record.toBean(FisCemeCheckHistory.class);
		fisCemeCheckHistoryDomain.update(fisCemeCheckHistory);
	}
	
	// 删除
	public void delete() {
		String hisId = (String) getParameter("hisId");
		fisCemeCheckHistoryDomain.delete(hisId);
	}
	
}