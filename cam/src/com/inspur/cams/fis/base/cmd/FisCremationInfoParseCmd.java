package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCremationInfoParse;
import com.inspur.cams.fis.base.domain.IFisCremationInfoParseDomain;

/**
 * �ϱ����������ѯcmd
 * @author 
 * @date 2013-11-07
 */
public class FisCremationInfoParseCmd extends BaseAjaxCommand {

	private IFisCremationInfoParseDomain fisCremationInfoParseDomain = ScaComponentFactory
			.getService(IFisCremationInfoParseDomain.class, "fisCremationInfoParseDomain/fisCremationInfoParseDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCremationInfoParse fisCremationInfoParse = (FisCremationInfoParse) record.toBean(FisCremationInfoParse.class);
		fisCremationInfoParseDomain.insert(fisCremationInfoParse);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCremationInfoParse fisCremationInfoParse = (FisCremationInfoParse) record.toBean(FisCremationInfoParse.class);
		fisCremationInfoParseDomain.update(fisCremationInfoParse);
	}
	
	// 删除
	public void delete() {
		String unitId = (String) getParameter("unitId");
		fisCremationInfoParseDomain.delete(unitId);
	}
	
}