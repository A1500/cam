package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeLogoffOpinion;
import com.inspur.cams.fis.base.domain.IFisCemeLogoffOpinionDomain;

/**
 * 同级其它部门意见cmd
 * @author 
 * @date 2013-08-15
 */
public class FisCemeLogoffOpinionCmd extends BaseAjaxCommand {

	private IFisCemeLogoffOpinionDomain fisCemeLogoffOpinionDomain = ScaComponentFactory
			.getService(IFisCemeLogoffOpinionDomain.class, "fisCemeLogoffOpinionDomain/fisCemeLogoffOpinionDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) record.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.insert(fisCemeLogoffOpinion);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeLogoffOpinion fisCemeLogoffOpinion = (FisCemeLogoffOpinion) record.toBean(FisCemeLogoffOpinion.class);
		fisCemeLogoffOpinionDomain.update(fisCemeLogoffOpinion);
	}
	
	// 删除
	public void delete() {
		String opinionId = (String) getParameter("opinionId");
		fisCemeLogoffOpinionDomain.delete(opinionId);
	}
	
}