package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.base.domain.IFisCemeCheckScoreDomain;

/**
 * 公墓年检打分cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckScoreCmd extends BaseAjaxCommand {

	private IFisCemeCheckScoreDomain fisCemeCheckScoreDomain = ScaComponentFactory
			.getService(IFisCemeCheckScoreDomain.class, "fisCemeCheckScoreDomain/fisCemeCheckScoreDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) record.toBean(FisCemeCheckScore.class);
		fisCemeCheckScoreDomain.insert(fisCemeCheckScore);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		FisCemeCheckScore fisCemeCheckScore = (FisCemeCheckScore) record.toBean(FisCemeCheckScore.class);
		fisCemeCheckScoreDomain.update(fisCemeCheckScore);
	}
	
	// 删除
	public void delete() {
		String scoreId = (String) getParameter("scoreId");
		fisCemeCheckScoreDomain.delete(scoreId);
	}
	
}