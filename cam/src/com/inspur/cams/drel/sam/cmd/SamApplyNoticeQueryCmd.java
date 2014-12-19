package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamApplyNoticeDomain;
/**
 * @title:公示结果Command
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
public class SamApplyNoticeQueryCmd extends BaseQueryCommand{
	private ISamApplyNoticeDomain samApplyNoticeDomain = ScaComponentFactory.getService(ISamApplyNoticeDomain.class, "samApplyNoticeDomain/samApplyNoticeDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samApplyNoticeDomain.query(pset);
	}
}
